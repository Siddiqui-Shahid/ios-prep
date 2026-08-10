# Sample 07 — Revision Q&A (day-18) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

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

### Q10. Non-fatals flooding the dashboard? `(30–45s)`
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


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “How does Crashlytics get a readable stack?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “The client persists a crash report with addresses and the build UUID, then uploads on a later launch. The backend matches that UUID to a dSYM and symbolicates frames into functions and lines. If CI forgets to upload symbols, triage sees unreadable stacks — so dSYM upload is part of the release pipeline, not a local-only step.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How does Crashlytics get a readable stack |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “What is async-signal-safe and why care” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Async-signal-safe means only a tiny set of operations are legal inside a signal handler. You can’t malloc, take locks, or call into Objective-C or much of the Swift runtime — those can deadlock or crash again. So we preallocate a crash buffer at init and write with safe primitives. The goal is persist-the-report, not a full-featured logger in-handler.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What is async-signal-safe and why care |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “Breadcrumbs — what do you log”. How do you diagnose? `(60–90s)`
**Answer:**

> “I keep a short ring of recent navigations, key user actions, and coarse network status codes — enough to reconstruct the path to a crash. Tokens and PII get scrubbed at the source. The buffer is designed so a crash mid-write doesn’t depend on taking locks casually. Breadcrumbs are context, not a second analytics product.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Breadcrumbs — what do you log |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Crash vs OOM vs hang”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “A crash is a fatal signal or uncaught fatal path we can often report with a stack. OOM is frequently jetsam — SIGKILL territory — so we lean on heuristics and MetricKit exit reasons. A hang is the main thread stuck; users feel a freeze even when crash-free looks fine. I refuse to treat those as one bucket.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Crash vs OOM vs hang |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “CFS drop during a sale — response”? `(60–90s)`
**Answer:**

> “I’d run IMOC playbook: confirm the spike is real, declare ownership and a channel, map blast radius by version and feature, then mitigate — pause phased release or kill-switch the path — before perfect root cause. Cadence communications to stakeholders, ship a fix or hotfix as needed, and write a blameless postmortem with alert and test actions. That’s how we operated P0/P1s at BookMyShow scale.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | CFS drop during a sale — response |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “How do you talk about 99.95% CFS” and how you’d correct it? `(60–90s)`
**Answer:**

> “I talk about it as a sustained operational bar at thirty-plus lakh DAU — Crashlytics triage workflows plus IMOC during peak events, backed by engineering fixes across the app. It’s not a vanity slide from one PR. When I mention synchronised dictionaries, I frame them as removing race crashes on a specific shared-state path — a contributor to reliability, not the sole cause of ninety-nine point nine five.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you talk about 99.95% CFS |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “Crash only on iOS beta, 2% users — ship?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I multiply severity by rarity. Two percent on a beta might be trackable if it’s a non-critical screen. If it’s checkout or payments, I mitigate immediately — flag, pause, or block the path — even at low percentage. Rare times critical still makes P0.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Crash only on iOS beta, 2% users — ship |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I8. Production symptom: something related to “dSYM missing — symptoms” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “You see addresses instead of symbols, triage slows to a crawl, and duplicate issues fragment. The fix is pipeline discipline — upload dSYMs for every shipped build and re-upload if a build slipped through. I treat missing symbols as an incident for the reliability process, not a ‘Swift bug.’.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | dSYM missing — symptoms |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. DI vs singletons under test? `(90–120s)`
**Answer:**

> “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. Prefetch that hurts scrolling? `(90–120s)`
**Answer:**

> “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
