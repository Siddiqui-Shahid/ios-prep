import Foundation

// Learning-lab — Day 11
// Hybrid hosting notes as compilable markers (UIKit/SwiftUI imports omitted for portability).
// Provenance cousin: Verified · S13 hybrid ownership.

enum HybridHostKind: String, Sendable {
    case uiKitRootHostingSwiftUI
    case swiftUIRootRepresentingUIKit
}

struct DeeplinkIntent: Equatable, Sendable {
    var route: String
    var items: [String: String]
}

/// Single navigation owner — both UIKit and SwiftUI hosts consume this.
protocol AppRouter: Sendable {
    func handle(_ intent: DeeplinkIntent) async
}

/// Cold-start queue: buffer intents until root is ready.
actor DeeplinkInbox {
    private var ready = false
    private var pending: [DeeplinkIntent] = []
    private let router: AppRouter

    init(router: AppRouter) {
        self.router = router
    }

    func markReady() async {
        ready = true
        let batch = pending
        pending.removeAll()
        for intent in batch {
            await router.handle(intent)
        }
    }

    func enqueue(_ intent: DeeplinkIntent) async {
        if ready {
            await router.handle(intent)
        } else {
            pending.append(intent)
        }
    }
}

enum HybridChecklist {
    static let hosting = [
        "addChild / didMove for UIHostingController",
        "Don’t recreate hosting VC every state tick",
        "Pause media on parent disappear",
        "Test safe-area on notched devices",
    ]

    static let representable = [
        "make once; update props",
        "Coordinator for delegates",
        "Stable identity — avoid UUID id in parent body",
        "Keep heavy work out of update",
    ]

    static let navigation = [
        "One router for deeplink + push taps",
        "Queue until root ready",
        "Never dual-mutate NavigationPath and UINavigationController",
    ]
}
