# 04 — Questions (two-layer Q&A)

> Cover **Full spoken**. Speak from **Answer points**.  
> **12 normal + 8 tricky**. Hard rule: never let S2 sole-own CFS.

---

## Normal questions

### Q1. How does Crashlytics get a readable stack? `(30–45s)`

**Answer points:**
- Client uploads report + build UUID
- Server applies dSYM
- CI must upload symbols

**Agenda opener:** “UUID-matched dSYMs on the server…”

**Full spoken answer:**
> “The client persists a crash report with addresses and the build UUID, then uploads on a later launch. The backend matches that UUID to a dSYM and symbolicates frames into functions and lines. If CI forgets to upload symbols, triage sees unreadable stacks — so dSYM upload is part of the release pipeline, not a local-only step.”

**Common wrong answer:** “Swift always ships readable stacks without symbols.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | Bitcode legacy? | Modern: always upload dSYMs you ship. |
| L2 | App Store Connect vs Firebase? | Both can matter — know your pipeline. |
| L3 | Re-upload? | Possible for missing symbols on a build. |

**Provenance:** Verified · S8 · Crashlytics workflows

---

### Q2. What is async-signal-safe and why care? `(30–45s)`

**Answer points:**
- Handler can’t malloc/lock/ObjC
- Preallocate mmap
- Secondary crash / deadlock risk

**Agenda opener:** “Crash handlers can’t use normal APIs…”

**Full spoken answer:**
> “Async-signal-safe means only a tiny set of operations are legal inside a signal handler. You can’t malloc, take locks, or call into Objective-C or much of the Swift runtime — those can deadlock or crash again. So we preallocate a crash buffer at init and write with safe primitives. The goal is persist-the-report, not a full-featured logger in-handler.”

**Common wrong answer:** “Just OSLog from the signal handler.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | What can you call? | Limited async-signal-safe syscalls. |
| L2 | Breadcrumbs? | Filled on happy path into lock-free ring. |
| L3 | Upload in handler? | No — next launch. |

**Provenance:** Learning-lab · crash SDK

---

### Q3. Breadcrumbs — what do you log? `(30–45s)`

**Answer points:**
- Last N navigations / actions / status codes
- Scrub PII/tokens
- Ring buffer

**Full spoken answer:**
> “I keep a short ring of recent navigations, key user actions, and coarse network status codes — enough to reconstruct the path to a crash. Tokens and PII get scrubbed at the source. The buffer is designed so a crash mid-write doesn’t depend on taking locks casually. Breadcrumbs are context, not a second analytics product.”

**Common wrong answer:** “Log Authorization headers for debugging.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | Why ring? | Bound memory; last-N relevance. |
| L2 | Privacy Sev? | Rotate credentials; treat as incident. |
| L3 | SQLite in handler? | No — happy-path only. |

**Provenance:** Learning-lab

---

### Q4. Crash vs OOM vs hang? `(30–45s)`

**Answer points:**
- Fatal signal/exception vs jetsam vs main freeze
- Different detectors
- CFS may ignore hangs

**Full spoken answer:**
> “A crash is a fatal signal or uncaught fatal path we can often report with a stack. OOM is frequently jetsam — SIGKILL territory — so we lean on heuristics and MetricKit exit reasons. A hang is the main thread stuck; users feel a freeze even when crash-free looks fine. I refuse to treat those as one bucket.”

**Common wrong answer:** “They’re all crashes in Crashlytics.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | Day 17 hang detector? | Ping main; threshold capture. |
| L2 | Cycles tool? | Graph/Allocations, not Leaks. |
| L3 | CFS gap? | Freezes can hide under healthy CFS. |

**Provenance:** Learning-lab · + S8 reliability culture

---

### Q5. CFS drop during a sale — response? `(45–60s)`

**Answer points:**
- IMOC confirm spike
- Blast radius
- Pause rollout / flag
- Comms + postmortem

**Full spoken answer:**
> “I’d run IMOC playbook: confirm the spike is real, declare ownership and a channel, map blast radius by version and feature, then mitigate — pause phased release or kill-switch the path — before perfect root cause. Cadence communications to stakeholders, ship a fix or hotfix as needed, and write a blameless postmortem with alert and test actions. That’s how we operated P0/P1s at BookMyShow scale.”

**Common wrong answer:** “Keep shipping while we investigate privately.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | Who do you page? | iOS + backend + QA as needed. |
| L2 | Flag vs hotfix? | Flag when possible; hotfix if mandatory native path. |
| L3 | Story? | S8. |

**Provenance:** Verified · S8 · IMOC

---

### Q6. How do you talk about 99.95% CFS? `(30–45s)`

**Answer points:**
- Sustained under peak via process
- Not vanity slide
- Multi-factor: triage + IMOC + engineering fixes
- Don’t credit S2 alone

