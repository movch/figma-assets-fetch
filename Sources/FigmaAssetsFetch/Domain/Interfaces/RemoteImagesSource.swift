import Combine

public protocol RemoteImagesSource {
    func fetchImages() -> AnyPublisher<[Image], Error>
}
