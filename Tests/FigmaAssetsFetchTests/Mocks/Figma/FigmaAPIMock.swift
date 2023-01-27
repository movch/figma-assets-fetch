import FigmaAssetsFetch
import Foundation

public struct FigmaAPIMock: FigmaAPIType {
    private let mockedFileRequestJSON: String
    private let mockedImagesRequestJSON: String

    public init(
        mockedFileRequestJSON: String,
        mockedImagesRequestJSON: String
    ) {
        self.mockedFileRequestJSON = mockedFileRequestJSON
        self.mockedImagesRequestJSON = mockedImagesRequestJSON
    }

    public func requestFile(with id: String, nodeId: String) async throws -> FileNodesResponse {
        guard let data = mockedFileRequestJSON.data(using: .utf8)
        else {
            throw RequestError.decode
        }

        return try JSONDecoder().decode(FileNodesResponse.self, from: data)
    }

    public func requestImagesLinks(
        fileId: String,
        nodeIds: [String],
        format: ImageFormat,
        scale: ImageScale
    ) async throws -> FigmaImages {
        guard let data = mockedImagesRequestJSON.data(using: .utf8)
        else {
            throw RequestError.decode
        }

        return try JSONDecoder().decode(FigmaImages.self, from: data)
    }
}
