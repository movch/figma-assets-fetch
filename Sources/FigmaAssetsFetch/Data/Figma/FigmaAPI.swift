import Combine
import Foundation

public enum FigmaAPIError: LocalizedError {
    case invalidFileURL
    case invalidJSON
}

public protocol FigmaAPIType {
    func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error>
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
}

public struct FigmaAPIMock: FigmaAPIType {
    private let mockedJSON: String

    public init(mockedJSON: String) {
        self.mockedJSON = mockedJSON
    }

    public func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error> {
        guard let data = mockedJSON.data(using: .utf8),
              let figmaNodes = try? JSONDecoder().decode(FileNodesResponse.self, from: data)
        else {
            return Fail(error: FigmaAPIError.invalidJSON)
                .eraseToAnyPublisher()
        }

        return Just(figmaNodes)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
