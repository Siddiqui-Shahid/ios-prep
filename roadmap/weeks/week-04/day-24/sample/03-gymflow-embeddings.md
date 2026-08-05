# Sample 03 — GymFlow embeddings & fallback (Q&A)

> Guided teaching. **Verified · S16** — retrieval + rank + degradation, not cloud LLM.

---

### Q1. What problem does GymFlow solve?

**Points to:** [Deep dive · §2.1 Problem](../02-deep-dive.md#21-problem) · [Production bridge · S16](../03-production-bridge.md#verified--s16--gymflow)

**Answer:**

> Workout recommendations **without** cloud LLM cost, latency, or privacy drag. On-device ranking over exercise catalog with trainer routine as RAG-style context.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cloud LLM dependency? | **Not claimed.** |
| Generative chat? | Rank/recommend — not required to stream tokens. |
| Day 23 link? | Top-K cosine = heap mental model. |

---

### Q2. Defend the GymFlow architecture.

**Points to:** [Deep dive · §2.2 Architecture](../02-deep-dive.md#22-architecture)

**Answer:**

> **(1)** INT8 **MiniLM TFLite** + WordPiece tokenizer (Dart in shipped app). **(2)** Embed query/user context; **cosine similarity** over exercise catalog; trainer routine as retrieval context. **(3)** Fail-soft: **TF-IDF** lexical fallback if TFLite missing, slow, or thermal-limited. Principle: retrieval + ranking + degradation — not “call an LLM.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “GymFlow ranks exercises with on-device MiniLM embeddings and falls back to TF-IDF when the model path can’t run.” |
| INT8 why? | Fits mobile RAM; quality trade-off vs FP32. |
| STAR? | story-bank #S16. |

---

### Q3. How does cosine top-K work?

**Points to:** [Deep dive · §2.3 Cosine teaching](../02-deep-dive.md#23-cosine-teaching)

**Answer:**

> `score(a,b) = dot(a,b) / (|a| |b|)`. Rank exercises by score; take **top-K**. Same “best K under a score” instinct as Day 23 heap patterns — mental model only unless verified heap shipped.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Normalize vectors? | Often pre-normalized for cosine ≈ dot product. |
| K too large on main thread? | Batch/off-main; thermal guard. |
| Empty catalog? | Honest empty — don’t hallucinate exercises. |

---

### Q4. When does TF-IDF fallback kick in?

**Points to:** [Deep dive · §5 Fail-soft matrix](../02-deep-dive.md#5-fail-soft-matrix-memorize) · [Foundations · §3 GymFlow row](../01-foundations.md#3-two-products-one-principle)

**Answer:**

> TFLite model missing, load/checksum fail, thermal `.serious`, Low Power, or memory warning → **TF-IDF** lexical similarity. Hide or downgrade embedding-powered UI chrome. User still gets recommendations — less “magical,” set expectations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Code sketch? | `code/TFIDFFallback.swift` — teaching. |
| vs BM25 FinTrack? | Both lexical fail-soft cousins — TF-IDF for GymFlow catalog text. |
| Paraphrase gap? | Embeddings handle better; TF-IDF weaker — accepted degrade. |

---

### Q5. Trade-offs: BM25/lexical vs MiniLM/vector?

**Points to:** [Deep dive · §4 Trade-offs](../02-deep-dive.md#4-trade-offs)

**Answer:**

> **BM25/lexical:** offline, explainable, no embedder — weaker paraphrase. **MiniLM/vector:** semantic paraphrase — model size, tokenizer bugs, main-thread jank if careless. **On-device LLM generate:** privacy/latency — quality, thermal, coverage cost. **Rules/TF-IDF fail-soft:** always-on, less magical.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| FinTrack picks? | BM25 + rules — sample 02. |
| Always-cloud “AI feature”? | Fails senior privacy + offline bars. |
| Apple FM on GymFlow? | Not claimed — TFLite path verified. |

---

### Q6. Map portfolio to generic on-device HLD?

**Points to:** [Deep dive · §3 Map portfolio](../02-deep-dive.md#3-map-portfolio--generic-on-device-hld)

**Answer:**

> Local RAG/index: FinTrack BM25; GymFlow MiniLM+cosine. Quantized runtime: GymFlow INT8 TFLite; FinTrack Apple FM path. Hybrid router + thermal: eligibility checks (`code/DeviceAIEligibility.swift`). Streaming UI: partial updates. Memory/jetsam: unload on warning. Privacy: FinTrack no-sync.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Optional deepen doc? | `ios-system-design/docs/on-device-llm-ai-engine.md` after chapter solid. |
| Day 27 link? | SD timing cheatsheet for system design day. |
| Scale caution BMS? | 30L DAU — unconstrained on-device LLM on checkout is reckless. |

---

### Q7. Hybrid router — speak the design?

**Points to:** [Deep dive · §7 Hybrid router](../02-deep-dive.md#7-hybrid-router-sketch-teaching)

**Answer:**

> If !eligible || thermal || lowPower → rulesOrTfIdf. Else retrieve (BM25 or embeddings). If ctx empty → emptyState. If canLocalGenerate → streamLocal. Else if cloudAllowed && consented → streamCloud(sanitize). Else rulesOrTfIdf. See `code/HybridAIRouter.swift`.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| FinTrack cloud branch? | Design-only with consent — not shipped default. |
| Eligibility checks? | OS, memory, model file, thermal at launch and per request. |
| Next sample? | Production S15/S16 honest proof. |

---

Next: [04-production-s15-s16.md](04-production-s15-s16.md)
