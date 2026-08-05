# Day 22 — DSA Trees: BFS / DFS Patterns

> Week 4 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-04/day-22.md](../../../revision/weeks/week-04/day-22.md)

## Outcomes

By end of day, without notes, you can:

- Choose **BFS vs DFS** from the prompt trigger (levels / unweighted shortest vs path / subtree / LCA) and state **O(n)** time with **O(h)** or **O(w)** space in one breath
- Code the **level-size BFS** idiom and the four DFS shapes (pre / in / post / “recurse children”) in Swift
- Open every tree problem with a **2–3 min “say this first”** script before typing
- Solve **8–12** medium tree problems from the track list while narrating complexity *before* implementation
- Map traversal patterns to production mental models (SDUI node tree, view hierarchy, deeplink routes) **without inventing LeetCode metrics**

## How to study (in Cursor only)

1. [`01-foundations.md`](01-foundations.md) — mental model + glossary + first walk-throughs
2. [`02-deep-dive.md`](02-deep-dive.md) — pattern catalog, skeletons, traps, complexity scripts
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified hooks (S3 / S10 / S13) + interview lines
4. [`code/`](code/) — worked Swift solutions (BFS, DFS, BST, diameter, LCA, serialize)
5. [`04-questions.md`](04-questions.md) — cover **Full spoken answer**; speak from **Answer points**; compare
6. [`05-exercises.md`](05-exercises.md) — problem set + timed drills
7. Revision twin for flashcards / timed recall day-of

## Module map

| Module | File | Role |
|---|---|---|
| Foundations | [01-foundations.md](01-foundations.md) | Intern → mid mental model |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) | Pattern triggers, skeletons, trade-offs |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) | SDUI / nav / SDK trees — honest mapping |
| Questions | [04-questions.md](04-questions.md) | Two-layer Q&A (normal + tricky) |
| Exercises | [05-exercises.md](05-exercises.md) | Solve log + speaking drills |
| Code | [code/](code/) | Runnable interview-style Swift |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Time budget (suggested)

| Block | Minutes |
|---|---|
| Foundations | 45–60 |
| Deep dive + skim code | 75–90 |
| Production bridge | 20–30 |
| Questions (speak 6–8 aloud) | 60–75 |
| Exercises (solve + agenda memos) | 90–120 |

## Provenance reminder

Only use Verified IDs from [`../../../provenance/README.md`](../../../provenance/README.md).

| Label | Use for today |
|---|---|
| **Verified · S3** | Backend-driven header / search — nested CMS / SDUI *shape* |
| **Verified · S10** | Stories SDK — component tree boundaries |
| **Verified · S13** | Deeplink + hybrid navigation hierarchy |
| **Learning-lab** | All LeetCode Swift in `code/` — interview practice, not shipped product |

Do **not** invent fill-rate %, latency ms, or “I solved N trees in prod.” Resume metrics stay for behavioral days: **30L+ DAU**, **99.95% crash-free**, **30%+ nav reduction**.

## Agenda opener (pin this)

> “Clarify binary vs BST, path vs bool, mutate OK? Brute O(n²) if needed. Pattern is BFS level-size / DFS postorder / bounds. Time O(n), space O(h) or O(w). Edges: null, skewed, duplicates. Coding now.”
