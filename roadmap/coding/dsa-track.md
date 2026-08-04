# Swift DSA Track — 4 Weeks

Candidate: **Muhammed Shahid** · BMS / District / Raw  
Solve in **Swift**. Narrate before typing. Timing: [answer-timing-guide.md](../timing/answer-timing-guide.md) § Coding approach (2–3 min).

**Resume metrics only** (behavioral / SD, not invent LeetCode numbers): 30L+ DAU · 99.95%+ CFS · 30%+ fewer full-screen navs.

---

## Master “say this first” (≈60s)

Use on **every** problem before code:

> “Constraints? Sorted? Duplicates? Mutate in place?  
> Brute force would be … O(?).  
> I’ll use … because … . Complexity time … space … .  
> Edge cases: empty, single element, all same / null head.  
> Coding the optimized version now.”

Swift tips: `String` is not random O(1) — convert to `[Character]` when needed; prefer iterative list reverse; note `Array.removeFirst` is O(n).

---

## Week 1 — Arrays / Strings / Two Pointers / Sliding Window

**Day:** Week 1 Day 06 · Target: **~12 problems** · Goal: pattern ID + communication > clever tricks.

| # | LeetCode | Pattern | Complexity | Say this first (60s) |
|---|---|---|---|---|
| 1 | **Two Sum** | Hash map (value→index) | O(n) time / O(n) space | “Need indices — sort loses them. I’ll scan once, store complements in a dictionary. Edges: empty, no pair, duplicates.” |
| 2 | **Best Time to Buy and Sell Stock** | One-pass min + profit | O(n) / O(1) | “One buy/sell. Track min so far and max profit. Brute O(n²) pairs. Edges: length 1, decreasing prices.” |
| 3 | **Valid Palindrome** | Two pointers opposite | O(n) / O(1) | “Skip non-alnum, compare ends inward. Edges: empty, all punctuation, unicode — clarify charset.” |
| 4 | **Container With Most Water** | Two pointers ends | O(n) / O(1) | “Area = min(h)×width. Move the shorter end. Brute O(n²). Edges: n=2, all equal heights.” |
| 5 | **3Sum** | Sort + two pointers | O(n²) / O(1)–O(n) | “Sort, fix i, two-sum on remainder; skip duplicates. Edges: all zero, fewer than 3, many dups.” |
| 6 | **Longest Substring Without Repeating Characters** | Variable sliding window + set/map | O(n) / O(min(n,Σ)) | “Expand right; shrink left when duplicate. Track last index. Edges: empty, all unique, all same.” |
| 7 | **Maximum Subarray** | Kadane | O(n) / O(1) | “Running sum; reset when negative; track global max. Edges: all negative — return largest element.” |
| 8 | **Product of Array Except Self** | Prefix/suffix products | O(n) / O(1) extra (output aside) | “Left products then right pass; no division. Edges: zeros, single zero, negatives.” |
| 9 | **Move Zeroes** | Write pointer | O(n) / O(1) | “Write non-zeros forward, fill zeros. Edges: no zeros, all zeros, already packed.” |
| 10 | **Longest Consecutive Sequence** *(optional)* | Hash set | O(n) avg / O(n) | “Only start chains from numbers without n−1. Edges: empty, dups, negatives.” |
| 11 | **Minimum Size Subarray Sum** | Variable window | O(n) / O(1) | “Expand until ≥ target, shrink left, track min length. Edges: impossible → 0, single element.” |
| 12 | **Group Anagrams** *(bridge to W4)* | Frequency signature map | O(n·k) / O(n·k) | “Key by sorted string or count tuple; bucket. Edges: empty strings, single char.” |

**Week 1 exit criteria:** 8/12 solved cold in Swift with spoken agenda; Two Sum + window + Kadane fluent.

---

## Week 2 — Stack / Queue / Linked List

**Day:** Week 2 Day 13 · Target: **~10 problems**.

