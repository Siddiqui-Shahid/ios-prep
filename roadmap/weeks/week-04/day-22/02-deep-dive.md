# 02 — Deep Dive: Tree Pattern Catalog & Skeletons

> Mechanics, traps, trade-offs. Self-contained — you do not need external blogs to interview on trees today.

---

## 1. Pattern catalog (trigger → algorithm)

| Trigger phrase in prompt | Default pattern | Why |
|---|---|---|
| “Level by level”, “leftmost/rightmost at each depth”, “zigzag level order” | **BFS** + queue | Natural FIFO; `O(w)` space for width |
| “Shortest path” in **unweighted** tree/graph | **BFS** | First hit = shortest |
| “Path sum”, “root-to-leaf”, “all paths” | **DFS** preorder + accumulator / backtrack | Path state rides the stack |
| “Subtree of another”, “same tree”, “symmetric” | **DFS** compare two pointers / mirrored | Structural recursion |
| “LCA of two nodes” (binary tree) | **DFS** postorder return markers | Bottom-up combine |
| “LCA” on **BST** | Walk comparing values | O(h); don’t use full tree scan unless asked |
| “Serialize / deserialize”, “clone N-ary” | DFS or BFS with null markers | Encoding must be reversible |
| “Max depth / diameter / balanced?” | DFS return height + side effects | One pass, multiple facts |
| “Validate BST” | DFS low/high bounds **or** inorder | Parent-only check is wrong |
| “k-th smallest in BST” | Inorder (stack or Morris) | Sorted order |
| “Connect next pointers / cousins” | BFS level-size | Sibling awareness |
| “Right / left side view” | BFS last/first in level **or** DFS prioritize side | Same answer, different space profile |

---

## 2. BFS skeleton (production-quality interview form)

```swift
func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root else { return [] }
    var result: [[Int]] = []
    var queue: [TreeNode] = [root]
    while !queue.isEmpty {
        let levelCount = queue.count
        var level: [Int] = []
        level.reserveCapacity(levelCount)
        for _ in 0..<levelCount {
            let node = queue.removeFirst() // interview OK; note O(n) shift — mention ArrayDeque if pushed
            level.append(node.val)
            if let l = node.left { queue.append(l) }
            if let r = node.right { queue.append(r) }
        }
        result.append(level)
    }
    return result
}
```

**Senior note:** `removeFirst()` on `Array` is O(n). In interviews, clarity usually wins; if interviewer cares, say “I’d use a true deque / index head.” See `code/TreeBFS.swift`.

### Zigzag variant

Same BFS; on odd levels `level.reverse()` (or insert at front / use deque). Prefer reverse of a level array — fewer bugs than index gymnastics.

### Right side view

Per level, append `level.last` (or track last dequeued). DFS alternative: recurse right before left, record first visit per depth.

---

## 3. DFS skeletons

### 3.1 Recursive template

```text
func dfs(node):
  if node == nil: return base
  // pre: act before children
  L = dfs(node.left)
  // in: act between (BST / inorder)
  R = dfs(node.right)
  // post: combine L,R with node
  return combined
```

### 3.2 Iterative preorder

Push root; while stack: pop, visit, **push right then left** (so left processed first).

### 3.3 Iterative inorder

Walk left pushing; pop/visit; go right — BST k-th / validate helper.

**When iterative wins:** “I need explicit control / avoid deep recursion on skewed input” or follow-up asks for stack form. Morris only if you can finish link/restore cleanly.

---

## 4. Worked pattern deep-dives

### 4.1 Diameter — why root-only fails

Diameter = max over **all** nodes of `leftHeight + rightHeight` (edges) or that sum + 1 (nodes) — **confirm definition**.

```text
At each node:
  leftH = height(left); rightH = height(right)
  best = max(best, leftH + rightH)
  return 1 + max(leftH, rightH)   // height in nodes
```

A long path entirely in the left subtree never touches the root — hence root-only `depth(L)+depth(R)` is insufficient if you only compute it once at root *without* scanning all nodes… Actually computing at root alone misses diameters that don’t pass through root. You must update at every node.

### 4.2 LCA binary tree — postorder markers

```text
if node == nil or node == p or node == q: return node
L = lca(left); R = lca(right)
if L != nil and R != nil: return node   // split here
return L ?? R
```

