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

public class FileWriterMock {
    public var paths: [String] = []
    public var contents: [String?] = []

    public init() {}
}

extension FileWriterMock: FileWriterType {
    public func write(content: String?, at url: URL) throws {
        paths.append(url.path)
        contents.append(content)
    }
}
