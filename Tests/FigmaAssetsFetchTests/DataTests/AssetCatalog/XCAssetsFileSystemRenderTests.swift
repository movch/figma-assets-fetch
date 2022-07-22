import XCTest

@testable import FigmaAssetsFetch

class XCAssetsFileSystemRenderTests: XCTestCase {
    func testXCAssetsFilePathGeneration() throws {
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

    func testColorSetContentGeneration() throws {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 1)
        )

        let colorSet = XCColorSet(color: namedColor.value, darkColor: nil)

        let assetContent = String(
            data: try JSONEncoder().encode(colorSet),
            encoding: .utf8
        )

        assert(
            assetContent ==
                "{\"info\":{\"version\":1,\"author\":\"xcode\"},\"colors\":[{\"color\":{\"color-space\":\"srgb\",\"components\":{\"red\":\"0.424\",\"alpha\":\"1.0\",\"blue\":\"0.49\",\"green\":\"0.459\"}},\"idiom\":\"universal\"}]}"
        )
    }

    func testColorSetWithDarkColorContentGeneration() throws {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 1),
            darkValue: .init(r: 0.324, g: 0.359, b: 0.39, a: 1)
        )

        let colorSet = XCColorSet(
            color: namedColor.value,
            darkColor: namedColor.darkValue
        )

        let assetContent = String(
            data: try JSONEncoder().encode(colorSet),
            encoding: .utf8
        )

        assert(
            assetContent ==
                "{\"info\":{\"version\":1,\"author\":\"xcode\"},\"colors\":[{\"color\":{\"color-space\":\"srgb\",\"components\":{\"red\":\"0.424\",\"alpha\":\"1.0\",\"blue\":\"0.49\",\"green\":\"0.459\"}},\"idiom\":\"universal\"},{\"color\":{\"color-space\":\"srgb\",\"components\":{\"red\":\"0.324\",\"alpha\":\"1.0\",\"blue\":\"0.39\",\"green\":\"0.359\"}},\"idiom\":\"universal\",\"appearances\":[{\"appearance\":\"luminosity\",\"value\":\"dark\"}]}]}"
        )
    }
}
