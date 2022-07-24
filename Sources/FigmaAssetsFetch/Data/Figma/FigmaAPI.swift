import Combine
import Foundation

public enum FigmaAPIError: LocalizedError {
    case invalidFileURL
    case invalidJSON
}

public protocol FigmaAPIType {
    func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error>
    func requestImagesLinks(fileId: String, nodeIds: [String], format: ImageFormat, scale: ImageScale)
        -> AnyPublisher<FigmaImages, Error>
}

public struct FigmaAPI {
    private let baseAPIPath = "https://api.figma.com/v1"

    private var token: String

    public init(token: String) {
        self.token = token
    }
}

extension FigmaAPI: FigmaAPIType {
    public func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error> {
        let path = "\(baseAPIPath)/files/\(id)/nodes?ids=\(nodeId)"

        guard let url = URL(string: path) else {
            return Fail(error: FigmaAPIError.invalidFileURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: FileNodesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func requestImagesLinks(
        fileId: String,
        nodeIds: [String],
        format: ImageFormat,
        scale: ImageScale
    ) -> AnyPublisher<FigmaImages, Error> {
        let path =
            "\(baseAPIPath)/images/\(fileId)?ids=\(nodeIds.joined(separator: ","))&format=\(format.rawValue)&scale=\(scale.rawValue)"

        guard let url = URL(string: path) else {
            return Fail(error: FigmaAPIError.invalidFileURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: FigmaImages.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

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

    public func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error> {
        guard let data = mockedFileRequestJSON.data(using: .utf8)
        else {
            return Fail(error: FigmaAPIError.invalidJSON)
                .eraseToAnyPublisher()
        }

        do {
            let figmaNodes = try JSONDecoder().decode(FileNodesResponse.self, from: data)
            return Just(figmaNodes)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }

    public func requestImagesLinks(
        fileId: String,
        nodeIds: [String],
        format: ImageFormat,
        scale: ImageScale
    ) -> AnyPublisher<FigmaImages, Error> {
        guard let data = mockedImagesRequestJSON.data(using: .utf8),
              let figmaImages = try? JSONDecoder().decode(FigmaImages.self, from: data)
        else {
            return Fail(error: FigmaAPIError.invalidJSON)
                .eraseToAnyPublisher()
        }

        return Just(figmaImages)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
