import Combine

public protocol RemoteColorsSource {
    func fetchColors() -> AnyPublisher<[ColorAsset], Error>
}
