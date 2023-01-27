import Foundation

public protocol FileWriterType {
    func write(content: String?, at url: URL) throws
}

public struct FileWriter: FileWriterType {
    public init() {}

    public func write(content: String?, at url: URL) throws {
        try content?.write(
            to: url,
            atomically: true,
            encoding: String.Encoding.utf8
        )
    }
}
