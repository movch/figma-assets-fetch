import Combine
import Foundation

enum FigmaPaletteParserError: Error {
    case colorsFrameReadError
}

extension FigmaPaletteParserError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .colorsFrameReadError:
            return "Unable to find document 'Colors' frame"
        }
    }
}

protocol FigmaPaletteParserType {
    func extract() throws -> [ColorObjectModel]
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
    
    private func process(_ ellipse: Document, with styles: [String: Style]) -> ColorObjectModel? {
        guard let color = ellipse.fills?.first?.color else {
            print("Failed to parse ellipse: \(ellipse.id) \(ellipse.name)")
            return nil
        }
        
        var styleName = ellipse.name
        if let styleId = ellipse.styles?["fill"],
           let styleTitle = styles[styleId]?.name{
            styleName = styleTitle
        }

        var paletteColor = ColorObjectModel(
            name: styleName,
            camelCaseName: styleName.camelCased,
            snakeCaseName: styleName.snakeCased,
            hexColor: color.toHex(),
            fullHexColor: color.toFullHex(),
            figmaColor: color
        )
        
        // if opacity of ellipse was set we need to take it
        if let opacity = ellipse.fills?.first?.opacity {
            paletteColor.figmaColor.a = opacity
            paletteColor.fullHexColor = paletteColor.figmaColor.toFullHex()
        }
        
        return paletteColor
    }
}

extension FigmaPaletteParser: FigmaPaletteParserType {
    func extract() throws -> [ColorObjectModel] {
        guard let colorsNode = figmaNodes.nodes.first?.value else {
            throw FigmaPaletteParserError.colorsFrameReadError
        }
        
        let colorsFrameChildren = colorsNode.document.children
        
        let ellipses = findEllipses(in: colorsFrameChildren)
        let styles = colorsNode.styles
        let paletteColors: [ColorObjectModel] = ellipses.compactMap { ellipse in
            process(ellipse, with: styles)
        }
        
        return paletteColors
    }
}
