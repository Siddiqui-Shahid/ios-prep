# Day 24 — On-Device AI (FinTrack / GymFlow)

> Week 4 · Revision pass ~45–60 min  
> Full study: [weeks/week-04/day-24/](../../../weeks/week-04/day-24/README.md)  
> Sample Q&A (guided): [weeks/week-04/day-24/sample/](../../../weeks/week-04/day-24/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Draw end-to-end **on-device AI** flow: eligibility → retrieve → prompt → local infer → **degrade path** → metrics
- Defend **FinTrack (FinTrack on-device AI):** Hive local-first; BM25 RAG; rules fallback; **no cloud financial sync**
- Defend **GymFlow (GymFlow on-device AI):** INT8 MiniLM TFLite; cosine top-K; **TF-IDF fail-soft**
- Separate **product on-device AI (FinTrack on-device AI/GymFlow on-device AI)** from **tooling judgment (District Free Parking + Clean/MVVM + AI tooling)** — no invented latency or accuracy %

## 2. Concept refresh (simple)

### 2.1 Pipeline (not “call an LLM”)

```text
eligibility → retrieve → prompt/context → local infer → stream UI → metrics
                              ↓ fail
                         degrade path (rules / TF-IDF / copy)
```

Seniors design **degradation paths** before the happy path. Money amounts come from **DB / rules** — never free-form generation.

### 2.2 FinTrack FinTrack on-device AI

| Piece | Truth |
|---|---|
| Storage | Hive local-first; biometric gate |
| Retrieval | BM25 offline RAG |
| Inference | Apple Foundation Models / platform AI bridge |
| Fail-soft | Deterministic **rules** fallback |
| Privacy | **No cloud sync** of financial data |

### 2.3 GymFlow GymFlow on-device AI

| Piece | Truth |
|---|---|
| Model | INT8 MiniLM **TFLite** + WordPiece |
| Ranking | Cosine **top-K** + trainer context |
| Fail-soft | **TF-IDF** lexical fallback |
| Not claimed | Cloud LLM dependency |

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| On-device AI | Retrieve + guarded infer + **degrade path** — not “call an LLM” |
| FinTrack FinTrack on-device AI | Hive local-first; BM25 RAG; rules fallback; **no cloud financial sync** |
| GymFlow GymFlow on-device AI | INT8 MiniLM TFLite; cosine top-K; TF-IDF fail-soft |
| Money amounts | **DB / rules** — never free-form generation |
| Product vs tooling | FinTrack on-device AI/GymFlow on-device AI ≠ District District Free Parking + Clean/MVVM + AI tooling context engineering |
| Forbidden | Invented latency ms, accuracy %, fine-tune on user ledgers |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-04/day-24/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-04/day-24/01-foundations.md) | FinTrack + GymFlow depth |
| Drill | [04-questions](../../../weeks/week-04/day-24/04-questions.md) | Timed answers |
| Code | [code/](../../../weeks/week-04/day-24/code/) | BM25, router, TF-IDF sketches |

## 4. Map to your work

**FinTrack on-device AI:** FinTrack — local-first finance coach; BM25 + Apple FM bridge + rule fallback.  
**GymFlow on-device AI:** GymFlow — on-device embeddings recommender with TF-IDF fail-soft.  
**Contrast · District Free Parking + Clean/MVVM + AI tooling:** District context engineering for migrations/tests — **not** product on-device AI.  
**Soft · BookMyShow IMOC + crash-free at scale:** Kill switches and crash-free judgment applied to model load failures.

**Interview line (≤20s):** “On-device AI is retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way.”

→ [FinTrack on-device AI](../../stories/story-bank.md#s15--fintrack-on-device-ai-finance-coach) · [GymFlow on-device AI](../../stories/story-bank.md#s16--gymflow-on-device-ai-recommender) · [District Free Parking + Clean/MVVM + AI tooling](../../stories/story-bank.md#s9--free-parking--cleanmvvm--ai-tooling-district)

## 5. Flash prompts

1. On-device pipeline — six stages + degrade arrow
2. FinTrack privacy — what never leaves the device?
3. BM25 RAG vs cloud LLM — why local retrieval first?
4. GymFlow fail-soft — what happens when TFLite fails?
5. Money amounts — DB/rules, not generation
6. District Free Parking + Clean/MVVM + AI tooling vs FinTrack on-device AI/GymFlow on-device AI — tooling ≠ product AI
7. Quantization one-liner — INT8 MiniLM, not magic
8. Forbidden claims — no latency ms, no accuracy %

## 6. Timed drills

| Drill | Budget |
|---|---|
| Pipeline whiteboard | 90s |
| FinTrack FinTrack on-device AI pitch | 90s |
| GymFlow GymFlow on-device AI pitch | 90s |
| District Free Parking + Clean/MVVM + AI tooling contrast answer | 60s |
| Fail-soft trade-off | 60s |
| SD opener (privacy→retrieve→infer→ops) | 45s |

Expand from [sample cards](../../../weeks/week-04/day-24/sample/) and [04-questions](../../../weeks/week-04/day-24/04-questions.md) answer points.
