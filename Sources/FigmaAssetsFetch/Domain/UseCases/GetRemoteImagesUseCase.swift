public struct GetRemoteImagesUseCase {
    public let source: RemoteImagesSource
    public let render: ImagesRender

    public let output: String

    func run() async throws {
        let images = try await source.fetchImages()
        try render.render(images: images, output: self.output)
    }
}
