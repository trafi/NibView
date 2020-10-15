// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let sourceFiles = [
    "Sources/NibLoadable.swift",
    "Sources/NibLoader.swift",
    "Sources/NibViewController.swift",
    "NibView.swift"
]

let excludedFiles = [
    "Example",
    "Img",
    "README.md",
    "CODEOWNERS",
    "LICENSE"
]

let package = Package(
    name: "NibView",
    defaultLocalization: "en",
    products: [
        .library(name: "NibView", targets: ["NibView"])
    ],
    targets: [
        .target(name: "NibView", path: "", exclude: excludedFiles, sources: sourceFiles)
    ],
    swiftLanguageVersions: [.v5]
)
