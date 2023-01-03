import ArgumentParser
import Darwin
import Foundation

struct ImagesXCAssets: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download images from Figma file and render them to *.xcassets file"
    )

    @OptionGroup
    var options: Options
    
    @Option(
        help: "Figma frame url that contains a collection of images."
    )
    var imagesNodeURL: String = ""


    func run() {
        let source = FigmaImagesSource(
            imagesFrameURLPath: imagesNodeURL,
            format: .pdf,
            scales: [.x1],
            figmaAPI: FigmaAPI(token: options.figmaToken)
        )
        let render = XCAssetsFileSystemRender()

        let useCase = GetRemoteImagesUseCase(
            source: source,
            render: render,
            output: options.output
        )

        let task = Task {
            do {
                try await useCase.run()
                print("Done.")
                Darwin.exit(0)
            } catch {
                print(error)
                Darwin.exit(1)
            }
        }

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(task) {}
    }
}
