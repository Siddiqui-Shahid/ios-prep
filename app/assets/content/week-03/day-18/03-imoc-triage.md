# Sample 03 — IMOC and triage (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What do you do in the first ten minutes of a P0?

**Points to:** [Deep dive · §7.1 First 10 minutes](../02-deep-dive.md#71-first-10-minutes)

**Answer:**

> (1) Confirm spike is **real** — not symbolication outage or bad deploy tag. (2) Declare **IMOC** / war-room channel. (3) **Blast radius:** version %, feature flag, geo, payment path? (4) **Mitigate:** pause phased release, kill switch, disable feature. (5) **Comms cadence:** next update in N minutes. User harm down before perfect RCA.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fake spike example? | dSYM pipeline broken — stacks all `<unknown>`. |
| Mitigate vs debug first? | Mitigate — IMOC pillar. |
| Payment path? | Highest blast radius — escalate comms frequency. |

---

### Q2. Mitigate vs hotfix — when which lever?

**Points to:** [Deep dive · §7.2 Mitigate vs hotfix](../02-deep-dive.md#72-mitigate-vs-hotfix)

**Answer:**

> **Remote config / feature flag** — fast, preferred when path is optional. **Pause phased rollout** — binary already bad for a %. **Hotfix** — native crash on mandatory path; trade review latency vs user harm. Staff default: flags and rollout pause before App Store emergency unless unavoidable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kill switch example? | Disable optional Stories SDK entry — not payment core without fallback. |
| Hotfix cost? | Process, review time, regression risk — justify with blast radius. |
| Backend mitigate? | Fallback API response while iOS fix ships — IMOC coordinates both. |

---

### Q3. How do you stop iOS vs backend blame spirals?

**Points to:** [Deep dive · §7.3 Cross-team blame spiral](../02-deep-dive.md#73-cross-team-blame-spiral)

**Answer:**

> Force **shared timeline** with correlation IDs and **% failing by layer**. Mitigate user harm first — fallback UI, disable feature, pause rollout. RCA second. IMOC owns the channel and cadence — not “my stack vs your stack.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Correlation ID example? | Checkout request id in breadcrumb + backend log. |
| % by layer? | “80% fail on API 503” vs “20% client decode” — focuses fix. |
| Behavioral interview angle? | Conflict → shared timeline + mitigate first. |

---

### Q4. How do you classify a Crashlytics spike?

**Points to:** [Foundations · §3 Triage workflow](../01-foundations.md#3-triage-workflow) · [Deep dive · §6 Non-fatals](../02-deep-dive.md#6-non-fatals--alert-hygiene)

**Answer:**

> New vs **regressed** (version compare). Top **symbolicated** stacks. **Affected version %** and device/OS matrix. **Journey tags** from breadcrumbs. Separate fatals (CFS) from non-fatals (quality). Confirm symbolication healthy before treating as new native bug.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Regressed signal? | Spike on latest version only — bisect release. |
| Flaky reproduce? | Race crashes (S2 path) — device matrix + stress. |
| Non-fatal flood? | Sample/group — don’t page on volume alone. |

---

### Q5. What is S2’s correct technical framing?

**Points to:** [Deep dive · §8 S2 concurrency](../02-deep-dive.md#8-s2-concurrency--correct-framing) · [Production bridge · §4 S2 add-on](../03-production-bridge.md#4-s2-as-technical-add-on-90s--correct-coupling)

**Answer:**

> **S2 was:** shared async maps hit from multiple queues → races → intermittent crashes; fixed with **GCD serial queues** / RW locks and safe API boundary. **S2 was not:** single explanation for org-wide **99.95% CFS**. OK: “Removed race crashes on that path.” Not OK: “S2 is why we have 99.95% CFS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S2-A1 greenfield? | Swift `actor` with same API boundary mindset — Applied. |
| try/catch myth? | SEGV/races need concurrency discipline + handlers — not catch alone. |
| Provenance? | Verified · S2 path-scoped; Verified · S8 system. |

---

### Q6. What IMOC pillars map to behavioral prompts?

**Points to:** [Production bridge · §6 Behavioral variants](../03-production-bridge.md#6-behavioral-variants-same-facts) · [Foundations · §4 IMOC](../01-foundations.md#4-imoc-leadership-proof)

**Answer:**

> **Conflict:** IMOC forces shared timeline vs blame. **Pressure / peak sale:** mitigate first, cadenced comms. **Leadership:** owner clarity, handoff, postmortem actions. **Technical depth:** add S2 path + signal-safety vocabulary — but S8 STAR leads on incident ownership questions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Postmortem output? | Alerts, tests, runbooks — not blame names. |
| Handoff? | Document state when shift ends — IMOC continuity. |
| Peak traffic BMS context? | 30L+ DAU — reliability is product during sales. |

---

### Q7. Whiteboard the crash SDK in ten minutes — what to include?

**Points to:** [Production bridge · §7 Whiteboard crash SDK](../03-production-bridge.md#7-whiteboard-crash-sdk-10-min)

**Answer:**

> Handlers → mmap writer → breadcrumb ring (happy path) → next-launch uploader → dSYM symbolication. Call out **signal safety** and **“no upload in handler.”** Init early but fast. Default interview assumption: **Crashlytics-class vendor** unless you evidence in-house SDK.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden claim? | “I wrote our in-house signal handler” without evidence. |
| CI box on diagram? | dSYM upload per build — Day 20. |
| Next sample? | [04-production-s8-s2.md](04-production-s8-s2.md) — Verified STAR language. |

---

Next: [04-production-s8-s2.md](04-production-s8-s2.md)
