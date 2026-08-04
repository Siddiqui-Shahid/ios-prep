import Foundation

enum BSTProblems {
    /// Bounds DFS. Clarify duplicate policy with interviewer.
    static func isValidBST(_ root: TreeNode?) -> Bool {
        func ok(_ node: TreeNode?, _ low: Int?, _ high: Int?) -> Bool {
            guard let node else { return true }
            if let low, node.val <= low { return false }
            if let high, node.val >= high { return false }
            return ok(node.left, low, node.val) && ok(node.right, node.val, high)
        }
        return ok(root, nil, nil)
    }

    /// Iterative inorder; stop at k. 1-indexed k.
    static func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
        var stack: [TreeNode] = []
        var current = root
        var remaining = k
        while current != nil || !stack.isEmpty {
            while let node = current {
                stack.append(node)
                current = node.left
            }
            let node = stack.removeLast()
            remaining -= 1
            if remaining == 0 { return node.val }
            current = node.right
        }
        preconditionFailure("k out of range")
    }

    /// BST LCA — O(h) walk. Do not use on general binary trees.
    static func lowestCommonAncestorBST(
        _ root: TreeNode?,
        _ p: TreeNode,
        _ q: TreeNode
    ) -> TreeNode? {
        var node = root
        while let n = node {
            if p.val < n.val && q.val < n.val {
                node = n.left
            } else if p.val > n.val && q.val > n.val {
                node = n.right
            } else {
                return n
            }
        }
        return nil
    }
}

/*
 Say this first — Validate BST:
 “Bounds (or inorder increasing). Parent-only check is wrong. O(n)/O(h).”
 */
'''