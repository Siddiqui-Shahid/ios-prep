# Sample Q&A Coverage Tracker

Track topics present in day modules (`01`–`05`) that are **missing** or **thin** in `sample/` guided Q&A.

**QnA shape (locked):** each card is `### Qn` → **Answer** → **Follow-ups** table → **How can I relate to my case** (named cases: Shipped / Design if asked / Lab only / Don’t claim — or a short concept-only block). No `Points to`, no `Provenance`, no S1/S2-A1 codes in learner-facing copy.

**Legend**

| Mark | Meaning |
|---|---|
| `[ ]` | Open — still missing or thin in sample |
| `[x]` | Closed — dedicated sample Q or thicker follow-up landed |
| **P0** | High — fill first if sample / audiobook is the primary study path |
| **P1** | Medium |
| **P2** | Low / optional polish |
| **By design** | Intentionally deferred to `04-questions.md` / deep dive — not a defect unless you study sample-only |

**How to close a row:** add a sample Q (or thicken a follow-up) in the suggested file, keep matching `.script.md` in sync, then check the box. *(All rows below were closed in the fill pass.)*

---

## Audit snapshot

| Check | Result |
|---|---|
| Days 01–28 have `sample/` | Yes |
| 4 QnA `.md` + matching `.script.md` + `README` | Yes |
| QnA format (`### Qn` → Answer → Follow-ups → How can I relate to my case) | Consistent — named cases, no S-codes |
| Empty/stub samples | None |

Core day outcomes are mostly covered. Gaps below are secondary module topics, tricky `04-questions` items, and pointer-only mock/revision days.

### Day status rollup

| Status | Days |
|---|---|
| Structure OK + sample gaps closed | 01–28 (all tracker rows filled into sample Q&A) |

---

## By design (not defects)

| Day | Note |
|---|---|
| 07, 14, 21, 26, 27 | Mock/revision days keep full talk tracks / deep pools in `04-questions.md` + deep dive |
| 25–28 | Day `03-production-bridge.md` files are lean by design; samples are often richer than those modules |

Promote a **By design** item to P0/P1 only if audiobook-only study must stand alone.

---

## P0 — High

### Day 03 — ARC / retain cycles

Sources: [`02-deep-dive.md`](weeks/week-01/day-03/02-deep-dive.md) · [`04-questions.md`](weeks/week-01/day-03/04-questions.md)  
Target: [`sample/02-retain-cycles.md`](weeks/week-01/day-03/sample/02-retain-cycles.md) or [`sample/03-tools-and-leaks.md`](weeks/week-01/day-03/sample/03-tools-and-leaks.md)

- [x] **Missing:** Autorelease pools (`04` Q9 / deep dive) — add dedicated sample Q

### Day 06 — DSA arrays / strings / windows

Sources: [`02-deep-dive.md`](weeks/week-01/day-06/02-deep-dive.md) · [`04-questions.md`](weeks/week-01/day-06/04-questions.md)  
Target: [`sample/01-approach-scripts.md`](weeks/week-01/day-06/sample/01-approach-scripts.md) · [`sample/02-two-pointers-window.md`](weeks/week-01/day-06/sample/02-two-pointers-window.md)

- [x] **Thin:** Container With Most Water — full 60–90s approach Q (not pattern signal only)
- [x] **Thin:** Move Zeroes — full approach Q
- [x] **Thin:** Min Size Subarray Sum — full approach Q (optional after the two above)
- [x] **Thin:** Group Anagrams — full approach Q (optional after the two above)

### Day 07 — Week 1 mock

Sources: [`04-questions.md`](weeks/week-01/day-07/04-questions.md)  
Target: [`sample/03-mock-interview.md`](weeks/week-01/day-07/sample/03-mock-interview.md) · [`sample/04-warmup-hld.md`](weeks/week-01/day-07/sample/04-warmup-hld.md)

- [x] **Thin / missing in sample:** Deep-pool D1–D8 condensed spoken answers (today sample only indexes → `04-questions`)

### Day 13 — Stack / queue / linked list

Sources: [`02-deep-dive.md`](weeks/week-02/day-13/02-deep-dive.md) · [`04-questions.md`](weeks/week-02/day-13/04-questions.md)  
Target: [`sample/01-stack-queue-basics.md`](weeks/week-02/day-13/sample/01-stack-queue-basics.md) · [`sample/02-monotonic-patterns.md`](weeks/week-02/day-13/sample/02-monotonic-patterns.md)

