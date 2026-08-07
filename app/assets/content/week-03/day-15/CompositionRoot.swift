import Foundation

// Learning-lab DI composition root sketch (Needle-inspired, no Needle dependency).

protocol NetworkProviding: Sendable {
    func get(url: URL) async throws -> Data
}

protocol CartProviding: Sendable {
    var itemCount: Int { get }
}

protocol CheckoutDependency: AnyObject {
    var network: NetworkProviding { get }
    var cart: CartProviding { get }
}

protocol CheckoutBuildable {
    @MainActor func makeCheckoutEntry() -> String // stand-in for UIViewController
}

final class CheckoutComponent: CheckoutBuildable {
    private let dependency: CheckoutDependency
    init(dependency: CheckoutDependency) { self.dependency = dependency }

    @MainActor
    func makeCheckoutEntry() -> String {
        "Checkout(items: \(dependency.cart.itemCount))"
    }
}

/// App = composition root. Features never call `.shared` network.
final class AppComponent: CheckoutDependency {
    let network: NetworkProviding
    let cart: CartProviding

    private(set) lazy var checkoutBuilder: CheckoutBuildable = CheckoutComponent(dependency: self)

    init(network: NetworkProviding, cart: CartProviding) {
        self.network = network
        self.cart = cart
    }
}

// MARK: - Fakes for interview narration

struct FakeNetwork: NetworkProviding {
    func get(url: URL) async throws -> Data { Data() }
}

struct FakeCart: CartProviding {
    let itemCount: Int
}

enum CompositionRootDemo {
    @MainActor
    static func run() {
        let app = AppComponent(network: FakeNetwork(), cart: FakeCart(itemCount: 2))
        print(app.checkoutBuilder.makeCheckoutEntry())
    }
}
