// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpotlightTutorial",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
    ],
    products: [
        .library(
            name: "SpotlightTutorial",
            targets: ["SpotlightTutorial"]
        ),
    ],
    targets: [
        .target(
            name: "SpotlightTutorial",
            dependencies: []
        ),
    ]
)
