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
        help: "Figma file node identifier that contains a collection of ellipses with colors. Node Id can be parsed from the Figma node url"
    )
    var colorsNodeId: String = ""

    @Option(
        help: "Optional. Figma file identifier with dark colors. Can be extracted from the URL of your Figma document. If not provided it will be taken from `figma-file-id` parameter."
    )
    var darkColorsFigmaFileId: String?

    @Option(
        help: "Optional. Figma node identifier that contains a collection of ellipses with dark colors. Node Id can be parsed from the Figma node url. If not provided dark colors won't be generated."
    )
    var darkColorsNodeId: String?

    @Option(
        help: "Optional. Dark color style name prefix."
    )
    var darkColorStyleNamePrefix: String?

    @Option(
        help: "Optional. Name of the result *.xcassets file. Default is 'Colors'."
    )
    var assetName: String?

    func run() {
        let figmaAPI: FigmaAPIType = FigmaAPI(token: options.figmaToken)

        let figmaFileId = options.figmaFileId
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
                        darkColorModel.name
                            .original == "\(self.darkColorStyleNamePrefix ?? "")\(colorModel.name.original)"
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
