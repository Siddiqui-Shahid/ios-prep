# Day 22 — DSA Trees: BFS / DFS Patterns

> Week 4 · Revision pass ~45–60 min  
> Full study: [weeks/week-04/day-22/](../../../weeks/week-04/day-22/README.md)  
> Sample Q&A (guided): [weeks/week-04/day-22/sample/](../../../weeks/week-04/day-22/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- When to pick **BFS** vs **DFS** from the prompt trigger — and state **O(n)** time with **O(h)** or **O(w)** space in one breath
- The **level-size BFS** idiom and the four DFS shapes (pre / in / post / recurse children)
- Open every tree problem with a **2–3 min “say this first”** script before typing
- Map traversal *shapes* to SDUI / nav / SDK trees — without inventing LeetCode metrics

## 2. Concept refresh (simple)

### 2.1 BFS vs DFS

| Trigger | Pattern |
|---|---|
| Level / width / unweighted shortest path | **BFS** + queue |
| Path / subtree / combine-after-children / LCA | **DFS** |

Level-size idiom: `for _ in 0..<queue.count` each wave — never mix nodes from different depths in one pass.

### 2.2 BST ≠ binary tree

LCA on a BST walks values in **O(h)**. General binary tree LCA is postorder bubble-up. Validate BST with **bounds** or **inorder** — parent-only compare is wrong.

### 2.3 Complexity script

> “n nodes, visit each once → **O(n)** time. Space **O(h)** recursion or **O(w)** queue; skewed worst **O(n)**.”

Say “auxiliary O(1) besides call stack O(h)” — not “O(1) recursive.”

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| BFS | Level / width / unweighted shortest path |
| DFS | Path, subtree, combine-after-children |
| BST ≠ binary tree | LCA walk and validate need extra invariants |
| Complexity | O(n) time; O(h) or O(w) space — not “O(1) recursive” |
| Level-size BFS | `for _ in 0..<queue.count` each wave |
| Production | Map *shapes* to SDUI/nav — don’t invent LeetCode metrics |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-04/day-22/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-04/day-22/01-foundations.md) | Pattern catalog + skeletons |
| Drill | [04-questions](../../../weeks/week-04/day-22/04-questions.md) | Timed answers |
| Code | [code/](../../../weeks/week-04/day-22/code/) | BFS, LCA, validate BST |

## 4. Map to your work

**BookMyShow backend-driven header & search:** Backend-driven header — nested CMS component tree; BFS-like depth passes vs DFS-like path decisions.  
**Stories SDK (Raw / Miami Heat):** Stories SDK — page/frame hierarchy and ownership boundaries.  
**Hybrid UI / deeplinks:** Deeplink route tree — path resolve is DFS-shaped; sibling listing is BFS-shaped.

**Interview line (≤20s):** “Tree BFS/DFS show up in product as view and SDUI trees — BFS for level-aware layout, DFS for path or subtree decisions.”

→ [BookMyShow backend-driven header & search](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow) · [Stories SDK (Raw / Miami Heat)](../../stories/story-bank.md#s10--stories-sdk-raw--miami-heat) · [Hybrid UI / deeplinks](../../stories/story-bank.md#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies)

Do **not** claim “we used LeetCode level-order in prod.” Resume trio (**30L+ DAU**, **99.95%**, **30%+ nav**) stays for behavioral days.

## 5. Flash prompts

1. BFS vs DFS — three trigger phrases each
2. Level-size BFS idiom — why the inner loop?
3. Validate BST — bounds vs inorder; why parent-only fails
4. LCA binary tree vs BST — different algorithms
5. Diameter — one-pass height + global max (not root-only)
6. Complexity script — O(n), O(h)/O(w), skewed worst
7. “Say this first” — clarify → brute → optimize → edges → code
8. SDUI tree shape — honest ≤20s, no fake metrics

## 6. Timed drills

| Drill | Budget |
|---|---|
| BFS vs DFS pick | 45s |
| Level-order implementation | 60s |
| Validate BST trap | 60s |
| LCA postorder | 60s |
| Complexity + edges | 45s |
| BookMyShow backend-driven header & search tree mapping ≤20s | 20s |

Expand from [sample cards](../../../weeks/week-04/day-22/sample/) and [04-questions](../../../weeks/week-04/day-22/04-questions.md) answer points.
