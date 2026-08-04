# Day 12 — SwiftUI State, Identity, @Observable, Lists, Performance

> Week 2 · Phase: Architecture, networking, SDUI, UI · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- SwiftUI **state ownership** rules: `@State`, `@Binding`, `@Observable` / `@Bindable`, environment — what belongs where
- Why **identity** (`id`, structural identity, `@State` lifetime) causes “random” bugs
- How to build **performant lists** (lazy stacks, stable IDs, avoid invalidation storms)
- How a **Stories SDK** public API keeps state/modularity clean across portfolio apps (Miami Heat / Raw)

## 2. Concept deep dive

### 2.1 State ownership (memorize)

| Tool | Owner | Use |
|---|---|---|
| `@State` | View (private) | View-local ephemeral UI |
| `@Binding` | Child writes parent state | Two-way controls |
| `@Observable` model | Often VM / feature model | Async + shared screen state |
| `@Bindable` | Bridge to observable fields | Forms into models |
| `Environment` / `EnvironmentObject` | Tree-wide | Theme, DI-lite — not every service |
| `@StateObject` / `ObservableObject` | Legacy Combine path | Know for interviews; prefer Observation in new code |

**Rule:** View-local for pure UI; hoist async/domain to observable VM (Day 08). Don’t duplicate every toggle into VM.

### 2.2 Identity — the senior differentiator

SwiftUI diffs the view tree by **identity**:

- **Structural identity:** position in hierarchy / type
- **Explicit identity:** `.id(...)` / `ForEach(id:)`
- **`@State` lifetime** follows identity — change `id` → state resets

**Bugs from bad identity:** list flicker, lost scroll position, recreated `UIViewControllerRepresentable`, restarted animations, Stories page reset mid-swipe.

**Stories SDK implication:** Story page identity must be stable across updates; don’t regenerate UUIDs each render.

### 2.3 Lists & performance

- Prefer `List` / `LazyVStack` in `ScrollView` for large data; avoid eager `VStack` of thousands.
- Stable `Identifiable` models; never `id: \.self` on mutable value types that change equality.
- Minimize work in `body`; precompute in model; avoid heavy formatting per row.
- Images: async + size budgets (Week 3 image pipeline).
- Prefer Equatable view inputs / reduced dependency on huge observed graphs.

**Invalidation storms:** one giant `@Observable` god-object → entire screen redraws. Split models or observe granularly.

### 2.4 Animation & transitions

Intentional animations via explicit `withAnimation` / transaction; identity-preserving updates animate better than destroy/recreate. Stories progress bar: drive from model timeline, not ad-hoc view timers alone.

### 2.5 Stories SDK (modular SwiftUI)

Standalone reusable SDK: clear public API, isolation from host networking where possible, adopted across NBA/WNBA portfolio. State machine for story groups/pages, pause on disappear/background, prefetch adjacent media carefully.

### 2.6 Trade-offs

