import Combine
import Foundation

enum FigmaAPIError: LocalizedError {
    case invalidFileURL
}

protocol FigmaAPIType {
    func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error>
}

class FigmaAPI {
    private let baseAPIPath = "https://api.figma.com/v1"

    private var token: String

    init(token: String) {
        self.token = token
    }
}

extension FigmaAPI: FigmaAPIType {
    func requestFile(with id: String, nodeId: String) -> AnyPublisher<FileNodesResponse, Error> {
        let path = "\(baseAPIPath)/files/\(id)/nodes?ids=\(nodeId)"

        guard let url = URL(string: path) else {
            return Fail(error: FigmaAPIError.invalidFileURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error }
            .map { return $0.data }
            .decode(type: FileNodesResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
