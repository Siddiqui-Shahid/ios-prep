# Sample 02 — Tree patterns & skeletons (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. How do I map prompt phrases to algorithms?

**Answer:**

> “Level by level”, zigzag, right side view → **BFS + level-size**. Unweighted shortest path → **BFS**. Path sum, all paths → **DFS preorder + backtrack**. Same tree, symmetric → **DFS compare two pointers**. LCA binary tree → **DFS postorder markers**. LCA on BST → **value walk O(h)**. Validate BST → **bounds DFS or inorder**. Diameter / balanced → **DFS return height + side effect**. Serialize → **DFS/BFS with null markers**.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Connect next pointers? | BFS level-size — link siblings while dequeuing. |
| k-th smallest BST? | Inorder (stack or Morris) — sorted order. |
| Construct from preorder + inorder? | Root from preorder[0]; split inorder; hashmap for O(n) if values unique. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How does LCA work on a binary tree?

**Answer:**

> Postorder DFS: if node is nil or equals p or q, return that node. Recurse left and right. If both sides return non-nil, current node is LCA. Otherwise return whichever side found a target. O(n) time, O(h) space. Clarify: both nodes exist? unique values? parent pointers available?

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One target is ancestor of the other? | Algorithm still works — first hit bubbles up. |
| BST LCA? | Compare values — don’t scan whole tree unless asked. |
| Parent-pointer variant? | Walk depth, align, step up — O(h) if map built. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Why does validate BST need bounds, not just parent?

**Answer:**

> Parent-only check fails when a node in the right subtree is less than an ancestor above the parent — e.g. 5 with right child 6 whose left child is 4. Pass low/high bounds (or inorder strictly increasing). O(n)/O(h).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Inorder approach? | Track previous value — current must be strictly greater (per duplicate policy). |
| Duplicates allowed? | Adjust bounds — clarify `<` vs `<=`. |
| Empty tree? | Valid — say in edges. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do I compute diameter correctly?

**Answer:**

> Diameter is the longest path between any two nodes — confirm edges vs nodes definition. At **every** node: leftH + rightH contributes to best; return 1 + max(leftH, rightH) as height. Root-only without scanning all nodes misses diameters entirely in one subtree.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-pass or two-pass? | One DFS pass returning height + updating global best. |
| Path through root only? | Insufficient — path may avoid root. |
| Balanced check? | Return height or -1 if |leftH - rightH| > 1. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How do I serialize and deserialize a tree?

**Answer:**

> Preorder values alone are ambiguous — encode **null markers** (`"#"` / `"null"`) or BFS with null children. Deserialize with queue or index pointer. O(n) time and space. Same reversibility instinct as SDUI JSON with schemaVersion + unknown-type fallback.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BFS encode? | Level order including nil slots — LeetCode Codec style. |
| N-ary tree? | Encode child count or delimiter between subtrees. |
| Production nod? | Version schema; fail-soft on unknown component types (Day 25 Brief B). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. Path Sum II — what is the backtracking pattern?

**Answer:**

> Push `node.val` onto path. At leaf, if remaining equals val, copy path to answers. Recurse left/right with `remaining - val`. Pop after both children — restore invariant for other branches. DFS preorder + explicit undo.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Path Sum I (exists)? | Return true early — no need to collect all paths. |
| Negative values? | Still DFS — no monotonic window trick. |
| Target zero at root-only? | Clarify whether root counts as path. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What trade-offs should seniors mention?

**Answer:**

> BFS vs DFS for same problem (max depth): same O(n), different space h vs w. Recursive vs iterative: clarity vs stack depth on skewed input. Array queue vs deque: acknowledge `removeFirst` cost. Failure modes: BST tricks on plain trees, forgetting null markers in serialize, diameter at root only, Morris without restore.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Symmetric tree? | Mirror DFS: `same(a.left,b.right) && same(a.right,b.left)`. |
| Iterative preorder? | Push root; pop, visit, push right then left. |
| When to mention Morris? | Only if you can finish link threading and restore in one breath. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Construct tree from preorder + inorder — full approach?

**Answer:**

> **Preorder[0] is the root.** Find that value in **inorder** to split left/right subtree sizes; recurse on matching preorder slices. Build a **hashmap value→index** for O(n) total if values are unique — don’t rescan inorder each time (that’s O(n²)). Clarify unique values. Time O(n), space O(n) for the map + O(h) recursion.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Duplicate values? | Classic LC assumes unique — say so; otherwise need multiset/indices carefully. |
| Why both arrays? | Preorder picks root order; inorder gives left/right partition. |
| Agenda tag? | “Hash index + recurse sizes.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Symmetric tree — full approach?

**Answer:**

> A single comparison of the root’s children is **nowhere near enough**. Need a **mirror predicate**: two nodes match if values are equal and **left of one matches right of the other** recursively — including **nulls**. Alternatively **BFS with a queue of pairs**. Time O(n), space O(h) or O(w). Agenda opener: “Mirror recursively — not one root check.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Asymmetric nulls on one side? | Mirror check fails — nulls must pair symmetrically. |
| Perfect binary vs symmetric? | Perfect ≠ symmetric; values/structure must mirror. |
| Next sample? | [03-approach-complexity.md](03-approach-complexity.md). |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-approach-complexity.md](03-approach-complexity.md)

---

