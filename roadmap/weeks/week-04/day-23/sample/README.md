# Day 23 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 23 modules.  
> Use this when you want hash/heap and mixed-pattern concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice in [`../04-questions.md`](../04-questions.md) and drills in [`../05-exercises.md`](../05-exercises.md).

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
| [01-hashmap-patterns.md](01-hashmap-patterns.md) | Frequency, complement, prefix+K, windows | Foundations · Deep dive |
| [02-heap-patterns.md](02-heap-patterns.md) | Top-K, Kth stream, merge K, min vs max | Foundations · Deep dive |
| [03-mixed-unknown-pattern.md](03-mixed-unknown-pattern.md) | 90s classify protocol, pivots, anti-DP worship | Foundations · Deep dive |
| [04-production-maps-topk.md](04-production-maps-topk.md) | S2/S3/S16 honest hooks | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| Hash | Expected O(1) lookup — design a good **key** |
| Heap Top-K | Min-heap size K for Kth **largest** — root is answer |
| Negatives + subarray sum | **Prefix+hash** — not sliding window |
| Unknown pattern | 90s classify **before** coding |
| Average vs worst hash | Say expected O(n); pathological collisions exist |
| Production | Maps for coalescing — not “search is Two Sum” |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).
