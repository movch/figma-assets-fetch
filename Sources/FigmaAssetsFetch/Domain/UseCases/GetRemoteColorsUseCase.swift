import Foundation

public struct GetRemoteColorsUseCase {
    let source: RemoteColorsSource
    let render: ColorsRender
    let output: String

    func run() async throws {
        let colorAssets = try await source.fetchColors()
        try render.render(colors: colorAssets, output: self.output)
    }
}
