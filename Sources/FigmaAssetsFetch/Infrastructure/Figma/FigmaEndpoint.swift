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
        case .node(let fileId, let nodeId):
            return "/v1/files/\(fileId)/nodes?ids=\(nodeId)"
        case .imagesLinks(let fileId, let nodeIds, let format, let imageScale):
            let nodeIdsJoined = nodeIds.joined(separator: ",")
            return "/v1/images/\(fileId)?ids=\(nodeIdsJoined)&format=\(format.rawValue)&scale=\(imageScale.rawValue)"
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
    
    var header: [String : String]? {
        ["X-Figma-Token": token]
    }
    
    var body: [String : String]? {
        nil
    }
}
