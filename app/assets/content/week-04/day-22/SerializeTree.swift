import Foundation

/// LeetCode-style codec: preorder with explicit null markers.
enum SerializeTree {
    static func serialize(_ root: TreeNode?) -> String {
        var parts: [String] = []
        func dfs(_ node: TreeNode?) {
            guard let node else {
                parts.append("#")
                return
            }
            parts.append(String(node.val))
            dfs(node.left)
            dfs(node.right)
        }
        dfs(root)
        return parts.joined(separator: ",")
    }

    static func deserialize(_ data: String) -> TreeNode? {
        var parts = data.split(separator: ",", omittingEmptySubsequences: false).map(String.init)
        var index = 0
        func dfs() -> TreeNode? {
            guard index < parts.count else { return nil }
            let token = parts[index]
            index += 1
            if token == "#" { return nil }
            let node = TreeNode(Int(token)!)
            node.left = dfs()
            node.right = dfs()
            return node
        }
        return dfs()
    }
}

/*
 Say this first — Serialize:
 “Preorder with null tokens so the encoding is reversible. O(n). Edges: empty tree.”
 */
'''