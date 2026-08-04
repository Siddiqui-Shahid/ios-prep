// MaxSubArray.swift — Kadane
import Foundation

enum MaxSubArray {
    /// running = max(x, running + x); track global. Handles all-negative.
    static func maxSubArray(_ nums: [Int]) -> Int {
        guard let first = nums.first else { return 0 }
        var running = first
        var best = first
        for x in nums.dropFirst() {
            running = max(x, running + x)
            best = max(best, running)
        }
        return best
    }
}
