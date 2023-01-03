import Foundation

public struct GetRemoteColorsUseCase {
    let source: RemoteColorsSource
    let render: ColorsRender
    let output: String
    
    public init(source: RemoteColorsSource, render: ColorsRender, output: String) {
        self.source = source
        self.render = render
        self.output = output
    }

    public func run() async throws {
        let colorAssets = try await source.fetchColors()
        try render.render(colors: colorAssets, output: self.output)
    }
}
