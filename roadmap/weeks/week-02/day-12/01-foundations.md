# 01 — Foundations: SwiftUI State & Identity Mental Model

> Intern → mid. Read before deep dive.

## 1. Plain-English mental model

SwiftUI is a **state → UI** engine. You describe views as a function of state; the framework diffs and updates. Most “SwiftUI is buggy” reports are **state in the wrong place** or **identity that resets**.

Think of a theater:

| Theater | SwiftUI |
|---|---|
| Script (what’s true) | Your model / `@State` / `@Observable` |
| Stage directions | `body` — cheap description |
| Actor’s continuity | **Identity** — same character across scenes |
| New casting each night | `.id(UUID())` — state amnesia |

If you recast (new identity) every frame, the actor forgets their lines (`@State` resets), animations restart, and representables remake (Day 11 pain).

## 2. Glossary

| Term | Meaning |
|---|---|
| **`@State`** | View-owned private storage; lifetime tied to view identity |
| **`@Binding`** | Two-way reference to someone else’s state |
| **`@Observable`** | iOS 17+ Observation macro for models; tracks property access |
| **`@Bindable`** | Bridge for bindings into observable fields |
| **`ObservableObject` / `@Published`** | Combine-era observation (pre-Observation / legacy) |
| **Environment** | Values propagated down the tree (theme, locale, DI-lite) |
| **Structural identity** | Same position/type in view tree ⇒ same identity |
| **Explicit identity** | `.id(...)` / `ForEach(id:)` |
| **Invalidation** | SwiftUI re-asking `body` because depended state changed |
| **Invalidation storm** | Giant observed object → huge subtree redraws |
| **Lazy container** | `List` / `LazyVStack` — build views on demand |
| **Eager `VStack`** | Builds all children — fine for tiny; death for thousands |
| **Stable ID** | Model key that doesn’t change across updates |
| **Stories page** | One story unit in a group; identity must survive progress ticks |

## 3. State ownership table (memorize)

| Tool | Owner | Use |
|---|---|---|
| `@State` | View (private) | Ephemeral UI — toggle chrome, local draft text |
| `@Binding` | Child writes parent | Controls |
| `@Observable` model | Often VM / feature model | Async + shared screen state (**iOS 17+**) |
| `@Bindable` | Bridge | Forms into observable fields |
| Environment | Tree-wide | Theme, layout direction — not every NetworkClient |
| `ObservableObject` | Legacy path | Know for interviews / older OS |

**Rule:** View-local for pure UI; hoist async/domain to observable VM (Day 08). Don’t duplicate every toggle into VM.

## 4. Identity — the senior differentiator

SwiftUI recognizes “same view” by identity:

- **Structural:** type + place in hierarchy  
- **Explicit:** `.id("profile")` / `ForEach(stories)` with stable `Identifiable`  

**`@State` lifetime follows identity.** Change `id` → state resets.

**Classic bug:** `.id(UUID())` inside `body` → new identity every render → text fields clear, timers restart, Stories page resets mid-swipe.

**Stories SDK implication (S10):** page identity must be stable across progress updates; don’t regenerate UUIDs each render.

## 5. Intern path: happy Stories player

1. Host app supplies story groups via data source protocol.  
2. `StoriesPlayerModel` (`@Observable`) owns timeline: idle → loading → playing → paused → finished.  
3. Views render progress from model — not ad-hoc view timers alone.  
4. `onDisappear` / scene phase → pause AV + timers.  
5. Adjacent media prefetch carefully (budget — Day 11 lesson).  
6. Host gets callbacks: open/close/CTA — injectable analytics.

## 6. Lists — intern path

| Do | Don’t |
|---|---|
| `List` / `LazyVStack` for large data | `VStack` of 10k rows |
| Stable `Identifiable` | `id: \.self` on mutating values |
| Cheap `body` | Format JSON in every row `body` |
| Async images with size budgets | Decode huge images on main in `body` |

## 7. `@Observable` version note (say this)

> “For new code on iOS 17+ I prefer `@Observable`. On older deployment targets I’d use `ObservableObject` and `@Published`. In interviews I can explain both.”

## 8. Environment DI — light touch

| OK | Risky |
|---|---|
| Theme, color scheme | Sole hidden `NetworkClient` |
| Layout direction | Service-locator EnvironmentKey soup |
| Feature-scoped store passed deliberately | SDK forcing host AppModel |

S10: SDK prefers **explicit injectable** networking/image loading protocols.

## 9. Production anchor — S10

Standalone reusable Stories SDK; clear public API; isolation from app-specific networking where possible; adopted across portfolio apps. SDK quality = API surface + versioning + independence from host shortcuts.

## 10. Self-check

1. `@State` vs `@Observable` placement  
2. Why UUID in `.id` breaks state  
3. Lazy vs eager lists  
4. iOS 17+ note for Observation  
5. Stories pause + stable page IDs  

## 11. Flash preview

| Front | Back |
|---|---|
| `@State` | Local ephemeral UI |
| `@Observable` | Feature/async model · iOS 17+ |
| Identity | Stable IDs preserve state |
| Lazy | Large collections |
| S10 | SDK API + isolation |
| Trap | `.id(UUID())` in body |
'''


## 12. Observation access tracking (intuition)

With `@Observable`, SwiftUI tracks which properties `body` read. Changing an unread property shouldn’t invalidate that view. Stuffing unused fields onto a model the root reads widely still causes storms — split models.

Legacy `ObservableObject` often broadcasts more coarsely via `objectWillChange`.

## 13. Stories UI chrome vs domain

| State | Placement |
|---|---|
| Progress 0…1 | Player model |
| Phase playing/paused | Player model |
| “Hold educational tooltip seen” | `@State` or lightly persisted host pref |
| CTA destination | Host callback — SDK doesn’t push tickets VC |
| Image bytes | Injectable loader |

## 14. 90-second teaching script

> “SwiftUI state belongs either view-local or in an observable feature model — @Observable on iOS 17+, ObservableObject when you must support older OS. Identity preserves @State and representables; UUID-in-body resets everything. Lists need lazy containers and stable IDs. The Stories SDK I built exposes a clear API with injectable loading and host isolation so portfolio apps share one player — pause on disappear, stable page ids, progress owned by the model.”
