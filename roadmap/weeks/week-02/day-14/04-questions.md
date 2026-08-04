# 04 — Questions (two-layer warm-ups for Mock #2)

> Study flow: cover full spoken → speak from **Answer points** → compare.  
> Totals: **12 normal + 8 tricky = 20**. These are Week 2 revision warm-ups + mock traps.

---

## Normal questions

### Q1. MVVM vs Clean — when Clean? `(45s)`

**Answer points:**
- Shared domain rules / multi-surface → UseCases
- Simple feature → MVVM enough
- District incremental migration (S9)

**Full spoken answer:**
> “I default to MVVM for a single screen with clear UI state. I reach for Clean-style UseCases when domain rules are shared across surfaces or we’re migrating a messy feature boundary — like Free Parking at District — so the domain isn’t trapped in a ViewModel. Incremental migration beats a big-bang rewrite.”

**Common wrong answer:** “Clean is always more senior.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | AI role? | Context inside protocols; human owns architecture (S9). |
| L2 | DI? | Inject UseCases at composition root. |
| L3 | — | — |

**Provenance:** Verified · S9

---

### Q2. Search debounce + cancel ownership? `(45s)`

**Answer points:**
- Debounce in VM (presentation policy)
- Cancel Task on new keystroke / disappear
- Cancel ≠ error toast
- Ignore stale results

**Full spoken answer:**
> “Debounce lives in the ViewModel as presentation policy. Each new query cancels the in-flight Task; cancellation is not a user-facing error. Completions check a generation token or task identity so out-of-order responses can’t win. That’s how we kept BMS search race-safer under MVVM.”

**Common wrong answer:** Showing “error” on cancel.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Repo cancel too? | May cancel network; policy still VM. |
| L2 | Story? | S3. |
| L3 | — | — |

**Provenance:** Verified · S3

---

### Q3. Single-flight token refresh? `(60s)`

**Answer points:**
- One refresh for N 401s
- Waiters share result
- Retry once
- Failure fan-out → logout
- Actor / critical section

**Full spoken answer:**
> “When many calls 401 together, only one refresh runs — waiters await that Task. On success, retry originals once; on failure, fan out logout. I isolate that behind an actor or serial critical section so we don’t mutate refresh state from unstructured tasks. Blind refresh storms revoke tokens and amplify outages.”

**Common wrong answer:** Each 401 refreshes independently.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | POST retry? | Don’t blind-retry non-idempotent charges. |
| L2 | Code? | Day 09 SingleFlightRefresh pattern. |
| L3 | — | — |

**Provenance:** Learning-lab · Day 09 · soft S4 stack

---

### Q4. SSL pinning failure mode? `(45–60s)`

**Answer points:**
- MITM resistance ↑
- Bad rotation → self-outage
- Backup pins + staged design (S4-A1)
- ATS ≠ pinning

**Full spoken answer:**
> “Pinning reduces MITM risk by requiring expected server identity, but a bad rotation bricks clients. On Ads we moved to URLSession with HTTPS, pinning, and a host whitelist. Separately, as design, I’d require backup pins and a monitored break-glass plan — I’m not claiming I shipped that full ops runbook.”

**Common wrong answer:** “Pinning never causes outages” or “ATS is pinning.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | SPKI? | Hash SPKI DER, not raw key export bytes. |
| L2 | Story? | S4. |
| L3 | — | — |

**Provenance:** Verified · S4 · Applied · S4-A1

---

### Q5. Unknown SDUI component policy? `(30–45s)`

**Answer points:**
- Skip + metric
- Never crash
- Empty root → hard fallback

**Full spoken answer:**
> “Unknown component types skip with a metric — never crash the shell. If the root is empty after filtering, show a hard fallback header or splash. Fail-soft is how SDUI survives CMS mistakes at scale.”

**Common wrong answer:** Force-unwrap / fatalError on unknown.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Version mismatch? | Gate major versions; fallback. |
| L2 | Story? | S3; S3-A1 for versioning emphasis. |
| L3 | — | — |

**Provenance:** Verified · S3 · Applied · S3-A1

---

### Q6. SDUI vs WebView? `(45s)`

**Answer points:**
- Native registry → a11y/perf
- Allowlisted actions
- WebView for truly open content

**Full spoken answer:**
> “SDUI with a native registry keeps accessibility, performance, and action allowlisting under app control. A WebView is fine for open-ended content you don’t want to native-render, but it’s the wrong default for a primary home header you need to trust.”

