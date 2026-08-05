# Sample 01 — On-device AI primer (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is on-device AI in one sentence?

**Points to:** [Foundations · §0 North star](../01-foundations.md#0-north-star) · [§1 Staff-level pipeline](../01-foundations.md#1-staff-level-pipeline-draw-every-time)

**Answer:**

> **Retrieval + guarded inference + an explicit degrade path** — not “call an LLM.” Private data stays local; models are optional accelerators behind capability checks. Draw the pipeline every time: eligibility → retrieve → prompt → local infer / fallback → stream → metrics.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Always generate? | No — rank-only (GymFlow) or rules (FinTrack fallback) are valid outputs. |
| Cloud default? | Fails senior privacy + offline bars for finance/health-adjacent data. |
| SD agenda 10s? | Privacy → retrieve → infer → fallback → metrics. |

---

### Q2. Walk the staff-level pipeline.

**Points to:** [Foundations · §1 Staff-level pipeline](../01-foundations.md#1-staff-level-pipeline-draw-every-time)

**Answer:**

> User query → **device eligibility** (OS, Neural Engine, memory, thermal, Low Power) → **retrieve local context** (BM25 / vector / rules) → **assemble prompt** (token budget; minimize PII for any cloud path) → **local generate OR cloud fallback OR deterministic template** → **stream tokens to UI** → **log quality + failure reason** (not raw private prompts).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Eligibility examples? | No FM, thermal serious, memory warning → skip infer. |
| Stream UI? | AsyncSequence / partial updates; cancel on navigate away. |
| Metrics? | Coarse events — `coach_shown`, `fallback_rule` — not ledger text. |

---

### Q3. What do token, quantization, and embedding mean on mobile?

**Points to:** [Foundations · §2 Primer glossary](../01-foundations.md#2-primer-glossary-4560s-each-aloud) · [Quantization intuition](../01-foundations.md#quantization-intuition-say-cleanly)

**Answer:**

> **Token:** model I/O unit ≈ ¾ word; context window is a hard budget. **Quantization:** FP16 multi-B weights blow RAM; INT8/INT4 shrink weights for mmap + Neural Engine — quality trade-off. **Embedding:** fixed-dim meaning vector; cosine ≈ semantic closeness. **KV-cache:** speeds decode, eats RAM — drop under memory pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Unquantized 3B on phone? | Usually infeasible — say why quant matters. |
| BM25 vs embedding retrieve? | Lexical vs semantic paraphrase — different trade-offs. |
| ANE / NPU? | Hardware path — not always available or thermally free. |

---

### Q4. What is RAG in plain words?

**Points to:** [Foundations · §2 RAG](../01-foundations.md#2-primer-glossary-4560s-each-aloud) · [RAG intuition](../01-foundations.md#rag-intuition-say-cleanly)

**Answer:**

> Retrieve relevant **local** chunks (ledger rows, exercises, docs), put them in the prompt, ground answers in that context. The model is not “trained on your Hive DB.” For money, **numbers come from the database**, not free-form generation.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Empty retrieval? | Honest empty + generic tips — don’t hallucinate balances. |
| Cloud RAG? | Only with sanitize + consent + minimize — never only path for FinTrack. |
| Hybrid router? | Local first; cloud/rules when capability or thermal fails. |

---

### Q5. What is fail-soft and why before happy path?

**Points to:** [Foundations · §4 Fail-soft](../01-foundations.md#4-fail-soft-before-happy-path-senior-habit) · [Deep dive · §5 Fail-soft matrix](../02-deep-dive.md#5-fail-soft-matrix-memorize)

**Answer:**

> Feature degrades to a useful subset — never hard-crashes the app. Seniors design degrade paths first: no FM/TFLite → rules/TF-IDF; thermal/Low Power → pause infer; memory warning → unload weights; empty retrieval → honest empty state. Hide generative chrome when infer unavailable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Model checksum fail? | Same fallback; remote config disable. |
| User sees blank? | Bad — rules/TF-IDF still coach/recommend. |
| Kill switch? | S8 culture — feature flags at consumer scale. |

---

### Q6. Product AI vs tooling AI (S9)?

**Points to:** [Foundations · §5 Product vs tooling](../01-foundations.md#5-product-ai-vs-tooling-ai-do-not-conflate)

**Answer:**

> **Product (S15/S16):** end user in app — risks are privacy, hallucination, thermal. **Tooling (S9 District):** engineer uses AI for migrations/tests — risks are bad tests, false greens. Don’t conflate Cursor/context engineering with FinTrack RAG.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interview trap? | “How do you use AI?” — separate product architecture from IDE tooling. |
| S9 in STAR? | Only as contrast — not as on-device proof. |
| Same hybrid router? | Shape similar; stakes and privacy differ. |

---

### Q7. FinTrack vs GymFlow — same shape, different knobs?

**Points to:** [Foundations · §3 Two products](../01-foundations.md#3-two-products-one-principle)

**Answer:**

> **FinTrack:** BM25 lexical retrieve; Apple FM when present; **deterministic rules** fail-soft; **no cloud sync** of financial records. **GymFlow:** INT8 MiniLM embeddings + cosine top-K; **TF-IDF** fail-soft; on-device, no cloud LLM required. Say aloud: “Same architecture shape — different retrieval and fallback knobs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Both RAG? | FinTrack yes; GymFlow retrieval+rank — generative optional/absent. |
| Privacy invariant FinTrack? | Financial data stays on device. |
| Next samples? | Deep dive each product in 02 and 03. |

---

Next: [02-fintrack-rag.md](02-fintrack-rag.md)
