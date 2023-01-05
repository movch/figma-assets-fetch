import Foundation

public struct FigmaEndpoint {
    enum Request {
        case node(fileId: String, nodeId: String)
        case imagesLinks(fileId: String, nodeIds: [String], format: ImageFormat, imageScale: ImageScale)
    }

    let request: Request
    let token: String
}

extension FigmaEndpoint: Endpoint {
    var scheme: String {
        "https"
    }

    var host: String {
        "api.figma.com"
    }

    var path: String {
        switch request {
        case let .node(fileId, _):
            return "/v1/files/\(fileId)/nodes"
        case let .imagesLinks(fileId, _, _, _):
            return "/v1/images/\(fileId)"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch request {
        case let .node(_, nodeId):
            return [
                URLQueryItem(name: "ids", value: nodeId),
            ]
        case let .imagesLinks(_, nodeIds, format, imageScale):
            let nodeIdsJoined = nodeIds.joined(separator: ",")
            return [
                URLQueryItem(name: "ids", value: nodeIdsJoined),
                URLQueryItem(name: "format", value: format.rawValue),
                URLQueryItem(name: "scale", value: "\(imageScale.rawValue)"),
            ]
        }
    }

    var method: RequestMethod {
        switch request {
        case .node:
            return .get
        case .imagesLinks:
            return .get
        }
    }

    var header: [String: String]? {
        [
            "X-Figma-Token": token,
            "Content-Type": "application/json;charset=utf-8",
        ]
    }

    var body: [String: String]? {
        nil
    }
}
