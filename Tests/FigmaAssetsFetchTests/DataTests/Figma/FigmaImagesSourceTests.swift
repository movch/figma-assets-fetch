import Combine
import XCTest

@testable import FigmaAssetsFetch

class FigmaImagesSourceTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testImagesFetch() throws {
        let figmaAPIMock = FigmaAPIMock(
            mockedFileRequestJSON: FigmaJSON.exampleCollectionOfIcons,
            mockedImagesRequestJSON: FigmaJSON.exampleImagesResponse
        )
        let imagesSource = FigmaImagesSource(
            imagesFrameURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=508%3A45",
            format: .pdf,
            scales: [.x1],
            figmaAPI: figmaAPIMock
        )

        var images = [ImageAsset]()
        var error: Error?
        let expectation = self.expectation(description: "Figma colors source mock")

        imagesSource.fetchImages()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(encounteredError):
                    error = encounteredError
                }

                expectation.fulfill()
            }, receiveValue: { value in
                images = value
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)

        assert(error == nil)
        assert(images.count == 2)
        assert(images.map { $0.name.original }.sorted() == ["Add_round_fill", "Date_range_fill"])
    }
}
