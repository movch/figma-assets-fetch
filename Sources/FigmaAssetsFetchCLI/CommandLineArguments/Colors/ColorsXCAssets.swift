import ArgumentParser
import Darwin
import FigmaAssetsFetch
import Foundation

struct ColorsXCAssets: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to *.xcassets file"
    )

    @OptionGroup
    var options: Options

    @OptionGroup
    var colorsOptions: ColorsOptions

    func run() {
        let source = FigmaColorsSource(
            colorsURLPath: colorsOptions.colorsNodeURL,
            darkColorsURLPath: colorsOptions.darkColorsNodeURL,
            figmaAPI: FigmaAPI(token: options.figmaToken)
        )
        let render = XCAssetsFileSystemRender()

        let useCase = GetRemoteColorsUseCase(
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
