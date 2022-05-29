import Foundation

class XCAssetsBuilder {
    enum AssetType {
        case colorSet(name: String, asset: XCColorSet)
    }

    private var name: String
    private var pathURL: URL

    private var assets: [AssetType] = []

    public init(name: String, pathURL: URL) {
        self.name = name
        self.pathURL = pathURL
    }

    @discardableResult
    public func append(asset: AssetType) -> XCAssetsBuilder {
        assets.append(asset)
        return self
    }

    public func build() throws {
        let assetFolderURL = try createAssetFolder()

        for asset in assets {
            switch asset {
            case let .colorSet(name, colorSet):
                let colorSetURL = assetFolderURL.appendingPathComponent("\(name).colorset")
                try create(colorSet: colorSet, at: colorSetURL)
            }
        }
    }

    private func createAssetFolder() throws -> URL {
        let assetFolderURL: URL = pathURL.appendingPathComponent("\(name).xcassets")
        try FileManager.default.createDirectory(
            atPath: assetFolderURL.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        let assetInfo = XCAssetInfo.default
        let assetInfoURL = assetFolderURL.appendingPathComponent("Contents.json")
        let assetInfoContent = String(
            data: try JSONEncoder().encode(assetInfo),
            encoding: .utf8
        )
        try assetInfoContent?.write(
            to: assetInfoURL,
            atomically: true,
            encoding: String.Encoding.utf8
        )

        return assetFolderURL
    }

    private func create(colorSet: XCColorSet, at pathURL: URL) throws {
        try FileManager.default.createDirectory(
            atPath: pathURL.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        let colorSetInfoURL = pathURL.appendingPathComponent("Contents.json")
        let colorSetInfoContent = String(
            data: try JSONEncoder().encode(colorSet),
            encoding: .utf8
        )

        try colorSetInfoContent?.write(
            to: colorSetInfoURL,
            atomically: true,
            encoding: String.Encoding.utf8
        )
    }
}
