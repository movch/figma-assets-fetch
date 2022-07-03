import Foundation

public enum FigmaURLParserError: Error {
    case unableToExtractFigmaFileId
    case unableToExtractFigmaFrameNodeId
}

public protocol FigmaURLParserType {
    func extractFileId(from url: String) throws -> String
    func extractNodeId(from url: String) throws -> String
}

public struct FigmaURLParser {}

extension FigmaURLParser: FigmaURLParserType {
    public func extractFileId(from url: String) throws -> String {
        let range = NSRange(location: 0, length: url.utf16.count)
        let regex = try NSRegularExpression(pattern: #"file\/(.*)\/"#)

        guard let fileIdMatch = regex.firstMatch(in: url, options: [], range: range),
              let matchRange = Range(fileIdMatch.range(at: 1), in: url)
        else {
            throw FigmaURLParserError.unableToExtractFigmaFileId
        }

        return String(url[matchRange])
    }

    public func extractNodeId(from url: String) throws -> String {
        guard let url = URLComponents(string: url),
              let nodeId = url.queryItems?.first(where: { $0.name == "node-id" })?.value
        else {
            throw FigmaURLParserError.unableToExtractFigmaFrameNodeId
        }

        return nodeId
    }
}
