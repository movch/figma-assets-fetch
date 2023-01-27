import FigmaAssetsFetch
import Foundation

public class FileWriterMock {
    public var paths: [String] {
        return queue.sync {
            self.safePaths
        }
    }

    public var contents: [String?] {
        return queue.sync {
            self.safeContents
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
    private var safeContents: [String?] = []

    public init() {}
}

extension FileWriterMock: FileWriterType {
    public func write(content: String?, at url: URL) throws {
        queue.async(flags: .barrier) {
            self.safePaths.append(url.path)
            self.safeContents.append(content)
        }
    }
}