- [x] **Missing:** Hit-counter / recent-requests design
- [x] **Missing:** Calculator / expression stack approach script

### Day 17 — Performance / Instruments

Sources: [`02-deep-dive.md`](weeks/week-03/day-17/02-deep-dive.md) · [`04-questions.md`](weeks/week-03/day-17/04-questions.md)  
Target: [`sample/02-instruments-metrickit.md`](weeks/week-03/day-17/sample/02-instruments-metrickit.md) · [`sample/03-startup-scrolling.md`](weeks/week-03/day-17/sample/03-startup-scrolling.md)

- [x] **Missing:** Binary size vs performance (`04` Q9)
- [x] **Missing:** Android-style ANR → iOS hang / watchdog translation
- [x] **Thin:** Core Animation / overdraw attribution

### Day 19 — Security / pinning

Sources: [`03-production-bridge.md`](weeks/week-03/day-19/03-production-bridge.md) · [`04-questions.md`](weeks/week-03/day-19/04-questions.md)  
Target: new `sample/04-production-s4.md` (or expand [`sample/02-ssl-pinning-spki.md`](weeks/week-03/day-19/sample/02-ssl-pinning-spki.md)); today [`sample/04-persistence-tree.md`](weeks/week-03/day-19/sample/04-persistence-tree.md) prioritizes persistence over STAR

- [x] **Thin:** Full timed S4 STAR spine (Opener / S / T / Action / Result / Lesson) as dedicated sample

### Day 23 — HashMap / Heap

Sources: [`04-questions.md`](weeks/week-04/day-23/04-questions.md) · [`02-deep-dive.md`](weeks/week-04/day-23/02-deep-dive.md)  
Target: [`sample/01-hashmap-patterns.md`](weeks/week-04/day-23/sample/01-hashmap-patterns.md)

- [x] **Missing:** O(1) insert / delete / `getRandom`

### Day 25 — Machine round debrief

Sources: [`04-questions.md`](weeks/week-04/day-25/04-questions.md)  
Target: [`sample/04-debrief-structure.md`](weeks/week-04/day-25/sample/04-debrief-structure.md)

- [x] **Missing:** Tricky debrief T1 — stale prices defend
- [x] **Missing:** Tricky debrief T2 — “generate whole app with AI”
- [x] **Missing:** Tricky debrief T3 — unfinished image loading fail?
- [x] **Missing:** Tricky debrief T4 — concurrency bugs in pager
- [x] **Missing:** Tricky debrief T5 — auth mid-round

---

## P1 — Medium

### Day 01

Sources: [`01-foundations.md`](weeks/week-01/day-01/01-foundations.md) · [`02-deep-dive.md`](weeks/week-01/day-01/02-deep-dive.md)  
Target: [`sample/01-value-types.md`](weeks/week-01/day-01/sample/01-value-types.md) · [`sample/02-cow-enums.md`](weeks/week-01/day-01/sample/02-cow-enums.md)

- [x] **Thin:** Class-wrapped `Array` kills COW across aliases
- [x] **Thin:** `Result` → UI state enum; unknown-case / versioning resilience

### Day 02

Sources: [`01-foundations.md`](weeks/week-01/day-02/01-foundations.md) · [`04-questions.md`](weeks/week-01/day-02/04-questions.md)  
Target: [`sample/01-pop-and-generics.md`](weeks/week-01/day-02/sample/01-pop-and-generics.md) · [`sample/02-associated-types-erasure.md`](weeks/week-01/day-02/sample/02-associated-types-erasure.md)

- [x] **Missing:** Conditional conformance
- [x] **Missing:** `rethrows` + generic higher-order functions

### Day 08

Sources: [`02-deep-dive.md`](weeks/week-02/day-08/02-deep-dive.md) · [`04-questions.md`](weeks/week-02/day-08/04-questions.md)  
Target: [`sample/01-layer-stack-di.md`](weeks/week-02/day-08/sample/01-layer-stack-di.md) · [`sample/02-mvvm-clean-mvi.md`](weeks/week-02/day-08/sample/02-mvvm-clean-mvi.md)

- [x] **Thin:** Navigation ownership (Coordinator vs Router vs `NavigationPath`) as full Q

### Day 09

Sources: [`02-deep-dive.md`](weeks/week-02/day-09/02-deep-dive.md) · [`04-questions.md`](weeks/week-02/day-09/04-questions.md)  
Target: [`sample/01-networking-layer.md`](weeks/week-02/day-09/sample/01-networking-layer.md) · [`sample/04-production-s4.md`](weeks/week-02/day-09/sample/04-production-s4.md)

