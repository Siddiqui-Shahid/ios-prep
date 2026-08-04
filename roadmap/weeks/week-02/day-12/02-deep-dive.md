# 02 — Deep Dive: Observation, Identity, Lists, Stories SDK

> Senior depth. Assumes [01-foundations.md](01-foundations.md). Self-contained.  
> **Version:** `@Observable` requires **iOS 17+**.

## 1. State ownership decision tree

```text
Is it pure ephemeral UI for one view?
  yes → @State
  no ↓
Do child controls need to write it?
  yes → @Binding into parent/@Bindable model
  no ↓
Is it screen/feature async or shared across children?
  yes → @Observable model (iOS 17+) / ObservableObject (legacy)
  no ↓
Is it tree-wide theme/locale?
  yes → Environment
  no → You’re over-abstracting — keep it simple
```

### Anti-patterns

| Anti-pattern | Fix |
|---|---|
| Every toggle in VM | Keep chrome `@State` |
| Fetch inside `body` | Model/Task on appear; never side-effect in `body` |
| One `AppModel` for entire app | Split by feature — invalidation storms |
| Environment NetworkClient only | Explicit init for testable/SDK seams |

## 2. Observation vs ObservableObject

| | `@Observable` (iOS 17+) | `ObservableObject` |
|---|---|---|
| Tracking | Property access fine-grained | Often `objectWillChange` whole object |
| Boilerplate | Macro `@Observable` | `: ObservableObject` + `@Published` |
| Bindings | `@Bindable` | `$` projected values |
| Deployment | iOS 17+ | Older OS |

**Interview sentence:** Prefer Observation on modern targets; still explain `@Published` when asked about legacy codebases.

### Granularity and storms

A monolithic observable with 50 fields used by a root view can invalidate huge trees when any field changes. Split models (player vs chrome vs catalog). Pass slices into children.

## 3. Identity mechanics

See [code/IdentityTraps.swift](code/IdentityTraps.swift).

### Structural identity

```swift
VStack {
  Header()   // structural position 0
  Content()  // structural position 1
}
```

Swap order conditionally without IDs → SwiftUI may treat views as different → state jumps.

### Explicit identity

```swift
ForEach(pages) { page in  // Identifiable stable id
  StoryPageView(page: page)
}
```

### Forced new identity (intentional)

Logout → `.id(userSessionID)` so forms reset. **Intentional** reset ≠ accidental UUID churn.

### Representable link (Day 11)

Parent identity churn → `makeUIViewController` storms → players restart. Stabilize IDs; update props.

## 4. Lists & performance

See [code/LazyListNotes.swift](code/LazyListNotes.swift).

### Container choice

| Container | Use |
|---|---|
| `List` | Platform list behaviors, edit modes |
| `LazyVStack` in `ScrollView` | Custom scrolls, large stacks |
| Eager `VStack` | Tiny static content only |

### Row rules

1. Stable `Identifiable` — never `UUID()` per `body`  
2. Avoid `id: \.self` when value equality changes often  
3. Don’t observe entire catalog inside each row — pass row models  
4. Precompute formatted strings in model  
5. Images: async + decode/size budgets (Week 3)  
6. Scope animations — don’t `.animation` the universe  

### When Lazy still janks

Profile: image decode, main-thread JSON, overlapping observations, expensive shadows, unbounded prefetch. Fix **data path**, not only container choice.

## 5. `body` purity

`body` is called often — that’s normal. Problem is **heavy work** or **side effects** inside.

| OK in body | Not OK |
|---|---|
| Compose views from state | Start network |
| Cheap formatting already cached | Sort 10k rows every call |
| Branch on enum state | Write to disk |

## 6. Animation & transitions

- Prefer identity-preserving updates for smooth animation  
- Destroy/recreate (identity change) feels like jump cuts  
- Drive Stories progress from **model timeline**, not scattered `onAppear` timers  
- Use explicit `withAnimation` / transactions for intentional motion  

## 7. Stories SDK design (S10 shape)

See [code/StoriesPlayerModel.swift](code/StoriesPlayerModel.swift).

### Public API sketch

```text
StoriesPlayer
  ├─ DataSource protocol  (host supplies groups/pages)
  ├─ ImageLoading / VideoLoading protocols (injectable)
  ├─ Event callbacks (onOpen, onClose, onCTA, onPage)
  ├─ Theming hooks
  └─ Versioned module boundary
```

### State machine

```text
idle → loading → playing ⇄ paused → finished
                     ↓
                 failed (retry)
```

Pause on: `onDisappear`, scene background, user hold — same lifecycle discipline as Ads video (S1 cousin).

### Why not hardcode networking?

Portfolio apps differ (Heat / other Raw apps). Injectable clients → testability + host variance. SDK quality = independence from host shortcuts.

### UIKit hosts

SwiftUI-first OK; offer `UIHostingController` façade for legacy. Public API shouldn’t force one nav paradigm (S13 hosts).

## 8. SDUI leaf identity (Day 10 crossover)

Registry views should use **server-stable node ids** for `ForEach` / `.id`. Array indices break when CMS inserts a banner above.

## 9. Testing SwiftUI logic

| Layer | How |
|---|---|
| Observable model / UseCase | XCTest — primary |
| Snapshots | Critical chrome sparingly |
| UITests | Open/close Stories golden path |
| ViewInspector etc. | Optional; don’t rely exclusively |

Theater UITests with `sleep` are AI smell (Day 08/S9 culture).

## 10. Equatable View — micro-opt

Useful for expensive rare-changing subtrees. Don’t sprinkle early. Prefer smaller observed state first. Measure.

## 11. Trade-offs

| Choice | When | Cost |
|---|---|---|
| `@Observable` VM | Feature screens iOS 17+ | Over-observation if monolithic |
| All `@State` | Tiny UI | Untestable async spaghetti |
| `AnyView` erasure | Rare need | Kills optimization / clarity |
| Eager VStack | Tiny lists | Jank at scale |
| SDK owns networking | Convenience | Couples hosts |
| `.id(UUID())` per body | Never | Resets state every frame |
| SwiftUI-only SDK | Modern hosts | Legacy need façade |

## 12. Whiteboard scripts

**A.** State ownership table + one wrong placement  
**B.** Identity: UUID trap vs stable page ids  
**C.** Stories SDK boundary + state machine + pause  

Agenda: README opener.

## 13. Failure modes

| Failure | Cause | Fix |
|---|---|---|
| Text clears while typing | Identity churn | Stable id |
| Progress bar desync | Timers in views / id reset | Model timeline |
| List jump | Unstable ForEach ids | Stable Identifiable |
| Whole screen redraws | God observable | Split models |
| Representable remake | Parent id churn | Stabilize; update props |
| Background audio | No scene-phase pause | Pause policy |

## 14. Decision rule card

```text
1. Pure UI → @State; async/domain → @Observable (iOS 17+)
2. IDs stable unless intentional reset
3. Large lists → lazy + cheap body + stable ids
4. Split models to avoid invalidation storms
5. SDK: protocols in, events out, pause on disappear
6. Say the iOS 17+ caveat aloud
```

## 15. Optional citations

Apple State and Data Flow; Observation framework; WWDC Demystify SwiftUI / SwiftUI performance; `app-modularization.md` — appendix only.

## 16. Bridge

→ [03-production-bridge.md](03-production-bridge.md)