**Common wrong answer:** “WebView is always simpler/better.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Hybrid? | Native shell + limited web islands. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab · Day 10

---

### Q7. Where pause ad / story video? `(30–45s)`

**Answer points:**
- Offscreen / disappear / background
- prepareForReuse
- Protocolised (S1 / S10)

**Full spoken answer:**
> “Pause when the widget leaves visibility, on viewWillDisappear, on background, and in prepareForReuse. On Ads, HeroWidget made that an explicit contract so video didn’t keep playing off-screen on a revenue surface.”

**Common wrong answer:** Fire-and-forget AVPlayer.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Stories? | Same lifecycle discipline in SDK. |
| L2 | Story? | S1. |
| L3 | — | — |

**Provenance:** Verified · S1

---

### Q8. Hybrid deeplink ownership? `(60s)`

**Answer points:**
- Parse at app edge → intent
- Single router
- No dual stacks forever-sync

**Full spoken answer:**
> “Parse deeplinks at the app edge into an intent, then one router owns navigation. Dual UIKit/SwiftUI stacks that try to stay forever in sync are a bug factory — Grizzlies-style hybrid work needs one owner for exits.”

**Common wrong answer:** “Each stack handles its own URLs independently forever.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Cold start? | Queue intent until root ready. |
| L2 | Story? | S13. |
| L3 | — | — |

**Provenance:** Verified · S13

---

### Q9. SwiftUI identity footgun? `(45s)`

**Answer points:**
- Unstable `.id` resets state
- UUID in body is bad
- Stories need stable page IDs

**Full spoken answer:**
> “If identity changes every render — like UUID in body — SwiftUI tears down and rebuilds state. Stories pages need stable IDs so progress and media don’t reset while paging.”

**Common wrong answer:** “SwiftUI bug — not my identity.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | List? | Stable `id:` on ForEach. |
| L2 | Story? | S10. |
| L3 | — | — |

**Provenance:** Verified · S10 soft bridge · Day 12

---

### Q10. LE Bottom Sheet impact? `(30–45s)`

**Answer points:**
- Lightweight overview
- **30%+** fewer full-screen navs
- Cross-functional contracts

**Full spoken answer:**
> “LE Bottom Sheet gave a lightweight overview instead of pushing full screens for many flows — Verified 30%+ fewer full-screen navigations on those flows. The win was product contract plus implementation, not a visual gimmick.”

**Common wrong answer:** Vague “better UX” without the metric you’re allowed to use.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Sheet vs push? | Overview vs deep task. |
| L2 | Story? | S6. |
| L3 | — | — |

**Provenance:** Verified · S6 · 30%+

---

### Q11. Array as queue issue? `(30s)`

**Answer points:**
- removeFirst O(n)
- Deque / two-stack / ring

**Full spoken answer:**
> “Array.removeFirst shifts elements — O(n) per dequeue. I’d use a deque, two-stack queue, or ring, and I’d say that cost if I ever demo Array naively.”

**Common wrong answer:** Ignoring cost.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Day? | 13. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab · Day 13

---

### Q12. District AI tooling — senior framing? `(45–60s)`

**Answer points:**
- Context Engineering inside protocols
- Human-owned architecture
- Review + tests gate

**Full spoken answer:**
> “At District, AI assisted inside a Context Engineering envelope — protocols, patterns, and tests I still owned. Senior signal isn’t ‘AI wrote the app’; it’s architecture judgment, review, and XCTest/XCUITest discipline around the migration.”

**Common wrong answer:** “AI generated our production architecture unsupervised.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | What AI got wrong? | Have one concrete review catch ready. |
| L2 | Story? | S9. |
| L3 | — | — |

**Provenance:** Verified · S9

---

## Tricky questions

### T1. Five minutes — design our Ads rendering system. `(5 min)`

**Trap:** Dive into cell code; skip lifecycle/security.

**Answer points:** Use Track A spine — POP, HeroWidget, URLSession pin, trade-offs.

**Full spoken answer:** Deliver [code/MockTalkTracks.md](code/MockTalkTracks.md) Track A full script under 5:00.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Pin rotation? | S4-A1 design. |
| L2 | POP vs inheritance? | Extension without fork. |
| L3 | Metrics? | No invented fill-rate %. |

**Provenance:** Verified · S1 · S4

---

### T2. Five minutes — design SDUI for our home header. `(5 min)`

**Trap:** Ignore versioning/fallback.

**Answer points:** Track B spine — schema, registry, fail-soft, BMS/Aces.

