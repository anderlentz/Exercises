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
        .library(name: "CoreUI", targets: ["CoreUI"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Feature-Exercises",
            dependencies: [
                "CoreUI",
                "Shared-DataLoader",
                .product(name: "CombineSchedulers", package: "combine-schedulers")
            ]
        ),
        .testTarget(
            name: "Feature-ExercisesTests",
            dependencies: ["Feature-Exercises"]
        ),
        .target(
            name: "CoreUI",
            dependencies: [
                "Shared-DataLoader"
            ]
        ),
        .testTarget(
            name: "CoreUI-Tests",
            dependencies: ["CoreUI"]
        ),
        .target(
            name: "Shared-DataLoader",
            dependencies: []
        ),
    ]
)
