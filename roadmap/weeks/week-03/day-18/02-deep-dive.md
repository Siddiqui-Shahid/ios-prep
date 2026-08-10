# 02 — Deep Dive: Crash SDK, OOM, IMOC (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Handler responsibilities (conceptual)? `(45–60s)`
**Answer:**

> “text On fatal signal: 1. Suspend other threads (implementation-dependent; be honest it’s delicate) 2. Capture backtrace / registers into PREALLOCATED buffer 3. write to mmap / file descriptor — no malloc 4. Reset handler / abort to terminate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Forbidden in-handler? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Allowed mindset? `(45–60s)`
**Answer:**

> “- Preallocate crash region at init - Async-signal-safe syscalls only (write, etc.) - Breadcrumbs already in a lock-free ring filled on the happy path Interview line: “The crash path is about surviving long enough to persist a report — not about doing a full-featured dump with normal APIs.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Breadcrumbs? `(45–60s)`
**Answer:**

> “Privacy incident: breadcrumbs with auth headers → treat as Sev; rotate; lint forbidden keys.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Symbolication & dSYM? `(45–60s)`
**Answer:**

> “text Build UUID in report → server finds matching dSYM → load address + frame offset → function/file/line.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. OOM detection (honest limits)? `(45–60s)`
**Answer:**

> “- SIGKILL from jetsam is not a normal catchable crash path - Next-launch heuristics: high last footprint + no clean exit + no crash file - MetricKit OOM / exit diagnostics arrive on delay - Memory Graph / Allocations (Day 17) for lab reproduction — cycles ≠ Leaks ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Upload reliability? `(45–60s)`
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

### Q8. Non-fatals & alert hygiene? `(45–60s)`
**Answer:**

> “- Group, sample, fix top offenders - Don’t equate non-fatal volume with CFS - Promote to P1 when user-impacting critical path (payments) ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. First 10 minutes? `(45–60s)`
**Answer:**

> “1. Confirm spike is real (not symbolication outage / bad deploy tag) 2. Declare IMOC / channel 3. Blast radius: version %, feature flag, geo, payment? 4. Mitigate: pause phased release / kill switch / disable feature 5. Comms cadence: next update in N minutes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Mitigate vs hotfix? `(45–60s)`
**Answer:**

> “See the notes for this topic and speak the core idea in simple words.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Cross-team blame spiral? `(45–60s)`
**Answer:**

> “Force shared timeline + correlation IDs + % failing by layer. Mitigate user harm first (fallback, disable). RCA second. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. S2 concurrency — correct framing? `(45–60s)`
**Answer:**

> “What was: shared async maps hit from multiple queues → races → intermittent crashes; fixed with GCD serial queues / RW locks and a safe API boundary. What was not: the single explanation for org-wide 99.95% CFS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q13. Trade-offs? `(45–60s)`
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

### Q14. Failure modes? `(45–60s)`
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

### Q15. Optional citations? `(45–60s)`
**Answer:**

> “- ios-system-design/docs/crash-reporting-sdk.md - Apple Understanding crashes / MetricKit diagnostics - Stories , Chapter is self-contained without opening them.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
