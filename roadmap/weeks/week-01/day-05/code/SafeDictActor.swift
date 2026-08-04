// SafeDictActor.swift
// Day 05 Learning-lab example — NOT a claim of shipped BMS code.
// Contrast with Day 04 GCD serial-queue SafeDict (Verified · S2).
// Greenfield direction: How I would apply it · S2-A1.
//
// Key teaching points:
// 1. Actor isolates mutable storage — external callers must await.
// 2. Key/Value are Sendable so values can cross isolation domains safely.
// 3. Never return a mutable interior reference that callers can race.
// 4. After any `await` inside an actor method, re-validate state (reentrancy).

import Foundation

/// Thread-safe dictionary boundary using a Swift actor.
///
/// Interview pitch:
/// “Production shared maps at BMS used GCD serial queues (S2).
///  For greenfield modules I’d expose an actor with the same safe API surface (S2-A1).”
actor SafeDictActor<Key: Hashable & Sendable, Value: Sendable> {
    private var storage: [Key: Value] = [:]

    func get(_ key: Key) -> Value? {
        storage[key]
    }

    func set(_ key: Key, value: Value) {
        storage[key] = value
    }

    func remove(_ key: Key) {
        storage.removeValue(forKey: key)
    }

    /// Returns a value-type snapshot. Callers cannot mutate `storage` through this.
    func snapshot() -> [Key: Value] {
        storage
    }

    func count() -> Int {
        storage.count
    }

    func merge(_ other: [Key: Value]) {
        for (key, value) in other {
            storage[key] = value
        }
    }

    // MARK: - Reentrancy teaching note (intentionally illustrative)

    /// BROKEN PATTERN — do not copy into production without hardening.
    ///
    /// Demonstrates actor reentrancy: while we `await` the loader, another task
    /// may enter this actor and change `storage[key]`. Assuming continuity across
    /// the await is a logic bug even though there is no data race on `storage`.
    ///
    /// Hardening options:
    /// - Re-read `storage[key]` after await and decide with explicit policy
    /// - Use a generation token per key
    /// - Perform loading outside, then apply a short synchronous set
    func brokenLoadIfMissing(
        _ key: Key,
        loader: @Sendable () async -> Value
    ) async -> Value {
        if let existing = storage[key] {
            return existing
        }

        // Suspension point: other tasks may mutate `storage` before we resume.
        let loaded = await loader()

        // BUG intuition: "still missing, so I can set."
        // Reality: another task may have set/removed this key during `await`.
        // A correct version re-checks and applies a defined merge policy:
        if let existing = storage[key] {
            return existing
        }
        storage[key] = loaded
        return loaded
    }

    /// Safer single-flight-ish variant for teaching:
    /// re-check after await; first writer wins; late loader result discarded if raced.
    func loadIfMissing(
        _ key: Key,
        loader: @Sendable () async -> Value
    ) async -> Value {
        if let existing = storage[key] {
            return existing
        }

        let loaded = await loader()

        if let existing = storage[key] {
            // Someone else populated while we were loading.
            return existing
        }
        storage[key] = loaded
        return loaded
    }
}

// MARK: - Usage sketch (Learning-lab)

enum SafeDictActorDemo {
    static func sketch() async {
        let dict = SafeDictActor<String, Int>()

        await dict.set("venue.42", value: 10)
        let value = await dict.get("venue.42")
        let copy = await dict.snapshot()

        // `copy` is independent; mutating it does not affect actor storage.
        _ = value
        _ = copy
    }
}

/*
 Day 04 GCD contrast (conceptual):

 final class GCDSafeDict<Key: Hashable, Value> {
   private let queue = DispatchQueue(label: "safe.dict")
   private var storage: [Key: Value] = [:]

   func get(_ key: Key) -> Value? {
     queue.sync { storage[key] }
   }

   func set(_ key: Key, value: Value) {
     queue.async { self.storage[key] = value }
   }
 }

 Trade-offs to say aloud:
 - GCD: sync get can deadlock if misused on same queue; isolation is convention.
 - Actor: compiler isolation; APIs are async from outside; reentrancy across await.
 */
