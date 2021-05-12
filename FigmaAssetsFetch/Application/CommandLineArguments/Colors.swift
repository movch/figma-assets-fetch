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
        help: "Figma file node identifier that contains the collections of ellipses with colors. The node Id can be parsed from any Figma node url"
    )
    var colorsNodeId: String = ""
    
    @Option(
        help: "Template file name to render."
    )
    var templateName: String = ""
    
    @Option(
        help: "A path to file for generated code"
    )
    var output: String = ""
    
    func run() {
        let figmaAPI: FigmaAPIType = FigmaAPI(token: options.figmaToken)

        let cancellable = figmaAPI.requestFile(with: figmaFileId, nodeId: colorsNodeId)
            .tryMap(render(figmaNodes:))
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                        Darwin.exit(1)
                    case .finished:
                        Darwin.exit(0)
                    }
                },
                receiveValue: { rendered in
                    guard let output = URL(string: "file://\(output)") else {
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
                        print(error.localizedDescription)
                    }
                }
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
    }
    
    private func render(figmaNodes: FileNodesResponse) throws -> String {
        let paletteExtractor = PaletteExtractor(figmaNodes: figmaNodes)
        let paletteColors = try paletteExtractor.extract()

        let context = ["colors": paletteColors]
        let environment = Environment(
            loader: FileSystemLoader(
                paths: [
                    Path(options.templatesDirectory)
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
