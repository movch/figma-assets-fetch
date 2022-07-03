import ArgumentParser
import Combine
import Darwin
import Foundation

struct ColorsXCAssets: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to *.xcassets file"
    )

    @OptionGroup
    var options: Options

    @Option(
        help: "Figma frame url that contains a collection of ellipses with colors."
    )
    var colorsNodeURL: String = ""

    @Option(
        help: "Optional. Figma frame url that contains a collection of ellipses with dark colors."
    )
    var darkColorsNodeURL: String?

    @Option(
        help: "Optional. Name of the result *.xcassets file. Default is 'Colors'."
    )
    var assetName: String?

    func run() {
        let figmaAPI: FigmaAPIType = FigmaAPI(token: options.figmaToken)
        let figmaURLParser: FigmaURLParserType = FigmaURLParser()

        guard let figmaFileId = try? figmaURLParser.extractFileId(from: colorsNodeURL),
              let colorsNodeId = try? figmaURLParser.extractNodeId(from: colorsNodeURL)
        else {
            print("Incorrect Figma frame URL")
            Darwin.exit(1)
        }

        let colorsRequest = figmaAPI.requestFile(with: figmaFileId, nodeId: colorsNodeId)
        let darkColorsRequest: AnyPublisher<FileNodesResponse, Error> = {
            guard let darkColorsNodeURL = self.darkColorsNodeURL,
                  let darkColorsFileId = try? figmaURLParser.extractFileId(from: darkColorsNodeURL),
                  let darkColorsNodeId = try? figmaURLParser.extractNodeId(from: darkColorsNodeURL)
            else {
                return Just(FileNodesResponse(nodes: [:], name: ""))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }

            return figmaAPI.requestFile(with: darkColorsFileId, nodeId: darkColorsNodeId)
        }()

        let cancellable = Publishers.Zip(colorsRequest, darkColorsRequest)
            .tryMap(convertToXCAssets)
            .sink(
                receiveCompletion: process(completion:),
                receiveValue: save(assets:)
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
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

    private func convertToXCAssets(
        colors: FileNodesResponse,
        darkColors: FileNodesResponse
    ) throws -> [XCAssets.Asset] {
        let colorsModels = try FigmaPaletteParser(figmaNodes: colors).extract()
        let darkColorsModels = try? FigmaPaletteParser(figmaNodes: darkColors).extract()

        return colorsModels.map { colorModel in
            XCAssets.Asset.colorSet(
                name: colorModel.name.camelCased,
                asset: XCColorSet(
                    color: colorModel,
                    darkColor: darkColorsModels?.first(where: { darkColorModel in
                        darkColorModel.name.original.contains(colorModel.name.original)
                    })
                )
            )
        }
    }

    private func save(assets: [XCAssets.Asset]) {
        guard let outputPath = URL(string: "file://\(options.output)") else {
            print("Unable to find output path")
            Darwin.exit(1)
        }

        let xcAssets = XCAssets(name: assetName ?? "Colors", assets: assets)
        let assetsRender = XCAssetsFileSystemRender(path: outputPath, content: xcAssets)

        do {
            try assetsRender.render()
        } catch {
            print(error)
            Darwin.exit(1)
        }
    }
}
