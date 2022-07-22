import ArgumentParser
import Combine
import Darwin
import Foundation
import PathKit
import Stencil

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

        let cancellable = useCase.run()
            .sink(
                receiveCompletion: process(completion:),
                receiveValue: { _ in }
            )

        // Infinitely run the main loop to wait for our request.
        RunLoop.main.run()
        withExtendedLifetime(cancellable) {}
    }

    private func process(completion: Subscribers.Completion<Error>) {
        switch completion {
        case let .failure(error):
            print(error)
            Darwin.exit(1)
        case .finished:
            print("Done.")
            Darwin.exit(0)
        }
    }
}
