// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "FigmaAssetsFetch",
    platforms: [.macOS(.v12)],
    products: [
        .executable(name: "figma-assets-fetch", targets: ["FigmaAssetsFetch"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stencilproject/Stencil", from: "0.13.1"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.1"),
    ],
    targets: [
        .executableTarget(
            name: "FigmaAssetsFetch",
            dependencies: [
                .product(name: "Stencil", package: "Stencil"),
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget(
            name: "FigmaAssetsFetchTests",
            dependencies: ["FigmaAssetsFetch"],
            resources: [
                .process("Resources"),
            ]
        ),
    ]
)
