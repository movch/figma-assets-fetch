import Combine
import XCTest

@testable import FigmaAssetsFetch

class FigmaColorsSourceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testColorsFetch() throws {
        let figmaAPIMock = FigmaAPIMock(
            mockedFileRequestJSON: FigmaJSON.examplePalleteWithStyles,
            mockedImagesRequestJSON: FigmaJSON.exampleImagesResponse
        )
        let colorsSource = FigmaColorsSource(
            colorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            darkColorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            figmaAPI: figmaAPIMock
        )

        var colors = [ColorAsset]()
        var error: Error?
        let expectation = self.expectation(description: "Figma colors source mock")

        colorsSource.fetchColors()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { value in
                colors = value.sorted(by: { $0.name.snakeCased < $1.name.snakeCased })
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)

        assert(error == nil)
        assert(colors.count == 5)
        assert(
            colors
                .map { $0.name.snakeCased } == ["bg_danger", "bg_info", "bg_primary", "bg_secondary", "bg_success"]
        )
        assert(colors.map { $0.value.hexValue } == ["DC3545", "17A2B8", "007BFF", "6C757D", "28A745"])
        assert(colors.map { $0.darkValue?.hexValue } == ["DC3545", "17A2B8", "007BFF", "6C757D", "28A745"])
    }
}