| # | LeetCode | Pattern | Complexity | Say this first (60s) |
|---|---|---|---|---|
| 1 | **Valid Parentheses** | Stack matching | O(n) / O(n) | “Push opens; on close check top match; empty at end. Edges: empty, only closers, odd length.” |
| 2 | **Min Stack** | Aux min stack | O(1) ops / O(n) | “Push min alongside; pop both. Edges: pop last, duplicate mins.” |
| 3 | **Daily Temperatures** | Monotonic stack | O(n) / O(n) | “Next greater: decreasing stack of indices; fill waits. Edges: strictly decreasing → zeros.” |
| 4 | **Evaluate Reverse Polish Notation** | Stack eval | O(n) / O(n) | “Numbers push; ops pop2 compute. Edges: negatives, single number.” |
| 5 | **Implement Queue using Stacks** | Two-stack amortize | Amortized O(1) | “In stack + out stack; flip on dequeue. Don’t claim worst-case O(1) always.” |
| 6 | **Sliding Window Maximum** | Monotonic deque | O(n) / O(k) | “Deque of decreasing indices in window; front is max. Edges: k=1, k=n.” |
| 7 | **Reverse Linked List** | 3-pointer iterative | O(n) / O(1) | “prev/curr/next; rewire. Edges: empty, single node. Prefer iterative for stack depth.” |
| 8 | **Linked List Cycle** | Floyd slow/fast | O(n) / O(1) | “Meet ⇒ cycle. Hash set is O(n) space alt. Edges: no cycle, cycle at head.” |
| 9 | **Merge Two Sorted Lists** | Dummy head | O(n+m) / O(1) | “Append smaller; attach remainder. Edges: one empty, equal values.” |
| 10 | **Middle of the Linked List** | Slow/fast | O(n) / O(1) | “Fast 2×; slow at middle. Clarify even-length convention (second middle).” |

**Stretch (if ahead):** Reverse Nodes in k-Group · Remove Nth Node From End · LRU Cache design sketch.

**Week 2 exit:** Valid Parentheses + reverse list + Floyd without notes; can explain why `removeFirst` is a bad queue.

---

## Week 3 — Light review + optional trees warm-up

No new heavy DSA day — Week 3 is modularization / images / perf / crashes / security / deeplinks. Keep DSA **alive**:

| Block | Time | What |
|---|---|---|
| Spaced review | 3×20 min during week | Re-solve 2 Week-1 + 2 Week-2 misses cold |
| Optional warm-up | 45–60 min once | Trees preview below (Easy only) |

### Optional trees warm-up (Easy)

| # | LeetCode | Pattern | Complexity | Say this first |
|---|---|---|---|---|
| 1 | **Maximum Depth of Binary Tree** | DFS height / BFS levels | O(n) / O(h) or O(w) | “DFS 1+max(L,R) or BFS level count. Edges: null, skewed.” |
| 2 | **Invert Binary Tree** | DFS/BFS swap | O(n) / O(h) | “Swap children recurse. Edges: null, leaf.” |
| 3 | **Same Tree** | Parallel DFS | O(n) / O(h) | “Both null OK; values + structure. Edges: shape mismatch.” |
| 4 | **Binary Tree Inorder Traversal** | DFS / stack | O(n) / O(h) | “Left-root-right. Mention BST sorted property for later.” |

---

## Week 4 — Trees BFS/DFS, HashMap/Heap, Mixed

### A. Trees (~12) — Day 22

| # | LeetCode | Pattern | Complexity | Say this first (60s) |
|---|---|---|---|---|
| 1 | **Binary Tree Level Order Traversal** | BFS level-size | O(n) / O(w) | “Queue; for count in level append. Edges: null, skewed.” |
| 2 | **Binary Tree Zigzag Level Order Traversal** | BFS + reverse odd | O(n) / O(w) | “Same as level order; reverse alternate. Edges: single node.” |
| 3 | **Binary Tree Right Side View** | BFS last-in-level | O(n) / O(w) | “Take last node each level (or DFS priority right). Edges: left-only tree.” |
| 4 | **Maximum Depth of Binary Tree** | DFS/BFS | O(n) / O(h) | Warm-up refresh. |
| 5 | **Diameter of Binary Tree** | DFS height + global | O(n) / O(h) | “At each node leftH+rightH; diameter may not pass root. Edges: line tree.” |
| 6 | **Path Sum** / **Path Sum II** | DFS remaining | O(n) / O(h) | “Subtract val; leaf check. II collects paths — copy carefully.” |
| 7 | **Lowest Common Ancestor of a Binary Tree** | Postorder both sides | O(n) / O(h) | “If both sides found, node is LCA. Trap: don’t assume BST.” |
| 8 | **Validate Binary Search Tree** | Bounds or inorder | O(n) / O(h) | “Pass (lo,hi) or check inorder increasing. Trap: only vs parent.” |
| 9 | **Kth Smallest Element in a BST** | Inorder count | O(h+k) / O(h) | “Inorder until k. Edges: k=1, k=n.” |
| 10 | **Symmetric Tree** | Mirror DFS or BFS pairs | O(n) / O(h) | “Compare left/right mirrors. Edges: null children asymmetric.” |
| 11 | **Serialize and Deserialize Binary Tree** *(stretch)* | Preorder + nulls / BFS | O(n) / O(n) | “Need explicit nulls. Link to SDUI versioning honesty.” |
| 12 | **Construct Binary Tree from Preorder and Inorder** *(stretch)* | Hash index + recurse | O(n) / O(n) | “Root from preorder; split inorder via map.” |

