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
    func extract() throws -> [NamedColor]
}

class FigmaPaletteParser {
    private var figmaNodes: FileNodesResponse

    init(figmaNodes: FileNodesResponse) {
        self.figmaNodes = figmaNodes
    }

    private func findEllipses(in root: [FigmaDocument]) -> [FigmaDocument] {
        var result = [FigmaDocument]()

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

    private func process(_ ellipse: FigmaDocument, with styles: [String: Style]) -> NamedColor? {
        guard let color = ellipse.fills?.first?.color else {
            print("Failed to parse ellipse: \(ellipse.id) \(ellipse.name)")
            return nil
        }

        let styleName: String = extractStyleName(from: ellipse, with: styles)
        let alphaValue: Double = extractAlphaValue(from: ellipse, and: color)

        let extractedColor = NamedColor(
            name: .init(name: styleName),
            value: .init(
                r: color.r,
                g: color.g,
                b: color.b,
                a: alphaValue
            )
        )

        return extractedColor
    }

    private func extractStyleName(from ellipse: FigmaDocument, with styles: [String: Style]) -> String {
        if let styleId = ellipse.styles?["fill"],
           let styleTitle = styles[styleId]?.name
        {
            return styleTitle
        }

        return ellipse.name
    }

    private func extractAlphaValue(from ellipse: FigmaDocument, and color: FigmaColor) -> Double {
        if let opacity = ellipse.fills?.first?.opacity {
            // if opacity of ellipse was set we need to take it
            return opacity
        }

        return color.a
    }
}

extension FigmaPaletteParser: FigmaPaletteParserType {
    func extract() throws -> [NamedColor] {
        guard let colorsNode = figmaNodes.nodes.first?.value else {
            throw FigmaPaletteParserError.colorsFrameReadError
        }

        let colorsFrameChildren = colorsNode.document.children

        let ellipses = findEllipses(in: colorsFrameChildren)
        let styles = colorsNode.styles
        let paletteColors: [NamedColor] = ellipses.compactMap { ellipse in
            process(ellipse, with: styles)
        }

        return paletteColors
    }
}
