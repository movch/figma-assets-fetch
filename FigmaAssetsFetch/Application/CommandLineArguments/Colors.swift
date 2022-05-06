import ArgumentParser
import Darwin
import Foundation
import PathKit
import Stencil

struct Colors: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to provided template"
    )
    
    @OptionGroup
    var options: Options
    
    @Option(
        help: "Figma file identifier. Can be extracted from the URL of your Figma document."
    )
    var figmaFileId: String = ""
    
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

        let cancellable = figmaAPI.requestFile(with: figmaFileId, nodeId: colorsNodeId)
            .tryMap(render(figmaNodes:))
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        print(error)
                        Darwin.exit(1)
                    case .finished:
                        Darwin.exit(0)
                    }
                },
                receiveValue: { rendered in
                    guard let output = URL(string: "file://\(options.output)") else {
                        print(rendered)
                        Darwin.exit(0)
                    }
                    
                    do {
                        try rendered.write(
                            to: output,
                            atomically: true,
                            encoding: String.Encoding.utf8
                        )
                    } catch let error {
                        print(error)
                    }
                }
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
    }
    
    private func render(figmaNodes: FileNodesResponse) throws -> String {
        let paletteExtractor = FigmaPaletteParser(figmaNodes: figmaNodes)
        let paletteColors = try paletteExtractor.extract()
            .sorted(by: { first, second in first.name < second.name })

        let context = ["colors": paletteColors]
        let environment = Environment(
            loader: FileSystemLoader(
                paths: [
                    Path(templatesDirectory)
                ]
            )
        )
        let rendered = try environment.renderTemplate(
            name: templateName,
            context: context
        )

        return rendered
    }
}
