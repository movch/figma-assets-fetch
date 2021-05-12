import Combine
import Foundation

enum PaletteExtractorError: Error {
    case canvasReadError
    case colorsFrameReadError
    case colorsFrameChildrenReadError
}

extension PaletteExtractorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .canvasReadError:
            return "Unable to read document canvas"
        case .colorsFrameReadError:
            return "Unable to find document 'Colors' frame"
        case .colorsFrameChildrenReadError:
            return "Unable to find 'Colors frame children"
        }
    }
}

protocol PaletteExtractorType {
    func extract() throws -> [ColorObjectModel]
}

class PaletteExtractor {
    private var figmaFile: FileResponse
    
    init(figmaFile: FileResponse) {
        self.figmaFile = figmaFile
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
        guard
            let styleId = ellipse.styles?["fill"],
            let styleName = styles[styleId]?.name,
            let color = ellipse.fills?.first?.color
        else {
            print("Failed to parse ellipse: \(ellipse.id) \(ellipse.name) \(String(describing: ellipse.fills?.first?.color))")
            return nil
        }
        
        var paletteColor = ColorObjectModel(
            name: styleName,
            camelCaseName: styleName.camelCased,
            hexColor: color.toHex(),
            figmaColor: color
        )
        
        // if opacity of ellipse was set we need to take it
        if let opacity = ellipse.fills?.first?.opacity {
            paletteColor.figmaColor.a = opacity
        }
        
        return paletteColor
    }
}

extension PaletteExtractor: PaletteExtractorType {
    func extract() throws -> [ColorObjectModel] {
        let document = figmaFile.document
        
        guard let canvas = document.children.first(where: { $0.type == .canvas }) else {
            throw PaletteExtractorError.canvasReadError
        }
        guard let colorsFrame = canvas.children?.first(where: { $0.name == "Colors" }) else {
            throw PaletteExtractorError.colorsFrameReadError
        }
        guard let colorsFrameChildren = colorsFrame.children else {
            throw PaletteExtractorError.colorsFrameChildrenReadError
        }
        
        let ellipses = findEllipses(in: colorsFrameChildren)
        let styles = figmaFile.styles
        let paletteColors: [ColorObjectModel] = ellipses.compactMap { ellipse in
            process(ellipse, with: styles)
        }
        
        return paletteColors
    }
}
