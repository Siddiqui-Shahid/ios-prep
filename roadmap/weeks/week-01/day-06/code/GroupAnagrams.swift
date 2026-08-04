// GroupAnagrams.swift — frequency / sorted key
import Foundation

enum GroupAnagrams {
    static func groupAnagrams(_ strs: [String]) -> [[String]] {
        var buckets: [String: [String]] = [:]
        for s in strs {
            let key = String(s.sorted())
            buckets[key, default: []].append(s)
        }
        return Array(buckets.values)
    }
}
