public struct GetRemoteImagesUseCase {
    let source: RemoteImagesSource
    let render: ImagesRender
    let output: String
    
    public init(source: RemoteImagesSource, render: ImagesRender, output: String) {
        self.source = source
        self.render = render
        self.output = output
    }

    public func run() async throws {
        let images = try await source.fetchImages()
        try render.render(images: images, output: self.output)
    }
}
