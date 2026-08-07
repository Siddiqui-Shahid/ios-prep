// ContainerWater.swift — Container With Most Water
import Foundation

enum ContainerWater {
    /// Opposite pointers. O(n) / O(1)
    static func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var best = 0
        while left < right {
            let h = min(height[left], height[right])
            best = max(best, h * (right - left))
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        return best
    }
}
