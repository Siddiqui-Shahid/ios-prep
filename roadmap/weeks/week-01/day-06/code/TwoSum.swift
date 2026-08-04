// TwoSum.swift — Learning-lab Week 1 Day 06
import Foundation

enum TwoSum {
    /// O(n) time / O(n) space — value → index map
    static func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var seen: [Int: Int] = [:]
        for (i, value) in nums.enumerated() {
            let need = target - value
            if let j = seen[need] {
                return [j, i]
            }
            seen[value] = i
        }
        return []
    }
}
