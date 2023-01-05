import Foundation

public protocol FileManagerType {
    func createDirectory(
        atPath path: String,
        withIntermediateDirectories createIntermediates: Bool,
        attributes: [FileAttributeKey: Any]?
    ) throws
}

extension FileManager: FileManagerType {}
