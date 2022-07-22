import XCTest

@testable import FigmaAssetsFetch

class TemplateFileSystemRenderTests: XCTestCase {
    func testTemplateRendering() throws {
        let mockFileWriter = FileWriterMock()
        let render = TemplateFileSystemRender(
            templatePath: Bundle.module.url(forResource: "TestTemplate", withExtension: "stencil")!.path,
            fileWriter: mockFileWriter
        )
        let namedColor = NamedColor(
            name: .init(name: "Bg / Primary"),
            value: .init(r: 0.424, g: 0.459, b: 0.49, a: 1)
        )

        try render.render(colors: [namedColor], output: "/Test.swift")

        assert(mockFileWriter.paths == ["/Test.swift"])
        assert(mockFileWriter.contents == ["\nbgPrimary 0.424 0.459 0.49 1.0 6C757D\n\n"])
    }
}
