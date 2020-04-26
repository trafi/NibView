// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let files = [
    "Sources/NibLoadable.swift",
    "Sources/NibLoader.swift",
    "Sources/NibViewController.swift",
    "NibView.swift"
]

let package = Package(
    name: "NibView",
    products: [
        .library(name: "NibView", targets: ["NibView"])
    ],
    targets: [
        .target(name: "NibView", path: "", sources: files)
    ],
    swiftLanguageVersions: [.v5]
)
