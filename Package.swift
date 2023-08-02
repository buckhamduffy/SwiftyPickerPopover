// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "SwiftyPickerPopover",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftyPickerPopover",
            targets: ["SwiftyPickerPopover"])
    ],
    targets: [
        .target(
            name: "SwiftyPickerPopover",
            path: "SwiftyPickerPopover"
        )
    ]
)
