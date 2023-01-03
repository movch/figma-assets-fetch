public protocol RemoteImagesSource {
    func fetchImages() async throws -> [ImageAsset]
}
