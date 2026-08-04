import Foundation

/// Learning-lab: lock-free-ish ring for crash breadcrumbs (conceptual).
/// Real crash SDKs use carefully audited concurrent structures.
/// Never treat this as production crash-safe code.

struct Breadcrumb: Sendable {
    let timestamp: Date
    let category: String
    let message: String
}

final class BreadcrumbRing: @unchecked Sendable {
    private let capacity: Int
    private var storage: [Breadcrumb?]
    private var index: Int = 0
    private let lock = NSLock() // happy-path only — NOT async-signal-safe

    init(capacity: Int = 64) {
        self.capacity = capacity
        self.storage = Array(repeating: nil, count: capacity)
    }

    func add(category: String, message: String) {
        let scrubbed = Self.scrub(message)
        let crumb = Breadcrumb(timestamp: Date(), category: category, message: scrubbed)
        lock.lock()
        storage[index % capacity] = crumb
        index += 1
        lock.unlock()
    }

    func snapshot() -> [Breadcrumb] {
        lock.lock()
        defer { lock.unlock() }
        let ordered = (0..<capacity).compactMap { offset -> Breadcrumb? in
            let i = (index + offset) % capacity
            return storage[i]
        }
        return ordered
    }

    /// Interview point: scrub at source — never keep Authorization headers.
    static func scrub(_ message: String) -> String {
        var out = message
        for key in ["Authorization", "token", "password", "refresh_token"] {
            if out.lowercased().contains(key.lowercased()) {
                out = "<redacted>"
                break
            }
        }
        return out
    }
}

/*
 Say aloud:
 - Breadcrumbs are recorded on the happy path.
 - Signal handlers must not take locks / allocate casually.
 - Production rings are audited for crash-time reads.

 Provenance: Learning-lab
 */
