import Foundation

/// DFS patterns — depth, diameter, path sum, symmetric, LCA.
enum TreeDFS {
    static func maxDepth(_ root: TreeNode?) -> Int {
        guard let root else { return 0 }
        return 1 + max(maxDepth(root.left), maxDepth(root.right))
    }

    /// Diameter in edges (LeetCode 543). Confirm definition with interviewer.
    static func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        var best = 0
        @discardableResult
        func height(_ node: TreeNode?) -> Int {
            guard let node else { return 0 }
            let left = height(node.left)
            let right = height(node.right)
            best = max(best, left + right)
            return 1 + max(left, right)
        }
        _ = height(root)
        return best
    }

    static func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
        guard let root else { return false }
        if root.left == nil && root.right == nil {
            return root.val == targetSum
        }
        let next = targetSum - root.val
        return hasPathSum(root.left, next) || hasPathSum(root.right, next)
    }

    static func pathSumII(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var answer: [[Int]] = []
        var path: [Int] = []
        func dfs(_ node: TreeNode?, _ remaining: Int) {
            guard let node else { return }
            path.append(node.val)
            defer { path.removeLast() }
            if node.left == nil && node.right == nil {
                if remaining == node.val { answer.append(path) }
                return
            }
            dfs(node.left, remaining - node.val)
            dfs(node.right, remaining - node.val)
        }
        dfs(root, targetSum)
        return answer
    }

    static func isSymmetric(_ root: TreeNode?) -> Bool {
        func mirror(_ a: TreeNode?, _ b: TreeNode?) -> Bool {
            if a == nil && b == nil { return true }
            guard let a, let b, a.val == b.val else { return false }
            return mirror(a.left, b.right) && mirror(a.right, b.left)
        }
        return mirror(root?.left, root?.right)
    }

    /// Assumes p and q exist in the tree (clarify in interview).
    static func lowestCommonAncestor(
        _ root: TreeNode?,
        _ p: TreeNode?,
        _ q: TreeNode?
    ) -> TreeNode? {
        guard let root else { return nil }
        if root === p || root === q { return root }
        let left = lowestCommonAncestor(root.left, p, q)
        let right = lowestCommonAncestor(root.right, p, q)
        if left != nil && right != nil { return root }
        return left ?? right
    }
}

/*
 Say this first — Diameter:
 “Postorder height; at every node update best with leftH+rightH — not root-only. O(n)/O(h).”
 */
'''