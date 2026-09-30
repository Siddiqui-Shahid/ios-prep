# Questions 01–10 — feeds, media, networking, sync

Speak each **Answer** in 60–90 seconds. Cover, then check. Every **bold term** has a parenthesis.

## Q1. Design an infinite social feed on iOS

**Answer:**

> “I clarify **DAU** (Daily Active Users) and offline. **HLD** (High-Level Design: boxes for CDN, API, cache): the client calls `GET /v1/feed?after=cursor`. **Cursor pagination** (opaque server token, not `page=5`) stays stable when new posts insert. Media URLs hit a **CDN** (Content Delivery Network: edge cache for images). **LLD** (Low-Level Design: types on device): `FeedView` → `@MainActor` `FeedViewModel` with `LoadState` → `FeedRepository` (cache then network) → shared `URLSession` → `FeedStore` actor on **SQLite** (on-device relational file). **Stale-while-revalidate** (show disk immediately, refresh behind). Images go through a coalesced loader. Likes are **optimistic** (UI first, rollback on 4xx) with a local overlay for **read-your-writes** (I see my own like even if the feed is stale).”

**If asked consistency:** other people’s posts can be **eventual** (replicas catch up); mine must not flicker.

## Q2. Design an image loading library

**Answer:**

> “Three tiers: memory **NSCache** (Apple’s evictable cache; cost = width × height × 4 bytes for **ARGB**), disk files named by URL hash, then network. **Coalesce** (`URL → Task`) so 20 cells don’t start 20 downloads. **Cancel** on cell reuse. Downsample to display size **off the main thread** (UI thread; 16.7ms frame budget at 60fps) or you **OOM** (Out Of Memory: Jetsam kills the app). Memory warning evicts L1. I do not cache 4K camera bitmaps in a table.”

## Q3. Design a networking / HTTP client SDK

**Answer:**

> “One shared **URLSession** (Apple’s HTTP stack; pooling). `HTTPClient` protocol for tests. **Interceptor** (plugin) for auth header. **401** (Unauthorized) **single-flights** token refresh: one `Task`, waiters retry once, else logout. Timeouts ~30s. Retry **idempotent** GET with exponential **backoff + jitter** (random delay so clients don’t stampede — **thundering herd**). Honor **ETag** / 304. Decode **Codable** off main. Never `URLSession()` per request.”

## Q4. Design an offline-first sync engine

**Answer:**

> “Local **SQLite** is source of truth. An **outbox** table (id, type, payload, tries, status) drains when `NWPath` is satisfied. **BGTaskScheduler** (best-effort iOS background work — not a cron). Conflicts: **409** then last-write-wins or user prompt. Don’t trust device clock; prefer server `updated_at`. **Idempotency-Key** on writes. Silent **APNs** (Apple Push) is throttled — never the only sync path.”

## Q5. Design iOS chat / messaging

**Answer:**

> “Foreground: **WebSocket** (`URLSessionWebSocketTask`, bidirectional). Background: **APNs**. Catch-up `GET /messages?after=seq` using server sequence, not client time. SQLite WAL (Write-Ahead Logging: readers don’t block the writer as hard). Message state machine: sending → sent → delivered → read. 30s heartbeat; reconnect with backoff. E2EE (end-to-end encryption) only if I can name Signal-style double ratchet — otherwise I say ‘transport TLS + server encryption’ and don’t fake crypto.”

## Q6. Design a long-form video player (HLS)

**Answer:**

> “**HLS** (HTTP Live Streaming: Apple’s playlist of short segments). **AVPlayer** (Apple’s player). **ABR** (adaptive bitrate: pick a ladder rung from bandwidth). Segments from CDN. Offline: `AVAssetDownloadURLSession`. **FairPlay** (Apple DRM) if licensed. Don’t decode frames on CPU in Swift. Audio session category playback. Background: now-playing info. Deep-dive: stall recovery and bitrate switching, not a custom decoder.”

## Q7. Design a short-form video feed

**Answer:**

> “Pool **3 AVPlayers** (current ±1). Prefetch next URL. Cap resolution on poor radio (e.g. 240p). Memory guard: tear down the player two away. Don’t keep 10 decoders. Impressions when 50% visible + 1s. Same cursor feed as Q1. Battery: pause off-screen immediately.”

## Q8. Design a Spotify-like audio player

**Answer:**

> “**AVQueuePlayer** for gapless. **MPNowPlayingInfoCenter** + remote commands. Offline DRM download session. Interruption handling (`AVAudioSession`). Queue persisted in SQLite. I don’t reinvent a mixer. Crossfade is an audio tap or two players — I pick one and name the trade-off (complexity vs glitch).”

## Q9. Design payment checkout on mobile

**Answer:**

> “No **PAN** (Primary Account Number: full card) on our servers — **tokenize** via SDK. Persist local **order id** before `POST /charges` with **Idempotency-Key**. **3-DS** (3-D Secure: bank challenge) can background us; reconcile with `GET /orders/{id}` — never double charge. Disable double tap. Tokens in **Keychain** (encrypted item store), not **UserDefaults**. PCI: we stay out of scope if the SDK owns the PAN field.”

## Q10. Design a Server-Driven UI engine

**Answer:**

> “**SDUI** (Server-Driven UI: JSON describes widgets so marketing changes without App Review). Client **registry** maps `type` → SwiftUI/UIKit. Unknown type → skip (forward compatible). Version the schema. Cache the document. Analytics injected at the renderer. Don’t execute code from JSON. Fallback layout if decode fails so the screen isn’t blank.”
