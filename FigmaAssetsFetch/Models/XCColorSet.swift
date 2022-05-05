import Foundation

// MARK: - XCColorSet
struct XCColorSet: Codable {
    let colors: [ColorElement]
    let info: XCAssetInfo
}

// MARK: - ColorElement
struct ColorElement: Codable {
    let color: ColorColor
    let idiom: String
    let appearances: [Appearance]?
}

// MARK: - Appearance
struct Appearance: Codable {
    let appearance, value: String
}

// MARK: - ColorColor
struct ColorColor: Codable {
    let colorSpace: String
    let components: Components

    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
}

// MARK: - Components
struct Components: Codable {
    let alpha, blue, green, red: String
}

// MARK: - Info
struct XCAssetInfo: Codable {
    let author: String
    let version: Int
}
