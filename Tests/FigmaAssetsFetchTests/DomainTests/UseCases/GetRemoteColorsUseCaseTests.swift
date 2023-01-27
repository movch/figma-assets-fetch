import XCTest

@testable import FigmaAssetsFetch

class GetRemoteColorsUseCaseTests: XCTestCase {
    func testGetColorsAndRenderToXCAssets() async throws {
        let figmaAPIMock = FigmaAPIMock(
            mockedFileRequestJSON: FigmaJSON.examplePalleteWithStyles,
            mockedImagesRequestJSON: ""
        )
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

        try await useCase.run()

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

    func testGetColorsAndRenderToStencilTemplate() async throws {
        let figmaAPIMock = FigmaAPIMock(
            mockedFileRequestJSON: FigmaJSON.examplePalleteWithStyles,
            mockedImagesRequestJSON: FigmaJSON.exampleImagesResponse
        )
        let colorsSource = FigmaColorsSource(
            colorsURLPath: "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3",
            figmaAPI: figmaAPIMock
        )

        let mockFileWriter = FileWriterMock()
        let render = TemplateFileSystemRender(
            templatePath: Bundle.module.url(forResource: "TestTemplate", withExtension: "stencil")!.path,
            fileWriter: mockFileWriter
        )

        let useCase = GetRemoteColorsUseCase(
            source: colorsSource,
            render: render,
            output: "/Test.swift"
        )

        try await useCase.run()

        assert(mockFileWriter.paths == ["/Test.swift"])
        assert(
            mockFileWriter
                .contents ==
                [
                    "\nbgPrimary 0.0 0.48235294222831726 1.0 1.0 007BFF\n\nbgSuccess 0.1568627506494522 0.6549019813537598 0.2705882489681244 1.0 28A745\n\nbgDanger 0.8627451062202454 0.2078431397676468 0.2705882489681244 1.0 DC3545\n\nbgInfo 0.09019608050584793 0.6352941393852234 0.7215686440467834 1.0 17A2B8\n\nbgSecondary 0.42352941632270813 0.4588235318660736 0.4901960790157318 1.0 6C757D\n\n",
                ]
        )
    }
}
