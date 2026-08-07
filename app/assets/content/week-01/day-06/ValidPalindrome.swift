// ValidPalindrome.swift
import Foundation

enum ValidPalindrome {
    /// Two pointers; Swift: work on [Character] for O(1) index. O(n)/O(n)
    static func isPalindrome(_ s: String) -> Bool {
        let chars = Array(s.lowercased())
        var left = 0
        var right = chars.count - 1
        while left < right {
            while left < right && !chars[left].isLetter && !chars[left].isNumber {
                left += 1
            }
            while left < right && !chars[right].isLetter && !chars[right].isNumber {
                right -= 1
            }
            if chars[left] != chars[right] { return false }
            left += 1
            right -= 1
        }
        return true
    }
}
