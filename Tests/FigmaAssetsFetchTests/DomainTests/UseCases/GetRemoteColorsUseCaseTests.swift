import Combine
import XCTest

@testable import FigmaAssetsFetch

class GetRemoteColorsUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func testGetColorsAndRenderToXCAssets() throws {
        let figmaAPIMock = FigmaAPIMock(mockedJSON: FigmaJSON.examplePalleteWithStyles)
        let colorsSource = FigmaColorsSource(
            colorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            figmaAPI: figmaAPIMock
        )

        let mockFileManager = FileManagerMock()
        let mockFileWriter = FileWriterMock()
        let render = XCAssetsFileSystemRender(
            fileManager: mockFileManager,
            fileWriter: mockFileWriter
        )

        let useCase = GetRemoteColorsUseCase(
            source: colorsSource,
            render: render,
            output: "/Test.xcassets"
        )

        var error: Error?
        let expectation = self.expectation(description: "Figma colors source mock")

        useCase.run()
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case let .failure(encounteredError):
                        error = encounteredError
                    }

                    expectation.fulfill()
                },
                receiveValue: { _ in }
            )
            .store(in: &cancellables)

        waitForExpectations(timeout: 10)

        XCTAssertNil(error)

        assert(mockFileManager.paths.sorted() == [
            "/Test.xcassets",
            "/Test.xcassets/bg_primary.colorset",
            "/Test.xcassets/bg_success.colorset",
            "/Test.xcassets/bg_danger.colorset",
            "/Test.xcassets/bg_info.colorset",
            "/Test.xcassets/bg_secondary.colorset",
        ].sorted())
        assert(mockFileWriter.paths.sorted() == [
            "/Test.xcassets/Contents.json",
            "/Test.xcassets/bg_primary.colorset/Contents.json",
            "/Test.xcassets/bg_success.colorset/Contents.json",
            "/Test.xcassets/bg_danger.colorset/Contents.json",
            "/Test.xcassets/bg_info.colorset/Contents.json",
            "/Test.xcassets/bg_secondary.colorset/Contents.json",
        ].sorted())
    }
}
