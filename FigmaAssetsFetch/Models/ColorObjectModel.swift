import Foundation

struct ColorObjectModel {
    /// Name that was imported from Figma as is
    let name: String
    
    /// `name` converted to camel case
    let camelCaseName: String

    /// `name` converted to snake case
    let snakeCaseName: String

    /// Hex value of color
    let hexColor: String

    /// Hex value with alpha of color
    var fullHexColor: String
    
    /// RGBA value of color
    var figmaColor: FigmaColor
}

extension XCColorSet {
    public static func with(
        color: ColorObjectModel,
        darkColor: ColorObjectModel?
    ) -> XCColorSet {
        var colors: [ColorElement] = [
            ColorElement(
                color: ColorColor(
                    colorSpace: "srgb",
                    components: Components(
                        alpha: "\(color.figmaColor.a)",
                        blue: "\(color.figmaColor.b)",
                        green: "\(color.figmaColor.g)",
                        red: "\(color.figmaColor.r)"
                    )
                ),
                idiom: "universal",
                appearances: nil
            )
        ]
        
        if let darkColor = darkColor {
            colors.append(
                ColorElement(
                    color: ColorColor(
                        colorSpace: "srgb",
                        components: Components(
                            alpha: "\(darkColor.figmaColor.a)",
                            blue: "\(darkColor.figmaColor.b)",
                            green: "\(darkColor.figmaColor.g)",
                            red: "\(darkColor.figmaColor.r)"
                        )
                    ),
                    idiom: "universal",
                    appearances: [
                        Appearance(
                            appearance: "luminosity",
                            value: "dark"
                        )
                    ]
                )
            )
        }
        
        return XCColorSet(
            colors: colors,
            info: XCAssetInfo(
                author: "xcode",
                version: 1
            )
        )
    }
}
