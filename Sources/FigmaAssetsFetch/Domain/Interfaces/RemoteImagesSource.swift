import Combine

public protocol RemoteImagesSource {
    func fetchImages() -> AnyPublisher<[ImageAsset], Error>
}
