import ArgumentParser
import Darwin
import Foundation
import Combine

struct XCAssets: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to xcassets file"
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
        help: "Figma file node identifier that contains the collections of ellipses with colors. The node Id can be parsed from any Figma node url"
    )
    var darkColorsNodeId: String?
    
    @Option(
        help: "Figma file identifier with dark colors. Can be extracted from the URL of your Figma document."
    )
    var darkColorsFigmaFileId: String?
    
    @Option(
        help: "Path to save generated file"
    )
    var output: String = ""
    
    func run() {
        let figmaAPI: FigmaAPIType = FigmaAPI(token: options.figmaToken)
        
        let colorsRequest = figmaAPI.requestFile(with: figmaFileId, nodeId: colorsNodeId)
        let darkColorsRequest: AnyPublisher<FileNodesResponse, Error> = {
            guard let darkColorsNodeId = self.darkColorsNodeId else {
                return Just(FileNodesResponse(nodes: [:], name: ""))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            
            let fileId = darkColorsFigmaFileId ?? figmaFileId
            
            return figmaAPI.requestFile(with: fileId, nodeId: darkColorsNodeId)
        }()

        let cancellable = colorsRequest
            .zip(darkColorsRequest)
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
                receiveValue: { colors, darkColors in
                    guard let output = URL(string: "file://\(output)") else {
                        print("Unable to find output path")
                        Darwin.exit(1)
                    }
                    
                    do {
                        let colorsModels = try PaletteExtractor(figmaNodes: colors).extract()
                        let darkColorsModels = try? PaletteExtractor(figmaNodes: darkColors).extract()
                        
                        XCColorSetGenerator().save(colors: colorsModels, darkColors: darkColorsModels, at: output)
                        
                    } catch let error {
                        print(error)
                        Darwin.exit(1)
                    }
                }
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
    }
}
