import Combine
import Foundation

public struct GetRemoteColorsUseCase {
    let source: RemoteColorsSource
    let render: ColorsRender
    let output: String

    func run() -> AnyPublisher<Void, Error> {
        return source.fetchColors()
            .tryMap { namedColors in
                try render.render(colors: namedColors, output: self.output)
                return ()
            }
            .eraseToAnyPublisher()
    }
}
