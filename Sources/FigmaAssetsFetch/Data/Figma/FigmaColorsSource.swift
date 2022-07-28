import Combine

public enum FigmaColorsSourceError: Error {
    case incorrectFigmaFrameURL
}

public struct FigmaColorsSource: RemoteColorsSource {
    private let colorsURLPath: String
    private let darkColorsURLPath: String?

    private let figmaAPI: FigmaAPIType
    private let figmaURLParser: FigmaURLParserType
    private let figmaPalleteParser: FigmaPaletteParserType

    public init(
        colorsURLPath: String,
        darkColorsURLPath: String? = nil,
        figmaAPI: FigmaAPIType,
        figmaURLParser: FigmaURLParserType = FigmaURLParser(),
        figmaPalleteParser: FigmaPaletteParserType = FigmaPaletteParser()
    ) {
        self.colorsURLPath = colorsURLPath
        self.darkColorsURLPath = darkColorsURLPath
        self.figmaAPI = figmaAPI
        self.figmaURLParser = figmaURLParser
        self.figmaPalleteParser = figmaPalleteParser
    }

    public func fetchColors() -> AnyPublisher<[ColorAsset], Error> {
        guard let figmaFileId = try? figmaURLParser.extractFileId(from: colorsURLPath),
              let colorsNodeId = try? figmaURLParser.extractNodeId(from: colorsURLPath)
        else {
            return Fail(error: FigmaColorsSourceError.incorrectFigmaFrameURL)
                .eraseToAnyPublisher()
        }

        let colorsRequest = figmaAPI.requestFile(with: figmaFileId, nodeId: colorsNodeId)
        let darkColorsRequest: AnyPublisher<FileNodesResponse, Error> = {
            guard let darkColorsNodeURL = self.darkColorsURLPath,
                  let darkColorsFileId = try? figmaURLParser.extractFileId(from: darkColorsNodeURL),
                  let darkColorsNodeId = try? figmaURLParser.extractNodeId(from: darkColorsNodeURL)
            else {
                return Just(FileNodesResponse(nodes: [:], name: ""))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }

            return figmaAPI.requestFile(with: darkColorsFileId, nodeId: darkColorsNodeId)
        }()

        return Publishers.Zip(colorsRequest, darkColorsRequest)
            .tryMap { colorsFigmaNodes, darkColorsFigmaNodes in
                let namedColors = try figmaPalleteParser.extract(figmaNodes: colorsFigmaNodes)
                let darkNamedColors = (try? figmaPalleteParser.extract(figmaNodes: darkColorsFigmaNodes)) ?? []
                return namedColors.map { namedColor in
                    ColorAsset(
                        name: namedColor.name,
                        value: namedColor.value,
                        darkValue: darkNamedColors.first(where: { darkNamedColor in
                            darkNamedColor.name.original.contains(namedColor.name.original)
                        })?.value
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
