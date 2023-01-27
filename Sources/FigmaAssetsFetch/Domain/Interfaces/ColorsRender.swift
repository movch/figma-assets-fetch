public protocol ColorsRender {
    func render(colors: [ColorAsset], output: String) async throws
}
