// MARK: - XCImageSet
public struct XCImageSet: Codable {
    let images: [XCImage]
    let info: XCAssetInfo
    
    public init(image: Image) {
        self.images = image.urlsForScales.map { key, value in
            XCImage(
                url: value,
                filename: "\(image.name)_\(key).\(image.format)",
                idiom: "universal",
                scale: key
            )
        }
        self.info = .default
    }
}

// MARK: - Image
public struct XCImage: Codable {
    @SkipEncode
    var url: String
    
    let filename, idiom, scale: String
}