| Choice | When | Cost |
|---|---|---|
| `@Observable` VM | Feature screens | Over-observation if monolithic |
| All `@State` in views | Tiny UI | Untestable async spaghetti |
| `AnyView` erasure | Rare type erasure need | Kills optimization / identity clarity |
| Eager VStack | Tiny lists | Scroll jank at scale |
| SDK owns networking | Convenience | Couples host; prefer injectable client (S10) |
| `.id(UUID())` per body | Never | Resets state every frame |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [State and data flow](https://developer.apple.com/documentation/swiftui/state-and-data-flow) | Official model |
| Must | WWDC: **Demystify SwiftUI** · **SwiftUI performance** | Identity + perf vocabulary |
| Deepen | [Observation](https://developer.apple.com/documentation/observation) framework docs | `@Observable` |
| Repo | [app-modularization.md](../../../ios-system-design/docs/app-modularization.md) | SDK boundaries |
| Repo | [stories/story-bank.md](../../stories/story-bank.md)#s10--stories-sdk-raw--miami-heat | Production hook |

## 4. Map to your work

**Company / feature:** Raw / Miami Heat — Stories SDK  
**What you did:** Designed standalone reusable Stories SDK with clear public API and isolation from app-specific networking where possible; leveraged across portfolio apps.  
**Interview line (≤20s):** “I built a reusable Stories SDK — stable public API and host isolation — so multiple NBA/WNBA apps shared one Instagram-style stories implementation.”

→ Full STAR: [stories/story-bank.md](../../stories/story-bank.md)#s10--stories-sdk-raw--miami-heat

**Also:** Grizzlies hybrid hosting identity (S13); SDUI registry views as SwiftUI leaves (Day 10).

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. `@State` vs `@Observable` — when each? `(30–45s)`
**Skeleton:** `@State` for local UI; `@Observable` for feature model/async shared across child views. Binding into observable via `@Bindable`.  
**Follow-up:** Legacy `ObservableObject`? → Still in codebases; know `@Published` + `objectWillChange`.  
**Story:** Stories player model vs local chrome state.

### Q2. What is view identity? `(45–60s)`
**Skeleton:** How SwiftUI recognizes same view across updates; structural vs explicit `.id`; `@State` tied to identity.  
**Follow-up:** When force new identity? → Intentional reset (logout clears form).  
**Story:** S10 page identity.

### Q3. Why did my Representable reset? `(45s)`
**Skeleton:** Parent identity changed or `id` churn → remake. Stabilize IDs; update props in `update` instead of recreate.  
**Follow-up:** Day 11 hybrid link.  
**Story:** S13.

### Q4. `ForEach` best practices? `(45s)`
**Skeleton:** Stable `Identifiable`; avoid indices as IDs when reordering; don’t create new IDs in `body`.  
**Follow-up:** Duplicate IDs? → Undefined weirdness / warnings.  
**Story:** Stories pages array.

### Q5. Make a long list smooth. `(60–90s)`
**Skeleton:** Lazy containers, async images, cheap `body`, stable IDs, pagination, avoid observing whole catalog in each row.  
**Follow-up:** Instruments? → SwiftUI and Time Profiler.  
**Story:** Portfolio apps scale; SDK consumers.

### Q6. How do you design Stories SDK API? `(60–90s)`
**Skeleton:** `StoriesPlayer` entry, data source protocol, event callbacks (open/close/tap CTA), injectable image/video loader, versioned module. Host supplies stories DTOs.  
**Follow-up:** Why not hardcode networking? → Portfolio variance; testability.  
**Story:** S10.

### Q7. Pause stories on background/disappear? `(45s)`
**Skeleton:** Scene phase / `onDisappear`; pause timers & AVPlayer; resume policy explicit. Same lifecycle discipline as Ads video.  
**Follow-up:** S1 parallel.  
**Story:** S10 + S1.

### Q8. Environment for DI — good idea? `(45s)`
**Skeleton:** Good for theme, layout direction, shallow deps. Bad as hidden service locator for NetworkClient everywhere — prefer explicit init for SDKs.  
**Follow-up:** Day 08 DI.  
**Story:** S10 injectable deps.

### Q9. Animation causes list jump — causes? `(45–60s)`
**Skeleton:** Identity changes, height changes without animation transaction, diffable mismatch, scroll position loss. Fix stable IDs + animate data changes carefully.  
**Follow-up:** `.animation` on big trees? → Scope animations.  
**Story:** General senior debugging.

### Q10. Performance: `body` called often — problem? `(45s)`
**Skeleton:** `body` should be cheap and pure-ish; frequent calls expected. Problem is heavy work inside. Move to model.  
**Follow-up:** Avoid side effects in `body`.  
**Story:** Interview classic.

### Q11. Cross-app reuse challenges for Stories? `(45–60s)`
**Skeleton:** Theming, analytics hooks, media formats, nav/deeplink exits, dependency versions. Solve with protocols + defaults.  
**Follow-up:** Modularization Day 15 preview.  
**Story:** S10 portfolio adoption.

### Q12. SwiftUI + SDUI registry? `(45–60s)`
**Skeleton:** Registry returns SwiftUI views keyed by type; keep leaves dumb; VM owns payload; identity of each node from server id.  
**Follow-up:** Day 10.  
**Story:** S3 header components.

## 6. Tricky questions

### T1. “I put UUID in `.id` inside body — why is state broken?” `(90s)`
**Trap:** Blame SwiftUI bugs.  
**Senior answer:** New identity every render resets `@State` and remakes children. IDs must be stable model keys.  
**Follow-up:** When UUID ok? → Model created once and stored.

### T2. “One `@Observable` AppModel for everything.” `(90–120s)`
**Trap:** Convenient architecture.  
**Senior answer:** Causes broad invalidation and tight coupling. Split by feature; pass slices; SDK shouldn’t depend on host AppModel.  
**Follow-up:** S10 isolation.

### T3. “LazyVStack still janky.” `(90–120s)`
**Trap:** Only “use List.”  
**Senior answer:** Profile: image decode, main-thread JSON, overlapping observations, complex shadows, unbounded prefetch. Fix data path, not only container choice.  
**Follow-up:** Week 3 image pipeline.

### T4. “Should Stories SDK be SwiftUI-only?” `(90s)`
**Trap:** Binary.  
**Senior answer:** SwiftUI-first OK if hosts can host; offer UIKit wrapper (`UIHostingController` façade) for legacy. Public API should not force one nav paradigm.  
**Follow-up:** S13 hybrid hosts.

### T5. “Equatable View conformance — worth it?” `(90s)`
**Trap:** Micro-optimize everything.  
**Senior answer:** Useful for expensive subtrees with rare changes; don’t sprinkle early. Prefer smaller observed state. Measure first.  
**Follow-up:** Observation already tracks properties — know interactions.

### T6. “How do you test SwiftUI state logic?” `(90s)`
**Trap:** Only UITests.  
**Senior answer:** Test observable models/UseCases in XCTest; light ViewInspector/snapshots optional; UITests for critical Stories open/close.  
**Follow-up:** S9 testing culture.

### T7. “Progress bar desyncs when paging stories.” `(90–120s)`
**Trap:** More timers in views.  
**Senior answer:** Single source of truth timeline in model; view renders; identity of page must not reset timer state incorrectly; pause/resume explicit events.  
**Follow-up:** State machine > scattered `onAppear` timers.

### T8. “Host app injects different image pipelines.” `(90s)`
**Trap:** SDK bundles Kingfisher only.  
**Senior answer:** `ImageLoading` protocol in SDK; hosts adapt; default implementation provided. Same DI lesson as networking Day 09.  
**Follow-up:** S10 API design.

## 7. Flashcards for today

| Front | Back |
|---|---|
| `@State` use | Local ephemeral UI · Trap: async in every view · Prod: chrome |
| `@Observable` use | Feature/async model · Trap: god AppModel · Prod: Stories player |
| Identity rule | Stable IDs preserve state · Trap: UUID in body · Prod: S10 pages |
| ForEach ID | Identifiable stable keys · Trap: indices on reorder · Prod: lists |
| Lazy vs VStack | Lazy for large · Trap: eager thousands · Prod: perf |
| body rule | Cheap; no side effects · Trap: fetch in body · Prod: jank |
| Environment DI | Theme ok; services careful · Trap: hidden NetworkClient · Prod: S10 |
| Stories API | DataSource + events + inject loaders · Trap: hardcode host net · Prod: S10 |
| Pause stories | Scene phase / disappear · Trap: run in background · Prod: S10/S1 |
| Invalidation storm | Split models · Trap: observe all · Prod: redraws |
| Representable reset | Parent id churn · Trap: SwiftUI bug · Prod: S13 |
| Animation scope | Transaction local · Trap: animate whole tree · Prod: lists |
| Portfolio reuse | Protocols + theming hooks · Trap: fork per app · Prod: S10 |
| SDUI leaf id | Server-stable id · Trap: array index · Prod: S3 |
| Test SwiftUI | Model unit tests first · Trap: only UITest · Prod: S9 |

## 8. Practice

- **Coding / SD:** Sketch Stories SDK module boundary: public protocols, player state machine (idle → loading → playing → paused → finished), host callbacks.
- **Complexity / agenda to say first:** “State ownership, then identity, then list perf, then SDK API isolation with S10.”
- **Hands-on:** Explain aloud why `.id(UUID())` on a form resets text — 30s drill.

## 9. Timed drill

1. Pick 3 Normal + 2 Tricky (recommended: Q2, Q6, Q5 + T1, T2). Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md).
3. Log misses in gotchas (identity + observation scope).
4. Deliver S10 STAR in **2–3 min**.
