import ArgumentParser

struct ColorsOptions: ParsableArguments {
    @Option(
        help: "Figma frame url that contains a collection of ellipses with colors."
    )
    var colorsNodeURL: String = ""

    @Option(
        help: "Optional. Figma frame url that contains a collection of ellipses with dark colors."
    )
    var darkColorsNodeURL: String?
}
