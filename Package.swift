// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SegmentedProgressViewStyle",
    platforms: [
        .iOS(.v17), .macOS(.v14)
    ],
    products: [
        .library(
            name: "SegmentedProgressViewStyle",
            targets: ["SegmentedProgressViewStyle"]
        )
    ],
    targets: [
        .target(
            name: "SegmentedProgressViewStyle"
        ),
        .testTarget(
            name: "SegmentedProgressViewStyleTests",
            dependencies: ["SegmentedProgressViewStyle"]
        )
    ]
)
