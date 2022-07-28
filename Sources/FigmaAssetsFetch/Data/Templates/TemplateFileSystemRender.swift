import Foundation
import PathKit
import Stencil

public enum TemplateFileSystemRenderError: Error {
    case invalidTemplatePath
    case invalidOutputPath
}

public struct TemplateFileSystemRender {
    private let templatePath: String
    private let fileWriter: FileWriterType

    public init(
        templatePath: String,
        fileWriter: FileWriterType = FileWriter()
    ) {
        self.templatePath = templatePath
        self.fileWriter = fileWriter
    }
}

extension TemplateFileSystemRender: ColorsRender {
    public func render(colors: [ColorAsset], output: String) throws {
        guard let templateURL = URL(string: "file://\(templatePath)"),
              templateURL.lastPathComponent.contains(".stencil")
        else {
            throw TemplateFileSystemRenderError.invalidTemplatePath
        }

        guard let outputURL = URL(string: "file://\(output)") else {
            throw TemplateFileSystemRenderError.invalidOutputPath
        }

        let context = ["colors": colors]

        let environment = Environment(
            loader: FileSystemLoader(
                paths: [
                    Path(templateURL.deletingLastPathComponent().path),
                ]
            )
        )

        let rendered = try environment.renderTemplate(
            name: templateURL.lastPathComponent,
            context: context
        )

        try fileWriter.write(content: rendered, at: outputURL)
    }
}
