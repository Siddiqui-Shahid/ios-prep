// swift-tools-version: 5.9
import PackageDescription

/// Learning-lab sketch — not a buildable monorepo package in this repo.
/// Interview fluency: Interface leaves vs Impls vs Core.

let package = Package(
    name: "PortfolioApps",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "Stories", targets: ["Stories"]),
        .library(name: "Checkout", targets: ["Checkout"]),
        .library(name: "CheckoutInterface", targets: ["CheckoutInterface"]),
        .library(name: "CartInterface", targets: ["CartInterface"]),
        .library(name: "CoreNetwork", targets: ["CoreNetwork"]),
    ],
    targets: [
        .target(name: "CoreNetwork", path: "Sources/CoreNetwork"),
        .target(name: "CartInterface", path: "Sources/CartInterface"),
        .target(
            name: "CheckoutInterface",
            dependencies: ["CoreNetwork"],
            path: "Sources/CheckoutInterface"
        ),
        .target(
            name: "Checkout",
            dependencies: ["CheckoutInterface", "CartInterface", "CoreNetwork"],
            path: "Sources/Checkout"
        ),
        // Stories SDK — reusable product; depends on Core abstractions only.
        .target(
            name: "Stories",
            dependencies: ["CoreNetwork"],
            path: "Sources/Stories"
        ),
        // NOTE: Checkout must NOT depend on another feature's Impl target.
    ]
)
