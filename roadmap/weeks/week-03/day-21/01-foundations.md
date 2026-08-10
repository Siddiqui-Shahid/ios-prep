# 01 — Foundations: 45-Minute Mobile System Design (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. North star? `(45–60s)`
**Answer:**

> “Timebox ruthlessly: clarify, draw a readable HLD, define API/data, deep-dive 2–3 hard subsystems, close on ops — grounded in real production proof. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Universal spine (memorize)? `(45–60s)`
**Answer:**

> “text 0–5 min → CLARIFY: Scope (in/out), scale (DAU), offline?, platform? 5–15 min → HLD: 4-layer diagram + data flow 15–25 min → DATA/API: Entities, endpoints, pagination/versioning 25–40 min → DEEP DIVE: 2–3 hardest subsystems (you choose) 40–45 min → OPS: Failures, metrics, rollout, flags, pause criteria Staff/EM opener: “I’ll spend ~5 minutes on scope and scale, then a full architecture pass, then deep-dive X and Y — does that match what you want?”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Clarify checklist (resume-true numbers only)? `(45–60s)`
**Answer:**

> “Trap: Invent precise QPS. If forced to estimate, label assumptions transparently.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Prompt A — SDUI engine? `(45–60s)`
**Answer:**

> “HLD layers: CMS/config → API → schema parser → component registry → renderer → actions/analytics → fallbacks/cache Strong deep dives (pick 2–3): 1. Schema versioning + unknown component fallback 2. Action routing / navigation (Day 20) 3. Caching & freshness of layout JSON 4. Performance — parse budget, images, p50/p90 (Day 17) 5. Security — allowlisted actions (no arbitrary script).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Prompt B — Networking + SSL pinning? `(45–60s)`
**Answer:**

> “HLD layers: Features → API client → interceptors → URLSession → pin/trust → cache → offline/reachability Strong deep dives (pick 2–3): 1. Auth refresh single-flight + 401 2. SPKI pinning + rotation/break-glass design 3. Caching / idempotency for POSTs 4. Observability — journey p50/p90 5. Modular Ads client ownership.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Ops closer (both prompts — last 5 min)? `(45–60s)`
**Answer:**

> “Always hit: - Failure modes (schema fail / pin fail / CDN down) - Metrics: CFS, journey p90, pin fail rate, SDUI fallback rate - Rollout: flags, phased release, IMOC pause - A/B or Remote Config gates.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Communication habits? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Teach-back? `(45–60s)`
**Answer:**

> “1. Spine timings 2. Two agenda scripts 3. Resume-only metrics discipline 4. Ops never optional Next: full scripts in 02-deep-dive.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
