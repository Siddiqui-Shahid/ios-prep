# 04 — Questions (two-layer Q&A) — On-Device AI

> Cover **Full spoken answer**. Speak from **Answer points**. Normal 30–45s · Tricky 90–120s · Architecture once at 3–5 min if asked.

---

## Normal questions

### Q1. What is on-device RAG? `(30–45s)`

**Answer points:**
- Index/retrieve local docs or rows
- Inject into prompt / ranking context
- Model stays general; private data stays local
- FinTrack BM25 example

**Agenda opener:**  
> “Retrieve local context, then generate or rank.”

**Full spoken answer:**  
> “On-device RAG means I keep the user’s private data local, retrieve the most relevant chunks for a query, and feed that context into generation or ranking. The model isn’t fine-tuned on the ledger — it reasons over retrieved rows. On FinTrack I use BM25 over a local spending index so retrieval works offline without an embedder.”

**Common wrong answer:**  
> “We fine-tune the LLM on user transactions.”

**Follow-up ladder:**
- **L1:** BM25 vs embeddings?
- **L2:** Empty retrieval behavior?

**Provenance:** Verified · S15

---

### Q2. Why quantize models on mobile? `(30–45s)`

**Answer points:**
- RAM/disk budgets
- INT8/INT4 trade accuracy for fit
- mmap + Neural Engine
- Unquantized multi-B blows Jetsam
- GymFlow INT8 MiniLM

**Agenda opener:**  
> “Fit the weights — quality trade for shippability.”

**Full spoken answer:**  
> “Mobile RAM budgets can’t host large full-precision weights. Quantization shrinks parameters to INT8 or INT4 so we can mmap and run on the Neural Engine. You trade some quality for fit. GymFlow ships an INT8 MiniLM TFLite model for that reason — and still has TF-IDF if the model path fails.”

**Common wrong answer:**  
> Quantize with no quality/ops story.

**Follow-up ladder:**
- **L1:** How monitor quality regressions?
- **L2:** FP16 vs INT8 when?

**Provenance:** Verified · S16

---

### Q3. How do you stream tokens to UI without jank? `(30–45s)`

**Answer points:**
- Inference off main
- AsyncSequence / callbacks
- MainActor append
- Cancel on dismiss
- Batch UI updates

**Agenda opener:**  
> “Background infer, main append, cancelable.”

**Full spoken answer:**  
> “I run inference off the main thread and stream tokens through an AsyncSequence or callback into MainActor UI updates. I cancel the task when the user navigates away so work doesn’t outlive the screen. I batch rapid tokens to avoid layout thrash. Partial answers stay on screen if we pause for thermal.”

**Common wrong answer:**  
> Synchronous inference on main.

**Follow-up ladder:**
- **L1:** Partial markdown rendering?
- **L2:** Backpressure if UI slower than decode?

**Provenance:** Learning-lab design; soft S15 UX

---

### Q4. Privacy benefits of on-device AI? `(30–45s)`

**Answer points:**
- Data minimization / offline
- Lower exfil risk
- Aligns platform privacy narrative
- Still need local disk security (biometric, encryption)
- FinTrack no cloud sync

**Agenda opener:**  
> “Local-first — HTTPS alone isn’t privacy.”

**Full spoken answer:**  
> “On-device AI keeps sensitive context on the phone, works offline, and reduces exfiltration risk. That matches Apple’s privacy narrative, but it’s not automatic — local vaults still need biometric locks and encryption at rest. FinTrack’s invariant is no cloud sync of financial records; analytics stay coarse events, not raw transactions.”

**Common wrong answer:**  
> “We use HTTPS so it’s private.”

**Follow-up ladder:**
- **L1:** Analytics design?
- **L2:** When is cloud ever OK?

**Provenance:** Verified · S15

---

### Q5. What is fail-soft in an AI feature? `(30–45s)`

