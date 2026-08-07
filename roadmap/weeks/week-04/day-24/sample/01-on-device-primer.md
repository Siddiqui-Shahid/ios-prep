# Sample 01 — On-device AI primer (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is on-device AI in one sentence?

**Answer:**

> **Retrieval + guarded inference + an explicit degrade path** — not “call an LLM.” Private data stays local; models are optional accelerators behind capability checks. Draw the pipeline every time: eligibility → retrieve → prompt → local infer / fallback → stream → metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always generate? | No — rank-only (GymFlow) or rules (FinTrack fallback) are valid outputs. |
| Cloud default? | Fails senior privacy + offline bars for finance/health-adjacent data. |
| SD agenda 10s? | Privacy → retrieve → infer → fallback → metrics. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Walk the staff-level pipeline.

**Answer:**

> User query → **device eligibility** (OS, Neural Engine, memory, thermal, Low Power) → **retrieve local context** (BM25 / vector / rules) → **assemble prompt** (token budget; minimize PII for any cloud path) → **local generate OR cloud fallback OR deterministic template** → **stream tokens to UI** → **log quality + failure reason** (not raw private prompts).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Eligibility examples? | No FM, thermal serious, memory warning → skip infer. |
| Stream UI? | AsyncSequence / partial updates; cancel on navigate away. |
| Metrics? | Coarse events — `coach_shown`, `fallback_rule` — not ledger text. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. What do token, quantization, and embedding mean on mobile?

**Answer:**

> **Token:** model I/O unit ≈ ¾ word; context window is a hard budget. **Quantization:** FP16 multi-B weights blow RAM; INT8/INT4 shrink weights for mmap + Neural Engine — quality trade-off. **Embedding:** fixed-dim meaning vector; cosine ≈ semantic closeness. **KV-cache:** speeds decode, eats RAM — drop under memory pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unquantized 3B on phone? | Usually infeasible — say why quant matters. |
| BM25 vs embedding retrieve? | Lexical vs semantic paraphrase — different trade-offs. |
| ANE / NPU? | Hardware path — not always available or thermally free. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. What is RAG in plain words?

**Answer:**

> Retrieve relevant **local** chunks (ledger rows, exercises, docs), put them in the prompt, ground answers in that context. The model is not “trained on your Hive DB.” For money, **numbers come from the database**, not free-form generation.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty retrieval? | Honest empty + generic tips — don’t hallucinate balances. |
| Cloud RAG? | Only with sanitize + consent + minimize — never only path for FinTrack. |
| Hybrid router? | Local first; cloud/rules when capability or thermal fails. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is fail-soft and why before happy path?

**Answer:**

> Feature degrades to a useful subset — never hard-crashes the app. Seniors design degrade paths first: no FM/TFLite → rules/TF-IDF; thermal/Low Power → pause infer; memory warning → unload weights; empty retrieval → honest empty state. Hide generative chrome when infer unavailable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Model checksum fail? | Same fallback; remote config disable. |
| User sees blank? | Bad — rules/TF-IDF still coach/recommend. |
| Kill switch? | BookMyShow IMOC + crash-free at scale culture — feature flags at consumer scale. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q6. Product AI vs tooling AI (District Free Parking + Clean/MVVM + AI tooling)?

**Answer:**

> **Product (FinTrack on-device AI/GymFlow on-device AI):** end user in app — risks are privacy, hallucination, thermal. **Tooling (District Free Parking + Clean/MVVM + AI tooling District):** engineer uses AI for migrations/tests — risks are bad tests, false greens. Don’t conflate Cursor/context engineering with FinTrack RAG.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “How do you use AI?” — separate product architecture from IDE tooling. |
| District Free Parking + Clean/MVVM + AI tooling in STAR? | Only as contrast — not as on-device proof. |
| Same hybrid router? | Shape similar; stakes and privacy differ. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. FinTrack vs GymFlow — same shape, different knobs?

**Answer:**

> **FinTrack:** BM25 lexical retrieve; Apple FM when present; **deterministic rules** fail-soft; **no cloud sync** of financial records. **GymFlow:** INT8 MiniLM embeddings + cosine top-K; **TF-IDF** fail-soft; on-device, no cloud LLM required. Say aloud: “Same architecture shape — different retrieval and fallback knobs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Both RAG? | FinTrack yes; GymFlow retrieval+rank — generative optional/absent. |
| Privacy invariant FinTrack? | Financial data stays on device. |
| Stream / thermal next? | Dedicated Q8–Q9 — UI streaming and mid-gen throttle. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. How do you stream tokens to UI without jank?

**Answer:**

> Run inference **off the main thread** and stream tokens through an **AsyncSequence** or callback into **MainActor** UI updates. **Cancel** the task when the user navigates away so work doesn’t outlive the screen. **Batch** rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal. Agenda: “Background infer, main append, cancelable.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Partial markdown rendering? | Buffer until safe boundaries or throttle redraws — don’t reparse every token. |
| Backpressure if UI slower? | Drop/coalesce tokens or pause decode — don’t unbounded-queue on main. |
| Sync infer on main? | Common wrong answer — causes jank / watchdog risk. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q9. Thermal throttling mid-generation — design the behavior?

**Answer:**

> Observe **ProcessInfo thermal** and **Low Power**. On **serious** pressure: **pause** local generation, keep the **last partial answer** on screen, and switch to **rules or TF-IDF** rather than spinning until Jetsam. GymFlow can **skip embedding refresh** and serve lexical recommendations. Emit coarse metrics — `throttle_events`, `completion_rate` — not raw prompts. Agenda: “Pause, degrade, keep partial — don’t melt.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume when thermal clears? | Optional restart or continue from partial — product call; don’t auto-burn battery. |
| Remote config? | Kill generate entirely without an app update. |
| Next samples? | Deep dive each product in 02 and 03. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [02-fintrack-rag.md](02-fintrack-rag.md)

---

