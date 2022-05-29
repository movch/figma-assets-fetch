import Foundation

/// Color object model, that will be passed to Stencil template
struct ColorData {
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

    /// Color representation that can be used in `*.xsassets` files
    var xcColor: XCColor {
        XCColor(
            colorSpace: "srgb",
            components: XCColorComponents(
                alpha: "\(figmaColor.a)",
                blue: "\(figmaColor.b)",
                green: "\(figmaColor.g)",
                red: "\(figmaColor.r)"
            )
        )
    }
}
