# Sample 02 — FinTrack RAG & privacy (Q&A)

> Guided teaching. **Verified · S15** — honest claims only.

---

### Q1. What problem does FinTrack solve?

**Points to:** [Deep dive · §1.1 Problem](../02-deep-dive.md#11-problem) · [Production bridge · S15](../03-production-bridge.md#verified--s15--fintrack)

**Answer:**

> Expense **coach** that must **not** ship ledger data to a cloud LLM by default. Local-first personal finance with retrieval-grounded advice and deterministic fallback when generative paths unavailable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified stack? | Flutter + Hive; biometric; no cloud sync of financial data. |
| Invented fine-tune? | **Forbidden** — “fine-tuned on user ledgers.” |
| Play Store ops? | Crashlytics, Remote Config, AdMob — qualitative verified. |

---

### Q2. Defend the FinTrack architecture in layers.

**Points to:** [Deep dive · §1.2 Architecture](../02-deep-dive.md#12-architecture-you-can-defend)

**Answer:**

> **(1)** Local store: Hive; biometric lock; **no cloud sync** of financial records. **(2)** Retrieval: **BM25** over local spending index — lexical, offline, explainable. **(3)** Generation: `flutter_native_ai` → Apple Foundation Models / platform AI when available. **(4)** Fail-soft: **deterministic rule engine** (budget thresholds, category heuristics). **(5)** Privacy: on-device preferred; any cloud design needs PII sanitize + consent + minimize.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “Local-first — BM25 RAG over Hive, Apple Intelligence when present, rules when not; financial data doesn’t leave the device.” |
| Android path? | Platform AI abstraction — don’t invent identical FM on Android. |
| STAR? | story-bank #S15 — full timing on exercise day. |

---

### Q3. What is BM25 enough for in interviews?

**Points to:** [Deep dive · §1.3 BM25 teaching](../02-deep-dive.md#13-bm25-teaching-enough-for-interviews)

**Answer:**

> BM25 scores documents against a query using term frequency, document length normalization, and inverse document frequency. **Do not derive the formula live.** Say: “BM25 ranks local spend notes and category text by lexical relevance — offline, explainable, no embedder binary. Weaker on paraphrase (‘UBER’ vs ‘rideshare’) — accepted trade-off for FinTrack’s text.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs vector RAG? | Semantic paraphrase vs lexical explainability — FinTrack picks lexical. |
| Code sketch? | `code/BM25Ranker.swift` — teaching, not production paste. |
| Empty index? | Fail-soft to rules + honest empty tips. |

---

### Q4. How do you ground money and stop hallucination?

**Points to:** [Deep dive · §1.4 Grounding money](../02-deep-dive.md#14-grounding-money-non-negotiable)

**Answer:**

> Generative text is **never** source of truth for balances or amounts. Prompt: only use provided context. UI shows retrieved rows / citations. **Rules path reads DB deterministically.** Analytics log coarse events — not raw transactions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User asks “what’s my balance?” | Answer from DB row in context — not invented token stream. |
| Model contradicts DB? | UI trusts DB; model text is explanatory only. |
| Cloud path design? | Sanitize fields; never send full ledger by default. |

---

### Q5. What failures trigger FinTrack fallback?

**Points to:** [Deep dive · §5 Fail-soft matrix](../02-deep-dive.md#5-fail-soft-matrix-memorize)

**Answer:**

> No Foundation Model / capability flag false → rules; hide generative chrome. Model file missing / checksum fail → same. Thermal serious / Low Power → pause infer; rules. Memory warning → unload weights. Retrieval empty → honest empty + generic tips. Cloud (if designed) → timeout → local message.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Still a “coach”? | Rules path gives budget/category guidance — not blank screen. |
| Remote config? | Disable feature path without app update. |
| 30L DAU lesson? | BMS scale teaches kill switches — FinTrack is personal-scale proof. |

---

### Q6. What is the 90s privacy-first script?

**Points to:** [Deep dive · §6 Privacy-first script](../02-deep-dive.md#6-privacy-first-script-90s--speak-verbatim-until-automatic) · [Foundations · §6 Complexity / ops](../01-foundations.md#6-complexity--ops-scripts)

**Answer:**

> “Financial and health-adjacent data stays on device. Retrieval runs locally. Generative models are optional accelerators behind capability checks. Analytics get coarse events — coach_shown, fallback_rule — not raw transactions. If hybrid cloud is required, it’s consent-gated, field-minimized, and never the only path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Health-adjacent? | FinTrack/GymFlow framing — not medical claims. |
| Token budget? | Minimize PII stuffed into any cloud prompt. |
| Hybrid router? | See `code/HybridAIRouter.swift` teaching sketch. |

---

### Q7. What must I NOT claim for S15?

**Points to:** [Production bridge · S15 table](../03-production-bridge.md#verified--s15--fintrack)

**Answer:**

> **Forbidden:** invented accuracy %, latency SLOs, “fine-tuned on user ledgers,” cloud sync of financial data. **Verified:** Hive local-first, BM25 + rule fallback, Apple FM bridge, no cloud financial sync.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 2–3 min STAR spine? | Situation local-first → Action Hive+BM25+FM+rules → Result privacy coach → Lesson retrieval+fallback not model worship. |
| Contrast S16? | GymFlow embeddings — sample 03. |
| After sample? | GymFlow + production bridge sample 04. |

---

Next: [03-gymflow-embeddings.md](03-gymflow-embeddings.md)
