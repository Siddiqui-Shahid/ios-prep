# 05 — Exercises: Trees BFS / DFS

> Goal: pattern ID + spoken agenda > clever tricks. Log every solve.

---

## 1. Code lab (read before inventing)

| File | What to extract |
|---|---|
| [`code/TreeNode.swift`](code/TreeNode.swift) | Shared node type |
| [`code/TreeBFS.swift`](code/TreeBFS.swift) | Level order, zigzag, right side view |
| [`code/TreeDFS.swift`](code/TreeDFS.swift) | Max depth, diameter, path sum, symmetric, LCA |
| [`code/BSTProblems.swift`](code/BSTProblems.swift) | Validate BST, kth smallest |
| [`code/SerializeTree.swift`](code/SerializeTree.swift) | Codec with null markers |

**Drill:** For each function, cover the solution, speak the 60–90s agenda from memory, then uncover and compare.

---

## 2. Solve set (target 8–12 Medium)

From [dsa-track.md](../../../coding/dsa-track.md) Week 4 Trees:

| # | Problem | Pattern tag | Agenda memo? (Y/N) | Time to first correct | Miss note |
|---|---|---|---|---|---|
| 1 | Binary Tree Level Order Traversal | | | | |
| 2 | Binary Tree Zigzag Level Order | | | | |
| 3 | Maximum Depth of Binary Tree | | | | |
| 4 | Diameter of Binary Tree | | | | |
| 5 | Path Sum II (or Path Sum) | | | | |
| 6 | Lowest Common Ancestor of a Binary Tree | | | | |
| 7 | Validate Binary Search Tree | | | | |
| 8 | Kth Smallest Element in a BST | | | | |
| 9 | Symmetric Tree | | | | |
| 10 | Binary Tree Right Side View | | | | |
| 11 | Serialize and Deserialize Binary Tree *(stretch)* | | | | |
| 12 | Construct Binary Tree from Preorder and Inorder *(stretch)* | | | | |

**Rule:** No memo of the master script → solve does not count as done.

---

## 3. Whiteboard-only (no IDE) — 25 min

Pick **Right Side View** cold:

1. Speak agenda (≤90s).
2. Write level-size BFS outline.
3. Trace the 5-node example from Foundations.
4. State complexity.
5. Only then peek `code/TreeBFS.swift`.

---

## 4. Speaking drills

| Drill | Time | Pass bar |
|---|---|---|
| Complexity script ×5 | 5 min | No “O(1) recursive” slip |
| BST validate trap explanation | 60s | Counterexample included |
| Diameter root-only failure | 60s | Subtree diameter named |
| Production bridge 45s | 45s | No fake LeetCode metrics |

---

## 5. Timed Q drill

1. Pick **3 Normal + 2 Tricky** from [`04-questions.md`](04-questions.md).
2. Record; score vs [answer-timing-guide.md](../../../timing/answer-timing-guide.md).
3. Log misses in gotchas (especially: BST validate, diameter root-only, O(1) space).

---

## 6. Bonus (10 min)

Cold-open **only** the agenda + code outline for Construct from Preorder and Inorder — no full polish. Tag pattern: “hash index + recurse sizes.”

---

## 7. Exit criteria

- [ ] ≥8 problems logged with pattern tags
- [ ] Complexity said aloud before each
- [ ] Two-layer Q set recorded once
- [ ] Skimmed revision twin: [../../../revision/weeks/week-04/day-22.md](../../../revision/weeks/week-04/day-22.md)

**Tomorrow:** Day 23 HashMap / Heap + mixed unknown-pattern — reuse today’s tree tags in the mixed set.
'''