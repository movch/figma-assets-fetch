import Combine
import Foundation

enum FigmaPaletteParserError: Error {
    case colorsFrameReadError
}

extension FigmaPaletteParserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .colorsFrameReadError:
            return "Unable to find specified node"
        }
    }
}

protocol FigmaPaletteParserType {
    func extract() throws -> [ColorData]
}

class FigmaPaletteParser {
    private var figmaNodes: FileNodesResponse

    init(figmaNodes: FileNodesResponse) {
        self.figmaNodes = figmaNodes
    }

    private func findEllipses(in root: [Document]) -> [Document] {
        var result = [Document]()

        for document in root {
            if document.type == .ellipse {
                result.append(document)
            }

            if let children = document.children {
                result.append(contentsOf: findEllipses(in: children))
            }
        }

        return result
    }

    private func process(_ ellipse: Document, with styles: [String: Style]) -> ColorData? {
        guard let color = ellipse.fills?.first?.color else {
            print("Failed to parse ellipse: \(ellipse.id) \(ellipse.name)")
            return nil
        }

        var styleName = ellipse.name
        if let styleId = ellipse.styles?["fill"],
           let styleTitle = styles[styleId]?.name
        {
            styleName = styleTitle
        }

        var extractedColor = ColorData(
            name: styleName,
            camelCaseName: styleName.camelCased,
            snakeCaseName: styleName.snakeCased,
            hexColor: color.toHex(),
            fullHexColor: color.toFullHex(),
            figmaColor: color
        )

        // if opacity of ellipse was set we need to take it
        if let opacity = ellipse.fills?.first?.opacity {
            extractedColor.figmaColor.a = opacity
            extractedColor.fullHexColor = extractedColor.figmaColor.toFullHex()
        }

        return extractedColor
    }
}

extension FigmaPaletteParser: FigmaPaletteParserType {
    func extract() throws -> [ColorData] {
        guard let colorsNode = figmaNodes.nodes.first?.value else {
            throw FigmaPaletteParserError.colorsFrameReadError
        }

        let colorsFrameChildren = colorsNode.document.children

        let ellipses = findEllipses(in: colorsFrameChildren)
        let styles = colorsNode.styles
        let paletteColors: [ColorData] = ellipses.compactMap { ellipse in
            process(ellipse, with: styles)
        }

        return paletteColors
    }
}
