import Foundation

public protocol ColorsRender {
    func render(colors: [NamedColor], output: String) throws
}
