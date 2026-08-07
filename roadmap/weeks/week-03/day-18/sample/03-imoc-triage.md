# Sample 03 — IMOC and triage (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What do you do in the first ten minutes of a P0?

**Answer:**

> (1) Confirm spike is **real** — not symbolication outage or bad deploy tag. (2) Declare **IMOC** / war-room channel. (3) **Blast radius:** version %, feature flag, geo, payment path? (4) **Mitigate:** pause phased release, kill switch, disable feature. (5) **Comms cadence:** next update in N minutes. User harm down before perfect RCA.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Fake spike example? | dSYM pipeline broken — stacks all `<unknown>`. |
| Mitigate vs debug first? | Mitigate — IMOC pillar. |
| Payment path? | Highest blast radius — escalate comms frequency. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. Mitigate vs hotfix — when which lever?

**Answer:**

> **Remote config / feature flag** — fast, preferred when path is optional. **Pause phased rollout** — binary already bad for a %. **Hotfix** — native crash on mandatory path; trade review latency vs user harm. Staff default: flags and rollout pause before App Store emergency unless unavoidable.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Kill switch example? | Disable optional Stories SDK entry — not payment core without fallback. |
| Hotfix cost? | Process, review time, regression risk — justify with blast radius. |
| Backend mitigate? | Fallback API response while iOS fix ships — IMOC coordinates both. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do you stop iOS vs backend blame spirals?

**Answer:**

> Force **shared timeline** with correlation IDs and **% failing by layer**. Mitigate user harm first — fallback UI, disable feature, pause rollout. RCA second. IMOC owns the channel and cadence — not “my stack vs your stack.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Correlation ID example? | Checkout request id in breadcrumb + backend log. |
| % by layer? | “80% fail on API 503” vs “20% client decode” — focuses fix. |
| Behavioral interview angle? | Conflict → shared timeline + mitigate first. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How do you classify a Crashlytics spike?

**Answer:**

> New vs **regressed** (version compare). Top **symbolicated** stacks. **Affected version %** and device/OS matrix. **Journey tags** from breadcrumbs. Separate fatals (CFS) from non-fatals (quality). Confirm symbolication healthy before treating as new native bug.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Regressed signal? | Spike on latest version only — bisect release. |
| Flaky reproduce? | Race crashes (BookMyShow synchronised dictionaries path) — device matrix + stress. |
| Non-fatal flood? | Sample/group — don’t page on volume alone. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q5. What is BookMyShow synchronised dictionaries’s correct technical framing?

**Answer:**

> **BookMyShow synchronised dictionaries was:** shared async maps hit from multiple queues → races → intermittent crashes; fixed with **GCD serial queues** / RW locks and safe API boundary. **BookMyShow synchronised dictionaries was not:** single explanation for org-wide **99.95% CFS**. OK: “Removed race crashes on that path.” Not OK: “BookMyShow synchronised dictionaries is why we have 99.95% CFS.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Design: actor SafeDict (not shipped) greenfield? | Swift `actor` with same API boundary mindset — Applied. |
| try/catch myth? | SEGV/races need concurrency discipline + handlers — not catch alone. |
| Provenance? | BookMyShow synchronised dictionaries path-scoped; BookMyShow IMOC + crash-free at scale system. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q6. What IMOC pillars map to behavioral prompts?

**Answer:**

> **Conflict:** IMOC forces shared timeline vs blame. **Pressure / peak sale:** mitigate first, cadenced comms. **Leadership:** owner clarity, handoff, postmortem actions. **Technical depth:** add BookMyShow synchronised dictionaries path + signal-safety vocabulary — but BookMyShow IMOC + crash-free at scale STAR leads on incident ownership questions.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Postmortem output? | Alerts, tests, runbooks — not blame names. |
| Handoff? | Document state when shift ends — IMOC continuity. |
| Peak traffic BMS context? | 30L+ DAU — reliability is product during sales. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. Whiteboard the crash SDK in ten minutes — what to include?

**Answer:**

> Handlers → mmap writer → breadcrumb ring (happy path) → next-launch uploader → dSYM symbolication. Call out **signal safety** and **“no upload in handler.”** Init early but fast. Default interview assumption: **Crashlytics-class vendor** unless you evidence in-house SDK.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden claim? | “I wrote our in-house signal handler” without evidence. |
| CI box on diagram? | dSYM upload per build — Day 20. |
| Next sample? | [04-production-s8-s2.md](04-production-s8-s2.md) — Verified STAR language. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [04-production-s8-s2.md](04-production-s8-s2.md)

---

