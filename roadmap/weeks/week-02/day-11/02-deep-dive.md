# 02 — Deep Dive: Lifecycle, Reuse, Prefetch, Hybrid, Sheets

> Senior depth. Assumes [01-foundations.md](01-foundations.md). Self-contained.

## 1. Lifecycle ownership matrix

| Work | Best hook | Why |
|---|---|---|
| Add subviews / bind VM once | `viewDidLoad` | Runs once per load |
| Refresh scores / header | `viewWillAppear` | Every show (tabs!) |
| Screen analytics “viewed” | `viewDidAppear` | Actually visible |
| Start muted preview video | `viewDidAppear` + visibility | Don’t play offscreen |
| Pause ad / cancel search | `viewWillDisappear` | Leaving screen |
| Layout-dependent snap | `viewDidLayoutSubviews` | Bounds ready — carefully |
| Break retain proof | `deinit` logging in DEBUG | Not production cleanup |

### Tab bar trap

Tab view controllers often **load once** and **appear many times**. Network-only-in-`viewDidLoad` means stale data forever. Refresh policy belongs in appear (with caching/throttle).

### `viewDidLoad` isn’t called again — bug or feature?

**Feature** when the VC instance is retained in a nav stack. Put repeatable work in appear hooks.

## 2. Ads / video visibility (S1)

Revenue contract:

```text
visible enough → play
below threshold / disappear / background → pause
```

Implementation patterns:

- VC disappear hooks for full-screen players
- CollectionView visibility % for in-feed ads
- App background notifications as a third pause signal

**Interview line:** “Lifecycle isn’t plumbing — for HeroWidget it was part of the product contract.”

## 3. Cells & Diffable

### prepareForReuse checklist

See [code/CellReuseGuard.swift](code/CellReuseGuard.swift).

1. Cancel image / network tasks  
2. Clear image, text, highlighted state  
3. Nil out closures / targets that capture VC  
4. Reset swipe/gesture transient UI  
5. Invalidate display tokens / generation IDs  

### Wrong-image anatomy

```text
cell binds movie A → start download A
scroll → reuse for movie B → bind B → start download B
download A completes → sets image without ID check → wrong poster
```

Fix: store `expectedID` on cell; completion checks ID; cancel on reuse.

### Diffable benefits

- Identity-based updates; fewer `reloadData` footguns  
- Animated diffs when IDs stable  
- Still need **stable Hashable IDs** — unstable hashes → flicker/reorder chaos  

### Self-sizing jank causes

- Ambiguous Autolayout  
- Estimated size far from real  
- Image height changes after bind  
- Heavy main-thread work in bind  

Mitigations: better estimates, prefetch images, stable heights when product allows, avoid multi-pass thrash.

## 4. Prefetch budgets

See [code/PrefetchBudget.swift](code/PrefetchBudget.swift).

| Rule | Reason |
|---|---|
| Cancel on `cancelPrefetching…` | Don’t download off-screen forever |
| Bound concurrency | Protect network + battery |
| Respect Low Data Mode | Platform courtesy / App Store expectations |
| Tune distance | Aggressive ≠ better |
| Wi-Fi vs cellular policy | Product decision |

**Trap:** Prefetch = unlimited download → data usage complaints.

Couple with Day 09 cancellation and Week 3 image pipeline.

## 5. Hybrid UIKit ↔ SwiftUI

See [code/HybridHostingNotes.swift](code/HybridHostingNotes.swift).

### SwiftUI in UIKit (`UIHostingController`)

| Concern | Practice |
|---|---|
| Containment | Add as child VC correctly (`addChild`, `didMove`) |
| Sizing | Constraints / intrinsic / `sizingOptions` awareness |
| Safe area | Hosting safeArea quirks — test on notched devices |
| Lifecycle | Parent appear/disappear should inform pause policies |
| State | Pass observable models; don’t rebuild hosting VC every bind |

### UIKit in SwiftUI (Representable)

| Concern | Practice |
|---|---|
| `make` vs `update` | Create once; update props |
| Coordinator | Delegates / target-action |
| Identity stability | Avoid parent `.id` churn → remake storms |
| Navigation | Don’t let representable own a second stack blindly |

### Dual navigation anti-pattern

```text
NavigationPath  ←→  UINavigationController
     ↑                     ↑
   deeplink A           deeplink B
```

Both mutate → double present, lost back stack, analytics double-count. **Pick one root owner**; bridge at edges. Grizzlies lesson: design interop + deeplink ownership deliberately (S13).

## 6. Deeplinks in hybrid apps

```text
URL → Parse at app edge → typed Intent → single Router
        → ensure root ready (cold start queue)
        → push/present UIKit host OR SwiftUI host
        → Airship/push taps use SAME router
```

| Rule | Why |
|---|---|
| One router | No parallel nav |
| Queue until ready | Cold start races |
| Same path for push taps | Mixpanel/Airship don’t invent second nav (S13) |
| Auth gates in router | Not deep in random VCs |