**Assumptions to clarify:** Both nodes exist in tree? Nodes are unique? Parent pointers available?

**BST LCA:** If both vals < node, go left; both > node, go right; else node is LCA. O(h).

### 4.3 Validate BST — bounds

```text
func ok(node, low, high):  // low/high exclusive bounds as Optionals
  if node == nil: return true
  if node.val <= low or node.val >= high: return false  // adjust for duplicate policy
  return ok(left, low, node.val) and ok(right, node.val, high)
```

Or inorder: previous value must be strictly less than current.

### 4.4 Path Sum II — backtracking

Push `node.val`; if leaf and remaining == val, copy path to answer; recurse left/right with `remaining - val`; pop.

### 4.5 Serialize — null markers required

Preorder values alone are ambiguous. Encode nulls (`"#"` / `"null"`) or use BFS with null children like LeetCode Codec. Deserialize with queue or index pointer. O(n).

**Production nod (10s):** SDUI JSON needs `schemaVersion` + unknown-type fallback — same *reversibility / versioning* instinct, different format (S3 / Day 25 Brief B).

### 4.6 Symmetric tree

Mirror DFS: `same(a.left, b.right) && same(a.right, b.left)`, or BFS pairing queue.

### 4.7 Construct from preorder + inorder

Preorder[0] is root; find root in inorder to split left/right sizes; recurse. Use hashmap value→index for O(n) if values unique.

---

## 5. Trade-offs

| Choice | When | Cost |
|---|---|---|
| BFS | Levels, width-aware, unweighted shortest | Queue `O(w)`; path reconstruction needs parent map |
| DFS recursive | Structure, path, subtree, LCA | Call stack `O(h)`; skewed → stack overflow risk in prod |
| DFS iterative | Same as DFS, explicit stack | More boilerplate; easier to pause/resume |
| Inorder on BST | Sorted queries, validate, k-th | Wrong on non-BST |
| Parent pointer / map | Path to root, cousin distance | Extra `O(n)` space |
| Two-pass vs one-pass | Diameter | Prefer one DFS returning height + global max |
| Morris inorder | O(1) aux space | Mutates links; easy to get wrong under timer |

---

## 6. Failure modes seniors mention

1. Claiming recursive DFS is O(1) space.
2. BST validate via parent-only comparison.
3. Diameter computed only at root once without per-node updates.
4. Serialize without nulls → ambiguous trees.
5. Using BST LCA walk on a general binary tree.
6. Mixing levels because you forgot `levelCount`.
7. `removeFirst` performance rabbit hole mid-interview — acknowledge, don’t rewrite half the solution.
8. Silent coding — no agenda → looks junior even if code is fine.

---

## 7. Production mental models (shape only)

| Domain | BFS-like | DFS-like |
|---|---|---|
| UIKit / SwiftUI hierarchy | Layout passes “by depth” | Hit-test / preference key fold |
| SDUI document | Render section rows by depth | Resolve nested actions / find component by id path |
| Deeplink graph | Breadth of sibling destinations | Walk nested route path |
| CMS nesting | Cap max depth (fail-soft) | Recurse children with budget |

**Honesty:** These are *isomorphisms for teaching*, not “I ran LeetCode BFS in BookMyShow.” Provenance in [`03-production-bridge.md`](03-production-bridge.md).

---

## 8. Complexity quick reference

| Problem family | Time | Space |
|---|---|---|
| Traversal / level order / views | O(n) | O(w) or O(h) |
| Diameter / balanced / max depth | O(n) | O(h) |
| LCA binary tree | O(n) | O(h) |
| LCA BST | O(h) | O(1) iterative / O(h) recursion |
| Validate BST | O(n) | O(h) |
| Serialize | O(n) | O(n) output + O(h)/O(w) |
| Construct pre+in | O(n) with index map | O(n) |
| Path Sum II | O(n²) worst copies / O(n) if count only | O(h) path |

---

## 9. Optional citations (not required to study)

- LeetCode Explore: Binary Tree cards (visual BFS/DFS)
- Apple docs: value types vs classes (aside only)
- Repo timing: [answer-timing-guide.md](../../../timing/answer-timing-guide.md) § Coding

→ Code: [`code/`](code/) · Bridge: [`03-production-bridge.md`](03-production-bridge.md)
'''