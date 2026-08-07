import Foundation

// Learning-lab — Day 10
// Last-known-good + baked default fallback for SDUI payloads.

protocol SDUICache: Sendable {
    func load(key: String) -> SDUIDocument?
    func save(_ document: SDUIDocument, key: String)
    func clear(key: String)
}

actor InMemorySDUICache: SDUICache {
    private var storage: [String: SDUIDocument] = [:]

    func load(key: String) -> SDUIDocument? { storage[key] }
    func save(_ document: SDUIDocument, key: String) { storage[key] = document }
    func clear(key: String) { storage[key] = nil }
}

enum FallbackReason: String, Sendable {
    case offline
    case versionReject
    case parseFailure
    case emptyRoot
    case timeout
}

struct FallbackEngine: Sendable {
    var cache: SDUICache
    var bakedDefault: SDUIDocument
    var cacheKey: String
    /// Include user id for personalized payloads — clear on logout.
    static func cacheKey(surface: String, userId: String?) -> String {
        "sdui:\(surface):\(userId ?? "guest")"
    }

    func resolveFailure(reason: FallbackReason) async -> SDUIDocument {
        if let cached = await cache.load(key: cacheKey) {
            return cached
        }
        return bakedDefault
    }

    func rememberSuccess(_ document: SDUIDocument) async {
        await cache.save(document, key: cacheKey)
    }
}

/// Splash policy illustration: prefer cache; network with timeout; else default.
struct SplashLoader: Sendable {
    var gate: SchemaVersionGate
    var registry: ComponentRegistry
    var fallback: FallbackEngine
    var fetch: @Sendable () async throws -> SDUIDocument
    var timeoutNanoseconds: UInt64

    func load() async -> ResolvedNode {
        // 1) Try network with timeout
        let networked: SDUIDocument? = await withTaskGroup(of: SDUIDocument?.self) { group in
            group.addTask { try? await fetch() }
            group.addTask {
                try? await Task.sleep(nanoseconds: timeoutNanoseconds)
                return nil
            }
            for await value in group {
                group.cancelAll()
                return value
            }
            return nil
        }

        if let doc = networked {
            switch gate.evaluate(doc) {
            case .accept(let accepted):
                if let resolved = registry.resolveRoot(accepted), !isMeaningless(resolved) {
                    await fallback.rememberSuccess(accepted)
                    return resolved
                }
            case .rejectTooNew, .rejectTooOld:
                break
            }
        }

        let fb = await fallback.resolveFailure(reason: networked == nil ? .timeout : .versionReject)
        if case .accept(let accepted) = gate.evaluate(fb), let resolved = registry.resolveRoot(accepted) {
            return resolved
        }
        // Baked default assumed compatible
        return registry.resolveRoot(fallback.bakedDefault) ?? .element(type: "logo", id: "fallback", props: [:], children: [], action: nil)
    }

    private func isMeaningless(_ node: ResolvedNode) -> Bool {
        if case .element(let type, _, _, let children, _) = node {
            return type != "logo" && children.isEmpty && type != "vstack"
        }
        return true
    }
}
