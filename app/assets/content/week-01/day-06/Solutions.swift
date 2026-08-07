// Solutions.swift — index + smoke checks (Learning-lab)
// Run mentally or in a playground. Not a shipping target.

import Foundation

enum Day06Smoke {
    static func run() {
        assert(TwoSum.twoSum([2, 7, 11, 15], 9) == [0, 1])
        assert(MaxProfit.maxProfit([7, 1, 5, 3, 6, 4]) == 5)
        assert(ValidPalindrome.isPalindrome("A man, a plan, a canal: Panama") == true)
        assert(ContainerWater.maxArea([1, 8, 6, 2, 5, 4, 8, 3, 7]) == 49)
        assert(LengthOfLongestSubstring.lengthOfLongestSubstring("abcabcbb") == 3)
        assert(MaxSubArray.maxSubArray([-2, 1, -3, 4, -1, 2, 1, -5, 4]) == 6)
        assert(ProductExceptSelf.productExceptSelf([1, 2, 3, 4]) == [24, 12, 8, 6])
        var z = [0, 1, 0, 3, 12]
        MoveZeroes.moveZeroes(&z)
        assert(z == [1, 3, 12, 0, 0])
        assert(ThreeSum.threeSum([-1, 0, 1, 2, -1, -4]).count >= 2)
        assert(MinSubArrayLen.minSubArrayLen(7, [2, 3, 1, 2, 4, 3]) == 2)
        assert(GroupAnagrams.groupAnagrams(["eat", "tea", "tan", "ate", "nat", "bat"]).count == 3)
        print("Day06Smoke OK")
    }
}
