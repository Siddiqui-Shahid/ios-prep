# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. How does Crashlytics get a readable stack? `(30–45s)`

**Answer:**

> The client persists a crash report with addresses and the build UUID, then uploads on a later launch. The backend matches that UUID to a dSYM and symbolicates frames into functions and lines. If CI forgets to upload symbols, triage sees unreadable stacks — so dSYM upload is part of the release pipeline, not a local-only step.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Bitcode legacy? | Modern: always upload dSYMs you ship. |
| App Store Connect vs Firebase? | Both can matter — know your pipeline. |
| Re-upload? | Possible for missing symbols on a build. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q2. What is async-signal-safe and why care? `(30–45s)`

**Answer:**

> Async-signal-safe means only a tiny set of operations are legal inside a signal handler. You can’t malloc, take locks, or call into Objective-C or much of the Swift runtime — those can deadlock or crash again. So we preallocate a crash buffer at init and write with safe primitives. The goal is persist-the-report, not a full-featured logger in-handler.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What can you call? | Limited async-signal-safe syscalls. |
| Breadcrumbs? | Filled on happy path into lock-free ring. |
| Upload in handler? | No — next launch. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Breadcrumbs — what do you log? `(30–45s)`

**Answer:**

> I keep a short ring of recent navigations, key user actions, and coarse network status codes — enough to reconstruct the path to a crash. Tokens and PII get scrubbed at the source. The buffer is designed so a crash mid-write doesn’t depend on taking locks casually. Breadcrumbs are context, not a second analytics product.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why ring? | Bound memory; last-N relevance. |
| Privacy Sev? | Rotate credentials; treat as incident. |
| SQLite in handler? | No — happy-path only. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Crash vs OOM vs hang? `(30–45s)`

**Answer:**

> A crash is a fatal signal or uncaught fatal path we can often report with a stack. OOM is frequently jetsam — SIGKILL territory — so we lean on heuristics and MetricKit exit reasons. A hang is the main thread stuck; users feel a freeze even when crash-free looks fine. I refuse to treat those as one bucket.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Day 17 hang detector? | Ping main; threshold capture. |
| Cycles tool? | Graph/Allocations, not Leaks. |
| CFS gap? | Freezes can hide under healthy CFS. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q5. CFS drop during a sale — response? `(45–60s)`

**Answer:**

> I’d run IMOC playbook: confirm the spike is real, declare ownership and a channel, map blast radius by version and feature, then mitigate — pause phased release or kill-switch the path — before perfect root cause. Cadence communications to stakeholders, ship a fix or hotfix as needed, and write a blameless postmortem with alert and test actions. That’s how we operated P0/P1s at BookMyShow scale.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Who do you page? | iOS + backend + QA as needed. |
| Flag vs hotfix? | Flag when possible; hotfix if mandatory native path. |
| Story? | BookMyShow IMOC / CFS incident response. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q6. How do you talk about 99.95% CFS? `(30–45s)`

**Answer:**

> I talk about it as a sustained operational bar at thirty-plus lakh DAU — Crashlytics triage workflows plus IMOC during peak events, backed by engineering fixes across the app. It’s not a vanity slide from one PR. When I mention synchronised dictionaries, I frame them as removing race crashes on a specific shared-state path — a contributor to reliability, not the sole cause of ninety-nine point nine five.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What threatens CFS next? | New SDK, races, missing dSYM, bad rollout. |
| Hangs? | Separate metrics. |
| synchronised dictionaries role? | BookMyShow synchronised dictionaries are path-scoped reliability — not the whole CFS story. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. Crash only on iOS beta, 2% users — ship? `(30–45s)`

**Answer:**

> I multiply severity by rarity. Two percent on a beta might be trackable if it’s a non-critical screen. If it’s checkout or payments, I mitigate immediately — flag, pause, or block the path — even at low percentage. Rare times critical still makes P0.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you weigh severity vs rarity? | Severity × rarity: rare-but-checkout-critical still ships as P0 mitigation even at ~2%. |
| When is beta-only enough to wait? | Only if the path is non-critical and trackable; otherwise flag/pause before waiting on OS fixes. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q8. dSYM missing — symptoms? `(30–45s)`

**Answer:**

> You see addresses instead of symbols, triage slows to a crawl, and duplicate issues fragment. The fix is pipeline discipline — upload dSYMs for every shipped build and re-upload if a build slipped through. I treat missing symbols as an incident for the reliability process, not a ‘Swift bug.’

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What do triage engineers see? | Addresses instead of symbols, slow grouping, and fragmented duplicate issues. |
| How do you remediate? | Upload dSYMs for every shipped build and re-upload any build that slipped the pipeline. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q9. How did synchronised dictionaries help CFS? `(30–45s)`

**Answer:**

> Shared dictionaries were hit from multiple queues, which caused intermittent race crashes. We serialized access with GCD serial queues and read-write locks behind a safe API so call sites couldn’t touch raw storage. That eliminated concurrent-access crashes on that path and improved reliability. I don’t claim that fix alone produced our ninety-nine point nine five crash-free rate — that bar was sustained by triage, IMOC, and many fixes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Actor today? | For greenfield shared maps, prefer a Swift actor (SafeDict design) over sprinkling locks. |
| How validate? | Concurrency stress + Crashlytics watch. |
| Sprinkle locks? | No — boundary API. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q10. Non-fatals flooding the dashboard. `(30–45s)`

**Answer:**

> I’d sample and group, fix the top noisy offenders, and keep non-fatals conceptually separate from crash-free sessions. If a non-fatal represents broken checkout UX, I escalate on user impact even without a fatal. Volume alone isn’t severity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| How do you cut noise? | Sample and group, fix the top noisy offenders, and keep non-fatals separate from crash-free. |
| When escalate a non-fatal? | When user impact is checkout-breaking even without a fatal crash. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q11. What belongs in a crash postmortem? `(30–45s)`

**Answer:**

> Timeline, user impact, root cause, what mitigation bought us time, and concrete action items — tests, alerts, runbooks — written blamelessly. The goal is preventing repeat, not finding a villain. That’s part of how IMOC closes the loop.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What sections are mandatory? | Timeline, impact, root cause, mitigation, and blameless action items for tests/alerts/runbooks. |
| What’s the goal? | Prevent repeat failures — close the IMOC loop, not assign blame. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q12. Crash SDK before analytics? `(30–45s)`

**Answer:**

> I prefer crash reporting early so launch failures still report, but initialisation must stay cheap. Heavy analytics and non-critical SDKs defer off the first-frame path. Reliability and launch performance are a joint budget, not a fight.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why early crash SDK? | So launch failures still report — but init must stay cheap on the first-frame path. |
| What defers? | Heavy analytics and non-critical SDKs move off the cold-start critical path. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

## Tricky questions

## Timed set

Recommend **Q5, Q6, Q9** + **T3, T4**. Deliver BookMyShow IMOC + crash-free at scale STAR ≤3 min; BookMyShow synchronised dictionaries add-on ≤90s with explicit non-sole-cause line.
