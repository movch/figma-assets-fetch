import ArgumentParser
import Darwin
import Foundation
import FigmaAssetsFetch

struct ColorsCodeGen: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download colors information from Figma file and render them to provided Stencil template"
    )

    @OptionGroup
    var options: Options

    @OptionGroup
    var colorsOptions: ColorsOptions

    @Option(
        help: "Path to Stencil template file to render. It should have `*.stencil` extension."
    )
    var templatePath: String = ""

    func run() {
        let source = FigmaColorsSource(
            colorsURLPath: colorsOptions.colorsNodeURL,
            darkColorsURLPath: colorsOptions.darkColorsNodeURL,
            figmaAPI: FigmaAPI(token: options.figmaToken)
        )

        let render = TemplateFileSystemRender(templatePath: templatePath)

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