**Full spoken answer:**
> “I talk about it as a sustained operational bar at thirty-plus lakh DAU — Crashlytics triage workflows plus IMOC during peak events, backed by engineering fixes across the app. It’s not a vanity slide from one PR. When I mention synchronised dictionaries, I frame them as removing race crashes on a specific shared-state path — a contributor to reliability, not the sole cause of ninety-nine point nine five.”

**Common wrong answer:** “We reached 99.95% because of synchronised dictionaries.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | What threatens CFS next? | New SDK, races, missing dSYM, bad rollout. |
| L2 | Hangs? | Separate metrics. |
| L3 | S2 role? | Path-scoped only. |

**Provenance:** Verified · S8 · (S2 bounded)

---

### Q7. Crash only on iOS beta, 2% users — ship? `(30–45s)`

**Answer points:**
- Severity × rarity
- Payment path → mitigate
- Don’t ignore rare×critical

**Full spoken answer:**
> “I multiply severity by rarity. Two percent on a beta might be trackable if it’s a non-critical screen. If it’s checkout or payments, I mitigate immediately — flag, pause, or block the path — even at low percentage. Rare times critical still makes P0.”

**Common wrong answer:** “Under 5% we always ignore.”

**Provenance:** Learning-lab · S8 judgment

---

### Q8. dSYM missing — symptoms? `(30–45s)`

**Answer points:**
- Unsymbolicated frames
- Broken triage speed
- Fix CI upload

**Full spoken answer:**
> “You see addresses instead of symbols, triage slows to a crawl, and duplicate issues fragment. The fix is pipeline discipline — upload dSYMs for every shipped build and re-upload if a build slipped through. I treat missing symbols as an incident for the reliability process, not a ‘Swift bug.’”

**Provenance:** Verified · S8 · workflow dependency

---

### Q9. How did synchronised dictionaries help CFS? `(30–45s)`

**Answer points:**
- Removed data races on shared maps
- Serial queue / RW boundary
- Path-scoped contribution
- Explicitly NOT sole CFS cause

**Full spoken answer:**
> “Shared dictionaries were hit from multiple queues, which caused intermittent race crashes. We serialized access with GCD serial queues and read-write locks behind a safe API so call sites couldn’t touch raw storage. That eliminated concurrent-access crashes on that path and improved reliability. I don’t claim that fix alone produced our ninety-nine point nine five crash-free rate — that bar was sustained by triage, IMOC, and many fixes.”

**Common wrong answer:** “That one change is why CFS is 99.95%.”

**Follow-up ladder:**
| L | Ask | Point |
|---|---|---|
| L1 | Actor today? | S2-A1 for greenfield. |
| L2 | How validate? | Concurrency stress + Crashlytics watch. |
| L3 | Sprinkle locks? | No — boundary API. |

**Provenance:** Verified · S2 · bounded; Verified · S8 · system

---

### Q10. Non-fatals flooding the dashboard. `(30–45s)`

**Answer points:**
- Sample/group
- Fix top offenders
- ≠ CFS
- Promote if critical UX

**Full spoken answer:**
> “I’d sample and group, fix the top noisy offenders, and keep non-fatals conceptually separate from crash-free sessions. If a non-fatal represents broken checkout UX, I escalate on user impact even without a fatal. Volume alone isn’t severity.”

**Provenance:** Learning-lab

---

### Q11. What belongs in a crash postmortem? `(30–45s)`

**Answer points:**
- Timeline, impact, RCA, mitigations, actions
- Blameless
- Alert gaps

**Full spoken answer:**
> “Timeline, user impact, root cause, what mitigation bought us time, and concrete action items — tests, alerts, runbooks — written blamelessly. The goal is preventing repeat, not finding a villain. That’s part of how IMOC closes the loop.”

**Provenance:** Verified · S8

---

### Q12. Crash SDK before analytics? `(30–45s)`

**Answer points:**
- Prefer early crash init
- Keep it fast
- Defer heavy SDKs
- Launch budget (Day 17)

**Full spoken answer:**
> “I prefer crash reporting early so launch failures still report, but initialisation must stay cheap. Heavy analytics and non-critical SDKs defer off the first-frame path. Reliability and launch performance are a joint budget, not a fight.”

**Provenance:** Learning-lab · + Day 17

---

## Tricky questions

### T1. “Just wrap everything in try/catch.” `(90–120s)`

**Trap:** Swift try covers SIGSEGV.

**Answer points:**
- try covers thrown errors only
- Signals / fatalError / asserts bypass catch
- Still need handlers + discipline + triage
- Necessary locally; insufficient as strategy

**Full spoken answer:**
> “Try/catch helps for thrown errors, but many fatals are POSIX signals, assertion failures, or fatalError-style paths that never become a catchable Swift error. You still need crash handlers, coding discipline around force unwraps and concurrency, and a triage pipeline. try/catch is necessary in places and wildly insufficient as a crash strategy.”

