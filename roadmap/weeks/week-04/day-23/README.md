# Day 23 — DSA HashMap / Heap + Mixed Unknown-Pattern

> Week 4 · Full study (self-contained) · ~4–5 hrs 
> Revision twin: [revision/weeks/week-04/day-23.md](../../../revision/weeks/week-04/day-23.md)

## Outcomes

By end of day, without notes, you can:

- Deploy **HashMap** patterns: frequency / index / prefix-state / sliding-window counts / two-sum family — and when hashing beats sorting
- Deploy **Heap** patterns: Top-K, merge K, Kth in stream, K closest — with min vs max heap intuition in Swift
- Run a **mixed unknown-pattern** drill: 60–90s classify *before* coding when the topic isn’t labeled
- Speak complexity: expected vs worst hash; heap `O(log k)`; space trade-offs
- Stop pattern-worship: stuck → brute → constrain → named structure

## How to study

1. [`01-foundations.md`](01-foundations.md) — mental models for hash + heap
2. [`02-deep-dive.md`](02-deep-dive.md) — catalogs, mixed classification, traps
3. [`03-production-bridge.md`](03-production-bridge.md) — S2 / S3 / S16 honest hooks
4. [`code/`](code/) — worked Swift (Two Sum, anagrams, prefix+K, top-K, merge-K sketch, window)
5. [`sample/07-revision-qna.md`](sample/07-revision-qna.md) — two-layer approach scripts
6. [`05-exercises.md`](05-exercises.md) — hash/heap blocks + mixed simulation
7. Revision twin for timed recall

## Module map

| Module | File |
|---|---|
| Foundations | [01-foundations.md](01-foundations.md) |
| Deep dive | [02-deep-dive.md](02-deep-dive.md) |
| Production bridge | [03-production-bridge.md](03-production-bridge.md) |
| Questions | [sample/07-revision-qna.md](sample/07-revision-qna.md) |
| Exercises | [05-exercises.md](05-exercises.md) |
| Code | [code/](code/) |
| Sample Q&A | [sample/README.md](sample/README.md) |

## Time budget

| Block | Minutes |
|---|---|
| Foundations | 40–50 |
| Deep dive + code | 70–90 |
| Production bridge | 15–25 |
| Questions | 50–60 |
| Hash/Heap solves | 60–75 |
| Mixed 90s tags + ≥3 solves | 75–90 |

## Provenance

| Label | Today |
|---|---|
| **Verified · S2** | Synchronised dictionaries — map *access* culture, not hash math |
| **Verified · S3** | Search debounce / coalesce keys |
| **Verified · S16** | GymFlow top-K similar via embeddings — heap/select mental model |
| **Learning-lab** | All `code/` Swift |

Do **not** invent LeetCode metrics. Resume trio only if behavioral drift: **30L+ DAU**, **99.95%**, **30%+ nav**.

## Agenda opener

> “Clarify uniqueness, order, online vs offline. Brute nested loops. Optimized: hash complements/frequencies or size-K heap. Expected O(n) or O(n log k). Edges: empty, dups, negatives. Coding now.”
