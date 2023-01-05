import Foundation

public struct XCAssetInfo: Codable {
    public static var `default`: XCAssetInfo {
        XCAssetInfo(
            author: "xcode",
            version: 1
        )
    }

    public let author: String
    public let version: Int
}
