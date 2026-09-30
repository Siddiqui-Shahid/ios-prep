# Audio script — LLD — worked example: offline-first feed + checkout sketch

## §0 Introduction

LLD — worked example: offline-first feed + checkout sketch Two sketches you can reuse in almost every mobile LLD round.

## §1 Sketch A — Social / listing feed

Requirements you clarify (2 minutes) - Pagination: cursor (opaque server token), page size 20. - Offline: show last feed. - Images: prefetch next 3. - New posts: optional WebSocket; fallback pull-to-refresh. - Auth: bearer token + refresh. Classes | Type | Role | Thread | |---|---|---| | FeedView | SwiftUI list | MainActor | | FeedViewModel | LoadState , pagination loadMore | MainActor | | FeedRepository | cache then network | async | | FeedAPI | /v1/feed?after= | URLSession | | FeedStore actor | SQLite rows | actor | | ImagePipeline | decode + cache | background | | TokenStore | Keychain | actor / class + lock | Sequence: first launch (cold) App install → empty store → spinner → GET feed → persist → render. Prefetch images for first 5 URLs. Sequence: nth launch (warm) Read SQLite → render immediately → conditional GET with ETag → 304 do nothing / 200 merge by id. Consistency Read-your-writes (after you like a post, that cell must show liked even if the feed API is stale). Keep a pending overlay in memory keyed by id. Optimistic update (change UI first, rollback on 4xx). Failure table | Event | UX | |---|---| | No network, have cache | Banner “offline” + cached rows | | No network, no cache | Empty state + retry | | 429 | Honor Retry-After | | Decode error | Drop bad item, log, don’t blank the whole feed | Interview closer “The hard part is not UITableView. It’s coalescing, cache layers, and not double-applying pagination when the user rotates the phone.”

## §2 Sketch B — Payment checkout (mobile)

Clarify - PCI: you never store PAN (Primary Account Number: full card). Use a tokenizer SDK. - Idempotency key on POST /charges . - 3-D Secure sheet can background your app. Types CheckoutViewModel → PaymentService → TokenSDK + OrdersAPI . Persist local order id in SQLite before calling network so a killed app can query status. App killed mid-pay: on next launch, GET /orders/{id} — never charge twice. Sequence 1. User taps Pay. 2. Disable button (no double tap). 3. Insert local Order(status: .creating) . 4. Tokenize card. 5. POST /charges with idempotency key = local UUID. 6. Poll or webhook via push for succeeded . 7. Show receipt. Do not keep card fields in UserDefaults logs.

## §3 Sequence diagram language (use boxes)

User - ViewModel: tap refresh ViewModel - Repository: refresh() Repository - Store: cached() Store -- ViewModel: items ViewModel - View: loaded(cached) Repository - API: GET API -- Repository: 200 DTOs Repository - Store: upsert Repository -- ViewModel: items If you can narrate that calmly, you pass most LLD bars.

## §4 iOS-specific landmines (list them proactively)

- ATS blocking cleartext debug API. - ATS + corporate proxy in interview Wi-Fi — have a story, not a live demo. - ATS aside: ATS is HTTPS; SSL pinning breakages on certificate rotation. - Background: URLSession callback on a background queue — hop to MainActor before UIKit. - Keychain kSecAttrAccessibleAfterFirstUnlock vs WhenUnlocked — background refresh fails if you picked too strict. - BGAppRefresh is opportunistic; never the only sync path.

## §5 What “done” looks like for LLD on the train

Paper page with: layer stack, 8 class names, one sequence, one failure table. Photo it if you want; otherwise the act of writing is the memory. Next chapter in this guide: HLD. Do not skip the layer stack — HLD without LLD is empty boxes.
