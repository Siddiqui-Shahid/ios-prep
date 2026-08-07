// ProductExceptSelf.swift
import Foundation

enum ProductExceptSelf {
    /// Left pass into output; right multiply back. O(n) / O(1) extra (output aside)
    static func productExceptSelf(_ nums: [Int]) -> [Int] {
        let n = nums.count
        var out = Array(repeating: 1, count: n)
        var left = 1
        for i in 0..<n {
            out[i] = left
            left *= nums[i]
        }
        var right = 1
        for i in stride(from: n - 1, through: 0, by: -1) {
            out[i] *= right
            right *= nums[i]
        }
        return out
    }
}
