# Sample 04 — FinTrack & GymFlow on-device AI (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under FinTrack on-device AI?
**Answer:**

> Flutter + Hive; biometric; **no cloud sync of financial data**. BM25 offline RAG + **rule fallback**. Bridge to Apple Foundation Models / platform AI. Play Store ops awareness (Crashlytics, Remote Config, AdMob) — qualitative. **Forbidden:** invented accuracy %, latency SLOs.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 2–3 min STAR spine? | Local-first finance → Hive+BM25+FM+rules → privacy coach with degrade → retrieval+fallback not model worship. |
| Money from model? | Never — DB/rules ground amounts. |
| Behavioral metrics? | 30L DAU / 99.95% only as company context if drift — not FinTrack proof. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What can you claim under GymFlow on-device AI?
**Answer:**

> INT8 MiniLM TFLite + WordPiece. Cosine top-K + trainer context. TF-IDF fail-soft. **Not claimed:** cloud LLM dependency, invented model accuracy %.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Heap in production? | Top-K **mental model** — don’t claim CFBinaryHeap unless verified. |
| vs FinTrack? | Embeddings vs BM25; both on-device degrade paths. |
| STAR? | #GymFlow on-device AI in story-bank. |

**How can I relate to my case:**
- **Shipped:** GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do you contrast District Free Parking + Clean/MVVM + AI tooling District tooling?
**Answer:**

> “District was context engineering for migrations/tests. FinTrack/GymFlow are product on-device systems with privacy and fail-soft. I don’t conflate Cursor with RAG.” Use District Free Parking + Clean/MVVM + AI tooling only to **separate** concerns when asked “how do you use AI?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| District Free Parking + Clean/MVVM + AI tooling in FinTrack answer? | Brief contrast — don’t lead with tooling. |
| Tests AI-generated? | District Free Parking + Clean/MVVM + AI tooling judgment — you own architecture and review. |
| Machine round Day 25? | Same rule — AI may scaffold tests; you own design. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What is soft BookMyShow IMOC + crash-free at scale applied to AI features?
**Answer:**

> Kill switches, capability flags, not crashing on model load — **crash-free culture** applied to AI features. At 30L+ DAU, unconstrained on-device LLM on critical flows is a reliability/battery risk. FinTrack/GymFlow are personal-scale architecture proofs; BMS teaches when *not* to be reckless.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent P0 AI war story? | Forbidden unless verified later. |
| Feature flags? | Remote config disable bad model path. |
| Jetsam? | Unload weights on memory warning — fail-soft matrix. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. What is the 45s bridge script?
**Answer:**

> “I treat on-device AI as retrieval plus guarded inference with an explicit degrade path — FinTrack BM25 and GymFlow MiniLM both ship that way. Money and recommendations stay grounded; models are optional.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance IDs? | FinTrack on-device AI · GymFlow on-device AI; contrast District Free Parking + Clean/MVVM + AI tooling; soft BookMyShow IMOC + crash-free at scale. |
| SD whiteboard? | [`../05-exercises.md`](../05-exercises.md) §2 HLD 25–30 min. |
| Privacy 90s? | Sample 02 Q6 — memorize spine. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI; BookMyShow IMOC + crash-free at scale; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q6. Anti-patterns in AI interview answers?
**Answer:**

> Don’t say “we fine-tuned on user ledgers.” Don’t invent latency ms or accuracy %. Don’t claim cloud sync of financial data. Don’t lead with District Cursor stories for product AI SD. Don’t skip fail-soft — seniors design degradation before happy path. Don’t treat generative text as financial source of truth.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always-cloud demo? | Fast demo, fails privacy bar. |
| Skip retrieval? | Model doesn’t know Hive DB — RAG required. |
| After sample? | [07-revision-qna.md](07-revision-qna.md) two-layer Q&A. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Next: main [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What can you claim under GymFlow on-device AI

**Ask yourself:** What can you claim under GymFlow on-device AI?

**Answer:** “INT8 MiniLM TFLite + WordPiece. Cosine top-K + trainer context. TF-IDF fail-soft. **Not claimed:** cloud LLM dependency, invented model accuracy %.”

### Puzzle B — How do you contrast District Free Parking + Clean/MVVM + AI tooling District too

**Ask yourself:** How do you contrast District Free Parking + Clean/MVVM + AI tooling District tooling?

**Answer:** “District was context engineering for migrations/tests. FinTrack/GymFlow are product on-device systems with privacy and fail-soft. I don’t conflate Cursor with RAG.” Use District Free Parking + Clean/MVVM + AI tooling only to **separate** concerns when asked “how do you use AI?”

### Puzzle C — What is soft BookMyShow IMOC + crash-free at scale applied to AI features

**Ask yourself:** What is soft BookMyShow IMOC + crash-free at scale applied to AI features?

**Answer:** “Kill switches, capability flags, not crashing on model load — **crash-free culture** applied to AI features. At 30L+ DAU, unconstrained on-device LLM on critical flows is a reliability/battery risk. FinTrack/GymFlow are personal-scale architecture proofs; BMS teaches when *not* to be reckless.”
