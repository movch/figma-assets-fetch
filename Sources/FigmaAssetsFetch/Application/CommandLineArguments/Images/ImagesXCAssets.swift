import ArgumentParser
import Combine
import Darwin
import Foundation

struct ImagesXCAssets: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Download images from Figma file and render them to *.xcassets file"
    )

    @OptionGroup
    var options: Options
    
    @Option(
        help: "Figma frame url that contains a collection images."
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
