import Foundation

public protocol FigmaAPIType {
    func requestFile(with id: String, nodeId: String) async throws -> FileNodesResponse
    func requestImagesLinks(fileId: String, nodeIds: [String], format: ImageFormat, scale: ImageScale) async throws -> FigmaImages
}

public struct FigmaAPI: HasHTTPRequest {
    private let token: String

    public init(token: String) {
        self.token = token
    }
}

extension FigmaAPI: FigmaAPIType {
    public func requestFile(with id: String, nodeId: String) async throws -> FileNodesResponse {
        let endpoint = FigmaEndpoint(
            request: .node(fileId: id, nodeId: nodeId),
            token: token
        )
        return try await sendRequest(endpoint: endpoint, responseModel: FileNodesResponse.self)
    }

    public func requestImagesLinks(
        fileId: String,
        nodeIds: [String],
        format: ImageFormat,
        scale: ImageScale
    ) async throws -> FigmaImages {
        let endpoint = FigmaEndpoint(
            request: .imagesLinks(
                fileId: fileId,
                nodeIds: nodeIds,
                format: format,
                imageScale: scale
            ),
            token: token
        )
        return try await sendRequest(endpoint: endpoint, responseModel: FigmaImages.self)
    }
}