## 7. LE Bottom Sheet (S6) — engineering + product

### Decision

| Prefer sheet | Prefer push |
|---|---|
| Glanceable overview | Deep multi-step hierarchy |
| Keep underlying context | Need strong back-stack history |
| Reduce nav fatigue | Full-screen tools / checkout |

### Delivery notes

- Reusable component integrated in high-traffic flows  
- API/content contracts with PM/Design/Backend  
- Detents + VoiceOver focus matter  
- Metric you may claim: **30%+ of user flows** fewer full-screen navigations  

**Why not a new tab?** Tabs change IA; sheet fixes local friction in existing flows.

## 8. Analytics + push with lifecycle (S13)

- Screen events on appear/disappear — avoid double-count with hybrid hosts  
- Push notification taps → same deeplink router  
- Gate SDK init on privacy consent  
- Don’t fire “viewed” from `viewDidLoad` for tab VCs that aren’t visible  

## 9. Retain cycles — cells & closures

```text
VC → CollectionView → Cell → closure → VC
```

Use `[weak self]`; clear handlers in `prepareForReuse`. Instruments Leaks (Day 03 recall). Crash-free hygiene (S8) includes leak discipline under scroll pressure.

## 10. Representable `update` storms

Symptoms: `updateUIViewController` spam; jank; players restart.

Causes: parent state churn; non-Equatable inputs; identity resets; heavy work inside `update`.

Fixes: reduce observed state; stable identity; move heavy work out; Equatable inputs where measured useful (Day 12).

## 11. Trade-offs

| Choice | When | Cost |
|---|---|---|
| Pure UIKit | Mature fine control | Slower feature UI |
| Pure SwiftUI | New features | Legacy gaps |
| Hybrid | Real NBA apps | Lifecycle/identity complexity |
| Bottom sheet | Shallow overview | Not for deep flows |
| Full-screen push | Deep hierarchy | Nav fatigue (S6 problem) |
| Aggressive prefetch | Image feeds | Data/battery burn |

## 12. Whiteboard scripts

**A. Lifecycle + ads pause**  
**B. Deeplink → single router → UIKit vs SwiftUI host**  
**C. Sheet vs push with 30%+ metric**

Agenda: README opener.

## 13. Failure modes

| Failure | Mitigation |
|---|---|
| Video plays offscreen | Disappear + visibility policy |
| Wrong cell image | Token + cancel on reuse |
| Prefetch bill shock | Budget + Low Data Mode |
| Double present deeplink | Single router + ready queue |
| Hosting height fights | Intrinsic/sizing ownership |
| Sheet for checkout wizard | Wrong tool — push/flow |

## 14. Decision rule card

```text
1. One-time vs every-show → didLoad vs appear
2. Leave screen → pause/cancel
3. Cells: reset + cancel in prepareForReuse
4. Prefetch: warm + cancel + bound
5. Hybrid: one nav owner; stable representable identity
6. Sheet for shallow overview; claim 30%+ only from S6
```

## 15. Optional citations

Apple UIViewController / UIViewControllerRepresentable docs; WWDC demystify identity; in-repo deeplink system design doc — appendix only.

## 16. Bridge

→ [03-production-bridge.md](03-production-bridge.md)


## 17. Appearance forwarding in custom containers

If you build a custom container VC that swaps children, you must forward appearance transitions (`beginAppearanceTransition` / `endAppearanceTransition`) or child `viewWillAppear` won’t run — analytics and pause/play break silently.

UINavigationController and UITabBarController do this for you. Your clever container might not.

## 18. Prefetch + image pipeline interaction

```text
prefetch(indexPaths)
  → repository.warm(ids)   // decode budgets, lower priority
cell configure
  → repository.image(id)   // coalesce with in-flight prefetch
cancelPrefetch
  → cancel warms not yet needed
```

Without coalescing, prefetch and cell bind double-fetch the same URL. Repository single-flight per URL helps (Day 09 cousin idea).

## 19. Bottom sheet engineering details

| Topic | Practice |
|---|---|
| Detents | Medium for overview; large for expanded details |
| Grabber | Accessibility + discoverability |
| Keyboard | Avoid covering inputs if sheet has search |
| VoiceOver | Focus to sheet title on present; restore on dismiss |
| Analytics | open / cta / dismiss — don’t count underlying screen as finished |
| Reuse | Shared component API across listing surfaces (S6) |

## 20. Mixpanel screen-name discipline

Hybrid risk: UIKit parent and SwiftUI child both fire `screen_view`. Pick one owner per visible surface. Representable updates must not re-fire viewed events.

## 21. Extended decision card

```text
Lifecycle: load once vs appear many
Media: visibility + disappear + background
Cells: token + cancel + clear handlers
Prefetch: warm + cancel + limit + Low Data Mode
Hybrid: containment + sizing + one router
Product UI: sheet vs push by depth; S6 30%+ only
```
