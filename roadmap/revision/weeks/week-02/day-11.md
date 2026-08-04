# Day 11 — UIKit Lifecycle, Cells, Prefetch · Hybrid UIKit ↔ SwiftUI

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- UIViewController **lifecycle** landmarks and where to start/stop work (incl. video/ads pause-play)
- `UITableView`/`UICollectionView` **cell reuse**, self-sizing pitfalls, and **prefetch**
- How to host **SwiftUI in UIKit** and **UIKit in SwiftUI** without identity/lifecycle bugs
- How Grizzlies hybrid UI + deeplinks and BMS **LE Bottom Sheet** (30%+ nav reduction) show product-minded UI engineering

## 2. Concept deep dive

### 2.1 UIViewController lifecycle (say in order)

`init` → `loadView` → `viewDidLoad` → `viewWillAppear` → `viewIsAppearing` (iOS 17+) → `viewDidAppear` → `viewWillLayoutSubviews` / `viewDidLayoutSubviews` → `viewWillDisappear` → `viewDidDisappear` → `deinit`

| Hook | Put here | Avoid |
|---|---|---|
| `viewDidLoad` | One-time setup, bindings | Assuming final bounds |
| `viewWillAppear` | Refresh on-screen state | Heavy sync I/O |
| `viewDidAppear` | Analytics “seen”, start players | Assuming still visible forever |
| `viewWillDisappear` | Pause video, cancel tasks | Forgetting Ads HeroWidget pause |
| `deinit` | Prove no retain cycle | Relying on it for critical cleanup |

**Ads link:** HeroWidget pause/play tied to visibility / VC lifecycle (S1) — lifecycle is part of the revenue contract.

### 2.2 Cells & reuse

- Always reset cell state in `prepareForReuse` (images, gestures, selections).
- Prefer Diffable Data Source for identity correctness.
- Self-sizing: stable Autolayout constraints; avoid multi-pass thrash.
- Don’t start unconstrained network in `cellForItem` without cancel on reuse.

### 2.3 Prefetching

`UICollectionViewDataSourcePrefetching`: warm images/data for near-viewport indexPaths; cancel on `cancelPrefetchingForItemsAt`. Couple with image pipeline (Week 3) and networking cancellation (Day 09).

**Trap:** Prefetch = unlimited download. Budget concurrent fetches.

### 2.4 Hybrid UIKit ↔ SwiftUI

| Direction | API | Watch-outs |
|---|---|---|
| SwiftUI in UIKit | `UIHostingController` | Sizing, `additionalSafeAreaInsets`, parent VC lifecycle |
| UIKit in SwiftUI | `UIViewControllerRepresentable` / `UIViewRepresentable` | `make` vs `update`; coordinator; identity stability |
| Navigation | One “source of truth” | Dual stacks fight deeplinks |

**Grizzlies:** Architected key UI with SwiftUI+UIKit interop; deeplinks + Mixpanel + Airship — interop costs (identity, lifecycle, hosting) designed, not bolted.

### 2.5 LE Bottom Sheet (product UI)

