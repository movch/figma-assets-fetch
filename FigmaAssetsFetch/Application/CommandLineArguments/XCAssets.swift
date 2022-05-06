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
        help: "Figma file node identifier that contains a collection of ellipses with colors. Node Id can be parsed from the Figma node url"
    )
    var colorsNodeId: String = ""
    
    @Option(
        help: "Figma node identifier that contains a collection of ellipses with dark colors. Node Id can be parsed from the Figma node url. If not provided dark colors would not be generated."
    )
    var darkColorsNodeId: String?
    
    @Option(
        help: "Figma file identifier with dark colors. Can be extracted from the URL of your Figma document. If not provided it will be taken from `figma-file-id` parameter."
    )
    var darkColorsFigmaFileId: String?
    
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
                    guard let output = URL(string: "file://\(options.output)") else {
                        print("Unable to find output path")
                        Darwin.exit(1)
                    }
                    
                    do {
                        let colorsModels = try FigmaPaletteParser(figmaNodes: colors).extract()
                        let darkColorsModels = try? FigmaPaletteParser(figmaNodes: darkColors).extract()
                        
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
