# Sample 02 — Tree patterns & skeletons (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. How do I map prompt phrases to algorithms?

**Points to:** [Deep dive · §1 Pattern catalog](../02-deep-dive.md#1-pattern-catalog-trigger--algorithm)

**Answer:**

> “Level by level”, zigzag, right side view → **BFS + level-size**. Unweighted shortest path → **BFS**. Path sum, all paths → **DFS preorder + backtrack**. Same tree, symmetric → **DFS compare two pointers**. LCA binary tree → **DFS postorder markers**. LCA on BST → **value walk O(h)**. Validate BST → **bounds DFS or inorder**. Diameter / balanced → **DFS return height + side effect**. Serialize → **DFS/BFS with null markers**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Connect next pointers? | BFS level-size — link siblings while dequeuing. |
| k-th smallest BST? | Inorder (stack or Morris) — sorted order. |
| Construct from preorder + inorder? | Root from preorder[0]; split inorder; hashmap for O(n) if values unique. |

---

### Q2. How does LCA work on a binary tree?

**Points to:** [Deep dive · §4.2 LCA binary tree](../02-deep-dive.md#42-lca-binary-tree--postorder-markers)

**Answer:**

> Postorder DFS: if node is nil or equals p or q, return that node. Recurse left and right. If both sides return non-nil, current node is LCA. Otherwise return whichever side found a target. O(n) time, O(h) space. Clarify: both nodes exist? unique values? parent pointers available?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One target is ancestor of the other? | Algorithm still works — first hit bubbles up. |
| BST LCA? | Compare values — don’t scan whole tree unless asked. |
| Parent-pointer variant? | Walk depth, align, step up — O(h) if map built. |

---

### Q3. Why does validate BST need bounds, not just parent?

**Points to:** [Deep dive · §4.3 Validate BST](../02-deep-dive.md#43-validate-bst--bounds) · [Foundations · §6.3](../01-foundations.md#63-validate-bst--bounds-preview)

**Answer:**

> Parent-only check fails when a node in the right subtree is less than an ancestor above the parent — e.g. 5 with right child 6 whose left child is 4. Pass low/high bounds (or inorder strictly increasing). O(n)/O(h).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Inorder approach? | Track previous value — current must be strictly greater (per duplicate policy). |
| Duplicates allowed? | Adjust bounds — clarify `<` vs `<=`. |
| Empty tree? | Valid — say in edges. |

---

### Q4. How do I compute diameter correctly?

**Points to:** [Deep dive · §4.1 Diameter](../02-deep-dive.md#41-diameter--why-root-only-fails)

**Answer:**

> Diameter is the longest path between any two nodes — confirm edges vs nodes definition. At **every** node: leftH + rightH contributes to best; return 1 + max(leftH, rightH) as height. Root-only without scanning all nodes misses diameters entirely in one subtree.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-pass or two-pass? | One DFS pass returning height + updating global best. |
| Path through root only? | Insufficient — path may avoid root. |
| Balanced check? | Return height or -1 if |leftH - rightH| > 1. |

---

### Q5. How do I serialize and deserialize a tree?

**Points to:** [Deep dive · §4.5 Serialize](../02-deep-dive.md#45-serialize--null-markers-required)

**Answer:**

> Preorder values alone are ambiguous — encode **null markers** (`"#"` / `"null"`) or BFS with null children. Deserialize with queue or index pointer. O(n) time and space. Same reversibility instinct as SDUI JSON with schemaVersion + unknown-type fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BFS encode? | Level order including nil slots — LeetCode Codec style. |
| N-ary tree? | Encode child count or delimiter between subtrees. |
| Production nod? | Version schema; fail-soft on unknown component types (Day 25 Brief B). |

---

### Q6. Path Sum II — what is the backtracking pattern?

**Points to:** [Deep dive · §4.4 Path Sum II](../02-deep-dive.md#44-path-sum-ii--backtracking)

**Answer:**

> Push `node.val` onto path. At leaf, if remaining equals val, copy path to answers. Recurse left/right with `remaining - val`. Pop after both children — restore invariant for other branches. DFS preorder + explicit undo.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Path Sum I (exists)? | Return true early — no need to collect all paths. |
| Negative values? | Still DFS — no monotonic window trick. |
| Target zero at root-only? | Clarify whether root counts as path. |

---

### Q7. What trade-offs should seniors mention?

**Points to:** [Deep dive · §5 Trade-offs](../02-deep-dive.md#5-trade-offs) · [§6 Failure modes](../02-deep-dive.md#6-failure-modes-seniors-mention)

**Answer:**

> BFS vs DFS for same problem (max depth): same O(n), different space h vs w. Recursive vs iterative: clarity vs stack depth on skewed input. Array queue vs deque: acknowledge `removeFirst` cost. Failure modes: BST tricks on plain trees, forgetting null markers in serialize, diameter at root only, Morris without restore.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symmetric tree? | Mirror DFS: `same(a.left,b.right) && same(a.right,b.left)`. |
| Iterative preorder? | Push root; pop, visit, push right then left. |
| When to mention Morris? | Only if you can finish link threading and restore in one breath. |

---

Next: [03-approach-complexity.md](03-approach-complexity.md)
