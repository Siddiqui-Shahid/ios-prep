// MinSubArrayLen.swift — variable window (positive nums)
import Foundation

enum MinSubArrayLen {
    static func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var left = 0
        var sum = 0
        var best = Int.max
        for right in 0..<nums.count {
            sum += nums[right]
            while sum >= target {
                best = min(best, right - left + 1)
                sum -= nums[left]
                left += 1
            }
        }
        return best == Int.max ? 0 : best
    }
}
