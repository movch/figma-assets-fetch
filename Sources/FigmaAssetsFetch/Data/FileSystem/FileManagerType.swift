import Foundation

public protocol FileManagerType {
    func createDirectory(
        atPath path: String,
        withIntermediateDirectories createIntermediates: Bool,
        attributes: [FileAttributeKey: Any]?
    ) throws
}

extension FileManager: FileManagerType {}

public class FileManagerMock {
    public var paths: [String] = []

    public init() {}
}

extension FileManagerMock: FileManagerType {
    public func createDirectory(
        atPath path: String,
        withIntermediateDirectories createIntermediates: Bool,
        attributes: [FileAttributeKey: Any]?
    ) throws {
        paths.append(path)
    }
}
