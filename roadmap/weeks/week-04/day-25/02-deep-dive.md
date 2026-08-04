# 02 — Deep Dive: Brief A & Brief B

---

## Brief A — Paginated list + cache + tests

### Prompt (use as-is)

> Build a mobile screen that loads a **paginated** remote list (cursor or page number). Show loading / empty / error. Support **pull-to-refresh** and next-page on scroll. Add a **cache** so revisiting shows last-good data quickly, then refresh. Include **unit tests** for pagination and cache policy.

### Suggested architecture

```text
ListView (SwiftUI or UIKit)
  → ListViewModel (items, page/cursor, isLoading, error)
    → ListRepository protocol
        → RemoteDataSource (URLSession or stub)
        → CacheDataSource (memory + optional disk)
```

### Must-have acceptance

1. First page renders from network (or stub).
2. Next page appends without wiping.
3. Failure on page 2 keeps page 1 visible.
4. Cache: cold open can show stale then refresh (define policy aloud).
5. Tests: pagination reducer / repository with mock — **not** only UI snapshots.

### Cache policy options (pick one, say why)

| Policy | When | Cost |
|---|---|---|
| Memory LRU only | Fast interview slice | Lost on kill |
| Memory + disk (Codable) | Stronger “senior” | Serialization time |
| Stale-while-revalidate | Best UX story | Need version/TTL |

### Cut lines (OK)

Fancy skeletons, Diffable animations, image pipeline, auth refresh, perfect offline merge.

---

## Brief B — SDUI component renderer

### Prompt (use as-is)

> Build a **server-driven UI** renderer: JSON document of components (`type`, `props`, optional `children`) → native views. Support ≥**3** types (e.g. `text`, `image`, `button` / `vstack`). Unknown `type` → safe fallback. Include `schemaVersion` check. Unit-test decoding + unknown-type fallback.

### Suggested architecture

```text
JSON Data
  → SDUIDocument (Codable, schemaVersion)
  → ComponentNode enum / protocol + factory
  → SDUIRenderer → AnyView / UIView
  → Feature flag / default fallback leaf
```

### Must-have acceptance

1. Decode sample JSON.
2. Render ≥3 types.
3. Unknown type does **not** crash — placeholder + analytics stub.
4. Nested children for one container.
5. Tests: decoder + factory fallback.

### Cut lines

Full CMS tooling, live reload, expression language, rich actions, Figma pixel parity.

---

## Rubrics (1–5)

| Dimension | 5 | 3 | 1 |
|---|---|---|---|
| Correctness | Happy + key failure solid | Happy only | Doesn’t run |
| Architecture | Clear layers + protocols | Mixed but navigable | God VC/VM |
| Cache or SDUI depth | Policy explained + coded | Partial | Missing |
| Tests | 3+ meaningful, fast | 1 weak | None |
| Communication | Agenda + trade-offs | Occasional | Silent |
| Time honesty | Cut lines documented | Overran polish | Unfinished core |

**Pass bar:** average ≥3.5, correctness ≥4, tests ≥3.

---

## Trade-offs

| Choice | When | Cost |
|---|---|---|
| SwiftUI list | Faster slice | UIKit shops may want Diffable — say assumption |
| Protocol + fake repo first | Tests & progress | Swap to live later |
| Real network in round | Impressive if stable | Flaky Wi‑Fi — prefer stub + one live |
| Perfect Clean Architecture | Rarely fits 3 hrs | Pragmatic MVVM + protocols |

→ [`03-production-bridge.md`](03-production-bridge.md)


---

## Worked vertical-slice scripts (speak at 0:15)

### Brief A — 90s plan

> “SwiftUI List + ListViewModel. Repository protocol with stub remote and memory SWR cache. Page-based pagination with in-flight guard and request generation id. Acceptance: page1, append page2, failed page2 keeps page1, stale-then-refresh, three unit tests. Cut: images, disk, auth.”

### Brief B — 90s plan

> “Codable SDUIDocument with schemaVersion. Factory for text, image, vstack. Recursive renderer. Unknown → PlaceholderView + log stub. Tests: decode fixture, three types, unknown doesn’t throw. Cut: actions DSL, live reload.”

---

## Brief A — state machine (teach)

```text
idle → loadingFirst
loadingFirst → loaded | empty | error
loaded → loadingMore | refreshing
loadingMore → loaded (append) | loaded (keep + nonblocking error)
refreshing → loaded (replace) | loaded (keep stale + error)
```

**Stale response rule:** each fetch captures `generation`; commit only if `generation == viewModel.generation`.

---

## Brief B — decode + factory sketch (interview whiteboard)

```swift
struct SDUIDocument: Codable {
    let schemaVersion: Int
    let root: ComponentDTO
}
struct ComponentDTO: Codable {
    let type: String
    let props: [String: String]?
    let children: [ComponentDTO]?
}
enum ComponentNode {
    case text(String)
    case image(URL?)
    case vstack([ComponentNode])
    case unknown(type: String)
}
```

Factory: `switch type` → known cases; `default: .unknown(type)`. Renderer never force-unwraps.

---

## Communication rubric cues (what graders hear)

| Minute | They should hear |
|---|---|
| 0:10 | Restated brief + 2 clarifying Qs |
| 0:18 | Layer plan + cut lines |
| 1:00 | “Happy path compiling” |
| 2:10 | Cache policy or unknown-type policy named |
| 2:40 | Test names aloud while writing |
| 2:55 | Known gaps README |
