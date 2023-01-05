import Foundation

public struct XCAssets {
    public enum Asset {
        case colorSet(name: String, asset: XCColorSet)
        case imageSet(name: String, asset: XCImageSet)
    }

    public let name: String
    public let assets: [Asset]
    public let assetInfo: XCAssetInfo = .default

    @discardableResult
    public func append(asset: Asset) -> XCAssets {
        var assetsNewValue = assets
        assetsNewValue.append(asset)

        return XCAssets(
            name: name,
            assets: assetsNewValue
        )
    }
}
