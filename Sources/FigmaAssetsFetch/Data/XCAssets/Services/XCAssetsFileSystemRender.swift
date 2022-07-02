import Foundation

public protocol XCAssetsRender {
    func render() throws
}

public struct XCAssetsFileSystemRender {
    public init(
        path: URL,
        content: XCAssets,
        fileManager: FileManagerType = FileManager.default,
        fileWriter: FileWriterType = FileWriter()
    ) {
        self.path = path
        self.content = content
        self.fileManager = fileManager
        self.fileWriter = fileWriter
    }

    private let path: URL
    private let content: XCAssets

    private var fileManager: FileManagerType
    private var fileWriter: FileWriterType
}

extension XCAssetsFileSystemRender: XCAssetsRender {
    public func render() throws {
        let assetFolderURL = try createAssetFolder()

        for asset in content.assets {
            switch asset {
            case let .colorSet(name, colorSet):
                let colorSetURL = assetFolderURL.appendingPathComponent("\(name).colorset")
                try create(colorSet: colorSet, at: colorSetURL)
            }
        }
    }

    private func createAssetFolder() throws -> URL {
        let assetFolderURL: URL = path.appendingPathComponent("\(content.name).xcassets")
        try fileManager.createDirectory(
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

        try fileWriter.write(content: assetInfoContent, at: assetInfoURL)

        return assetFolderURL
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
