import ArgumentParser

struct Options: ParsableArguments {
    @Option(
        help: "Figma API token. Obtain it on your account page on Figma website."
    )
    var figmaToken: String = ""
    
    @Option(
        help: "Figma file identifier. Can be extracted from the URL of your Figma document."
    )
    var figmaFileId: String = ""
    
    @Option(
        help: "A path to generated output"
    )
    var output: String = ""
}
