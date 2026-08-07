// LengthOfLongestSubstring.swift — variable sliding window
import Foundation

enum LengthOfLongestSubstring {
    /// Expand right; move left past last duplicate. O(n) / O(min(n, Σ))
    static func lengthOfLongestSubstring(_ s: String) -> Int {
        let chars = Array(s)
        var lastIndex: [Character: Int] = [:]
        var left = 0
        var best = 0
        for (right, ch) in chars.enumerated() {
            if let prev = lastIndex[ch] {
                left = max(left, prev + 1)
            }
            lastIndex[ch] = right
            best = max(best, right - left + 1)
        }
        return best
    }
}
