// SafeDict.swift
// Day 04 Learning-lab — teaching shape for Verified · S2 (GCD serial-queue maps).
// NOT claimed as shipped BookMyShow source.
//
// Critical notes:
// 1. Spell `final class` (not `Final class`).
// 2. Prefer sync set when call sites need read-after-write.
// 3. Async set then sync get may not see the write until the write runs —
//    usually ordered if async was enqueued first, but sync set is the clear API.
// 4. Never expose `storage` or `queue`.

import Foundation

final class SafeDict<Key: Hashable, Value> {
    private var storage: [Key: Value] = [:]
    private let queue = DispatchQueue(label: "learning.safe.dict")

    func get(_ key: Key) -> Value? {
        queue.sync { storage[key] }
    }

    /// Synchronous write — preferred when the caller needs read-after-write.
    func set(_ key: Key, value: Value) {
        queue.sync { storage[key] = value }
    }

    /// Fire-and-forget write. Document visibility: next sync get from this
    /// thread usually sees it (enqueue order), but treat completion as async.
    func setAsync(_ key: Key, value: Value) {
        queue.async { self.storage[key] = value }
    }

    func remove(_ key: Key) {
        queue.sync { storage.removeValue(forKey: key) }
    }

    func snapshot() -> [Key: Value] {
        queue.sync { storage }
    }

    func count() -> Int {
        queue.sync { storage.count }
    }

    func mutate(_ body: (inout [Key: Value]) -> Void) {
        queue.sync { body(&storage) }
    }
}

enum SafeDictDemo {
    static func readAfterWrite() {
        let dict = SafeDict<String, Int>()

        dict.set("venue.1", value: 10)
        assert(dict.get("venue.1") == 10)

        // Teaching contrast — do not rely on this in production APIs without docs:
        dict.setAsync("venue.2", value: 20)
        _ = dict.get("venue.2") // may be 20 if async block already enqueued/ran
    }
}

/*
 Interview pitch (Verified · S2):
 “Private serial queue, safe get/set API, no raw storage escape.
  For new modules I’d evaluate an actor (S2-A1).”
 */
