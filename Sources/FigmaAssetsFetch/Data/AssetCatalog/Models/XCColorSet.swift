import Foundation

// MARK: - XCColorSet

public struct XCColorSet: Codable {
    let colors: [XCColorElement]
    let info: XCAssetInfo

    init(
        color: NamedColor,
        darkColor: NamedColor?
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

public struct XCColorElement: Codable {
    init(colorModel: NamedColor, appearances: [Appearance]? = nil) {
        color = XCColor(with: colorModel)
        idiom = "universal"
        self.appearances = appearances
    }

    let color: XCColor
    let idiom: String
    let appearances: [Appearance]?
}

// MARK: - Appearance

public struct Appearance: Codable {
    public static var dark: Appearance {
        Appearance(
            appearance: "luminosity",
            value: "dark"
        )
    }

    let appearance, value: String
}

// MARK: - XCColor

public struct XCColor: Codable {
    enum CodingKeys: String, CodingKey {
        case colorSpace = "color-space"
        case components
    }

    let colorSpace: String
    let components: XCColorComponents

    init(with namedColor: NamedColor) {
        colorSpace = "srgb"
        components = XCColorComponents(
            alpha: "\(namedColor.value.a)",
            blue: "\(namedColor.value.b)",
            green: "\(namedColor.value.g)",
            red: "\(namedColor.value.r)"
        )
    }
}

// MARK: - XCColorComponents

public struct XCColorComponents: Codable {
    let alpha, blue, green, red: String
}