### B. Hash / Heap (~8) — Day 23

| # | LeetCode | Pattern | Complexity | Say this first |
|---|---|---|---|---|
| 1 | **Two Sum** | Hash | O(n) / O(n) | Refresh; indices. |
| 2 | **Group Anagrams** | Hash signature | O(n·k) | Refresh. |
| 3 | **Subarray Sum Equals K** | Prefix + hash | O(n) / O(n) | “Count prefix−k. Negatives → not two-pointer.” |
| 4 | **Longest Substring Without Repeating Characters** | Window + map | O(n) | Refresh. |
| 5 | **Top K Frequent Elements** | Hash + heap or bucket | O(n log k) or O(n) | “Min-heap size k, or freq buckets. Clarify ordered output?” |
| 6 | **Kth Largest Element in an Array** | Min-heap size k / Quickselect | O(n log k) | “Heap of k; peek is answer. Edges: dups, k=1.” |
| 7 | **Merge k Sorted Lists** | Heap of heads | O(N log k) / O(k) | “Push heads; pop min; push next. Prod metaphor: merge cursors.” |
| 8 | **K Closest Points to Origin** | Max-heap size k | O(n log k) | “Compare distance². Edges: ties — clarify.” |

### C. Mixed simulation (~6+ tags)

Cold-open: write **pattern tag in 90s**, then solve ≥3:

| Tag | Sample |
|---|---|
| Tree BFS | Right Side View leftover |
| Tree DFS | Diameter / LCA |
| Hash | Clone Graph · Subarray Sum K |
| Window | Longest substring |
| Heap | Top K / Merge K |
| Stack | Daily Temperatures if rusty |

**Week 4 volume target:** Trees 8–12 + Hash/Heap 7–8 + Mixed 3 ≈ **~20 problems**.

---

## Machine-round briefs (3 hours)

Full day notes: [week-04/day-25.md](../weeks/week-04/day-25.md). Timing guide: [answer-timing-guide.md](../timing/answer-timing-guide.md).

### Shared timebox

| Phase | Clock | Do | Don’t |
|---|---|---|---|
| Clarify | 0:00–0:15 | Restate, API shape, UIKit/SwiftUI, offline?, XCTest | Code immediately |
| Agenda | 0:15–0:20 | Layers + milestones out loud | Silent architecture |
| Skeleton | 0:20–0:45 | Types, protocols, empty UI, fake repo | Pixel UI |
| Vertical slice | 0:45–2:00 | One happy path E2E | All edges first |
| Depth | 2:00–2:30 | Cache **or** 2nd SDUI component | Aesthetic refactor |
| Tests | 2:30–2:50 | 3–6 meaningful unit tests | Coverage chase |
| Buffer | 2:50–3:00 | Trade-offs + cut lines README | New features |

**Proctor line @ 0:15:**  
> “I’ll clarify briefly, then vertical slice: UI → ViewModel → protocol repository — fake first. I’ll leave time for tests and document cut lines.”

---

### Brief A — Paginated list + cache + unit tests (3 hours)

**Prompt:**  
Build a screen that loads a **paginated** remote list (cursor or page). Show loading / empty / error. Pull-to-refresh + next page on scroll. **Cache** last-good data for fast revisit + refresh. **Unit tests** for pagination + cache policy.

**Suggested layers:**

