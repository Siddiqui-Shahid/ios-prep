# 04 — Questions (two-layer answers)

> Study flow: cover the full spoken answer → speak from **Answer points** only → uncover and compare timing.  
> Totals: **12 normal + 8 tricky = 20**.

---

## Normal questions

### Q1. Walk UIViewController appearance lifecycle. `(30–45s)`

**Answer points (frame first):**
- load → will/did appear → layout → will/did disappear
- Appear for refresh
- Disappear for pause/cancel
- didLoad one-time

**Agenda opener:** “I’d separate one-time setup from every-show work…”

**Full spoken answer:**
> “After load and viewDidLoad for one-time setup, viewWillAppear and viewDidAppear run each time the screen shows — that’s where I refresh on-screen state and start players. On the way out, viewWillDisappear and viewDidDisappear are where I pause video and cancel tasks. Layout callbacks handle bounds. Relying on deinit for critical pause is too late.”

**Common wrong answer:** Put all networking only in viewDidLoad forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Tabs? | Load once, appear many — refresh on appear. |
| L2 | viewIsAppearing? | iOS 17+ appear-phase hook. |
| L3 | Ads? | Pause on disappear — S1. |

**Provenance:** Verified · S1 lifecycle sibling

---
### Q2. Why does cell reuse show wrong images? `(45s)`

**Answer points (frame first):**
- Async completes after reuse
- Fix: tokens/IDs
- Cancel in prepareForReuse
- Check identity before assign

**Agenda opener:** “I’d blame stale async, not UIImage…”

**Full spoken answer:**
> “Cells are recycled. If an image download for movie A finishes after the cell was reused for movie B, you’ll assign the wrong poster unless you cancel on prepareForReuse and check a generation token or model ID before applying. Clearing handlers matters too so closures don’t retain the wrong context.”

**Common wrong answer:** “UIKit is buggy; call reloadData always.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Prefetch? | Cancel prefetch when leaving paths. |
| L2 | Diffable? | Stable IDs help updates; still cancel loads. |
| L3 | Library? | Still need reuse hygiene. |

**Provenance:** Learning-lab · CellReuseGuard

---
### Q3. Diffable data source benefit? `(30–45s)`

**Answer points (frame first):**
- Identity-based updates
- Animated diffs
- Fewer reloadData footguns
- Need stable IDs

**Agenda opener:** “I’d center identity…”

**Full spoken answer:**
> “Diffable data sources update lists by identity instead of blanket reloadData, which reduces flicker and makes animated diffs practical. You still need stable Hashable identifiers — unstable hashes cause flicker and weird moves.”

**Common wrong answer:** “Diffable fixes all performance problems.”

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Hashable pitfall? | Unstable hashes → chaos. |
| L2 | Equatable noise? | Avoid changing IDs on every refresh. |
| L3 | SwiftUI ForEach? | Same stable-ID lesson Day 12. |

**Provenance:** Learning-lab · lists

---
### Q4. How does prefetching work? `(45–60s)`

**Answer points (frame first):**
- System hints upcoming indexPaths
- Warm fetches
- Cancel when not needed
- Bound concurrency

**Agenda opener:** “I’d pair warm with cancel and budget…”

**Full spoken answer:**
> “UICollectionView prefetching tells you indexPaths likely to appear soon so you can warm images or data. You must implement cancelPrefetching for paths that scroll away, and bound concurrency so prefetch doesn’t become an unbounded downloader — especially on cellular.”

**Common wrong answer:** Prefetch everything at once.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Data or images? | Often both via repository. |
| L2 | Low Data Mode? | Reduce aggressiveness. |
| L3 | Day 09? | Same cancellation mindset. |

**Provenance:** Learning-lab · PrefetchBudget

---
### Q5. Embed SwiftUI in a UIKit app? `(45–60s)`

**Answer points (frame first):**
- UIHostingController
- Correct child containment
- Pass observable state
- Size with constraints/intrinsic

**Agenda opener:** “I’d treat hosting as a real child VC…”

**Full spoken answer:**
> “I embed SwiftUI with UIHostingController, add it as a proper child view controller, pass state through an observable model, and constrain sizing carefully — including safe-area quirks. I avoid recreating the hosting controller on every tiny state change. That’s the hosting half of the Grizzlies hybrid approach.”

**Common wrong answer:** frame = bounds hacks only.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Safe area? | Test notched devices; hosting insets quirks. |
| L2 | Pause media? | Parent disappear → pause. |
| L3 | S13? | Designed interop, not bolt-on. |

