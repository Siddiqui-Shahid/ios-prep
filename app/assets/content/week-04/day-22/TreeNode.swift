import Foundation

/// Shared LeetCode-style binary tree node for Day 22 worked solutions.
/// Learning-lab only — not a shipped production type.
final class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?

    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
}

enum TreeExamples {
    ///       1
    ///      / \
    ///     2   3
    ///    / \
    ///   4   5
    static func small() -> TreeNode {
        TreeNode(1, TreeNode(2, TreeNode(4), TreeNode(5)), TreeNode(3))
    }
}
'''