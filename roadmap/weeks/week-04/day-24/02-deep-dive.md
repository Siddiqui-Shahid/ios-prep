# 02 — Deep Dive: FinTrack, GymFlow, Router, Privacy (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Problem? `(45–60s)`
**Answer:**

> “Expense coach that must not ship ledger data to a cloud LLM by default.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Architecture you can defend? `(45–60s)`
**Answer:**

> “1. Local store: Flutter + Hive; biometric lock; no cloud sync of financial records. 2. Retrieval: BM25 over local spending index (lexical, offline, explainable). 3. Generation path: flutter_native_ai → Apple Foundation Models / platform AI where available; else on-device Nano-class path when present. 4. Fail-soft: Deterministic rule engine (budget thresholds, category heuristics) when model unavailable — still a coach, not a blank screen. 5. Privacy invariant: Prefer on-device; if a design interview adds cloud, PII sanitize + user consent + minimize fields.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. BM25 teaching (enough for interviews)? `(45–60s)`
**Answer:**

> “BM25 scores a document against a query using term frequency, document length normalization, and inverse document frequency. You do not need to derive the formula live. Say: “BM25 ranks local spend notes and category text by lexical relevance. It’s offline, explainable, and needs no embedder binary — weaker on paraphrase (‘UBER’ vs ‘rideshare’), which is an accepted trade-off for FinTrack’s text.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Grounding money (non-negotiable)? `(45–60s)`
**Answer:**

> “Generative text is never source of truth for balances or amounts. Prompt: only use provided context. UI can show retrieved rows / citations. Rules path reads DB deterministically.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “FinTrack is local-first — BM25 RAG over Hive, Apple Intelligence when present, rules when not; financial data doesn’t leave the device.” → STAR: story-bank.md#.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Problem? `(45–60s)`
**Answer:**

> “Workout recommendations without cloud LLM cost/latency/privacy drag.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Architecture? `(45–60s)`
**Answer:**

> “1. INT8 MiniLM TFLite + WordPiece tokenizer (Dart in the shipped app). 2. Embed query / user context; cosine similarity over exercise catalog; trainer routine as RAG context. 3. Fail-soft: TF-IDF lexical fallback if TFLite model missing/slow/thermal. 4. Principle: retrieval + ranking + degradation, not “call an LLM.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Cosine teaching? `(45–60s)`
**Answer:**

> “text score(a,b) = dot(a,b) / ( ) Top-K by score. Same “best K” instinct as Day 23 heaps (mental model only).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Interview line (≤20s)? `(45–60s)`
**Answer:**

> “GymFlow ranks exercises with on-device MiniLM embeddings and falls back to TF-IDF when the model path can’t run.” → STAR: #.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Map portfolio → generic on-device HLD? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Trade-offs? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Fail-soft matrix (memorize)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Privacy-first script (90s) — speak verbatim until automatic? `(45–60s)`
**Answer:**

> “Financial and health-adjacent data stays on device. Retrieval runs locally. Generative models are optional accelerators behind capability checks. Analytics get coarse events — coach_shown, fallback_rule — not raw transactions. If a hybrid cloud path is required, it’s consent-gated, field-minimized, and never the only path.” ---.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Hybrid router sketch (teaching)? `(45–60s)`
**Answer:**

> “text func route(query): if !eligible lowPower: return rulesOrTfIdf(query) ctx = retrieve(query) // BM25 or embeddings if ctx.isEmpty: return emptyState if canLocalGenerate: return streamLocal(ctx, query) if cloudAllowed && consented: return streamCloud(sanitize(ctx, query)) return rulesOrTfIdf(query) See code/HybridAIRouter.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Scale caution (BookMyShow judgment)? `(45–60s)`
**Answer:**

> “At 30L+ DAU, unconstrained on-device LLM on checkout is a reliability/battery risk. You’d want feature flags, sampling, kill switches — same culture as 99.95% crash-free. FinTrack/GymFlow are personal-scale proofs of architecture; BMS teaches when not to be reckless. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q16. Optional citations (after mastery)? `(45–60s)`
**Answer:**

> “- on-device-llm-ai-engine.md - Apple Foundation Models / WWDC on-device sessions - cheatsheet.md for Day 27 SD timing → 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