- [x] **Thin:** Networking debug workflow
- [x] **Thin:** Interceptor vs journey-span observability depth

### Day 11

Sources: [`02-deep-dive.md`](weeks/week-02/day-11/02-deep-dive.md) · [`04-questions.md`](weeks/week-02/day-11/04-questions.md)  
Target: [`sample/02-cells-reuse-prefetch.md`](weeks/week-02/day-11/sample/02-cells-reuse-prefetch.md) · [`sample/04-production-s13-s6.md`](weeks/week-02/day-11/sample/04-production-s13-s6.md)

- [x] **Thin:** Self-sizing collection jank causes
- [x] **Thin:** Mixpanel screen-name / analytics double-count discipline
- [x] **Thin:** Bottom-sheet engineering (detents, VoiceOver, open/dismiss analytics)

### Day 15

Sources: [`04-questions.md`](weeks/week-03/day-15/04-questions.md) · [`02-deep-dive.md`](weeks/week-03/day-15/02-deep-dive.md)  
Target: [`sample/01-modularization-basics.md`](weeks/week-03/day-15/sample/01-modularization-basics.md) · [`sample/02-spm-di-graphs.md`](weeks/week-03/day-15/sample/02-spm-di-graphs.md)

- [x] **Missing:** Binary size as interview topic
- [x] **Thin:** Circular-dependency prevention as first-class Q

### Day 16

Sources: [`04-questions.md`](weeks/week-03/day-16/04-questions.md)  
Target: [`sample/02-image-pipeline.md`](weeks/week-03/day-16/sample/02-image-pipeline.md) · [`sample/03-video-audio-media.md`](weeks/week-03/day-16/sample/03-video-audio-media.md)

- [x] **Missing:** GIFs / animated images

### Day 18

Sources: [`04-questions.md`](weeks/week-03/day-18/04-questions.md)  
Target: [`sample/02-signal-safety-oom.md`](weeks/week-03/day-18/sample/02-signal-safety-oom.md)

- [x] **Missing:** Name OSLog / logging inside signal handler as an explicit trap

### Day 21

Sources: [`02-deep-dive.md`](weeks/week-03/day-21/02-deep-dive.md) · [`04-questions.md`](weeks/week-03/day-21/04-questions.md)  
Target: [`sample/02-clarify-phase.md`](weeks/week-03/day-21/sample/02-clarify-phase.md) · [`sample/03-cache-scroll.md`](weeks/week-03/day-21/sample/03-cache-scroll.md)

- [x] **Thin:** SDUI action-routing worked sample Q
- [x] **Thin:** Prompt B full HLD / API / ops walkthrough in sample form

### Day 22

Sources: [`02-deep-dive.md`](weeks/week-04/day-22/02-deep-dive.md) · [`04-questions.md`](weeks/week-04/day-22/04-questions.md)  
Target: [`sample/02-tree-patterns-skeletons.md`](weeks/week-04/day-22/sample/02-tree-patterns-skeletons.md)

- [x] **Thin:** Construct tree from preorder + inorder as full Q
- [x] **Thin:** Symmetric tree as full Q

### Day 24

Sources: [`04-questions.md`](weeks/week-04/day-24/04-questions.md) · [`02-deep-dive.md`](weeks/week-04/day-24/02-deep-dive.md)  
Target: [`sample/01-on-device-primer.md`](weeks/week-04/day-24/sample/01-on-device-primer.md) · [`sample/03-gymflow-embeddings.md`](weeks/week-04/day-24/sample/03-gymflow-embeddings.md)

- [x] **Thin:** Stream tokens to UI without jank (dedicated Q)
- [x] **Thin:** Thermal throttling mid-generation behavior design

### Day 27

Sources: [`04-questions.md`](weeks/week-04/day-27/04-questions.md)  
Target: [`sample/03-warmup-recovery.md`](weeks/week-04/day-27/sample/03-warmup-recovery.md)

- [x] **Thin:** Pool E rapid defs — retain cycle 30s
- [x] **Thin:** Pool E rapid defs — SSL pinning + S4
- [x] **Thin:** Pool E rapid defs — p50 / p90 why
- [x] **Thin:** Pool E rapid defs — fail-soft AI 30s

---

## P2 — Low / optional polish

### Day 04

