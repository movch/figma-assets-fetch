import Foundation

/// Name info data structure
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
