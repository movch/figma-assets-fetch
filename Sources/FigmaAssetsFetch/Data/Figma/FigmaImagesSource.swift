public enum FigmaImagesSourceError: Error {
    case incorrectFigmaFrameURL
    case imagesFrameReadError
}

public struct FigmaImagesSource: RemoteImagesSource {
    private let imagesFrameURLPath: String
    private let format: ImageFormat
    private let scales: [ImageScale]

    private let figmaAPI: FigmaAPIType
    private let figmaURLParser: FigmaURLParserType

    public init(
        imagesFrameURLPath: String,
        format: ImageFormat,
        scales: [ImageScale],
        figmaAPI: FigmaAPIType,
        figmaURLParser: FigmaURLParserType = FigmaURLParser()
    ) {
        self.imagesFrameURLPath = imagesFrameURLPath
        self.format = format
        self.scales = scales
        self.figmaAPI = figmaAPI
        self.figmaURLParser = figmaURLParser
    }

    public func fetchImages() async throws -> [ImageAsset] {
        guard let figmaFileId = try? figmaURLParser.extractFileId(from: imagesFrameURLPath),
              let imagesNodeId = try? figmaURLParser.extractNodeId(from: imagesFrameURLPath)
        else {
            throw FigmaImagesSourceError.incorrectFigmaFrameURL
        }

        let figmaNodes = try await figmaAPI.requestFile(with: figmaFileId, nodeId: imagesNodeId)

        guard let imagesNode = figmaNodes.nodes.first?.value else {
            throw FigmaImagesSourceError.imagesFrameReadError
        }

        let imagesFrameChildren = imagesNode.document.children
        var imagesToRequest: [String: String] = [:]
        for child in imagesFrameChildren {
            if child.type == .text {
                continue
            }

            imagesToRequest[child.id] = child.name
        }

        let figmaImages = try await figmaAPI.requestImagesLinks(
            fileId: figmaFileId,
            nodeIds: imagesToRequest.keys.map { String($0) },
            format: format,
            scale: .x1
        )

        var images: [ImageAsset] = []

        for imageDict in figmaImages.images {
            guard let name = imagesToRequest[imageDict.key] else {
                continue
            }

            images.append(
                ImageAsset(
                    name: Name(name: name),
                    format: format,
                    urlsForScales: ["1x": imageDict.value]
                )
            )
        }

        return images
    }
}
