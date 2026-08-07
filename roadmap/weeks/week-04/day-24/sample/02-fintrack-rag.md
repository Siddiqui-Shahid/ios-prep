# Sample 02 — FinTrack RAG & privacy (Q&A)

> Guided teaching. **FinTrack on-device AI** — honest claims only.

---

### Q1. What problem does FinTrack solve?

**Answer:**

> Expense **coach** that must **not** ship ledger data to a cloud LLM by default. Local-first personal finance with retrieval-grounded advice and deterministic fallback when generative paths unavailable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Verified stack? | Flutter + Hive; biometric; no cloud sync of financial data. |
| Invented fine-tune? | **Forbidden** — “fine-tuned on user ledgers.” |
| Play Store ops? | Crashlytics, Remote Config, AdMob — qualitative verified. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Defend the FinTrack architecture in layers.

**Answer:**

> **(1)** Local store: Hive; biometric lock; **no cloud sync** of financial records. **(2)** Retrieval: **BM25** over local spending index — lexical, offline, explainable. **(3)** Generation: `flutter_native_ai` → Apple Foundation Models / platform AI when available. **(4)** Fail-soft: **deterministic rule engine** (budget thresholds, category heuristics). **(5)** Privacy: on-device preferred; any cloud design needs PII sanitize + consent + minimize.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s line? | “Local-first — BM25 RAG over Hive, Apple Intelligence when present, rules when not; financial data doesn’t leave the device.” |
| Android path? | Platform AI abstraction — don’t invent identical FM on Android. |
| STAR? | story-bank #FinTrack on-device AI — full timing on exercise day. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is BM25 enough for in interviews?

**Answer:**

> BM25 scores documents against a query using term frequency, document length normalization, and inverse document frequency. **Do not derive the formula live.** Say: “BM25 ranks local spend notes and category text by lexical relevance — offline, explainable, no embedder binary. Weaker on paraphrase (‘UBER’ vs ‘rideshare’) — accepted trade-off for FinTrack’s text.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs vector RAG? | Semantic paraphrase vs lexical explainability — FinTrack picks lexical. |
| Code sketch? | `code/BM25Ranker.swift` — teaching, not production paste. |
| Empty index? | Fail-soft to rules + honest empty tips. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do you ground money and stop hallucination?

**Answer:**

> Generative text is **never** source of truth for balances or amounts. Prompt: only use provided context. UI shows retrieved rows / citations. **Rules path reads DB deterministically.** Analytics log coarse events — not raw transactions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User asks “what’s my balance?” | Answer from DB row in context — not invented token stream. |
| Model contradicts DB? | UI trusts DB; model text is explanatory only. |
| Cloud path design? | Sanitize fields; never send full ledger by default. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What failures trigger FinTrack fallback?

**Answer:**

> No Foundation Model / capability flag false → rules; hide generative chrome. Model file missing / checksum fail → same. Thermal serious / Low Power → pause infer; rules. Memory warning → unload weights. Retrieval empty → honest empty + generic tips. Cloud (if designed) → timeout → local message.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Still a “coach”? | Rules path gives budget/category guidance — not blank screen. |
| Remote config? | Disable feature path without app update. |
| 30L DAU lesson? | BMS scale teaches kill switches — FinTrack is personal-scale proof. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is the 90s privacy-first script?

**Answer:**

> “Financial and health-adjacent data stays on device. Retrieval runs locally. Generative models are optional accelerators behind capability checks. Analytics get coarse events — coach_shown, fallback_rule — not raw transactions. If hybrid cloud is required, it’s consent-gated, field-minimized, and never the only path.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Health-adjacent? | FinTrack/GymFlow framing — not medical claims. |
| Token budget? | Minimize PII stuffed into any cloud prompt. |
| Hybrid router? | See `code/HybridAIRouter.swift` teaching sketch. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What must I NOT claim for FinTrack on-device AI?

**Answer:**

> **Forbidden:** invented accuracy %, latency SLOs, “fine-tuned on user ledgers,” cloud sync of financial data. **Verified:** Hive local-first, BM25 + rule fallback, Apple FM bridge, no cloud financial sync.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 2–3 min STAR spine? | Situation local-first → Action Hive+BM25+FM+rules → Result privacy coach → Lesson retrieval+fallback not model worship. |
| Contrast GymFlow on-device AI? | GymFlow embeddings — sample 03. |
| After sample? | GymFlow + production bridge sample 04. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: [03-gymflow-embeddings.md](03-gymflow-embeddings.md)

---

