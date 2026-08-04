# Day 24 — On-Device AI (FinTrack / GymFlow)

> Week 4 · Full study (self-contained) · ~4–5 hrs  
> Revision twin: [revision/weeks/week-04/day-24.md](../../../revision/weeks/week-04/day-24.md)

## Outcomes

By end of day, without notes, you can:

- Draw end-to-end **on-device AI assistant** flow: eligibility → retrieve → prompt → local infer / fallback → stream → metrics
- Defend **FinTrack (S15):** BM25 offline RAG + Apple Intelligence / Foundation Models bridge + **deterministic rule** fail-soft; **no cloud sync** of financial data
- Defend **GymFlow (S16):** INT8 MiniLM **TFLite** + cosine top-K + **TF-IDF** fail-soft
- Explain why seniors design **degradation paths** before the happy path
- Answer normal + tricky AI questions with agenda, trade-off, and honest provenance (product AI ≠ District tooling AI)

## How to study

1. [`01-foundations.md`](01-foundations.md) — primer (tokens, quant, embeddings, RAG, fail-soft)
2. [`02-deep-dive.md`](02-deep-dive.md) — FinTrack + GymFlow full teaching + hybrid router + privacy
3. [`03-production-bridge.md`](03-production-bridge.md) — Verified S15/S16 + Applied design + 30L DAU caution
4. [`code/`](code/) — Swift teaching sketches (BM25-ish ranker, router, TF-IDF fallback, eligibility)
5. [`04-questions.md`](04-questions.md) — two-layer Q&A
6. [`05-exercises.md`](05-exercises.md) — HLD whiteboard + STAR timing
7. Revision twin for flashcards

**Optional deepen (after chapter is solid):** [on-device-llm-ai-engine.md](../../../../ios-system-design/docs/on-device-llm-ai-engine.md) — this chapter is self-contained first.

## Provenance

| Label | Today |
|---|---|
| **Verified · S15** | FinTrack: Hive local-first, BM25 RAG, Apple FM / native AI bridge, rule fallback, no cloud financial sync |
| **Verified · S16** | GymFlow: INT8 MiniLM TFLite, cosine top-K, TF-IDF fail-soft |
| **Verified · S9** | Contrast only — AI *tooling* / context engineering ≠ product on-device AI |
| **Verified · S8** | Soft — kill switch / crash-free judgment at consumer scale |
| **Learning-lab** | `code/` sketches — teaching, not production Flutter/Dart paste |

Do **not** invent model latency ms, accuracy %, or “we fine-tuned on user ledgers.”

## Agenda opener (SD)

> “I’ll cover privacy constraints, retrieval, on-device inference, hybrid fallback, and ops metrics — starting with FinTrack and GymFlow as concrete instances.”
