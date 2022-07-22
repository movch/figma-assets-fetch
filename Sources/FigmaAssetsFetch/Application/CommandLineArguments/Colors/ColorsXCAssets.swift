import ArgumentParser
import Combine
import Darwin
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
