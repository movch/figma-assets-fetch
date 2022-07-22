import Foundation

public enum XCAssetsFileSystemRenderError: Error {
    case invalidOutputPath
}

public struct XCAssetsFileSystemRender {
    public init(
        fileManager: FileManagerType = FileManager.default,
        fileWriter: FileWriterType = FileWriter()
    ) {
        self.fileManager = fileManager
        self.fileWriter = fileWriter
    }

    private let fileManager: FileManagerType
    private let fileWriter: FileWriterType
}

extension XCAssetsFileSystemRender: ColorsRender {
    public func render(colors: [NamedColor], output: String) throws {
        guard let outputURL = URL(string: "file://\(output)"),
              outputURL.lastPathComponent.contains(".xcassets")
        else {
            throw XCAssetsFileSystemRenderError.invalidOutputPath
        }

        let xcAssets = colors.map { colorModel in
            XCAssets.Asset.colorSet(
                name: colorModel.name.snakeCased,
                asset: XCColorSet(
                    color: colorModel.value,
                    darkColor: colorModel.darkValue
                )
            )
        }

        try createAssetFolder(url: outputURL)

        for asset in xcAssets {
            switch asset {
            case let .colorSet(name, colorSet):
                let colorSetURL = outputURL.appendingPathComponent("\(name).colorset")
                try create(colorSet: colorSet, at: colorSetURL)
            }
        }
    }

    private func createAssetFolder(url: URL) throws {
        try fileManager.createDirectory(
            atPath: url.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        let assetInfo = XCAssetInfo.default
        let assetInfoURL = url.appendingPathComponent("Contents.json")
        let assetInfoContent = String(
            data: try JSONEncoder().encode(assetInfo),
            encoding: .utf8
        )

        try fileWriter.write(content: assetInfoContent, at: assetInfoURL)
    }

    private func create(colorSet: XCColorSet, at pathURL: URL) throws {
        try fileManager.createDirectory(
            atPath: pathURL.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        let colorSetInfoURL = pathURL.appendingPathComponent("Contents.json")
        let colorSetInfoContent = String(
            data: try JSONEncoder().encode(colorSet),
            encoding: .utf8
        )

        try fileWriter.write(content: colorSetInfoContent, at: colorSetInfoURL)
    }
}
