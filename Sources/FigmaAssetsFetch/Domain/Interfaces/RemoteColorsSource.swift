public protocol RemoteColorsSource {
    func fetchColors() async throws -> [ColorAsset]
}
