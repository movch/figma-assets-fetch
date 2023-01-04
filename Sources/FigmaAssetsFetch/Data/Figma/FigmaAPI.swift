import Foundation

public enum FigmaAPIError: LocalizedError {
    case invalidFileURL
    case invalidJSON
    case invalidStatusCode
}

public protocol FigmaAPIType {
    func requestFile(with id: String, nodeId: String) async throws -> FileNodesResponse
    func requestImagesLinks(fileId: String, nodeIds: [String], format: ImageFormat, scale: ImageScale) async throws -> FigmaImages
}

public struct FigmaAPI {
    private let baseAPIPath = "https://api.figma.com/v1"

    private var token: String

    public init(token: String) {
        self.token = token
    }
}

extension FigmaAPI: FigmaAPIType {
    public func requestFile(with id: String, nodeId: String) async throws -> FileNodesResponse {
        let path = "\(baseAPIPath)/files/\(id)/nodes?ids=\(nodeId)"
        guard let url = URL(string: path) else {
            throw FigmaAPIError.invalidFileURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FigmaAPIError.invalidStatusCode
        }
        
        let fileNodesResponse = try JSONDecoder().decode(FileNodesResponse.self, from: data)
        
        return fileNodesResponse
    }

    public func requestImagesLinks(
        fileId: String,
        nodeIds: [String],
        format: ImageFormat,
        scale: ImageScale
    ) async throws -> FigmaImages {
        let path =
            "\(baseAPIPath)/images/\(fileId)?ids=\(nodeIds.joined(separator: ","))&format=\(format.rawValue)&scale=\(scale.rawValue)"

        guard let url = URL(string: path) else {
            throw FigmaAPIError.invalidFileURL
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")

        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw FigmaAPIError.invalidStatusCode
        }
        
        let fileNodesResponse = try JSONDecoder().decode(FigmaImages.self, from: data)
        
        return fileNodesResponse
    }
}
