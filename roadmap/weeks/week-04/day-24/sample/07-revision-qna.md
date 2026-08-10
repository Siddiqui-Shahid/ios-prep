# Sample 07 — Revision Q&A (day-24) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

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

### Q7. What is the one rule to remember for day-24? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q8. What is the one rule to remember for day-24? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q9. What is the one rule to remember for day-24? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q10. What is the one rule to remember for day-24? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-24, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “What is on-device RAG?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “On-device RAG means I keep the user’s private data local, retrieve the most relevant chunks for a query, and feed that context into generation or ranking. The model isn’t fine-tuned on the ledger — it reasons over retrieved rows. On FinTrack I use BM25 over a local spending index so retrieval works offline without an embedder.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is on-device RAG |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “Why quantize models on mobile” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Mobile RAM budgets can’t host large full-precision weights. Quantization shrinks parameters to INT8 or INT4 so we can mmap and run on the Neural Engine. You trade some quality for fit. GymFlow ships an INT8 MiniLM TFLite model for that reason — and still has TF-IDF if the model path fails.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Why quantize models on mobile |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “How do you stream tokens to UI without jank”. How do you diagnose? `(60–90s)`
**Answer:**

> “I run inference off the main thread and stream tokens through an AsyncSequence or callback into MainActor UI updates. I cancel the task when the user navigates away so work doesn’t outlive the screen. I batch rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you stream tokens to UI without jank |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Privacy benefits of on-device AI”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “On-device AI keeps sensitive context on the phone, works offline, and reduces exfiltration risk. That matches Apple’s privacy narrative, but it’s not automatic — local vaults still need biometric locks and encryption at rest. FinTrack’s invariant is no cloud sync of financial records; analytics stay coarse events, not raw transactions.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Privacy benefits of on-device AI |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “What is fail-soft in an AI feature”? `(60–90s)`
**Answer:**

> “Fail-soft means I detect capability and runtime pressure, then degrade to a still-useful path — deterministic rules on FinTrack, TF-IDF on GymFlow — instead of crashing or showing a dead feature. I hide generative chrome when the model isn’t there, and I keep a remote-config kill switch. Users get honesty, not hallucinated magic.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is fail-soft in an AI feature |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “BM25 vs vector search — when each” and how you’d correct it? `(60–90s)`
**Answer:**

> “BM25 is strong for keyword-ish personal text, fully offline, and explainable without shipping an embedder. Vector search with MiniLM handles paraphrase and semantic closeness better at the cost of model size and tokenizer complexity. FinTrack chose BM25 for spend text simplicity; GymFlow chose embeddings for exercise similarity — with TF-IDF as lexical fail-soft.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | BM25 vs vector search — when each |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
