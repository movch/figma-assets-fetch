import Combine

public struct GetRemoteImagesUseCase {
    public let source: RemoteImagesSource
    public let render: ImagesRender

    public let output: String

    func run() -> AnyPublisher<Void, Error> {
        return source.fetchImages()
            .tryMap { images in
                try render.render(images: images, output: self.output)
                return ()
            }
            .eraseToAnyPublisher()
    }
}
