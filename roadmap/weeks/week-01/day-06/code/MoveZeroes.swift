// MoveZeroes.swift — write pointer
import Foundation

enum MoveZeroes {
    static func moveZeroes(_ nums: inout [Int]) {
        var write = 0
        for i in 0..<nums.count {
            if nums[i] != 0 {
                nums[write] = nums[i]
                write += 1
            }
        }
        while write < nums.count {
            nums[write] = 0
            write += 1
        }
    }
}
