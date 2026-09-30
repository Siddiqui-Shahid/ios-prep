# LLD — how to run a low-level design interview

**LLD** (Low-Level Design: you name types, ownership, call order, and thread hops — not data centers). On iOS this is “what objects exist in the process and who owns whom.”

## The 25-minute LLD agenda (say it first)

> “I’ll list requirements, draw types, walk a happy-path sequence, then failure, then tests. I’ll call out MainActor hops.”

| Min | Move |
|---|---|
| 0–3 | Requirements: online/offline, pagination, auth, who owns disk |
| 3–10 | Type diagram: View, ViewModel, Repository, API client, Store |
| 10–18 | Sequence: tap → request → decode → persist → UI |
| 18–22 | Failures: 401, timeout, empty, disk full |
| 22–25 | Test seams: protocol for client and clock |

## Layer stack (memorize this drawing)

```
SwiftUI View / UIViewController     ← dumb, MainActor
        ↓
ViewModel (@MainActor)              ← UI state enum
        ↓
Repository / UseCase                ← merge memory + disk + network
        ↓
APIClient (URLSession)              ← HTTP, retries, auth plugin
Store (SQLite / actor cache)        ← source of truth for offline
```

**Repository** (a type that hides whether data came from memory, disk, or network).

**ViewModel** (holds UI state; not a dumping ground for URLSession).

**DI** (Dependency Injection: construct the graph in a composition root — `App` or a `Session` object — not inside views).

## Sequence: pull-to-refresh a list (speak while pointing)

1. View calls `viewModel.refresh()`.
2. ViewModel sets `state = .loading` (keep stale rows on screen if you have them — **stale-while-revalidate**: show cache immediately, refresh in background).
3. Repository reads **L1** (in-memory **NSCache** / actor dictionary).
4. If miss, read **L2** (SQLite). Emit cached rows.
5. APIClient `GET /items?after=cursor` with **URLRequest**.
6. Decode `[ItemDTO]` off the main actor.
7. Map DTO → domain `Item`.
8. Upsert SQLite; update memory.
9. ViewModel `state = .loaded(items)`.
10. On 401: **TokenRefresher** single-flights a refresh, retries once, else `state = .loggedOut`.

**Single-flight** (only one refresh request in flight; waiters share the same `Task`).

## Core types (write these names on paper)

```swift
@MainActor
final class FeedViewModel: ObservableObject {
    @Published private(set) var state: LoadState<[Item]> = .idle
    private let repo: FeedRepository
}

protocol FeedRepository: Sendable {
    func items(cursor: String?) async throws -> Page<Item>
}

protocol HTTPClient: Sendable {
    func send(_ request: URLRequest) async throws -> (Data, HTTPURLResponse)
}

actor FeedStore {
    func upsert(_ items: [Item]) async throws
    func page(after: String?) async throws -> [Item]
}
```

**LoadState** (enum: `idle`, `loading`, `loaded(T)`, `failed(Error)` — associated values keep illegal combos unrepresentable).

**Page** (payload + `nextCursor: String?` — never `page=5` for a feed).

## URLSession LLD details interviewers want

- **One shared session** per app (connection pooling, cookies). Do not `URLSession()` per request.
- **Timeouts:** `timeoutIntervalForRequest` ~30s, resource longer for downloads.
- **waitsForConnectivity** (true for user-initiated; false for analytics you can drop).
- **URLCache** (HTTP cache for GET honoring Cache-Control; not a substitute for your domain store).
- **Background configuration** for downloads that must outlive the process.
- Decode with `JSONDecoder` on a background task; `keyDecodingStrategy` documented (convertFromSnakeCase vs explicit `CodingKeys` — pick one style).

**Retry policy:** retry **idempotent** GET on timeout/5xx with exponential backoff + jitter. Do **not** retry POST checkout without **idempotency key** (client-generated UUID the server de-dupes).

## Combine LLD (if they ask)

`viewModel` owns `Set<AnyCancellable>`. Pipeline: `urlSession.dataTaskPublisher` → `decode` → `receive(on: DispatchQueue.main)` → `sink`. Cancel in `deinit` / `onDisappear`. Prefer async/await for new code; be fluent in Combine for legacy.

## SwiftUI / UIKit ownership

- SwiftUI: `View` is a value; identity is `id:` on lists. Store objects with `@StateObject` (view creates) vs `@ObservedObject` (parent owns) vs `@EnvironmentObject` (injected). Wrong choice = lost state on redraw or leaks.
- UIKit: VC owns VM; VM must not own VC (retain cycle). Delegates `weak`.

## Persistence LLD

**SQLite WAL** (Write-Ahead Logging: readers don’t block the writer as hard; checkpoint periodically).

**Core Data** (object graph + SQLite; use `NSPersistentContainer`, background context for imports, merge to view context).

**SwiftData** (newer Apple ORM; know it exists; don’t pretend production battle scars you don’t have).

Schema versioning: **migration** (lightweight if you only add columns; heavy if you reshape). Never explode on launch because of a failed migration — recover to empty + re-sync.

## Threading rules (write on the page)

1. UI types: MainActor only.
2. SQLite: one writer (serialize in an actor or queue).
3. JSON decode: not main.
4. Image downsample: not main; cache decoded thumbnail, not original.

## Sample LLD prompt: “Design image loading”

Types: `ImageLoader` actor, `MemoryCache` (NSCache, cost = byte size), `DiskCache` (files named by URL SHA), `Downloader` (URLSession), coalescing map `url → Task<UIImage>` so 20 cells don’t fire 20 downloads.

Evict on `didReceiveMemoryWarning`. Cancel on cell reuse (`task.cancel()`).

**Done when you can draw this without notes.**