```text
ListView → ListViewModel → ListRepository
                ├─ RemoteDataSource (URLSession / stub)
                └─ CacheDataSource (memory ± disk Codable)
```

**Acceptance:**

1. First page renders (network or stub).  
2. Next page **appends** (no wipe).  
3. Page-2 failure keeps page-1 visible.  
4. Cache: cold open can show stale then refresh (state policy aloud).  
5. Tests on reducer/repository — not only snapshots.

**Cache pick-one:** memory LRU · memory+disk · stale-while-revalidate.

**Cut lines OK:** skeletons, Diffable animations, image pipeline, auth refresh, perfect offline merge.

**BMS hook (≤20s):** listings/search state + cancel patterns at scale — don’t claim this toy is production BMS.

#### Rubric A (score 1–5 each)

| Dimension | 5 | 3 | 1 |
|---|---|---|---|
| Correctness | Happy path + key failure | Happy path only | Doesn’t run |
| Architecture | Layers + protocols | Mixed but clear | God VC/VM |
| Cache depth | Policy explained + coded | Partial | Missing |
| Tests | 3+ fast meaningful | 1 weak | None |
| Communication | Agenda + trade-offs | Occasional notes | Silent |
| Time honesty | Cut lines written | Overran polish | Unfinished core |

**Pass:** average ≥3.5, correctness ≥4, tests ≥3.

---

### Brief B — SDUI component renderer (3 hours)

**Prompt:**  
JSON document of components (`type`, `props`, optional `children`) → native views. ≥**3** types (e.g. text, image, button / vstack). Unknown `type` → safe fallback. Simple `schemaVersion` check. Unit-test decode + unknown fallback.

**Suggested layers:**

```text
JSON → SDUIDocument (Codable) → ComponentNode / factory → Renderer → AnyView/UIView
```

**Acceptance:**

1. Decode sample JSON.  
2. Render ≥3 types.  
3. Unknown type **does not crash** (placeholder + analytics stub).  
4. Nested children for one container.  
5. Tests: decoder + factory fallback.

**Cut lines OK:** CMS tooling, live reload, expression language, rich actions, Figma parity.

**Prod hooks:** BMS backend-driven header · Aces splash · Stories — fail-soft, not invent metrics.

#### Rubric B (score 1–5 each)

| Dimension | 5 | 3 | 1 |
|---|---|---|---|
| Correctness | Decode + render + fallback | Partial render | Crash on unknown |
| Architecture | Document → factory → view | Ad hoc switch in View | JSON parsed in body |
| Schema/version | Checked + commented | Mentioned only | Ignored |
| Tests | Decode + fallback covered | One decoder test | None |
| Communication | Agenda + fail-soft story | Sparse | Silent |
| Time honesty | Cut lines | Over-scoped | Pretty UI, no fallback |

**Pass:** same bar as A (avg ≥3.5, correctness ≥4, tests ≥3).

---

## Timeboxing guidance (daily DSA)

| Slot | Budget | Rule |
|---|---|---|
| Approach aloud | 2–3 min | Mandatory — see timing guide |
| Code to first green | ≤25 min Easy/Medium | If stuck 25+ min: brute + note optimize, move on |
| Edge dry-run | 3–5 min | Empty / single / all-same / null |
| Pattern log | 1 min | Tag · complexity said? · miss note |
| Spaced review | 20 min | Yesterday’s misses only |

**Anti-patterns:** silent coding · skipping brute · inventing product metrics for LC · chasing Hards in Week 1.

---

## Links

- Timing: [../timing/answer-timing-guide.md](../timing/answer-timing-guide.md)  
- Flashcards: [../flashcards/week-01.md](../flashcards/week-01.md) · [week-04.md](../flashcards/week-04.md)  
- Machine day: [../weeks/week-04/day-25.md](../weeks/week-04/day-25.md)  
- LeetCode: https://leetcode.com/ (filter Easy/Medium; Swift)

---

### Problem count summary

| Week | Focus | ≈ Problems |
|---|---|---|
| 1 | Arrays / strings / pointers / window | 12 |
| 2 | Stack / queue / linked list | 10 |
| 3 | Review + optional Easy trees | 4 optional + reviews |
| 4 | Trees + hash/heap + mixed | ~20 |
| Machine | Brief A or B | 1 timed build |
| **Total DSA solves** | | **~42 + machine** |
