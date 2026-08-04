# 01 — Foundations: Tree BFS / DFS

> Read this first. Goal: an intern can teach back *when* to BFS vs DFS, then you layer the senior edges (complexity honesty, BST traps, production analogies).

---

## 0. One-sentence north star

**BFS walks by distance (levels / width); DFS walks by structure (paths / subtrees / combine-after-children). Pick from the prompt trigger, then state O(n) time and O(h) or O(w) space before you type.**

Everything below unpacks that sentence.

---

## 1. Mental model: what a tree problem is asking

### 1.1 Two boxes in your head

| Box | Meaning | Interview trigger words |
|---|---|---|
| **Level / distance box** | Process nodes in waves from the root | “level by level”, “leftmost at each depth”, “zigzag”, “right side view”, “shortest path” (unweighted) |
| **Structure / path box** | Recurse into children; combine results on the way up or accumulate on the way down | “path sum”, “subtree”, “same tree”, “symmetric”, “LCA”, “diameter”, “validate BST”, “serialize” |

```text
BFS:  root → [level 0] → [level 1] → [level 2] …   (queue / FIFO)
DFS:  root → deep left … backtrack → siblings …     (stack / recursion)
```

### 1.2 The intern demo (say aloud once)

Draw this tree:

```text
      1
     / \
    2   3
   / \
  4   5
```

- **BFS order (visit):** 1, then 2–3, then 4–5 → levels `[[1],[2,3],[4,5]]`
- **DFS preorder:** visit, left, right → `1,2,4,5,3`
- **DFS inorder:** left, visit, right → `4,2,5,1,3` (BST sorted if it were a BST)
- **DFS postorder:** left, right, visit → `4,5,2,3,1`

**Say aloud:** “BFS answers width questions. DFS answers structure and path questions. Inorder is special for BSTs.”

### 1.3 Binary tree vs BST (do not blur)

| Type | Extra invariant | Extra algorithms unlocked |
|---|---|---|
| Binary tree | Each node ≤ 2 children | BFS/DFS structural only |
| BST | Left < node < right (clarify duplicates) | Bounds validate, inorder sorted, BST LCA walk O(h), k-th smallest via inorder |

**Trap:** Using “BST walk” LCA on a plain binary tree — wrong.

---

## 2. Glossary (interview vocabulary)

| Term | Crisp meaning |
|---|---|
| **Height / depth** | Confirm with interviewer: edges vs nodes; “max depth” usually nodes along longest root→leaf |
| **Level-size loop** | Snapshot `queue.count` each wave so you don’t mix levels |
| **Preorder** | Process node before children — path building, serialize prefixes |
| **Inorder** | Left → node → right — BST sorted order |
| **Postorder** | Children first — height, diameter, LCA combine |
| **h** | Height (skewed → n; balanced → ~log n) |
| **w** | Max width of a level (can be Θ(n) in a fat tree) |
| **Morris** | Threaded O(1) aux inorder — mutate links temporarily; mention only if solid |

---

## 3. Complexity script (memorize verbatim)

> “n = number of nodes. Visit each once → **O(n)** time. Recursion depth or queue holds up to **O(h)** or **O(w)** space; worst case skewed tree **O(n)**, balanced **O(log n)** height.”

Never say “O(1) space” for recursive DFS unless you explicitly discuss the call stack. Prefer: “auxiliary O(1) besides the call stack O(h).”

---

## 4. BFS foundation — level-size idiom

Always separate “nodes currently in the queue” from “this level”:

```text
queue = [root]
while queue not empty:
  levelCount = queue.count
  for _ in 0..<levelCount:
    node = dequeue
    // process / collect
    enqueue children if non-nil
```

**Why interviewers care:** Without `levelCount`, zigzag / right-side-view / level averages become messy index math.

**Edge cases to name:** empty root → `[]`; single node; skewed left chain (width 1, height n); very wide bushy level.

---

## 5. DFS foundation — three return styles

### 5.1 Void / side-effect DFS

Build a path array, push before recurse, pop after (backtracking). Classic Path Sum II.

### 5.2 Return a value DFS

Height, boolean “found”, optional node pointer. Classic max depth, same tree, LCA.

### 5.3 Return + global update

Diameter: return height; update `maxDiameter` with `leftH + rightH` at every node.

**Say aloud:** “I decide up front: am I accumulating down, combining up, or both?”

---

## 6. First worked micro-examples (no full solution yet)

### 6.1 Maximum depth — DFS

```text
depth(null) = 0
depth(node) = 1 + max(depth(left), depth(right))
```

BFS alternative: count waves. Same O(n); space trade-off h vs w.

### 6.2 Level order — BFS

Collect one array per wave. This is the template for zigzag (reverse odd levels) and right side view (last node of each wave).

### 6.3 Validate BST — bounds (preview)

Parent-only check fails on:

```text
    5
   / \
  1   6
     / \
    4   7     ← 4 is wrong: still in right subtree of 5
```

Need low/high bounds (or inorder strictly increasing).

---

## 7. “Say this first” — 2–3 min coding approach

Aligns with [answer-timing-guide.md](../../../timing/answer-timing-guide.md).

1. **Clarify (20–30s):** Binary vs BST? Path or bool? Mutate OK? n up to?
2. **Brute (20–30s):** Enumerate all paths / compare every subtree — often O(n²).
3. **Optimize (45–60s):** Name pattern + why correct.
4. **Complexity (15s):** O(n) time; O(h) or O(w) space; worst case.
5. **Edges (20s):** null, one child, skewed, duplicates.
6. **Commit (5s):** “I’ll code the optimized version now.”

**Example — Level Order:**

> “I’ll BFS with a queue and process by level size so each result array is one depth. Empty root returns []. Time O(n), space O(w). Edges: single node, skewed chain. Coding now.”

**Example — LCA (binary tree):**

> “Postorder DFS: recurse left/right; if both sides find targets, current is LCA; if one side finds, bubble that up. Confirm both nodes exist. O(n)/O(h).”

**Example — Validate BST:**

> “Not enough to compare only to parent. I’ll DFS with low-high bounds, or inorder strictly increasing. O(n)/O(h).”

---

## 8. Swift node shape (interview default)

```swift
final class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) {
        self.val = val; self.left = left; self.right = right
    }
}
```

**Interview aside (10s max):** Production SDUI trees are often value/`Codable` enums; LeetCode uses reference nodes. Same *traversal* ideas; different ownership model. Don’t derail into ARC unless asked (Day 03 territory).

---

## 9. Checklist before you open Deep Dive

- [ ] I can draw BFS vs DFS on a 5-node tree
- [ ] I can recite the complexity script without “O(1) recursive”
- [ ] I know BST ≠ binary tree for LCA / validate
- [ ] I can speak the 6-step “say this first” agenda
- [ ] I know level-size = `for _ in 0..<queue.count`

→ Continue: [`02-deep-dive.md`](02-deep-dive.md)
'''
)