import Foundation

public enum FileDownloaderError: Error {
    case invalidFileURL
}

public protocol FileDownloader {
    func download(from url: URL, to output: URL) async throws
}

public struct AsyncFileDownloader: FileDownloader, HasHTTPRequest {
    public init() {}
}
