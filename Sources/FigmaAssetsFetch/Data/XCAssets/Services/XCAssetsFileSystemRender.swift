import Foundation

public enum XCAssetsFileSystemRenderError: Error {
    case invalidOutputPath
    case invalidImageURL
}

public struct XCAssetsFileSystemRender {
    public init(
        fileManager: FileManagerType = FileManager.default,
        fileWriter: FileWriterType = FileWriter(),
        fileDownloader: FileDownloader = NSDataFileDownloader()
    ) {
        self.fileManager = fileManager
        self.fileWriter = fileWriter
        self.fileDownloader = fileDownloader
    }

    private let fileManager: FileManagerType
    private let fileWriter: FileWriterType
    private let fileDownloader: FileDownloader
    
    public func render(assets: [XCAssets.Asset], outputURL: URL) throws {
        for asset in assets {
            switch asset {
            case let .colorSet(name, colorSet):
                let colorSetURL = outputURL.appendingPathComponent("\(name).colorset")
                try create(colorSet: colorSet, at: colorSetURL)
                
            case let .imageSet(name, imageSet):
                let imageSetURL = outputURL.appendingPathComponent("\(name).imageset")
                try create(imageSet: imageSet, at: imageSetURL)
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
    
    private func create(imageSet: XCImageSet, at pathURL: URL) throws {
        try fileManager.createDirectory(
            atPath: pathURL.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        let imageSetInfoURL = pathURL.appendingPathComponent("Contents.json")
        let imageSetInfoContent = String(
            data: try JSONEncoder().encode(imageSet),
            encoding: .utf8
        )
        
        for image in imageSet.images {
            guard let imageURL = URL(string: image.url)
            else {
                throw XCAssetsFileSystemRenderError.invalidImageURL
            }
            
            try fileDownloader.download(
                from: imageURL,
                to: pathURL.appendingPathComponent(image.filename)
            )
        }

        try fileWriter.write(content: imageSetInfoContent, at: imageSetInfoURL)
    }
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
        try render(assets: xcAssets, outputURL: outputURL)
    }
}

extension XCAssetsFileSystemRender: ImagesRender {
    public func render(images: [Image], output: String) throws {
        guard let outputURL = URL(string: "file://\(output)"),
              outputURL.lastPathComponent.contains(".xcassets")
        else {
            throw XCAssetsFileSystemRenderError.invalidOutputPath
        }
        
        let xcAssets = images.map { image in
            XCAssets.Asset.imageSet(
                name: image.name,
                asset: XCImageSet(image: image)
            )
        }
        
        try createAssetFolder(url: outputURL)
        try render(assets: xcAssets, outputURL: outputURL)
    }
}
