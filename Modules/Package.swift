// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Modules",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "Feature-Exercises", targets: ["Feature-Exercises"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Feature-Exercises",
            dependencies: []),
        .testTarget(
            name: "Feature-ExercisesTests",
            dependencies: ["Feature-Exercises"]),
    ]
)
