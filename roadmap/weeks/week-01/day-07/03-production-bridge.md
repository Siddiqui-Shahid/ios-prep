# 03 — Production Bridge — Mock Narrative Spine (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Centerpiece — Verified · S2? `(45–60s)`
**Answer:**

> “≤20s: “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” ≤3 min STAR: Use story-bank beats — races → serial queues / RW → safe API → stress + Crashlytics → path fixed → actor coda.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q2. Follow-up — S2-A1? `(45–60s)`
**Answer:**

> “For a new module I’d expose an actor with the same get/set/snapshot surface — callers await; isolation moves into the type system. That’s how I’d apply it — production was GCD.” > Provenance: How I would apply it · .

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Adjacent reliability — S8 (soft)? `(45–60s)`
**Answer:**

> “Use when asked about production risk / why races matter: - 30L+ DAU - 99.95%+ crash-free - Crashlytics / IMOC culture.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Optional encore — S1? `(45–60s)`
**Answer:**

> “If energy allows after mock: > “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Social feed talk — honesty? `(45–60s)`
**Answer:**

> “Feed HLD is design skill. Tie ads slots to instinct only. Scale context from when asked “how big.” ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Anti-patterns today? `(45–60s)`
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

### Q7. Next? `(45–60s)`
**Answer:**

> “Drill warm-up pool in sample/07-revision-qna.md before the timed mock if any card is shaky.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
