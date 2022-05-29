import Foundation

// MARK: - XCColorSet

struct XCColorSet: Codable {
    let colors: [XCColorElement]
    let info: XCAssetInfo

    init(
        color: ColorData,
        darkColor: ColorData?
    ) {
        var colors: [XCColorElement] = [
            XCColorElement(colorModel: color),
        ]

        if let darkColor = darkColor {
            colors.append(
                XCColorElement(
                    colorModel: darkColor,
                    appearances: [.dark]
                )
            )
        }

        self.colors = colors
        info = .default
    }
}

// MARK: - XCColorElement

struct XCColorElement: Codable {
    init(colorModel: ColorData, appearances: [Appearance]? = nil) {
        color = colorModel.xcColor
        idiom = "universal"
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
    let components: XCColorComponents

    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }
}

// MARK: - XCColorComponents

struct XCColorComponents: Codable {
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
