import XCTest

@testable import FigmaAssetsFetch

class NamedColorTests: XCTestCase {
    func testSnakeCaseNameGeneration() {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )
        
        assert(namedColor.name.snakeCased == "bg_primary")
    }
    
    func testCamelCaseNameGeneration() {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0, g: 0, b: 0, a: 0)
        )
        
        assert(namedColor.name.camelCased == "bgPrimary")
    }
    
    func testColorHexValue() {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 1)
        )
        
        assert(namedColor.value.hexValue == "6C757D")
    }
    
    func testColorHexWithAlphaValue() {
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 0.4)
        )
        
        assert(namedColor.value.fullHexValue == "666C757D")
    }
}
