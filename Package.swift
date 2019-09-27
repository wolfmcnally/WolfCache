// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "WolfCache",
    platforms: [
        .iOS(.v12), .macOS(.v10_14), .tvOS(.v12)
    ],
    products: [
        .library(
            name: "WolfCache",
            targets: ["WolfCache"]),
        ],
    dependencies: [
        .package(url: "https://github.com/wolfmcnally/WolfCore", from: "5.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfLog", from: "2.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNIO", from: "1.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfGraphics", from: "1.0.0"),
        .package(url: "https://github.com/wolfmcnally/WolfNetwork", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "WolfCache",
            dependencies: [
                "WolfCore",
                "WolfLog",
                "WolfNIO",
                "WolfGraphics",
                "WolfNetwork",
            ])
        ]
)
