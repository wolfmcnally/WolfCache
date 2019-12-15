// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "WolfCache",
    platforms: [
        .iOS(.v12), .macOS(.v10_13), .tvOS(.v12)
    ],
    products: [
        .library(
            name: "WolfCache",
            type: .dynamic,
            targets: ["WolfCache"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfFoundation", from: "5.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfLog", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNIO", from: "1.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfConcurrency", from: "3.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNetwork", from: "5.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfImage", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "WolfCache",
            dependencies: [
                "WolfFoundation",
                "WolfLog",
                "WolfNIO",
                "WolfConcurrency",
                "WolfNetwork",
                "WolfImage"
            ])
        ]
)
