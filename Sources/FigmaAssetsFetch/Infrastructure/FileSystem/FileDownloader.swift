import Foundation

public enum FileDownloaderError: Error {
    case invalidFileURL
}

public protocol FileDownloader {
    func download(from url: URL, to output: URL) throws
}

public struct NSDataFileDownloader: FileDownloader {
    public init() {}

    public func download(from url: URL, to output: URL) throws {
        guard let data = NSData(contentsOf: url) else {
            throw FileDownloaderError.invalidFileURL
        }

        try data.write(to: output)
    }
}
