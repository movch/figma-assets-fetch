import XCTest

@testable import FigmaAssetsFetch

class FigmaURLParserTests: XCTestCase {
    func testFileIdParsing() throws {
        let figmaURLParser = FigmaURLParser()
        let inputUrl =
            "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3"

        let extractedId = try figmaURLParser.extractFileId(from: inputUrl)

        assert(extractedId == "1z5n1txr0nz7qMVzcS3Oif")
    }

    func testNodeIdParsing() throws {
        let figmaURLParser = FigmaURLParser()
        let inputUrl =
            "https://www.figma.com/file/1z5n1txr0nz7qMVzcS3Oif/figma-assets-fetch-palette-example?node-id=1%3A3"

        let extractedId = try figmaURLParser.extractNodeId(from: inputUrl)

        assert(extractedId == "1:3")
    }
}
