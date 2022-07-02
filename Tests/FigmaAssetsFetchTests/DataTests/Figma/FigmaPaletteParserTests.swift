import XCTest

@testable import FigmaAssetsFetch

class FigmaPaletteParserTests: XCTestCase {
    func testPalleteParsing() throws {
        let json = FigmaJSON.examplePalleteWithStyles
        let data = json.data(using: .utf8)
        let figmaNodes = try JSONDecoder().decode(FileNodesResponse.self, from: data!)
        let parsedColors = try FigmaPaletteParser(figmaNodes: figmaNodes)
            .extract()
            .sorted(by: { $0.name.snakeCased < $1.name.snakeCased })

        assert(parsedColors.count == 5)
        assert(
            parsedColors
                .map { $0.name.snakeCased } == ["bg_danger", "bg_info", "bg_primary", "bg_secondary", "bg_success"]
        )
        assert(parsedColors.map { $0.value.hexValue } == ["DC3545", "17A2B8", "007BFF", "6C757D", "28A745"])
    }
}
