# Day 14 — Revision + Mock #2 (Ads or SDUI Architecture)

> **Full chapter:** [`weeks/week-02/day-14/`](../../../weeks/week-02/day-14/) · Revision twin — timed recall only after the full study.

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~5–6 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- A **5-minute** architecture talk on either **Ads (POP + HeroWidget + networking/pinning)** or **SDUI engine (schema → registry → fallback)** without notes
- Week 2 connective tissue: MVVM/DI → networking → SDUI → UIKit/SwiftUI hybrid → SwiftUI identity
- Timed Normal/Tricky answers from Days 08–12 with fewer stalls
- Honest gotchas list + plan for Week 3 (modularization, perf, security)

## 2. Concept deep dive

### 2.1 Week 2 synthesis map

```text
Day 08  Layers / DI / search VM
   ↓
Day 09  URLSession client / refresh / pin / cancel
   ↓
Day 10  SDUI schema / registry / fallback
   ↓
Day 11  Lifecycle / cells / hybrid / bottom sheet
   ↓
Day 12  SwiftUI state / identity / Stories SDK
   ↓
Day 13  Stack·Queue·LL reps
```

**One sentence senior narrative:**  
“I structure features with clear layers and DI, own networking with cancellation and security, use SDUI where content velocity matters with fail-soft schema, and treat UIKit/SwiftUI lifecycle and identity as production contracts — proven on BMS, District, and Raw apps.”

### 2.2 Mock #2 format (self/peer, 60–90 min)

| Block | Time | What |
|---|---|---|
| Warm-up Qs | 15–20 min | 4–5 Normal from Week 2 mixed |
| Deep dive | 15–20 min | 2 Tricky (refresh **or** SDUI outage **or** hybrid nav) |
| **Architecture talk** | **5 min timed** | **Ads path or SDUI path** (pick one) |
| STAR | 10 min | S1 or S3/S12 + S9 or S4 |
| Retro | 10–15 min | Score timing; update gotchas |

Parallel SD skim (optional after mock): [payment-checkout.md](../../../ios-system-design/docs/payment-checkout.md) · [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md)

### 2.3 Track A — Ads architecture (5 min)

**Agenda to say in first 20s:**  
“I’ll cover problem scope, type-safe component pipeline (POP+generics), HeroWidget lifecycle, networking/pinning on URLSession, and trade-offs vs SDUI for media.”

**Outline (≈1 min each):**

1. **Context:** Highest-revenue Ads module; need safe reusable rendering; video pause/play correctness.  
2. **Component model:** Protocol-oriented ad contracts + generics pipeline (not inheritance trees).  
3. **HeroWidget:** Visibility/VC lifecycle → pause/play; cell reuse cancel.  
4. **Networking:** Alamofire→URLSession; HTTPS; SSL pinning; domain whitelist; pin rotation.  
5. **Trade-offs / close:** Keep media native; CMS may configure placement; metrics/revenue safety; questions.

**Docs:** Day 08–09 notes · S1 · S4 · optional [networking-layer.md](../../../ios-system-design/docs/networking-layer.md)

### 2.4 Track B — SDUI architecture (5 min)

**Agenda (20s):**  
“I’ll define SDUI scope, schema/versioning, registry+actions, fallback/cache for crash-free, and BMS header / Aces splash examples — then limits vs native Ads.”

**Outline:**

1. **Problem:** Content/layout velocity without releases; personalisation.  
2. **Pipeline:** Fetch → version gate → parse → registry → layout → allowlisted actions.  
3. **Resilience:** Unknown skip; last-known-good; default splash/header; metrics.  
4. **Prod:** BMS backend-driven header + search; Aces server splash / cold start.  
5. **Trade-offs:** New component types need app release; Ads media often stays native (S1).

**Docs:** [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) · S3 · S12 · Day 10

### 2.5 Trade-offs (meta for mock)

| Choice | When | Cost |
|---|---|---|
| Ads 5-min talk | Strong POP/lifecycle/security stories | Less CMS vocabulary |
| SDUI 5-min talk | Strong schema/fallback stories | Must not ignore native limits |
| Doing both cold | Ego | Neither talk is crisp — pick one |
| Skip STAR | Fatigue | Lose behavioral signal |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | Days [08](day-08.md)–[12](day-12.md) flashcards (skim) | Active recall |
| Must | Chosen track doc: [networking-layer.md](../../../ios-system-design/docs/networking-layer.md) **or** [sdui-engine.md](../../../ios-system-design/docs/sdui-engine.md) | 5-min spine |
| Must | [answer-timing-guide.md](../../timing/answer-timing-guide.md) | Score mock |
| Deepen | [payment-checkout.md](../../../ios-system-design/docs/payment-checkout.md) · [search-autocomplete.md](../../../ios-system-design/docs/search-autocomplete.md) | Week 2 parallel SD |
| Repo | Story bank S1, S3, S4, S6, S9, S10, S12, S13 | Mock STAR pool |

