import XCTest

@testable import FigmaAssetsFetch

class XCAssetsFileSystemRenderTests: XCTestCase {
    func testXCAssetsColorSetFilePathGeneration() throws {
        let mockFileManager = FileManagerMock()
        let mockFileWriter = FileWriterMock()

        let json = FigmaJSON.examplePalleteWithStyles
        let data = json.data(using: .utf8)
        let figmaNodes = try JSONDecoder().decode(FileNodesResponse.self, from: data!)
        let parsedColors = try FigmaPaletteParser().extract(figmaNodes: figmaNodes)

        let render = XCAssetsFileSystemRender(
            fileManager: mockFileManager,
            fileWriter: mockFileWriter
        )
        try render.render(colors: parsedColors, output: "/Test.xcassets")

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

    func testXCAssetsImageSetFilePathGeneration() throws {
        let mockFileManager = FileManagerMock()
        let mockFileWriter = FileWriterMock()
        let mockFileDownloader = FileDownloaderMock()

        let images = [ImageAsset(
            name: Name(name: "test1"),
            format: .pdf,
            urlsForScales: [
                "x1": "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/751fd453-404f-48e1-8b28-dc341ce3d30e",
            ]
        )]

        let render = XCAssetsFileSystemRender(
            fileManager: mockFileManager,
            fileWriter: mockFileWriter,
            fileDownloader: mockFileDownloader
        )
        try render.render(images: images, output: "/Images.xcassets")

        assert(mockFileManager.paths.sorted() == [
            "/Images.xcassets",
            "/Images.xcassets/test1.imageset",
        ].sorted())
        assert(mockFileWriter.paths.sorted() == [
            "/Images.xcassets/Contents.json",
            "/Images.xcassets/test1.imageset/Contents.json",
        ].sorted())
        assert(mockFileDownloader.paths.sorted() == [
            "/Images.xcassets/test1.imageset/test1_x1.pdf",
        ].sorted())
    }
}
