import Foundation

/// Color object model, that will be passed to Stencil template
public struct ColorAsset {
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
    public let darkValue: Color?

    public init(
        name: Name,
        value: ColorAsset.Color,
        darkValue: ColorAsset.Color? = nil
    ) {
        self.name = name
        self.value = value
        self.darkValue = darkValue
    }
}
