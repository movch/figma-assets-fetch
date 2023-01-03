import XCTest

@testable import FigmaAssetsFetch

class FigmaImagesSourceTests: XCTestCase {
    func testImagesFetch() async throws {
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

        let images = try await imagesSource.fetchImages()

        assert(images.count == 2)
        assert(images.map { $0.name.original }.sorted() == ["Add_round_fill", "Date_range_fill"].sorted())
    }
}
