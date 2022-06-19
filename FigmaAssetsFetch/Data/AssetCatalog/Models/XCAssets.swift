import Foundation

public struct XCAssets {
    public enum Asset {
        case colorSet(name: String, asset: XCColorSet)
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
