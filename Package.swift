// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "SwiftyVersion",
    products: [
        .library(
            name: "SwiftyVersion",
            targets: ["SwiftyVersion"]),
    ],
    targets: [
        .target(
            name: "SwiftyVersion",
            dependencies: [],
            path: "Sources"),
        .testTarget(
            name: "SwiftyVersionTests",
            dependencies: ["SwiftyVersion"]),
    ],
    swiftLanguageVersions: [4]
)
