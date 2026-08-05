# Sample 01 — BFS / DFS basics (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. When do I pick BFS vs DFS?

**Points to:** [Foundations · §1 Mental model](../01-foundations.md#1-mental-model-what-a-tree-problem-is-asking) · [Deep dive · §1 Pattern catalog](../02-deep-dive.md#1-pattern-catalog-trigger--algorithm)

**Answer:**

> **BFS** when the prompt cares about **levels, width, or unweighted shortest path** — level order, zigzag, right-side view, cousins at a depth. **DFS** when it cares about **paths, subtrees, or combining results after children** — path sum, same tree, symmetric, LCA, diameter, validate BST, serialize. BFS uses a queue (FIFO); DFS uses recursion or an explicit stack.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “Shortest path” in a tree? | **BFS** — first visit is shortest when edges are unweighted. |
| “All root-to-leaf paths”? | **DFS** preorder + backtracking. |
| Can I use either for max depth? | Yes — both O(n); BFS counts waves, DFS returns 1 + max(children). Pick the one you can explain cleanly. |

---

### Q2. What is the level-size BFS idiom?

**Points to:** [Foundations · §4 BFS foundation](../01-foundations.md#4-bfs-foundation--level-size-idiom) · [Deep dive · §2 BFS skeleton](../02-deep-dive.md#2-bfs-skeleton-production-quality-interview-form)

**Answer:**

> Snapshot `queue.count` at the start of each wave, then process exactly that many nodes before starting the next level. Without it, zigzag, right-side view, and level averages turn into messy index math. Empty root → `[]`; enqueue only non-nil children.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Swift `removeFirst()` cost? | O(n) on `Array` — fine in interviews if you mention a deque or index head if pushed. |
| Zigzag variant? | Same BFS; reverse odd levels (or insert at front). |
| Right side view? | Last node dequeued each level — or DFS right-before-left with depth tracking. |

---

### Q3. What are the three DFS return styles?

**Points to:** [Foundations · §5 DFS foundation](../01-foundations.md#5-dfs-foundation--three-return-styles)

**Answer:**

> **Void / side-effect:** build a path array, push before recurse, pop after (Path Sum II). **Return a value:** height, boolean, optional node (max depth, same tree, LCA). **Return + global update:** return height but also update a global best (diameter). Decide up front: accumulating down, combining up, or both.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Preorder vs inorder vs postorder? | Pre: node before children (paths, serialize). In: left → node → right (BST sorted). Post: children first (height, LCA combine). |
| When iterative DFS? | Skewed deep trees, explicit stack control, or interviewer asks for non-recursive form. |
| Morris traversal? | O(1) aux inorder via threaded links — mention only if you can restore cleanly. |

---

### Q4. Binary tree vs BST — why does it matter?

**Points to:** [Foundations · §1.3 Binary tree vs BST](../01-foundations.md#13-binary-tree-vs-bst-do-not-blur) · [Deep dive · §4.2 LCA](../02-deep-dive.md#42-lca-binary-tree--postorder-markers)

**Answer:**

> A **binary tree** only guarantees ≤2 children. A **BST** adds left < node < right (clarify duplicates). BST unlocks bounds validation, inorder sorted order, O(h) BST LCA walk, and k-th smallest via inorder. Using BST LCA on a plain binary tree is wrong.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BST LCA in one line? | If both vals < node → left; both > node → right; else current node is LCA. O(h). |
| Validate BST trap? | Parent-only check fails — need low/high bounds or strictly increasing inorder. |
| Duplicate policy? | Clarify with interviewer — affects bounds (`<=` vs `<`). |

---

### Q5. What complexity should I say for tree problems?

**Points to:** [Foundations · §3 Complexity script](../01-foundations.md#3-complexity-script-memorize-verbatim) · [Deep dive · §8 Complexity quick reference](../02-deep-dive.md#8-complexity-quick-reference)

**Answer:**

> n = number of nodes. Visit each once → **O(n)** time. Recursion depth or queue holds up to **O(h)** height or **O(w)** max width; skewed tree → O(n) space; balanced → O(log n) height. Never say “O(1) space” for recursive DFS without noting the call stack is O(h).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BFS space? | O(w) for the queue — can be Θ(n) on a wide bushy level. |
| DFS space? | O(h) call stack — O(n) if skewed. |
| Morris inorder? | O(1) auxiliary besides mutations — rare mention. |

---

### Q6. Walk BFS and DFS on a tiny tree.

**Points to:** [Foundations · §1.2 Intern demo](../01-foundations.md#12-the-intern-demo-say-aloud-once)

**Answer:**

> Tree: root 1, children 2 and 3, 2 has 4 and 5. **BFS visit order:** 1, then 2–3, then 4–5 → levels `[[1],[2,3],[4,5]]`. **DFS preorder:** 1,2,4,5,3. **Inorder:** 4,2,5,1,3. **Postorder:** 4,5,2,3,1. Say aloud: “BFS answers width; DFS answers structure; inorder is special for BSTs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why draw this every time? | Proves you know level vs depth vs visit order — not just memorizing one template. |
| Single-node tree? | BFS/DFS both visit once; depth = 1 (confirm node vs edge definition). |
| Null root? | Return empty / 0 / false per prompt — name it in edges. |

---

### Q7. What should I know before opening Deep Dive?

**Points to:** [Foundations · §9 Checklist](../01-foundations.md#9-checklist-before-you-open-deep-dive)

**Answer:**

> Draw BFS vs DFS on a 5-node tree. Recite complexity without “O(1) recursive.” Know BST ≠ binary tree for LCA and validate. Speak the 6-step “say this first” agenda. Know level-size = `for _ in 0..<queue.count`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Default Swift node shape? | `final class TreeNode { var val, left, right }` — reference nodes in LeetCode; SDUI trees are often value/Codable enums in prod. |
| Height vs depth? | Confirm with interviewer — edges vs nodes along longest root→leaf. |
| Next file? | Pattern catalog and skeletons in sample 02 and Deep Dive. |

---

Next: [02-tree-patterns-skeletons.md](02-tree-patterns-skeletons.md)