**Provenance:** Verified · S13 · hosting

---
### Q6. Embed UIKit in SwiftUI? `(45–60s)`

**Answer points (frame first):**
- Representable
- Coordinator for delegates
- update for props
- Stable identity

**Agenda opener:** “I’d emphasize make-once, update-props…”

**Full spoken answer:**
> “I wrap UIKit in UIViewControllerRepresentable or UIViewRepresentable, use a Coordinator for delegates, apply prop changes in update, and keep identity stable so SwiftUI doesn’t remake the controller every render. Recreate only when you truly need a fresh instance.”

**Common wrong answer:** New UUID id every body call.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | update spam? | Reduce state churn — Day 12. |
| L2 | Navigation? | Don’t spawn second stack. |
| L3 | S13? | Interop costs designed. |

**Provenance:** Verified · S13 · representable

---
### Q7. Deeplink into hybrid nav stack — approach? `(60–90s)`

**Answer points (frame first):**
- Parse at app edge
- Typed Intent
- Single router
- Defer until root ready
- Avoid double-present

**Agenda opener:** “I’d insist on one navigation owner…”

**Full spoken answer:**
> “I parse the URL at the app edge into a typed Intent, then a single router builds or pushes the correct UIKit or SwiftUI host. On cold start I queue until the root is ready. Push notification taps use the same router so Airship doesn’t invent a parallel navigation path. Dual stacks fighting deeplinks is the classic hybrid failure.”

**Common wrong answer:** Each SDK opens its own screen.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Auth gate? | Router decides. |
| L2 | Analytics? | Don’t double-count presents. |
| L3 | S13? | Deeplink + lifecycle owned. |

**Provenance:** Verified · S13 · deeplinks

---
### Q8. Bottom sheet vs push — decision? `(45s)`

**Answer points (frame first):**
- Sheet for glanceable overview
- Push for deep hierarchy
- LE cut 30%+ full-screen navs
- Keep context

**Agenda opener:** “I’d decide by depth and context…”

**Full spoken answer:**
> “Use a sheet when the user needs a glanceable overview and should keep underlying context; push when the flow is a deep hierarchy that needs history. The LE Bottom Sheet on BookMyShow reduced full-screen navigations for 30%+ of user flows by making event overview lightweight.”

**Common wrong answer:** Always push for consistency.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Detents/a11y? | Design detents; VoiceOver focus. |
| L2 | Why not tab? | Tabs change IA; sheet fixes local friction. |
| L3 | Metric? | 30%+ from resume — don’t invent more. |

**Provenance:** Verified · S6 · 30%+ nav

---
### Q9. Where do you pause ad video? `(45s)`

**Answer points (frame first):**
- Disappear
- Out of viewport
- App background
- Resume on visible
- Protocolised HeroWidget

**Agenda opener:** “I’d make pause part of the contract…”

**Full spoken answer:**
> “Pause when the screen disappears, when the ad scrolls below a visibility threshold, and on app background. Resume only when visibly eligible. On BookMyShow Ads we protocolised HeroWidget pause/play with lifecycle — wasted playback is a product bug on a revenue module.”

**Common wrong answer:** Pause only in deinit.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Half visible? | Define threshold policy. |
| L2 | Audio session? | Coordinate with other players. |
| L3 | Cells? | Reuse must stop playback. |

**Provenance:** Verified · S1 · HeroWidget

---
### Q10. Retain cycle via closure in cell? `(45s)`

**Answer points (frame first):**
- Cell → closure → VC → collection → cell
- [weak self]
- Clear actions in prepareForReuse

**Agenda opener:** “I’d break the ring at capture lists…”

**Full spoken answer:**
> “A cell holding a strong closure to its view controller which owns the collection view creates a cycle. Capture [weak self], and clear handlers in prepareForReuse so recycled cells don’t keep old VC references. That’s leak hygiene under scroll pressure.”

**Common wrong answer:** Ignore — ARC always saves you.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Instruments? | Leaks / graph. |
| L2 | Combine? | Store cancellables carefully. |
| L3 | S8? | Crash-free includes leak discipline. |

**Provenance:** Learning-lab · S8 hygiene

---
### Q11. Mixpanel + Airship with UI lifecycle? `(45–60s)`

**Answer points (frame first):**
- Screen events on appear/disappear
- Push taps → same deeplink router
- Don’t double-count
- Consent gate SDK init

