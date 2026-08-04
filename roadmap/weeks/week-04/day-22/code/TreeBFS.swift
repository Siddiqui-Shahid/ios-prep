import Foundation

/// BFS patterns — level order, zigzag, right side view.
/// Interview note: `removeFirst()` on Array is O(n); mention deque if interviewer pushes.
enum TreeBFS {
    static func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root else { return [] }
        var result: [[Int]] = []
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            let levelCount = queue.count
            var level: [Int] = []
            level.reserveCapacity(levelCount)
            for _ in 0..<levelCount {
                let node = queue.removeFirst()
                level.append(node.val)
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
            result.append(level)
        }
        return result
    }

    static func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var levels = levelOrder(root)
        for i in levels.indices where i % 2 == 1 {
            levels[i].reverse()
        }
        return levels
    }

    /// Last node of each BFS level.
    static func rightSideView(_ root: TreeNode?) -> [Int] {
        guard let root else { return [] }
        var result: [Int] = []
        var queue: [TreeNode] = [root]
        while !queue.isEmpty {
            let levelCount = queue.count
            for i in 0..<levelCount {
                let node = queue.removeFirst()
                if i == levelCount - 1 { result.append(node.val) }
                if let left = node.left { queue.append(left) }
                if let right = node.right { queue.append(right) }
            }
        }
        return result
    }
}

/*
 Say this first — Level Order:
 “BFS with level-size loop; empty → []. O(n)/O(w). Edges: skewed, single node.”
 */
'''