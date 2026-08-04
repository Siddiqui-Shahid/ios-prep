# 01 — Foundations: Lifecycle, Cells, Hybrid — Mental Model

> Intern → mid. Read before deep dive.

## 1. Plain-English mental model

UIKit screens are **objects with a lifetime**. If you start a video in `viewDidLoad` and never pause, it plays in the graveyard behind another tab. If you bind an image in a cell and ignore reuse, yesterday’s poster smiles on today’s movie.

**Hybrid UI** means SwiftUI and UIKit share one product. Each side has rules; bolting `UIHostingController` without ownership is how deeplinks double-present and state resets.

Restaurant metaphor:

| Metaphor | UIKit idea |
|---|---|
| Open restaurant | `viewDidLoad` — one-time setup |
| Seat guests | `viewWillAppear` / `viewDidAppear` |
| Clear table between guests | `prepareForReuse` |
| Call ahead for ingredients | Prefetch |
| Two kitchens, one ticket system | Hybrid + single router |

## 2. Glossary

| Term | Meaning |
|---|---|
| **UIViewController lifecycle** | Callbacks from load → appear → layout → disappear → deinit |
| **viewIsAppearing** | iOS 17+ appear-phase hook |
| **Cell reuse** | Table/collection recycles views for different indexPaths |
| **prepareForReuse** | Reset UI + cancel async before new bind |
| **Diffable Data Source** | Identity-based list updates / animated diffs |
| **Prefetching** | Warm data/images for near-viewport paths |
| **UIHostingController** | Embed SwiftUI in UIKit |
| **UIViewControllerRepresentable** | Embed UIKit VC in SwiftUI |
| **UIViewRepresentable** | Embed UIKit view in SwiftUI |
| **Coordinator** | Glue for delegates inside representables |
| **Structural vs explicit identity** | How SwiftUI decides “same view” (Day 12 deepens) |
| **Deeplink intent** | Typed navigation request from URL |
| **Bottom sheet** | Modal lightweight surface; preserves context |
| **Detents** | Sheet heights (medium/large/custom) |
| **Visibility threshold** | How much of an ad must show to play |

## 3. Lifecycle order (say aloud)

`init` → `loadView` → `viewDidLoad` → `viewWillAppear` → `viewIsAppearing` (iOS 17+) → `viewDidAppear` → layout callbacks → `viewWillDisappear` → `viewDidDisappear` → `deinit`

| Hook | Put here | Avoid |
|---|---|---|
| `viewDidLoad` | One-time setup, bindings | Assuming final bounds; repeat network forever |
| `viewWillAppear` | Refresh on-screen state | Heavy sync I/O |
| `viewDidAppear` | Analytics “seen”; start players | Assuming visible forever |
| `viewWillDisappear` | Pause video; cancel tasks | Forgetting ads pause |
| `deinit` | Prove no retain cycle | Relying on it for critical cleanup |

**Ads link (S1):** HeroWidget pause/play tied to visibility / VC lifecycle — lifecycle is part of the revenue contract.

## 4. Cells — intern path

1. `cellForItem` dequeues recycled cell.
2. Bind model for indexPath; start image task with ID token.
3. User scrolls; cell goes to reuse pool.
4. `prepareForReuse` cancels task, clears image, clears handlers.
5. Rebound for new model — no stale poster.

**Wrong image bug:** Async completion after reuse assigns old image unless you check ID / cancel.

## 5. Prefetch — intern path

System hints upcoming indexPaths → start warm fetches → cancel when `cancelPrefetchingForItemsAt` fires. Bound concurrency. Not unlimited download.

## 6. Hybrid — intern path

| Direction | API |
|---|---|
| SwiftUI in UIKit | `UIHostingController` as child VC |
| UIKit in SwiftUI | Representable + Coordinator |

**One navigation owner.** Deeplinks write to that owner only (S13).

## 7. LE Bottom Sheet — product picture (S6)

Lightweight event overview sheet reduced **full-screen navigations for 30%+ of user flows**. Prefer sheet when overview depth is shallow; push when hierarchy is deep. Cross-functional API/content contracts with PM/Design/Backend.

## 8. Production anchors

- **S13 Grizzlies:** Hybrid architecture; deeplinks; Mixpanel; Airship — interop designed, not bolted.
- **S6 BMS:** LE Bottom Sheet; **30%+** nav reduction metric from resume.
- **S1:** Ads video lifecycle.

## 9. Self-check

1. Appear vs load distinction  
2. prepareForReuse duties  
3. Prefetch cancel  
4. Why dual nav stacks fail  
5. Sheet vs push product rule + 30%+

## 10. Flash preview

| Front | Back |
|---|---|
| Pause video | willDisappear / offscreen |
| Reuse | prepareForReuse reset |
| Prefetch | Warm + cancel + budget |
| SwiftUI⊂UIKit | UIHostingController |
| UIKit⊂SwiftUI | Representable |
| S6 | 30%+ fewer full-screen navs |
| S13 | Hybrid + deeplink owner |


## 11. Appearance vs load — tab example

```text
User opens Tab A  → load + didLoad + appear
User switches B   → A disappear; B load (first time) + appear
User back to A    → A appear ONLY (didLoad does not rerun)
```

If Tab A fetched only in `viewDidLoad`, data is stale forever. Throttle refresh on appear (e.g. if older than N seconds).

## 12. Cell bind sequence (memorize)

```text
dequeue → prepareForReuse (previous owner cleanup)
       → configure(model)
       → start async with token
       → on complete: if token matches → apply
```

Never configure without a reuse reset path.

## 13. Hybrid containment checklist (UIHostingController)

1. `addChild(hosting)`  
2. Add `hosting.view` constraints  
3. `hosting.didMove(toParent: self)`  
4. Forward appearance if needed for nested players  
5. On remove: `willMove`, remove view, `removeFromParent`  

Skipping containment breaks rotation, safe area, and appearance forwarding.

## 14. Sheet product heuristics

| Signal | Lean sheet | Lean push |
|---|---|---|
| Depth | 1–2 actions | Multi-step wizard |
| Context | Keep list underneath | Replace context |
| Frequency | High overview taps | Rare deep tools |
| Metric story | S6 30%+ | — |

## 15. 90-second teaching script

> “UIKit lifecycle separates one-time load from every-show appear work — pause and cancel on disappear. Cells must reset and cancel in prepareForReuse; prefetch must cancel and bound concurrency. Hybrid UI needs one navigation owner for deeplinks and push taps. On Grizzlies I designed SwiftUI↔UIKit interop that way; on BookMyShow the LE Bottom Sheet cut full-screen navigations for 30%+ of flows.”
