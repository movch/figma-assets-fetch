import Combine

public protocol RemoteColorsSource {
    func fetchColors() -> AnyPublisher<[NamedColor], Error>
}