**Agenda opener:** “I’d unify engagement with navigation…”

**Full spoken answer:**
> “Fire screen analytics from appear/disappear with hybrid hosts in mind so you don’t double-count. Route Airship push taps through the same deeplink router as universal links. Gate SDK initialization on privacy consent. Lifecycle and growth tooling share one navigation story — that was part of the Grizzlies work.”

**Common wrong answer:** Let each SDK present UI itself.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Background fetch? | Separate from screen viewed. |
| L2 | Deep link collision? | Inbox queue until ready. |
| L3 | S13? | Mixpanel + Airship verified. |

**Provenance:** Verified · S13 · analytics/push

---
### Q12. Self-sizing collection jank causes? `(45–60s)`

**Answer points (frame first):**
- Ambiguous constraints
- Bad estimated sizes
- Image height post-bind
- Heavy main work
- Fix estimates/prefetch/stable heights

**Agenda opener:** “I’d profile layout, not guess…”

**Full spoken answer:**
> “Self-sizing jank usually comes from ambiguous constraints, estimated sizes far from reality, images changing height after bind, or heavy work on the main thread during bind. Fix estimates, prefetch images, stabilize heights when product allows, and keep cell bind cheap.”

**Common wrong answer:** Only ‘switch to SwiftUI List.’

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Instruments? | Time Profiler + Core Animation. |
| L2 | SwiftUI list? | Trade-offs Day 12. |
| L3 | Fixed height? | OK when design allows. |

**Provenance:** Learning-lab · performance

---

## Tricky questions

### T1. viewDidLoad isn’t called again — bug or feature? `(90s)`

**Answer points (frame first):**
- Feature when VC retained
- Refresh in appear
- Tab VCs load once
- Memory warning strategies separate

**Agenda opener:** “I’d call it a feature and relocate refresh…”

**Full spoken answer:**
> “It’s usually a feature — the view controller instance is retained in the stack or tab. One-time setup belongs in viewDidLoad; repeatable refresh belongs in appear hooks. Tab controllers especially load once and appear many times. If data looks stuck, your refresh policy is wrong, not UIKit.”

**Common wrong answer:** Force recreate VCs every time.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Memory warning? | Drop caches; recreate views if system dumped them. |
| L2 | Children? | Containment lifecycle forwarding. |
| L3 | SwiftUI? | onAppear analogous, identity caveats Day 12. |

**Provenance:** Learning-lab · lifecycle

---
### T2. HostingController messes Auto Layout height. `(90–120s)`

**Answer points (frame first):**
- Intrinsic bridging
- sizingOptions awareness
- Constrain edges carefully
- Nested scroll fights
- Sometimes UIKit layout authority wins

**Agenda opener:** “I’d own sizing deliberately…”

**Full spoken answer:**
> “Hosting height bugs usually mean intrinsic content size isn’t bridged cleanly. Constrain edges carefully, understand sizing options, and avoid nested scroll-view fights where both UIKit and SwiftUI think they own measurement. Sometimes giving UIKit layout authority for that island is the senior call. On Grizzlies-style hybrid, sizing is part of designing interop — not a weekend frame hack.”

**Common wrong answer:** Only set frame = bounds forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Scroll inside sheet? | One scroll owner. |
| L2 | Intrinsic zero? | Content not ready — placeholder height. |
| L3 | Recreate hosting? | Last resort; prefer updates. |

**Provenance:** Verified · S13 · hybrid sizing

---
### T3. Two sources of truth — NavigationPath and UINavigationController. `(120s)`

**Answer points (frame first):**
- Pick one root owner
- Bridge at edges
- Deeplinks write to owner only
- Hybrid fails when both mutate

**Agenda opener:** “I’d forbid dual writers…”

**Full spoken answer:**
> “Two sources of truth will diverge. Pick one root navigation owner — either UIKit nav or SwiftUI path — and bridge at the edges. Deeplinks and push taps write only to that owner. Hybrid apps fail when both stacks mutate independently, causing double presents and lost history. Grizzlies taught deliberate single-router ownership.”

**Common wrong answer:** Sync both every frame.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Migration period? | Strangler with one writer still. |
| L2 | Modals? | Presentation owned by same router policy. |
| L3 | State restoration? | Serialize owner’s stack only. |

**Provenance:** Verified · S13 · single router

---
### T4. Prefetch caused data usage complaints. `(90s)`