## 4. Map to your work

Pick **one** primary mock story set:

| Track | Core stories | Supporting |
|---|---|---|
| **Ads** | [S1](../../stories/story-bank.md)#s1--ads-module-refactor--herowidget-bookmyshow · [S4](../../stories/story-bank.md)#s4--ssl-pinning--alamofire--urlsession-bookmyshow | S5 perf, S8 scale |
| **SDUI** | [S3](../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow · [S12](../../stories/story-bank.md)#s12--audio-streaming--server-driven-splash-raw--las-vegas-aces | S8 fail-soft culture |

**Always available spice:** District [S9](../../stories/story-bank.md)#s9--free-parking--cleanmvvm--ai-tooling-district (architecture migration + AI judgment) · [S6](../../stories/story-bank.md)#s6--le-bottom-sheet-bookmyshow (product UI) · [S10](../../stories/story-bank.md)#s10--stories-sdk-raw--miami-heat / [S13](../../stories/story-bank.md)#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies (modular/hybrid)

**Interview line (≤20s) — Ads:** “I’ll walk a revenue Ads architecture — POP/generics, HeroWidget lifecycle, and URLSession pinning.”  
**Interview line (≤20s) — SDUI:** “I’ll walk a fail-soft SDUI pipeline — schema versioning, registry, and BMS/Aces production usage.”

## 5. Normal questions

Revision set — answer out loud within budget. Skeletons are pointers back to day depth.

### Q1. MVVM vs Clean — when Clean? `(45s)`
**Skeleton:** Domain/shared rules/migration → UseCases; else MVVM. District incremental.  
**Follow-up:** AI envelope? → S9.  
**Story:** S9 · Day 08.

### Q2. Search debounce + cancel ownership? `(45s)`
**Skeleton:** VM debounce; cancel Task; don’t treat cancel as error.  
**Follow-up:** Out-of-order responses.  
**Story:** S3 · Day 08/09.

### Q3. Single-flight token refresh? `(60s)`
**Skeleton:** One refresh Task; waiters; retry once; fail → logout.  
**Follow-up:** Non-idempotent POST.  
**Story:** Day 09.

### Q4. SSL pinning failure mode? `(45–60s)`
**Skeleton:** MITM↓; bad rotation → outage; backup pins + runbook.  
**Follow-up:** Ads migration why URLSession.  
**Story:** S4.

### Q5. Unknown SDUI component policy? `(30–45s)`
**Skeleton:** Skip + metric; never crash; empty root → hard fallback.  
**Follow-up:** Version major mismatch.  
**Story:** S3 · Day 10.

### Q6. SDUI vs WebView? `(45s)`
**Skeleton:** Native registry, a11y, perf, allowlisted actions.  
**Follow-up:** When WebView OK.  
**Story:** Day 10 T1.

### Q7. Where pause ad / story video? `(30–45s)`
**Skeleton:** Disappear / offscreen / background; protocolised.  
**Follow-up:** Cell reuse.  
**Story:** S1 · S10 · Day 11/12.

### Q8. Hybrid deeplink ownership? `(60s)`
**Skeleton:** App-edge parse → intent → single router; no dual stacks.  
**Follow-up:** Cold start queue.  
**Story:** S13 · Day 11.

### Q9. SwiftUI identity footgun? `(45s)`
**Skeleton:** Unstable `.id` resets state; UUID in body bad.  
**Follow-up:** Stories page IDs.  
**Story:** S10 · Day 12.

### Q10. LE Bottom Sheet impact? `(30–45s)`
**Skeleton:** Lightweight overview; **30%+** fewer full-screen navs; cross-functional contracts.  
**Follow-up:** Sheet vs push.  
**Story:** S6.

### Q11. Array as queue issue? `(30s)`
**Skeleton:** `removeFirst` O(n); use deque/two-stack.  
**Follow-up:** Day 13.  
**Story:** —

### Q12. District AI tooling — senior framing? `(45–60s)`
**Skeleton:** Context Engineering inside protocols + review + tests; you own architecture.  
**Follow-up:** What AI got wrong.  
**Story:** S9.

## 6. Tricky questions

### T1. “5 minutes — design our Ads rendering system.” `(5 min talk)`
**Trap:** Dive into cell code; skip lifecycle/security.  
**Senior answer:** Use Track A outline; end with trade-offs + metrics/revenue.  
**Follow-up:** Pin rotation incident? · POP vs inheritance?

### T2. “5 minutes — design SDUI for our home header.” `(5 min talk)`
**Trap:** Ignore versioning/fallback.  
**Senior answer:** Track B outline; cite BMS; unknown skip; cache; action allowlist.  
**Follow-up:** Breaking schema at 30L DAU?

### T3. “Refresh stampede + pinning outage same week — how do you lead?” `(120s)`
**Trap:** Only technical rabbit hole.  
**Senior answer:** IMOC-style: blast radius, feature guards, rollback/break-glass, owners, comms; then technical fixes (single-flight, pin backup). Metrics: crash-free / TLS failure rate.  
**Follow-up:** S8 + S4.

### T4. “Why not SDUI the Ads video player?” `(90–120s)`
**Trap:** SDUI religion.  
**Senior answer:** Revenue media needs typed native lifecycle (S1); SDUI for configuration/placement; native renderer.  
**Follow-up:** Bridge Mock tracks A/B.

### T5. “SwiftUI Stories SDK in a UIKit-heavy host.” `(90–120s)`
**Skeleton:** HostingController façade; injectable deps; deeplink exits via host router; identity stable.  
**Follow-up:** S10 + S13.

### T6. “Debounce in repository vs VM — argue both sides, then pick.” `(90s)`
**Trap:** No decision.  
**Senior answer:** Presentation policy → VM; repository may cancel; pick VM for BMS search.  
**Follow-up:** Day 08 T2.

### T7. “Mock feedback: you ran 8 minutes on architecture.” `(60s)`
**Trap:** Defensiveness.  
**Senior answer:** Cut examples; agenda first; timeboxes per section; practice with timer. Timing guide.  
**Follow-up:** Re-record 5:00 hard stop.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Week 2 one-liner | Layers→network→SDUI→UI identity · Trap: isolated facts · Prod: narrative |
| Ads 5-min agenda | POP·lifecycle·URLSession pin · Trap: no agenda · Prod: S1/S4 |
| SDUI 5-min agenda | Schema·registry·fallback·prod · Trap: skip fail-soft · Prod: S3/S12 |
| Refresh stampede | Single-flight · Trap: N refreshes · Prod: Day 09 |
| Pin outage | Rotation/runbook · Trap: pinning only · Prod: S4 |
| Unknown SDUI node | Skip+metric · Trap: crash · Prod: crash-free |
| Dual nav stacks | One owner · Trap: sync forever · Prod: S13 |
| UUID in body | Resets state · Trap: SwiftUI bug · Prod: Day 12 |
| Sheet metric | 30%+ fewer pushes · Trap: vague UX · Prod: S6 |
| AI seniority | Envelope+review · Trap: AI wrote app · Prod: S9 |
| Search cancel | Task cancel silent · Trap: error toast · Prod: S3 |
| HeroWidget | Pause on invisible · Trap: play forever · Prod: S1 |
| Stories SDK | Public API+inject · Trap: host coupled · Prod: S10 |
| Queue pitfall | removeFirst O(n) · Trap: ignore · Prod: Day 13 |
| Mock discipline | Timer + retro gotchas · Trap: skip retro · Prod: growth |

## 8. Practice

- **Coding / SD:**  
  - **Required:** One full **5:00** architecture recording (Ads **or** SDUI).  
  - **Optional:** 20 min skim of the *other* track’s doc bullets (familiarity only).  
  - Light DSA: 1 stack + 1 linked-list Easy/Medium from [dsa-track.md](../../coding/dsa-track.md) if energy remains.
- **Complexity / agenda to say first:** Always open architecture with agenda + scope; invite questions at end.
- **Peer option:** Swap 5-min talks; score each other with timing guide.

## 9. Timed drill

1. **Mock #2 full run** (60–90 min) per section 2.2 — record architecture block separately.
2. Score all answers against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas; tag `week-02`.
4. Checklist before Week 3:
   - [ ] 5-min Ads **or** SDUI talk hits <5:30
   - [ ] S1/S3/S4/S9 openers each ≤20s
   - [ ] Token refresh + unknown component answers clean
   - [ ] DSA: stack/queue/LL basics not blocking
5. Rest: Week 3 starts modularization / images / perf / crashes / security — don’t cram past sleep.
