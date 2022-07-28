import XCTest

@testable import FigmaAssetsFetch

class NamedColorTests: XCTestCase {
    func testSnakeCaseNameGeneration() {
        let namedColor = ColorAsset(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )

        assert(namedColor.name.snakeCased == "bg_primary")

        let namedColor2 = ColorAsset(
            name: .init(name: "Bg/Primary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )

        assert(namedColor2.name.snakeCased == "bg_primary")

        let namedColor3 = ColorAsset(
            name: .init(name: "BgPrimary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )

        assert(namedColor3.name.snakeCased == "bgprimary")
    }

    func testCamelCaseNameGeneration() {
        let namedColor = ColorAsset(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )

        assert(namedColor.name.camelCased == "bgPrimary")
    }

    func testColorHexValue() {
        let namedColor = ColorAsset(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 1)
        )

        assert(namedColor.value.hexValue == "6C757D")
    }

    func testColorHexWithAlphaValue() {
        let namedColor = ColorAsset(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 0.4)
        )

        assert(namedColor.value.fullHexValue == "666C757D")
    }
}
