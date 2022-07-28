import Combine

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

    public func fetchImages() -> AnyPublisher<[ImageAsset], Error> {
        guard let figmaFileId = try? figmaURLParser.extractFileId(from: imagesFrameURLPath),
              let imagesNodeId = try? figmaURLParser.extractNodeId(from: imagesFrameURLPath)
        else {
            return Fail(error: FigmaImagesSourceError.incorrectFigmaFrameURL)
                .eraseToAnyPublisher()
        }

        let frameRequest = figmaAPI.requestFile(with: figmaFileId, nodeId: imagesNodeId)

        var imagesToRequest: [String: String] = [:]
        return frameRequest.flatMap { figmaNodes -> AnyPublisher<FigmaImages, Error> in
            guard let imagesNode = figmaNodes.nodes.first?.value else {
                return Fail(error: FigmaImagesSourceError.imagesFrameReadError)
                    .eraseToAnyPublisher()
            }

            let imagesFrameChildren = imagesNode.document.children
            for child in imagesFrameChildren {
                if child.type == .text {
                    continue
                }

                imagesToRequest[child.id] = child.name
            }

            return self.figmaAPI.requestImagesLinks(
                fileId: figmaFileId,
                nodeIds: imagesToRequest.keys.map { String($0) },
                format: self.format,
                scale: .x1
            )
        }
        .tryMap { figmaImages in
            var images: [ImageAsset] = []

            for imageDict in figmaImages.images {
                guard let name = imagesToRequest[imageDict.key] else {
                    continue
                }

                images.append(
                    ImageAsset(
                        name: Name(name: name),
                        format: self.format,
                        urlsForScales: ["1x": imageDict.value]
                    )
                )
            }

            return images
        }
        .eraseToAnyPublisher()
    }
}
