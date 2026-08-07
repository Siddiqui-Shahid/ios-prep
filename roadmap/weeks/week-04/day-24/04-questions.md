# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. What is on-device RAG? `(30–45s)`

**Answer:**

> On-device RAG means I keep the user’s private data local, retrieve the most relevant chunks for a query, and feed that context into generation or ranking. The model isn’t fine-tuned on the ledger — it reasons over retrieved rows. On FinTrack I use BM25 over a local spending index so retrieval works offline without an embedder.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BM25 vs embeddings? | BM25 ranks by term frequency/IDF with no embedder download; embeddings catch paraphrase but need an on-device model and vector index. |
| Empty retrieval behavior? | Show a clear empty state or fall back to deterministic rules on FinTrack — never invent spend insights from an empty local index. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. Why quantize models on mobile? `(30–45s)`

**Answer:**

> Mobile RAM budgets can’t host large full-precision weights. Quantization shrinks parameters to INT8 or INT4 so we can mmap and run on the Neural Engine. You trade some quality for fit. GymFlow ships an INT8 MiniLM TFLite model for that reason — and still has TF-IDF if the model path fails.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How monitor quality regressions? | Track offline eval (precision@k / preference) plus production fallback and dismiss/retry rates — not invented live accuracy percentages. |
| FP16 vs INT8 when? | Prefer INT8 when RAM must fit a mmapped mobile model like GymFlow’s MiniLM; move toward FP16 only if eval shows INT8 quality loss and memory still allows it. |

**How can I relate to my case:**
- **Shipped:** GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do you stream tokens to UI without jank? `(30–45s)`

**Answer:**

> I run inference off the main thread and stream tokens through an AsyncSequence or callback into MainActor UI updates. I cancel the task when the user navigates away so work doesn’t outlive the screen. I batch rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Partial markdown rendering? | Render completed blocks or plain text until a fence/heading closes — don’t re-parse a broken partial fence on every token. |
| Backpressure if UI slower than decode? | Coalesce tokens into batches (or drop intermediate frames) so MainActor updates can’t queue unboundedly behind decode. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. Privacy benefits of on-device AI? `(30–45s)`

**Answer:**

> On-device AI keeps sensitive context on the phone, works offline, and reduces exfiltration risk. That matches Apple’s privacy narrative, but it’s not automatic — local vaults still need biometric locks and encryption at rest. FinTrack’s invariant is no cloud sync of financial records; analytics stay coarse events, not raw transactions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Analytics design? | Emit coarse feature events (opened, fallback, cancelled) without transaction text or other PII payloads. |
| When is cloud ever OK? | Optional opt-in sync or non-sensitive telemetry — never as the default path for FinTrack’s financial ledger. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What is fail-soft in an AI feature? `(30–45s)`

**Answer:**

> Fail-soft means I detect capability and runtime pressure, then degrade to a still-useful path — deterministic rules on FinTrack, TF-IDF on GymFlow — instead of crashing or showing a dead feature. I hide generative chrome when the model isn’t there, and I keep a remote-config kill switch. Users get honesty, not hallucinated magic.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Metrics for fallback rate? | Count model-path versus TF-IDF/rules-path sessions and thermal/cancel reasons — soft-fail rate, not fake accuracy numbers. |
| Thermal mid-generation? | Pause or cancel generation, keep partial UI text, and offer resume/retry after cooling — same fail-soft honesty as FinTrack/GymFlow. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. BM25 vs vector search — when each? `(45s)`

**Answer:**

> BM25 is strong for keyword-ish personal text, fully offline, and explainable without shipping an embedder. Vector search with MiniLM handles paraphrase and semantic closeness better at the cost of model size and tokenizer complexity. FinTrack chose BM25 for spend text simplicity; GymFlow chose embeddings for exercise similarity — with TF-IDF as lexical fail-soft.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid reciprocal rank fusion? | Merge BM25 and vector ranked lists by reciprocal ranks so keyword and semantic hits both surface without brittle score calibration. |
| Why not BM25 alone for GymFlow? | Exercise names paraphrase (“bench press” vs “chest press”); embeddings catch that better than pure lexical BM25 on GymFlow. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

## Tricky questions

## Suggested record set