**Answer points (frame first):**
- Bound concurrency
- Low Data Mode
- Cancel aggressively
- Tune distance
- Wi-Fi vs cellular policy

**Agenda opener:** “I’d tune policy, not delete prefetch…”

**Full spoken answer:**
> “Prefetch isn’t bad — unbounded prefetch is. I’d bound concurrency, respect Low Data Mode, cancel aggressively, tune prefetch distance, and consider Wi-Fi versus cellular policy. Then revisit image quality tiers. Prefetch should feel invisible, not like a background downloader.”

**Common wrong answer:** Disable all prefetch forever.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Metric? | Bytes/session; cancel rates. |
| L2 | User setting? | Data saver mode. |
| L3 | Week 3? | Image pipeline quality tiers. |

**Provenance:** Learning-lab · budget

---
### T5. Why not make LE overview a new tab? `(90s)`

**Answer points (frame first):**
- Product: reduce steps in existing flows
- Sheet preserves context
- 30%+ metric
- Tabs change IA

**Agenda opener:** “I’d answer as product + engineering…”

**Full spoken answer:**
> “A new tab changes information architecture for everyone. The LE problem was local friction — users took full-screen navigations for a shallow overview too often. A sheet preserves context and cuts steps in existing flows. We measured impact as 30%+ fewer full-screen navigations. That’s a product-minded UI change with cross-functional contracts, not a nav redesign for its own sake.”

**Common wrong answer:** Engineering-only ‘sheets are cool.’

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Contracts? | PM/Design/Backend API alignment — S6. |
| L2 | When tab wins? | Primary destination users return to constantly. |
| L3 | Deep flow? | Don’t force wizards into sheets. |

**Provenance:** Verified · S6 · product UI

---
### T6. Representable update called too often — perf? `(90–120s)`

**Answer points (frame first):**
- Reduce state churn
- Equatable inputs
- Avoid recreating VC
- Heavy work out of update
- Identity stability

**Agenda opener:** “I’d connect SwiftUI invalidation to UIKit cost…”

**Full spoken answer:**
> “Representable update spam means the SwiftUI parent is invalidating too broadly. Reduce observed state, prefer Equatable inputs where measured useful, keep identity stable so you update instead of remake, and move heavy work out of update. This is the same identity/performance story Day 12 deepens — hybrid makes it visible because UIKit recreate is expensive.”

**Common wrong answer:** Ignore — SwiftUI always calls update.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Players restart? | Identity churn — stabilize. |
| L2 | Logging? | Count make vs update in DEBUG. |
| L3 | S13? | Interop perf is design. |

**Provenance:** S13 + Day 12 bridge

---
### T7. Cell starts URLSession that finishes after scroll away. `(90s)`

**Answer points (frame first):**
- Cancel on reuse/disappear
- Correlate request ID with model ID
- Optional repository coalescing
- Same as search cancel

**Agenda opener:** “I’d cancel at the cell and validate on apply…”

**Full spoken answer:**
> “Cancel the task in prepareForReuse and when the screen disappears. Correlate the request with a model ID or generation token before assigning results. Repository-level coalescing can help but doesn’t replace reuse hygiene. It’s the same race pattern as cancelling in-flight search — stale work must not win.”

**Common wrong answer:** Only blame the image library.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Day 09? | Cancellation participates in Task. |
| L2 | Prefetch? | Cancel paths too. |
| L3 | Error UI? | Don’t flash errors for cancelled. |

**Provenance:** Learning-lab · cancel + S3 sibling pattern

---
### T8. How do push + universal links share one router without races? `(90s)`

**Answer points (frame first):**
- Typed intents
- Inbox until ready
- Deduplicate identical intents
- Single owner presents

**Agenda opener:** “I’d queue and dedupe…”

**Full spoken answer:**
> “Both Airship taps and universal links become typed intents into one inbox. Until the root is ready, intents queue. I’d dedupe identical intents in a short window to avoid double present if both systems fire. Only the router presents. That keeps Mixpanel screen events aligned with what users actually saw.”

**Common wrong answer:** Present immediately from each callback.

**Follow-up ladder:**
| Level | Ask | Point + short answer |
|---|---|---|
| L1 | Foreground vs cold? | Same intent; different ready timing. |
| L2 | Auth? | Router holds pending post-login. |
| L3 | S13? | Push + deeplink one story. |

**Provenance:** Verified · S13 · engagement nav

---
