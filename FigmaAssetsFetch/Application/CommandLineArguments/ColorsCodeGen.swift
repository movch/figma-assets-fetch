import ArgumentParser
import Combine
import Darwin
import Foundation
import PathKit
import Stencil

struct ColorsCodeGen: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to provided Stencil template"
    )

    @OptionGroup
    var options: Options

    @Option(
        help: "Figma node identifier that contains a collection of ellipses with colors. Node Id can be parsed from the Figma node url."
    )
    var colorsNodeId: String = ""

    @Option(
        help: "Template file name to render."
    )
    var templateName: String = ""

    @Option(
        help: "Templates directory path."
    )
    var templatesDirectory: String = ""

    func run() {
        let figmaAPI: FigmaAPIType = FigmaAPI(token: options.figmaToken)

        let cancellable = figmaAPI.requestFile(with: options.figmaFileId, nodeId: colorsNodeId)
            .tryMap(render(figmaNodes:))
            .sink(
                receiveCompletion: process(completion:),
                receiveValue: save(result:)
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
    }

    private func render(figmaNodes: FileNodesResponse) throws -> String {
        let paletteExtractor = FigmaPaletteParser(figmaNodes: figmaNodes)
        let paletteColors = try paletteExtractor.extract()
            .sorted(by: { first, second in first.name.original < second.name.original })

        let context = ["colors": paletteColors]
        let environment = Environment(
            loader: FileSystemLoader(
                paths: [
                    Path(templatesDirectory),
                ]
            )
        )
        let rendered = try environment.renderTemplate(
            name: templateName,
            context: context
        )

        return rendered
    }

    private func process(completion: Subscribers.Completion<Error>) {
        switch completion {
        case let .failure(error):
            print(error)
            Darwin.exit(1)
        case .finished:
            Darwin.exit(0)
        }
    }

    private func save(result: String) {
        guard let output = URL(string: "file://\(options.output)") else {
            print(result)
            Darwin.exit(0)
        }

        do {
            try result.write(
                to: output,
                atomically: true,
                encoding: String.Encoding.utf8
            )
        } catch {
            print(error)
            Darwin.exit(1)
        }
    }
}