**Answer points:**
- Capability detect
- Degrade to rules/TF-IDF/cached
- User-visible honesty
- Never crash; remote config kill
- S15/S16

**Agenda opener:**  
> “Degrade usefully — don’t blank or crash.”

**Full spoken answer:**  
> “Fail-soft means I detect capability and runtime pressure, then degrade to a still-useful path — deterministic rules on FinTrack, TF-IDF on GymFlow — instead of crashing or showing a dead feature. I hide generative chrome when the model isn’t there, and I keep a remote-config kill switch. Users get honesty, not hallucinated magic.”

**Common wrong answer:**  
> Only an error alert with no useful fallback.

**Follow-up ladder:**
- **L1:** Metrics for fallback rate?
- **L2:** Thermal mid-generation?

**Provenance:** Verified · S15 · S16

---

### Q6. BM25 vs vector search — when each? `(45s)`

**Answer points:**
- BM25: keyword, offline light, explainable
- Vector: paraphrase/semantic
- Hybrid often best
- FinTrack BM25 vs GymFlow MiniLM split

**Agenda opener:**  
> “Lexical versus semantic — pick for the text.”

**Full spoken answer:**  
> “BM25 is strong for keyword-ish personal text, fully offline, and explainable without shipping an embedder. Vector search with MiniLM handles paraphrase and semantic closeness better at the cost of model size and tokenizer complexity. FinTrack chose BM25 for spend text simplicity; GymFlow chose embeddings for exercise similarity — with TF-IDF as lexical fail-soft.”

**Common wrong answer:**  
> One-size-fits-all vectors for everything.

**Follow-up ladder:**
- **L1:** Hybrid reciprocal rank fusion?
- **L2:** Why not BM25 alone for GymFlow?

**Provenance:** Verified · S15 · S16

---

## Tricky questions

### T1. “On-device model hallucinates a transaction amount — who’s at fault?” `(90–120s)`

**Answer points:**
- Generative text ≠ source of truth for money
- Ground numbers in deterministic DB reads
- Prompt: only use provided context
- UI shows retrieved rows
- Rules path for balances
- Eval set; low retrieval score → fallback

**Agenda opener:**  
> “Database owns money — model doesn’t.”

**Full spoken answer:**  
> “That’s a product-control failure if free-form generation can invent amounts. I never let the model be source of truth for money. RAG must ground numbers from deterministic database reads, the prompt must forbid inventing values, and the UI should show the retrieved rows. The rules path reads balances directly. I keep an eval set of prompts and fall back when retrieval scores are low. Hallucination becomes an architecture bug we design against, not an excuse.”

**Common wrong answer:**  
> “Models just do that.”

**Follow-up ladder:**
- **L1:** Citation chips UX?
- **L2:** Logging without leaking PII?

**Provenance:** Verified · S15

---

### T2. “Why not always call GPT-4o from the phone?” `(90–120s)`

**Answer points:**
- Privacy, offline, latency, cost
- App Store / finance optics
- Cloud as optional escalate with consent
- On-device for personal context
- BMS at 30L DAU → sampling, budgets, server-side

**Agenda opener:**  
> “Privacy and offline first — cloud is escalate.”

**Full spoken answer:**  
> “Always-cloud fails privacy, offline, latency, and cost bars — especially for finance. On-device retrieval and generation keep personal context local. Cloud can be an optional escalate for hard reasoning with consent and minimized fields, never the only path. At BookMyShow scale I’d be even stricter: feature flags, sampling, and budgets before any heavy AI on hot paths.”

**Common wrong answer:**  
> Cost-only answer.

**Follow-up ladder:**
- **L1:** How would ads AI differ at 30L DAU?
- **L2:** Consent UX?

**Provenance:** Verified · S15; soft S8 scale judgment

---

### T3. “Thermal throttling mid-generation — design the behavior.” `(90–120s)`

