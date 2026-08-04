import Foundation

// MARK: - Single-flight token refresh (actor-safe)
//
// Learning-lab example for Day 09.
//
// CORRECTNESS RULES:
// 1. Do NOT mutate actor state inside an unstructured `Task { }` body.
//    That pattern races actor isolation (common buggy sample).
// 2. Concurrent callers must share one in-flight refresh (single-flight).
// 3. Success / failure fans out to all waiters.
// 4. Clear "refreshing" BEFORE resuming waiters so a resumed caller that
//    immediately refreshes again does not join a drained waiter list.

/// Coordinates concurrent token refresh so N parallel 401s share one refresh.
actor SingleFlightRefresh {
    private var accessToken: String?
    private var isRefreshing = false
    private var waiters: [CheckedContinuation<String, Error>] = []

    /// Latest access token known to this coordinator (optional mirror of Keychain).
    func currentAccessToken() -> String? {
        accessToken
    }

    /// Install a token after login / bootstrap (Keychain remains source of truth in apps).
    func setAccessToken(_ token: String?) {
        accessToken = token
    }

    /// Runs `performRefresh` once while concurrent callers await the same result.
    ///
    /// - Parameter performRefresh: Sendable network work that returns a new access token.
    ///   Must not capture this actor unsafely; typically reads refresh token from Keychain
    ///   and hits `/oauth/token`.
    @discardableResult
    func refresh(
        performRefresh: @Sendable () async throws -> String
    ) async throws -> String {
        if isRefreshing {
            return try await withCheckedThrowingContinuation { continuation in
                waiters.append(continuation)
            }
        }

        isRefreshing = true

        do {
            let token = try await performRefresh()
            accessToken = token

            let pending = waiters
            waiters = []
            isRefreshing = false
            pending.forEach { $0.resume(returning: token) }

            return token
        } catch {
            let pending = waiters
            waiters = []
            isRefreshing = false
            pending.forEach { $0.resume(throwing: error) }

            throw error
        }
    }
}

// MARK: - Alternative sketch (Task join) — mutations stay on the actor
//
// This variant is also acceptable IF the unstructured Task only runs network
// work and does not write actor-isolated properties. Assignment happens after
// `await` resumes on the actor.
//
// actor SingleFlightRefreshTaskJoin {
//     private var inFlight: Task<String, Error>?
//     private var accessToken: String?
//
//     func refresh(
//         performRefresh: @Sendable @escaping () async throws -> String
//     ) async throws -> String {
//         if let inFlight {
//             return try await inFlight.value
//         }
//
//         let task = Task {
//             // ✅ Network only — no `self.accessToken = …` here.
//             try await performRefresh()
//         }
//         inFlight = task
//
//         do {
//             let token = try await task.value
//             // ✅ Actor-isolated mutation after await.
//             accessToken = token
//             inFlight = nil
//             return token
//         } catch {
//             inFlight = nil
//             throw error
//         }
//     }
// }
//
// Note: multiple waiters finishing cleanup can race a *new* in-flight task if
// you nil `inFlight` from every waiter. Prefer the continuation design above,
// or clear only from the creator path with a generation token.

// MARK: - Tiny usage sketch (not a full NetworkClient)

enum DemoRefreshError: Error {
    case refreshRejected
}

func demoSingleFlight() async throws {
    let gate = SingleFlightRefresh()

    // Simulate three parallel 401 handlers sharing one refresh.
    async let a: String = gate.refresh {
        try await Task.sleep(nanoseconds: 50_000_000)
        return "access-token-1"
    }
    async let b: String = gate.refresh {
        // Should not run if single-flight works — first caller owns performRefresh.
        // In real clients only the leader executes; waiters never call this closure.
        // Here each call site passes the same closure; the actor still ensures
        // only one execution while `isRefreshing` is true.
        try await Task.sleep(nanoseconds: 50_000_000)
        return "access-token-1"
    }
    async let c: String = gate.refresh {
        try await Task.sleep(nanoseconds: 50_000_000)
        return "access-token-1"
    }

    let tokens = try await [a, b, c]
    precondition(Set(tokens).count == 1)
    _ = await gate.currentAccessToken()
}

/*
 ❌ ANTI-PATTERN — do not use:

 actor BrokenRefresh {
     private var accessToken: String?
     private var refreshTask: Task<String, Error>?

     func refresh() async throws -> String {
         if let refreshTask { return try await refreshTask.value }
         let task = Task {
             let token = try await hitNetwork()
             self.accessToken = token  // racy: Task body is not actor-isolated
             return token
         }
         refreshTask = task
         defer { refreshTask = nil }
         return try await task.value
     }

     private func hitNetwork() async throws -> String { "x" }
 }
*/