**Full spoken answer:** Deliver Track B full script under 5:00.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Breaking schema at scale? | Version gate + fallback; S8 bar. |
| L2 | Actions? | Allowlist. |
| L3 | — | — |

**Provenance:** Verified · S3 · S12

---

### T3. Refresh stampede + pinning outage same week — how do you lead? `(120s)`

**Trap:** Only technical rabbit hole.

**Answer points:**
- IMOC-style blast radius / owners / comms
- Then single-flight + backup pins design
- Metrics: TLS failures, crash-free
- Honest S8 culture without pinning=owns CFS

**Full spoken answer:**
> “I’d lead with blast radius and owners first — feature guards, rollback, break-glass design — while engineering fixes single-flight refresh and pin backups. I’d watch TLS failure rate and crash-free. At BMS scale we held a 99.95%+ CFS bar at 30L+ DAU — I’m not claiming pinning alone created that number, but that reliability culture shapes how I’d run the week.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Comms? | Status cadence; don’t silent-fix. |
| L2 | Stories? | S8 + S4 + S4-A1. |
| L3 | — | — |

**Provenance:** Verified · S8 · S4 · Applied · S4-A1

---

### T4. Why not SDUI the Ads video player? `(90–120s)`

**Trap:** SDUI religion.

**Answer points:**
- Revenue media needs typed native lifecycle
- SDUI for placement/config
- Native HeroWidget renderer

**Full spoken answer:**
> “I’d keep the video renderer native. Revenue media needs typed lifecycle — pause/play, reuse, viewability — which is exactly what HeroWidget encoded. SDUI is excellent for placement and campaign configuration. Forcing the player through a generic CMS widget usually weakens the contract that protects UX and revenue.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Bridge tracks A/B? | Config SDUI + native player. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S1 · contrast S3

---

### T5. SwiftUI Stories SDK in a UIKit-heavy host. `(90–120s)`

**Trap:** Ignore hosting/identity/router.

**Answer points:**
- UIHostingController façade
- Inject deps (S10)
- Deeplink exits via host router (S13)
- Stable identity

**Full spoken answer:**
> “I’d expose Stories behind a small UIKit façade — hosting controller, injectable content/analytics/image loader — so the host doesn’t import SDK internals. Deeplink exits go through the host router, not a second nav religion. Stable SwiftUI identity keeps pages from resetting. That’s how a reusable Stories SDK survives portfolio hosts.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Stories? | S10. |
| L2 | Hybrid? | S13. |
| L3 | — | — |

**Provenance:** Verified · S10 · S13

---

### T6. Debounce in repository vs VM — argue both, then pick. `(90s)`

**Trap:** No decision.

**Answer points:**
- VM = presentation policy
- Repo may cancel network
- Pick VM for BMS search

**Full spoken answer:**
> “Repository debounce couples policy to data and surprises other callers. ViewModel debounce matches UX timing and is easy to test with fake clocks. The repository should still cancel work when asked. For BMS search I’d keep debounce in the VM and cancel through the networking layer.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Shared search used by two UIs? | Shared UseCase with explicit policy param. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S3 judgment · Day 08

---

### T7. Mock feedback: you ran 8 minutes on architecture. `(60s)`

**Trap:** Defensiveness.

**Answer points:**
- Cut examples
- Agenda + timeboxes
- Re-record 5:00 hard stop

**Full spoken answer:**
> “Fair — I over-indexed on examples. Next pass: agenda in twenty seconds, one minute per beat, hard stop at five, invite questions. I’ll re-record with a visible timer tonight.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Which beat to cut? | Duplicate prod anecdote. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Learning-lab mock discipline

---

### T8. Payment + search skim — what do you refuse to botch? `(90s)`

**Trap:** Ramble both systems.

**Answer points:**
- Payments: no blind POST retry; idempotency mindset (S7)
- Search: debounce/cancel/stale (S3)
- Pick depth if timeboxed

**Full spoken answer:**
> “If I only get two minutes: payments must not blindly retry charge POSTs — status poll / idempotency mindset from checkout UX work. Search must debounce, cancel, and ignore stale. If the interviewer wants depth, I’ll pick one and agenda it rather than half-finish both.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | S7 claim? | Intent to reduce drop-off/support — no invented %. |
| L2 | — | — |
| L3 | — | — |

**Provenance:** Verified · S7 intent · S3

---

Revision twin: [../../../revision/weeks/week-02/day-14.md](../../../revision/weeks/week-02/day-14.md)
