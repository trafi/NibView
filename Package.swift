// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NibView",
    products: [
        .library(name: "NibView", targets: ["NibView"])
    ],
    targets: [
        .target(name: "NibView", dependencies: [], path: "Sources")
    ],
    swiftLanguageVersions: [.v5]
)
