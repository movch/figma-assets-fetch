import Foundation

struct ColorObjectModel {
    /// Name that was imported from Figma as is
    let name: String
    
    /// `name` converted to camel case
    let camelCaseName: String
    
    /// Hex value of color
    let hexColor: String
    
    /// RGBA value of color
    var figmaColor: FigmaColor
}