Sources: [`02-deep-dive.md`](weeks/week-01/day-04/02-deep-dive.md)  
Target: [`sample/01-queues-sync-async.md`](weeks/week-01/day-04/sample/01-queues-sync-async.md) · [`sample/03-groups-races.md`](weeks/week-01/day-04/sample/03-groups-races.md)

- [x] **Thin:** Mixing GCD with async/await
- [x] **Thin:** Locks vs queues vs actors comparison as dedicated Q
- [x] **Thin:** Target-queue inversion / thread-hop edge cases

### Day 05

Sources: [`04-questions.md`](weeks/week-01/day-05/04-questions.md) · [`02-deep-dive.md`](weeks/week-01/day-05/02-deep-dive.md)  
Target: [`sample/02-structured-concurrency.md`](weeks/week-01/day-05/sample/02-structured-concurrency.md) · [`sample/03-actors-sendable.md`](weeks/week-01/day-05/sample/03-actors-sendable.md)

- [x] **Thin:** Task priority / QoS
- [x] **Thin:** GCD `sync` inside async deadlock / starvation as dedicated Q
- [x] **Thin:** Sendable across modules / public classes
- [x] **Thin:** MainActor-from-actor deadlock myths as full Q

### Day 10

Sources: [`04-questions.md`](weeks/week-02/day-10/04-questions.md)  
Target: [`sample/02-schema-version-fallbacks.md`](weeks/week-02/day-10/sample/02-schema-version-fallbacks.md) · [`sample/03-registry-actions-splash.md`](weeks/week-02/day-10/sample/03-registry-actions-splash.md)

- [x] **Thin:** Personalized SDUI cache privacy leak as full Q
- [x] **Thin:** iOS / Android parity as primary answer
- [x] **Thin:** Registry ownership app vs SDK as standalone Q

### Day 12

Sources: [`02-deep-dive.md`](weeks/week-02/day-12/02-deep-dive.md) · [`04-questions.md`](weeks/week-02/day-12/04-questions.md)  
Target: [`sample/02-identity-traps.md`](weeks/week-02/day-12/sample/02-identity-traps.md) · [`sample/03-lists-performance.md`](weeks/week-02/day-12/sample/03-lists-performance.md)

- [x] **Thin:** Equatable View micro-opt as dedicated Q
- [x] **Thin:** Testing SwiftUI state logic
- [x] **Thin:** Animation → list jump as standalone Q

### Day 14

Sources: [`03-production-bridge.md`](weeks/week-02/day-14/03-production-bridge.md) · [`04-questions.md`](weeks/week-02/day-14/04-questions.md)  
Target: [`sample/02-mock-format.md`](weeks/week-02/day-14/sample/02-mock-format.md) · [`sample/03-ads-architecture.md`](weeks/week-02/day-14/sample/03-ads-architecture.md)

- [x] **Thin (by design):** Full S1 / S3 STAR talk tracks embedded in sample
- [x] **Thin:** Leadership hybrid T3 (refresh stampede + pin outage) worked answer
- [x] **Thin:** Mixed warm-up spoken answers bank in sample

### Day 20

Sources: [`04-questions.md`](weeks/week-03/day-20/04-questions.md)  
Target: [`sample/01-deep-links.md`](weeks/week-03/day-20/sample/01-deep-links.md)

- [x] **Thin:** “Two routers drifted” as first-class failure story
- [x] **Thin:** Marketing pressure for `myapp://` everywhere (scheme-hijack pushback)

### Day 26

Sources: [`04-questions.md`](weeks/week-04/day-26/04-questions.md)  
Target: [`sample/01-star-rhythm.md`](weeks/week-04/day-26/sample/01-star-rhythm.md) · [`sample/03-mentorship-ai.md`](weeks/week-04/day-26/sample/03-mentorship-ai.md)

- [x] **Thin (by design):** Full 2–3 min spoken STAR scripts in sample (spines today; full text in `04`)
- [x] **Thin:** Backup stories S14 / S10 as mentorship routers
- [x] **Thin:** Failure STAR “real miss” story flesh

### Day 28

Sources: [`05-exercises.md`](weeks/week-04/day-28/05-exercises.md)  
Target: [`sample/01-taper-rules.md`](weeks/week-04/day-28/sample/01-taper-rules.md)

- [x] **Thin:** Optional micro TMAY in sample (lightly present)

---

## Close status

All P0 / P1 / P2 tracker rows are filled into the target `sample/*.md` cards with matching `.script.md` updates. Re-open a checkbox only if a future audit finds the sample answer still too thin vs the day module.
