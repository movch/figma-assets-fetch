import ArgumentParser

struct Options: ParsableArguments {
    @Option(
        help: "Figma API token. Obtain it on your account page on Figma website."
    )
    var figmaToken: String = ""
    
    @Option(
        help: "Templates directory path."
    )
    var templatesDirectory: String = ""
}
