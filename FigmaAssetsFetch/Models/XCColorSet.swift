import Foundation

// MARK: - XCColorSet
struct XCColorSet: Codable {
    let colors: [ColorElement]
    let info: XCAssetInfo
    
    init(
        color: ColorObjectModel,
        darkColor: ColorObjectModel?
    ) {
        var colors: [ColorElement] = [
            ColorElement(colorModel: color)
        ]
        
        if let darkColor = darkColor {
            colors.append(
                ColorElement(
                    colorModel: darkColor,
                    appearances: [.dark]
                )
            )
        }
        
        self.colors = colors
        self.info = .default
    }
}

// MARK: - ColorElement
struct ColorElement: Codable {
    init(colorModel: ColorObjectModel, appearances: [Appearance]? = nil) {
        self.color = colorModel.xcColor
        self.idiom = "universal"
        self.appearances = appearances
    }
    
    let color: XCColor
    let idiom: String
    let appearances: [Appearance]?
}

// MARK: - Appearance
struct Appearance: Codable {
    public static var dark: Appearance {
        Appearance(
            appearance: "luminosity",
            value: "dark"
        )
    }
    
    let appearance, value: String
}

// MARK: - XCColor
struct XCColor: Codable {
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
    public static var `default`: XCAssetInfo {
        XCAssetInfo(
            author: "xcode",
            version: 1
        )
    }
    
    let author: String
    let version: Int
}
