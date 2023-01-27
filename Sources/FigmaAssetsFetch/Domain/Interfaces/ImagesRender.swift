public protocol ImagesRender {
    func render(images: [ImageAsset], output: String) async throws
}
