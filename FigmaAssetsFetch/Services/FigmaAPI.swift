import Combine
import Foundation

enum FigmaAPIError: LocalizedError {
    case invalidFileURL
}

protocol FigmaAPIType {
    func requestFile(with id: String) -> AnyPublisher<FileResponse, Error>
}

class FigmaAPI {
    private let baseAPIPath = "https://api.figma.com/v1"

    private var token: String

    init(token: String) {
        self.token = token
    }
}

extension FigmaAPI: FigmaAPIType {
    func requestFile(with id: String) -> AnyPublisher<FileResponse, Error> {
        let filePath = "\(baseAPIPath)/files/\(id)"

        guard let url = URL(string: filePath) else {
            return Fail(error: FigmaAPIError.invalidFileURL).eraseToAnyPublisher()
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(token, forHTTPHeaderField: "X-Figma-Token")

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: FileResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
