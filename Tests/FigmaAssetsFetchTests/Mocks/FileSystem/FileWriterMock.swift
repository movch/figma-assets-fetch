import FigmaAssetsFetch
import Foundation

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
