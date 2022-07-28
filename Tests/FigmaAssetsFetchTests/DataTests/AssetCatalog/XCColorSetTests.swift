import XCTest

@testable import FigmaAssetsFetch

class XCColorSetTests: XCTestCase {
    func testColorSetContentGeneration() throws {
        let namedColor = ColorAsset(
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
        let namedColor = ColorAsset(
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
