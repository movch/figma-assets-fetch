import Foundation

struct ColorObjectModel {
    /// Name that was imported from Figma as is
    let name: String
    
    /// `name` converted to camel case
    let camelCaseName: String

    /// `name` converted to snack case
    let snackCaseName: String

    /// Hex value of color
    let hexColor: String

    /// Hex value with alpha of color
    let fullHexColor: String
    
    /// RGBA value of color
    var figmaColor: FigmaColor
}
