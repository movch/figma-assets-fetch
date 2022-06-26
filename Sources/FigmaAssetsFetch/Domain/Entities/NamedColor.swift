import Foundation

/// Color object model, that will be passed to Stencil template
public struct NamedColor {
    /// Color style name info
    public struct Name {
        /// Name that was imported from Figma as is
        public let original: String

        /// `name` converted to camel case
        public let camelCased: String

        /// `name` converted to snake case
        public let snakeCased: String

        public init(name: String) {
            original = name
            camelCased = name.camelCased
            snakeCased = name.snakeCased
        }
    }

    /// Color style RGBA color info
    public struct Color {
        /// Alpha channel value, between 0 and 1
        public let a: Double
        /// Blue channel value, between 0 and 1
        public let b: Double
        /// Green channel value, between 0 and 1
        public let g: Double
        /// Red channel value, between 0 and 1
        public let r: Double

        /// Hex representation of color
        public let hexValue: String

        /// Hex representation of color with alpha channel
        public let fullHexValue: String

        public init(r: Double, g: Double, b: Double, a: Double) {
            self.r = r
            self.g = g
            self.b = b
            self.a = a

            hexValue = String(format: "%02lX%02lX%02lX", lround(r * 255), lround(g * 255), lround(b * 255))
            fullHexValue = String(
                format: "%02lX%02lX%02lX%02lX",
                lround(a * 255),
                lround(r * 255),
                lround(g * 255),
                lround(b * 255)
            )
        }
    }

    public let name: Name
    public let value: Color
    
    public init(name: NamedColor.Name, value: NamedColor.Color) {
        self.name = name
        self.value = value
    }
}