**Provenance:** Learning-lab

---

### T2. Logging with OSLog inside the signal handler. `(90–120s)`

**Trap:** Normal logging in signal context.

**Answer points:**
- OSLog / frameworks ≠ async-signal-safe
- Secondary crash / deadlock risk
- Preallocated mmap + safe writes only
- Breadcrumbs filled on happy path

**Full spoken answer:**
> “That’s how you get a secondary crash or deadlock. Logging frameworks aren’t async-signal-safe. The crash writer must use a precomputed path — mmap and safe writes — filled without allocating. Breadcrumbs are recorded earlier on the happy path so the handler only persists what’s already there.”

**Provenance:** Learning-lab

---

### T3. CFS stable but users report freezes. `(90–120s)`

**Trap:** Trust CFS alone.

**Answer points:**
- CFS ≠ hang-free / session quality
- Pull hang, MetricKit, APM hang rate
- Reproduce with Time Profiler
- Treat freezes as reliability at scale

**Full spoken answer:**
> “Crash-free can look healthy while hangs and memory pressure destroy UX. I’d pull hang diagnostics, MetricKit signals, and any APM hang rate, reproduce with Time Profiler, and treat freezes as reliability even when CFS doesn’t move. At BMS scale we cared about session quality, not a single green metric.”

**Provenance:** Verified · S8 · culture; Day 17 tools

---

### T4. iOS blames backend, backend blames iOS. `(90–120s)`

**Trap:** Argue in war room.

**Answer points:**
- Shared timeline + correlation IDs
- Failure % by layer
- Mitigate user harm first
- Data before finger-pointing (IMOC)

**Full spoken answer:**
> “As IMOC I force a shared timeline, correlation IDs, and failure percentages by layer. We mitigate user harm first — fallback, disable feature, pause rollout — then argue root cause with data. Finger-pointing extends downtime; ownership shortens it. That’s the leadership pattern behind our P0/P1 coordination.”

**Provenance:** Verified · S8 · IMOC

---

### T5. Hotfix vs config kill switch. `(90–120s)`

**Trap:** Always hotfix.

**Answer points:**
- Flag first if it cuts blast radius
- Hotfix for mandatory native path
- Accept review latency trade-off
- Payments bias fast mitigate; hotfix ≠ default ego

**Full spoken answer:**
> “If a flag can remove blast radius in minutes, I take it. Hotfix when the crash is in a mandatory native path and flags can’t save users — accepting review latency. Payment paths bias toward fast mitigate. Process cost of hotfixes means they shouldn’t be the default ego move.”

**Provenance:** Verified · S8 · (+ S7 if payments)

---

### T6. Breadcrumbs captured auth headers. `(90–120s)`

**Trap:** “Debug later.”

**Answer points:**
- Treat as privacy/security incident
- Scrub at source; rotate tokens
- Assess exposure
- Lint / review forbid secret keys in logs

**Full spoken answer:**
> “That’s a privacy/security incident. Scrub at source, rotate tokens, assess exposure, and add lint or code review checks for forbidden keys in logging APIs. Debuggability never outranks credential leakage. Crosses into Day 19 security thinking.”

**Provenance:** Learning-lab · Sev mindset

---

### T7. Crash SDK upload reliability design. `(90–120s)`

**Trap:** Upload during crash.

**Answer points:**
- Persist durably; upload next launch
- Backoff + cap pending reports
- Ack before delete last crash
- No networking in signal context

**Full spoken answer:**
> “Almost never upload in the crashing process context. Persist durably, upload next launch with backoff, cap pending reports, and don’t delete the last crash before acknowledgement. Battery and quota matter. Signal-time networking is both unsafe and unreliable.”

**Provenance:** Learning-lab

---

### T8. Intermittent unreproducible crash. `(90–120s)`

**Trap:** Close as unrepro.

**Answer points:**
- Better breadcrumbs + careful non-fatals
- Concurrency stress / device matrix / flag bisect
- Often races (S2 shared-map pattern)
- TSan in CI; don’t close without instrumentation

**Full spoken answer:**
> “Improve breadcrumbs, add careful non-fatal probes, concurrency stress, device matrix, and feature-flag bisect. Intermittent crashes are often races — the same reasoning as our synchronised dictionary work on a shared path. Thread Sanitizer in CI helps for some classes. Closing as unrepro without instrumentation is how intermittent becomes permanent.”

**Provenance:** Verified · S2 · reasoning pattern; S8 triage

---

## Timed set

Recommend **Q5, Q6, Q9** + **T3, T4**. Deliver S8 STAR ≤3 min; S2 add-on ≤90s with explicit non-sole-cause line.