**Answer points:**
- Observe thermal / Low Power
- Pause or switch to rules/TF-IDF
- Keep last partial answer
- Don’t spin until Jetsam
- GymFlow: skip embed refresh
- Metrics: throttle_events, completion_rate

**Agenda opener:**  
> “Pause, degrade, keep partial — don’t melt.”

**Full spoken answer:**  
> “I observe ProcessInfo thermal and Low Power state. On serious pressure I pause local generation, keep the last partial answer on screen, and switch to rules or TF-IDF rather than spinning until Jetsam. GymFlow can skip embedding refresh and serve lexical recommendations. I emit coarse metrics for throttle events and completion rate — not raw prompts.”

**Common wrong answer:**  
> Ignore thermal; block UI with a spinner forever.

**Follow-up ladder:**
- **L1:** Resume policy when thermal clears?
- **L2:** Remote config to disable generate entirely?

**Provenance:** Verified · S16 fail-soft; learning-lab router

---

### T4. “How is this different from a server RAG blog demo?” `(90–120s)`

**Answer points:**
- RAM ≤ hundreds of MB, battery, offline
- Fail-soft matrix
- Privacy invariants
- Capability matrix across devices
- Cancellation / lifecycle
- Shipped FinTrack/GymFlow proof

**Agenda opener:**  
> “Mobile constraints plus shipped degrade paths.”

**Full spoken answer:**  
> “A notebook cosine demo ignores Jetsam, thermal, device coverage, and cancelation. Mobile on-device AI designs for RAM budgets, battery, offline, a fail-soft matrix, privacy invariants, and lifecycle cancellation. My proof is FinTrack BM25 with rule fallback and GymFlow MiniLM with TF-IDF — not a blog embedding loop.”

**Common wrong answer:**  
> Buzzword soup without constraints.

**Follow-up ladder:**
- **L1:** Walk FinTrack vs HLD mapping.
- **L2:** What would you add for 30L DAU?

**Provenance:** Verified · S15 · S16

---

### T5. “PII in prompts when hybrid cloud is on — concrete steps.” `(90–120s)`

**Answer points:**
- HTTPS necessary not sufficient
- Redact account numbers, names
- Send aggregates not raw SMS
- User toggle; retention limits
- Prefer local; Keychain/biometric vault

**Agenda opener:**  
> “Minimize, redact, consent — TLS isn’t enough.”

**Full spoken answer:**  
> “TLS is necessary and nowhere near sufficient. Before any cloud path I redact account numbers and names, prefer category aggregates over raw messages, require an explicit user toggle, and bound retention. Local vault stays biometric-locked. The default remains local-only — cloud is a narrow escalate.”

**Common wrong answer:**  
> “We encrypt HTTPS.”

**Follow-up ladder:**
- **L1:** What fields never leave device?
- **L2:** Audit logging design?

**Provenance:** Verified · S15 invariant + Applied hybrid design

---

### T6. “District used AI for tests — isn’t that the same as on-device AI?” `(90–120s)`

**Answer points:**
- Separate concerns
- S9 = engineering accelerator + review judgment
- S15/S16 = product AI privacy/fallback
- Seniors don’t confuse Cursor with on-device RAG

**Agenda opener:**  
> “Tooling AI versus product AI — different risk.”

**Full spoken answer:**  
> “They’re different systems. At District I used AI as an engineering accelerator for migrations and tests inside a review bar — context engineering, not autopilot. FinTrack and GymFlow are product features with privacy invariants and fail-soft architecture. Seniors don’t confuse Cursor or Copilot with on-device RAG.”

**Common wrong answer:**  
> Tool-worship conflation.

**Follow-up ladder:**
- **L1:** Day 26 leadership follow-up.
- **L2:** When forbid AI in workflow?

**Provenance:** Verified · S9 · S15 · S16

---

## Suggested record set

Q1, Q4, Q5 + T1, T6. Also deliver S15 and S16 once each at 2:30.
