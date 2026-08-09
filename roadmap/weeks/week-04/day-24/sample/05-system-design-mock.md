# Sample 05 — System-design mock: On-Device LLM / AI Engine (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.
> **Source:** [`ios-system-design/docs/on-device-llm-ai-engine.md`](../../../../ios-system-design/docs/on-device-llm-ai-engine.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)
> **Angle:** Day 24 — Parallel on-device AI (FinTrack/GymFlow).

---

### Q1. Interviewer: “Design On-Device LLM / AI Engine.” How do you open?

**Answer:**

> **Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client HLD with backend touchpoints and load, then API/data, two deep dives on **HybridAIRouter** and **RAG + memory/thermal**, and close on failure modes, metrics, and kill switches. Does that work?”
> **Then ask the interviewer (speak these):**
> 1. On-device inference + local RAG?
> 2. Cloud hybrid fallback allowed?
> 3. RAM budget ≤500MB?
> 4. PII must not leave device by default?
> 5. Streaming tokens to UI?
> 6. Out: training/quant math?
> Do **not** draw until they answer or you state **labeled assumptions**. Keep backend load in mind from the first minute.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Weak senior signal — interviewer may want different dives. |
| Clarify for 15 min? | Hard stop at 5 — park extras as labeled assumptions. |
| They refuse numbers? | State labeled estimates from DAU context; continue. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q2. After clarify — what does the optimal flow look like?

**Answer:**

> **Scripted outcomes for this mock:** HybridAIRouter; on-device RAG; thermal/memory guards; streaming; PII scrub before cloud; out: training.
> **Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → API → two crisp dives → ops last 5.
> **Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They change scope mid-HLD? | Re-confirm in/out in 20s; adjust dives; protect ops. |
| Backend mesh deep-dive? | Out unless asked — sketch touchpoints, stay client-owned. |
| Forgot to ask offline? | State online-first + last-good cache as assumption; invite correction. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q3. Walk the HLD — client layers, backend, load.

**Answer:**

> UI stream ← Router ← (local ANE model + vector store) OR cloud SSE. Unmap weights on memory warning.
> **Load:** cloud if >~2k tokens or thermal serious; KV-cache example ~128MB; TTFT <100ms class.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| FinTrack vs GymFlow? | Same shape — BM25 vs MiniLM knobs. |
| Tooling AI? | District Copilot ≠ product on-device — separate story. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q4. Data / API — entities, endpoints, scale.

**Answer:**

> Local AsyncSequence tokens; cloud SSE TLS; never log raw financial text.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fail-soft? | Rules/TF-IDF if model absent. |
| Kill? | Remote disable generative; retrieval-only. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q5. Deep dive 1 — HybridAIRouter?

**Answer:**

> Policy: privacy class → local only; else thermal/size → cloud; mid-stream switch on thermal.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| User toggle? | Respect; default private for finance. |
| Hallucination? | Ground in retrieved docs; cite. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q6. Deep dive 2 — RAG + memory/thermal?

**Answer:**

> HNSW/VSS top-K; purge KV on warning; throttle gen; hard stop ~1024 tokens.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Embeddings size? | INT8 MiniLM — GymFlow angle. |
| Battery? | Throttle; prefer plug-in for large jobs. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> TTFT, tok/s, memory, thermal events, cloud fallback rate. Kill generative path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Production? | FinTrack/GymFlow learning-lab — label honestly. |
| Cheatsheet? | AI stack section. |

**How can I relate to my case:**
- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> **Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; API has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics.
> **Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.
> **Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | Park dive 2 bullets; protect ops 5 min. |
| Forgot load? | One sentence: DAU → labeled QPS, cursor cost, single-flight. |
| Invented crash-free %? | Forbidden — use resume-backed numbers or label as target. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