Reusable lightweight event-overview sheet reduced **full-screen navigations for 30%+ of user flows**. Cross-functional API/content contracts with PM/Design/Backend. Prefer sheet over push when overview depth is shallow.

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| Pure UIKit | Mature codebase, fine control | Slower feature UI |
| Pure SwiftUI | New features, lists, forms | Interop/legacy gaps |
| Hybrid | Real production NBA apps | Lifecycle/identity complexity |
| Bottom sheet | Shallow overview | Not for deep multi-step flows |
| Full-screen push | Deep hierarchy | Nav fatigue (S6 problem) |
| Prefetch aggressive | Image-heavy feeds | Data/battery burn |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [UIViewController](https://developer.apple.com/documentation/uikit/uiviewcontroller) | Lifecycle source of truth |
| Must | [UIViewControllerRepresentable](https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable) | Hybrid hosting |
| Deepen | WWDC: demystify SwiftUI identity; UIKit interop sessions | Identity bugs |
| Repo | [deep-linking-universal-links.md](../../../ios-system-design/docs/deep-linking-universal-links.md) | Grizzlies deeplink context |
| Repo | S6 · S13 · S1 in [story-bank.md](../../stories/story-bank.md) | Sheet, hybrid, ads lifecycle |

## 4. Map to your work

**Company / feature:** Raw / Memphis Grizzlies — SwiftUI↔UIKit + deeplinks + Mixpanel/Airship  
**What you did:** Hybrid UI architecture; deep linking with navigation/lifecycle handling; analytics + push integrations.  
**Interview line (≤20s):** “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.”

→ Full STAR: [stories/story-bank.md](../../stories/story-bank.md)#s13--swiftuiuikit--deeplinks--analyticspush-raw--memphis-grizzlies

**Secondary — BMS LE Bottom Sheet:** End-to-end lightweight event overview → **30%+** fewer full-screen navs.  
→ [stories/story-bank.md](../../stories/story-bank.md)#s6--le-bottom-sheet-bookmyshow

**Tertiary — Ads HeroWidget lifecycle:** pause/play with visibility (S1).

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. Walk UIViewController appearance lifecycle. `(30–45s)`
**Skeleton:** load → will/did appear → layout → will/did disappear; use appear for refresh, disappear for pause/cancel.  
**Follow-up:** `viewDidLoad` vs appear? → One-time vs every show.  
**Story:** S1 video pause.

### Q2. Why does cell reuse show wrong images? `(45s)`
**Skeleton:** Async image completes after reuse; fix with tokens/IDs in `prepareForReuse`, cancel tasks, check identity before assign.  
**Follow-up:** Prefetch interaction? → Cancel prefetch on leave.  
**Story:** General; Ads cells caution.

### Q3. Diffable data source benefit? `(30–45s)`
**Skeleton:** Identity-based updates, animated diffs, fewer reloadData footguns. Still need stable IDs.  
**Follow-up:** Hashable pitfalls? → Unstable hashes → flicker.  
**Story:** List-heavy BMS surfaces.

### Q4. How does prefetching work? `(45–60s)`
**Skeleton:** System hints upcoming indexPaths; start warm fetches; cancel when not needed; bound concurrency.  
**Follow-up:** Prefetch data or only images? → Often both via repository.  
**Story:** Feed/list performance narrative.

### Q5. Embed SwiftUI in a UIKit app? `(45–60s)`
**Skeleton:** `UIHostingController`; child VC containment correctly; pass state via Observable; size with constraints/intrinsic.  
**Follow-up:** Safe area issues? → Hosting controller safeAreaInsets quirks.  
**Story:** S13.

### Q6. Embed UIKit in SwiftUI? `(45–60s)`
**Skeleton:** Representable; Coordinator for delegates; `updateUIViewController` for props; stable identity (`id`) to avoid recreate storms.  
**Follow-up:** When recreate is required? → Rare; prefer updates.  
**Story:** S13.

### Q7. Deeplink into hybrid nav stack — approach? `(60–90s)`
**Skeleton:** Parse URL at app edge → typed Intent → single router builds/pushes correct UIKit or SwiftUI host; defer until root ready; avoid double-present.  
**Follow-up:** Cold start deeplink? → Queue until main UI ready.  
**Story:** S13 + deeplink doc.

### Q8. Bottom sheet vs push — decision? `(45s)`
**Skeleton:** Sheet for glanceable overview; push for deep hierarchy/history. LE sheet cut 30%+ full-screen navs.  
**Follow-up:** Accessibility/detents? → Design detents; VoiceOver focus.  
**Story:** S6.

### Q9. Where do you pause ad video? `(45s)`
**Skeleton:** On disappear / out of viewport / app background; resume on visible. Protocolised HeroWidget behavior.  
**Follow-up:** Cell scrolled half off? → Visibility threshold policy.  
**Story:** S1.

### Q10. Retain cycle via closure in cell? `(45s)`
**Skeleton:** Cell → closure → VC → collection → cell. Use `[weak self]`, clear actions in `prepareForReuse`.  
**Follow-up:** Instruments? → Leaks (Day 03 recall).  
**Story:** Crash-free hygiene S8.

### Q11. Mixpanel + Airship with UI lifecycle? `(45–60s)`
**Skeleton:** Screen events on appear/disappear; push notification taps route via same deeplink router; don’t double-count.  
**Follow-up:** Privacy consent? → Gate SDK init.  
**Story:** S13.

### Q12. Self-sizing collection jank causes? `(45–60s)`
**Skeleton:** Ambiguous constraints, estimated size far from real, image height changes post-bind, heavy work on main. Fix estimates, prefetch images, stable heights when possible.  
**Follow-up:** Prefer SwiftUI list? → Trade-offs Day 12.  
**Story:** Hybrid judgment.

## 6. Tricky questions

### T1. “`viewDidLoad` isn’t called again — bug or feature?” `(90s)`
**Trap:** Misunderstanding reuse of VC instances.  
**Senior answer:** Feature — VC retained in stack. Put repeatable refresh in appear; one-time in didLoad. Tab VCs may load once and appear many times.  
**Follow-up:** Memory warning reload strategies.

### T2. “HostingController messes Auto Layout height.” `(90–120s)`
**Trap:** Only `frame = bounds` hacks.  
**Senior answer:** Intrinsic content size bridging, `sizingOptions`, constrain edges carefully, avoid nested scroll view fights; sometimes UIKit layout authority wins.  
**Follow-up:** S13 production war story style answer.

### T3. “Two sources of truth — NavigationPath and UINavigationController.” `(120s)`
**Trap:** Sync both every time.  
**Senior answer:** Pick one root owner; bridge at edges; deeplinks write to owner only. Hybrid apps fail when both stacks mutate independently.  
**Follow-up:** Grizzlies approach: single router.

### T4. “Prefetch caused data usage complaints.” `(90s)`
**Trap:** Prefetch bad.  
**Senior answer:** Bound concurrency, respect Low Data Mode, cancel aggressively, prefetch distance tuning, Wi-Fi vs cellular policy.  
**Follow-up:** Image pipeline quality tiers (Week 3).

### T5. “Why not make LE overview a new tab?” `(90s)`
**Trap:** Engineering-only answer.  
**Senior answer:** Product: reduce steps in existing flows; sheet preserves context. Metric: 30%+ fewer full-screen navs. Tabs change IA; sheet fixes local friction.  
**Follow-up:** Cross-functional contract story S6.

### T6. “Representable `update` called too often — perf?” `(90–120s)`
**Trap:** Ignore SwiftUI invalidation.  
**Senior answer:** Reduce state churn; Equatable inputs; avoid recreating VC; move heavy work out of update; identity stability.  
**Follow-up:** Tie to Day 12 SwiftUI identity.

### T7. “Cell starts URLSession that finishes after scroll away.” `(90s)`
**Trap:** Only image library blame.  
**Senior answer:** Cancel on reuse/disappear; correlate request ID with model ID; repository-level coalescing optional. Same pattern as search cancel.  
**Follow-up:** Day 09 cancellation.

## 7. Flashcards for today

| Front | Back |
|---|---|
| Pause video where | willDisappear / offscreen · Trap: only deinit · Prod: S1 HeroWidget |
| prepareForReuse | Reset async + UI · Trap: stale images · Prod: lists |
| Prefetch cancel | cancelPrefetching… · Trap: unbounded downloads · Prod: data budget |
| SwiftUI in UIKit | UIHostingController · Trap: sizing/safeArea · Prod: S13 |
| UIKit in SwiftUI | Representable + Coordinator · Trap: recreate storms · Prod: S13 |
| Deeplink owner | App-edge router → intent · Trap: dual stacks · Prod: S13 |
| Bottom sheet win | Context kept; fewer pushes · Trap: deep flows in sheet · Prod: S6 30%+ |
| Diffable benefit | Identity diffs · Trap: unstable IDs · Prod: fewer reload bugs |
| Appear vs load | Refresh vs once · Trap: network only in didLoad · Prod: tabs |
| Cell retain cycle | weak self + clear handlers · Trap: strong VC in cell · Prod: leaks |
| Airship tap path | Same deeplink router · Trap: parallel nav · Prod: S13 |
| Hybrid cost | Lifecycle + identity · Trap: bolt hosting · Prod: S13 lesson |
| Estimated size | Close to real · Trap: 1pt estimates · Prod: jank |
| LE metric | 30%+ fewer full-screen navs · Trap: vanity UI · Prod: resume |
| Visibility ads | Threshold policy · Trap: play always · Prod: S1 |

## 8. Practice

- **Coding / SD:** Sketch Grizzlies deeplink → router → UIKit host vs SwiftUI host sequence. Separately, outline LE Bottom Sheet presentation API (inputs, dismiss, analytics).
- **Complexity / agenda to say first:** “Lifecycle ownership first, then cells/prefetch, then hybrid identity, then product sheet metric.”
- **Hands-on (optional 30m):** In a scratch project, embed a representable and log `make`/`update` counts while typing — feel invalidation.

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q7, Q8, Q5 + T3, T5). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas (dual navigation + hosting sizing).
4. Deliver S6 and S13 STAR openers (20s each) + one full S6 in 2–3 min.
