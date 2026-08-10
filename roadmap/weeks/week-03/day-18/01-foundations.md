# 01 — Foundations: Crash Reporting & Incidents (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. North star? `(45–60s)`
**Answer:**

> “Catch fatals safely, make stacks readable, triage with process, lead incidents with mitigate-first ownership — and never attribute org-wide CFS to a single dictionary fix. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Crash SDK pipeline? `(45–60s)`
**Answer:**

> “text Init (<~10ms class) → register handlers → breadcrumb ring Crash (signal / uncaught / fatalError path) → async-signal-safe write to preallocated mmap/disk → terminate Next launch → discover report → upload → server symbolicates with dSYM.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. What crash-free sessions (CFS) means? `(45–60s)`
**Answer:**

> “- CFS: sessions without a fatal crash (vendor definitions vary slightly — say Crashlytics sessions) - Verified · : sustained 99.95%+ at 30+ lakh DAU — operational excellence under peak load - Non-fatals ≠ crashes — still triage if user-impacting - OOM / jetsam: often no clean client stack; heuristics + MetricKit exit reasons (Day 17) - Hangs: may not count against CFS — users still churn.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q4. Honesty bound (memorize)? `(45–60s)`
**Answer:**

> “Synchronised dictionaries removed intermittent race crashes on that shared state path. Crash-free at 99.95% was sustained by triage workflows, incident command, and many fixes — not one API.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q5. Triage workflow? `(45–60s)`
**Answer:**

> “1. Detect — spike / CFS drop alert 2. Classify — new vs regressed; top stacks; version %; journey tags 3. Reproduce — symbolicated stack + breadcrumbs + device/OS matrix 4. Mitigate — flag off, pause phased rollout, hotfix path 5. Fix — root cause + regression test 6. Write-up — blameless postmortem for P0/P1 ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. IMOC (leadership proof)? `(45–60s)`
**Answer:**

> “As IMOC, coordinate iOS + backend + QA on P0/P1 during high-traffic events.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Glossary? `(45–60s)`
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

### Q8. Crash vs OOM vs hang? `(45–60s)`
**Answer:**

> “Trap: “CFS is fine so the app isn’t freezing.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Launch ordering preview? `(45–60s)`
**Answer:**

> “- Prefer crash SDK early so launch crashes report - Keep init fast (budget milliseconds-class) - Defer heavy analytics (Day 17 launch budget) ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Teach-back checklist? `(45–60s)`
**Answer:**

> “1. Pipeline: capture → persist → upload → symbolicate 2. Async-signal-safe one-liner 3. CFS definition + 99.95% / 30L context 4. contributes; does not solely cause CFS 5. IMOC pillars 6. Hang gap vs CFS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. One-minute CFS honesty drill? `(45–60s)`
**Answer:**

> “Speak continuously: > “Crash-free at ninety-nine point nine five percent on thirty-plus lakh DAU was sustained through Crashlytics triage workflows and IMOC coordination on P0/P1s during peak traffic. Separately, synchronised dictionaries removed intermittent race crashes on a shared async state path — that contributed to reliability. I don’t collapse those into one causal story.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
