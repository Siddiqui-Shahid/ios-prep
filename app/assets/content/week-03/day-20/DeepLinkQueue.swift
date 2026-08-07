import Foundation

/// Learning-lab: cold-start deep link queue (S13 navigation mindset).

enum AppRoute: Equatable, Sendable {
    case home
    case event(id: String)
    case checkout(cartId: String)
    case unknown(raw: String)
}

struct DeepLinkParser {
    func parse(_ url: URL) -> AppRoute {
        // Illustrative only — real apps validate host allowlist + path schema.
        guard let host = url.host, host.hasSuffix("example.com") || url.scheme == "myapp" else {
            return .unknown(raw: url.absoluteString)
        }
        let parts = url.path.split(separator: "/").map(String.init)
        if parts.first == "events", parts.count >= 2 {
            return .event(id: parts[1])
        }
        if parts.first == "checkout", let cart = URLComponents(url: url, resolvingAgainstBaseURL: false)?
            .queryItems?.first(where: { $0.name == "cartId" })?.value {
            return .checkout(cartId: cart)
        }
        if parts.isEmpty || parts == [""] { return .home }
        return .unknown(raw: url.absoluteString)
    }
}

actor PendingDeepLinkStore {
    private var pending: AppRoute?

    func enqueue(_ route: AppRoute) {
        // Latest wins — avoid stacking stale cold-start intents.
        pending = route
    }

    func flush() -> AppRoute? {
        defer { pending = nil }
        return pending
    }
}

@MainActor
final class AppCoordinator {
    private let parser = DeepLinkParser()
    private let pending = PendingDeepLinkStore()
    private(set) var isReady = false

    func markReady() async {
        isReady = true
        if let route = await pending.flush() {
            navigate(route)
        }
    }

    func handleIncomingURL(_ url: URL) async {
        let route = parser.parse(url)
        let safe: AppRoute
        switch route {
        case .checkout:
            // Auth gate would live here — never trust query price.
            safe = route
        case .unknown:
            safe = .home
        default:
            safe = route
        }
        if isReady {
            navigate(safe)
        } else {
            await pending.enqueue(safe)
        }
    }

    func navigate(_ route: AppRoute) {
        // Wire to UIKit/SwiftUI stack ownership (S13 hybrid lesson).
        print("navigate → \(route)")
    }
}

/*
 Interview lines:
 - One parser/router for UL + push entrypoints.
 - Queue until ready on cold start.
 - Unknown → home + metric (metric omitted here).

 Provenance: Learning-lab · mirrors Verified · S13 routing concerns
 */
