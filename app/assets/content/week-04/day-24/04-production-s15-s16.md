# Sample 04 — Production S15 / S16 (Q&A)

> Guided teaching. Verified claims, contrasts, and bridge scripts — no invented AI metrics.

---

### Q1. What can you claim under Verified · S15?

**Points to:** [Production bridge · S15 table](../03-production-bridge.md#verified--s15--fintrack)

**Answer:**

> Flutter + Hive; biometric; **no cloud sync of financial data**. BM25 offline RAG + **rule fallback**. Bridge to Apple Foundation Models / platform AI. Play Store ops awareness (Crashlytics, Remote Config, AdMob) — qualitative. **Forbidden:** invented accuracy %, latency SLOs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 2–3 min STAR spine? | Local-first finance → Hive+BM25+FM+rules → privacy coach with degrade → retrieval+fallback not model worship. |
| Money from model? | Never — DB/rules ground amounts. |
| Behavioral metrics? | 30L DAU / 99.95% only as company context if drift — not FinTrack proof. |

---

### Q2. What can you claim under Verified · S16?

**Points to:** [Production bridge · S16 table](../03-production-bridge.md#verified--s16--gymflow)

**Answer:**

> INT8 MiniLM TFLite + WordPiece. Cosine top-K + trainer context. TF-IDF fail-soft. **Not claimed:** cloud LLM dependency, invented model accuracy %.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Heap in production? | Top-K **mental model** — don’t claim CFBinaryHeap unless verified. |
| vs FinTrack? | Embeddings vs BM25; both on-device degrade paths. |
| STAR? | #S16 in story-bank. |

---

### Q3. How do you contrast S9 District tooling?

**Points to:** [Production bridge · Contrast S9](../03-production-bridge.md#contrast--s9--district-tooling) · [Foundations · §5](../01-foundations.md#5-product-ai-vs-tooling-ai-do-not-conflate)

**Answer:**

> “District was context engineering for migrations/tests. FinTrack/GymFlow are product on-device systems with privacy and fail-soft. I don’t conflate Cursor with RAG.” Use S9 only to **separate** concerns when asked “how do you use AI?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S9 in FinTrack answer? | Brief contrast — don’t lead with tooling. |
| Tests AI-generated? | S9 judgment — you own architecture and review. |
| Machine round Day 25? | Same rule — AI may scaffold tests; you own design. |

---

### Q4. What is soft S8 applied to AI features?

**Points to:** [Production bridge · Soft S8](../03-production-bridge.md#soft--s8) · [Deep dive · §8 Scale caution](../02-deep-dive.md#8-scale-caution-bookmyshow-judgment)

**Answer:**

> Kill switches, capability flags, not crashing on model load — **crash-free culture** applied to AI features. At 30L+ DAU, unconstrained on-device LLM on critical flows is a reliability/battery risk. FinTrack/GymFlow are personal-scale architecture proofs; BMS teaches when *not* to be reckless.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent P0 AI war story? | Forbidden unless verified later. |
| Feature flags? | Remote config disable bad model path. |
| Jetsam? | Unload weights on memory warning — fail-soft matrix. |

---

### Q5. What is the 45s bridge script?

**Points to:** [Production bridge · Bridge script](../03-production-bridge.md#bridge-script-45s)

**Answer:**

> “I treat on-device AI as retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way. Money and recommendations stay grounded; models are optional.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance IDs? | Verified S15 · S16; contrast S9; soft S8. |
| SD whiteboard? | [`../05-exercises.md`](../05-exercises.md) §2 HLD 25–30 min. |
| Privacy 90s? | Sample 02 Q6 — memorize spine. |

---

### Q6. Anti-patterns in AI interview answers?

**Points to:** [Foundations · §0](../01-foundations.md#0-north-star) · [Deep dive · §4](../02-deep-dive.md#4-trade-offs)

**Answer:**

> Don’t say “we fine-tuned on user ledgers.” Don’t invent latency ms or accuracy %. Don’t claim cloud sync of financial data. Don’t lead with District Cursor stories for product AI SD. Don’t skip fail-soft — seniors design degradation before happy path. Don’t treat generative text as financial source of truth.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always-cloud demo? | Fast demo, fails privacy bar. |
| Skip retrieval? | Model doesn’t know Hive DB — RAG required. |
| After sample? | [`../04-questions.md`](../04-questions.md) two-layer Q&A. |

---

Next: main [`../04-questions.md`](../04-questions.md)
