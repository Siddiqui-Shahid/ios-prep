# Day 24 sample — guided Q&A

> Separate teaching sample. Does **not** replace the main Day 24 modules.  
> Use this when you want on-device AI concepts explained as **question → module pointer → answer → follow-ups**.

## How to use

1. Read the question.
2. Follow **Points to** and skim that module section (optional first pass; answers stand alone).
3. Read the **Answer** in full.
4. Cover the follow-up answers and try to speak them, then check.

After the sample, practice in [`../04-questions.md`](../04-questions.md) and HLD drills in [`../05-exercises.md`](../05-exercises.md).

## Module map

Full curriculum layout: [`../README.md`](../README.md) — study order and provenance in day README.

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
| [01-on-device-primer.md](01-on-device-primer.md) | Pipeline, tokens, RAG, quant, fail-soft | Foundations |
| [02-fintrack-rag.md](02-fintrack-rag.md) | S15 BM25, rules, privacy, grounding money | Deep dive · Production bridge |
| [03-gymflow-embeddings.md](03-gymflow-embeddings.md) | S16 MiniLM, cosine top-K, TF-IDF fallback | Deep dive · Production bridge |
| [04-production-s15-s16.md](04-production-s15-s16.md) | Verified claims, S9 contrast, bridge script | Production bridge |

## Critical truths (pin these)

| Claim | Truth |
|---|---|
| On-device AI | Retrieve + guarded infer + **degrade path** — not “call an LLM” |
| FinTrack S15 | Hive local-first; BM25 RAG; rules fallback; **no cloud financial sync** |
| GymFlow S16 | INT8 MiniLM TFLite; cosine top-K; TF-IDF fail-soft |
| Money amounts | **DB / rules** — never free-form generation |
| Product vs tooling | S15/S16 ≠ District S9 context engineering |
| Forbidden | Invented latency ms, accuracy %, fine-tune on user ledgers |

## Suggested order

`01` → `02` → `03` → `04` → then main [`../04-questions.md`](../04-questions.md).
