// BarrierDict.swift
// Day 04 Learning-lab — concurrent queue + barrier reader-writer pattern.
// S2 mentioned RW locks where read-heavy — this is the GCD barrier teaching twin.
// NOT claimed as shipped BookMyShow source.

import Foundation

final class BarrierDict<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let queue = DispatchQueue(
        label: "learning.rw.dict",
        attributes: .concurrent
    )

    func get(_ key: Key) -> Value? {
        queue.sync { storage[key] }
    }

    func set(_ key: Key, value: Value) {
        queue.async(flags: .barrier) {
            self.storage[key] = value
        }
    }

    /// Prefer sync barrier when read-after-write must be guaranteed.
    func setSync(_ key: Key, value: Value) {
        queue.sync(flags: .barrier) {
            self.storage[key] = value
        }
    }

    func snapshot() -> [Key: Value] {
        queue.sync { storage }
    }
}

/*
 Say aloud:
 - Readers may overlap.
 - Barrier writes are exclusive.
 - Still hide queue + storage.
 - Watch writer starvation under constant reads.
 - Async barrier write has the same visibility caveat as async serial write.
 */
