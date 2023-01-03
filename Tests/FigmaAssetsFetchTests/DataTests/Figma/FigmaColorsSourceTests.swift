import XCTest

@testable import FigmaAssetsFetch

class FigmaColorsSourceTests: XCTestCase {
    func testColorsFetch() async throws {
        let figmaAPIMock = FigmaAPIMock(
            mockedFileRequestJSON: FigmaJSON.examplePalleteWithStyles,
            mockedImagesRequestJSON: FigmaJSON.exampleImagesResponse
        )
        let colorsSource = FigmaColorsSource(
            colorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            darkColorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            figmaAPI: figmaAPIMock
        )

        let colors = try await colorsSource.fetchColors()

        assert(colors.count == 5)
        assert(
            colors
                .map { $0.name.snakeCased }.sorted() == ["bg_danger", "bg_info", "bg_primary", "bg_secondary", "bg_success"].sorted()
        )
        assert(colors.map { $0.value.hexValue }.sorted() == ["DC3545", "17A2B8", "007BFF", "6C757D", "28A745"].sorted())
        assert(colors.map { $0.darkValue?.hexValue ?? "" }.sorted() == ["DC3545", "17A2B8", "007BFF", "6C757D", "28A745"].sorted())
    }
}
