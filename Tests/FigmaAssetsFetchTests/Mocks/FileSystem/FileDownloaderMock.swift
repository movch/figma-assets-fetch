import FigmaAssetsFetch
import Foundation

public class FileDownloaderMock: FileDownloader {
    public private(set) var paths: [String] = []

    public init() {}

    public func download(from url: URL, to output: URL) throws {
        paths.append(output.path)
    }
}
