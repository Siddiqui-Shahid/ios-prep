# Day 22 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 22 modules.  
> Use this when you want tree BFS/DFS concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice interview timing in [`../04-questions.md`](../04-questions.md) and solves in [`../05-exercises.md`](../05-exercises.md).

## Module map

Full curriculum layout: [`../README.md`](../README.md#module-map)

| Module | File |
|---|---|
| Foundations | [01-foundations.md](../01-foundations.md) |
| Deep dive | [02-deep-dive.md](../02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](../03-production-bridge.md) |
| Questions | [04-questions.md](../04-questions.md) |
| Exercises | [05-exercises.md](../05-exercises.md) |
| Code | [code/](../code/) |

## Topic map

| Sample file | What it teaches | Main modules |
|---|---|---|
| [01-bfs-dfs-basics.md](01-bfs-dfs-basics.md) | BFS vs DFS, binary vs BST, level-size idiom | Foundations · Deep dive |
| [02-tree-patterns-skeletons.md](02-tree-patterns-skeletons.md) | Pattern catalog, LCA, validate BST, diameter | Deep dive · code |
| [03-approach-complexity.md](03-approach-complexity.md) | “Say this first”, complexity scripts, edges | Foundations · Deep dive |
| [04-production-trees.md](04-production-trees.md) | SDUI / SDK / deeplink tree hooks (honest) | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| BFS | Level / width / unweighted shortest path |
| DFS | Path, subtree, combine-after-children |
| BST ≠ binary tree | LCA walk and validate need extra invariants |
| Complexity | O(n) time; O(h) or O(w) space — not “O(1) recursive” |
| Level-size BFS | `for _ in 0..<queue.count` each wave |
| Production | Map *shapes* to SDUI/nav — don’t invent LeetCode metrics |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).
