import FigmaAssetsFetch
import Foundation

public class FileManagerMock {
    public var paths: [String] {
        return queue.sync {
            self.safePaths
        }
    }
    
    let queue = DispatchQueue(
        label: "cc.ovchinnikov.\(UUID().uuidString)",
        qos: .background,
        attributes: .concurrent,
        autoreleaseFrequency: .inherit,
        target: .global()
    )
    
    private var safePaths: [String] = []

    public init() {}
}

extension FileManagerMock: FileManagerType {
    public func createDirectory(
        atPath path: String,
        withIntermediateDirectories createIntermediates: Bool,
        attributes: [FileAttributeKey: Any]?
    ) throws {
        queue.async(flags: .barrier) {
            self.safePaths.append(path)
        }
    }
}
