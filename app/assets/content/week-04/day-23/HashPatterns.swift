import Foundation

enum HashPatterns {
    /// Two Sum — return indices. Expected O(n) time / O(n) space.
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var seen: [Int: Int] = [:]
        for (i, value) in nums.enumerated() {
            let need = target - value
            if let j = seen[need] { return [j, i] }
            seen[value] = i
        }
        return []
    }

    /// Group Anagrams — count signature key.
    static func groupAnagrams(_ strs: [String]) -> [[String]] {
        var groups: [String: [String]] = [:]
        for s in strs {
            var counts = [Int](repeating: 0, count: 26)
            for ch in s.utf8 {
                counts[Int(ch - 97)] += 1
            }
            let key = counts.map(String.init).joined(separator: "#")
            groups[key, default: []].append(s)
        }
        return Array(groups.values)
    }

    /// Subarray sum equals K — works with negatives.
    static func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var prefix = 0
        var freq: [Int: Int] = [0: 1]
        var count = 0
        for value in nums {
            prefix += value
            count += freq[prefix - k, default: 0]
            freq[prefix, default: 0] += 1
        }
        return count
    }

    /// Longest substring without repeating characters.
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        var lastIndex: [Character: Int] = [:]
        var left = 0
        var best = 0
        let chars = Array(s)
        for (right, ch) in chars.enumerated() {
            if let prev = lastIndex[ch], prev >= left {
                left = prev + 1
            }
            lastIndex[ch] = right
            best = max(best, right - left + 1)
        }
        return best
    }
}

/*
 Say this first — Subarray Sum K:
 “Negatives → prefix + hash frequencies, not two pointers. O(n)/O(n).”
 */
