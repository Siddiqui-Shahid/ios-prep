# Audio script — HLD — high-level design for mobile interviews

## §0 Introduction

HLD — high-level design for mobile interviews HLD (High-Level Design: services, APIs, data flow, scale, and trade-offs — you still own the client , but you must speak the backend enough to be credible).

## §1 The 45-minute framework (compress to 12 minutes on the train)

| Clock | Move | What to say | |---|---|---| | 0–5 | Clarify | DAU, offline?, iOS-only?, write/read ratio, latency SLO | | 5–15 | HLD diagram | Client, CDN, API gateway, app servers, cache, DB, push, object store | | 15–25 | API + data | Entities, cursor pagination, payload size, auth | | 25–40 | Deep dives | Pick 2: sync, images, realtime, search, payments | | 40–45 | Ops | Metrics, rollout, kill switch, failure modes | DAU (Daily Active Users: unique users per day — use it to size QPS). QPS (Queries Per Second). Rough: peak QPS ≈ DAU × requests per user per day / 86400 × peak factor . Example: 10M DAU × 50 requests × 3 peak factor / 86400 ≈ 17k QPS . You will not be exact; you will show you multiply. SLO (Service Level Objective: e.g. p95 API < 200ms). p95 (95th percentile latency: 95% of calls faster than this). CDN (Content Delivery Network: caches images/static near the user — Cloudflare, Akamai, CloudFront).

## §2 Mobile-specific constraints (say these unprompted)

1. Battery and radio: batch, don’t chatty-poll every 2s in foreground without need. 2. Intermittent network: ghats tunnels on this very Mumbai–Pune route — queue writes. 3. Payload size: cellular; gzip; don’t send 2MB JSON for a list row. 4. OS killers: Jetsam, background budgets, App Review. 5. Store versions: old clients live forever; API versioning ( /v1/ ) and feature flags . 6. Security: tokens in Keychain, ATS, least PII on disk.

## §3 Caching (interview table)

| Layer | Where | Example | |---|---|---| | L0 | HTTP CDN | images, HLS segments | | L1 | Process memory NSCache | decoded images, hot DTOs | | L2 | Disk SQLite / files | feed, profile | | L3 | URLCache | GET JSON with Cache-Control | | L4 | Server Redis | session, feed fanout | TTL (Time To Live: how long a cache entry is trusted). Write-through (write memory and disk together) vs write-back (disk later — faster, crash risk). Invalidation is the hard problem: prefer version / updated at over hoping TTL is enough for profile changes.

## §4 Consistency words (use correctly)

Strong consistency (every read sees the latest write — expensive, often not needed on a feed). Eventual consistency (replicas catch up; likes may lag). Causal / read-your-writes (the writer sees their own write — do this on device with a local overlay). For a social feed, eventual on other people’s posts + read-your-writes for me is the grown-up answer.

## §5 API design

- REST JSON is the default in iOS interviews unless they say GraphQL. - Cursor pagination always for feeds. - Idempotency-Key header on payments and ticket booking. - ETag / If-None-Match for profiles. - Error body: { "code": "rate limited", "message": "...", "retry after ms": 800 } . - Fan-out on write vs fan-out on read (Twitter classic): celebrity with 10M followers cannot write 10M rows per tweet — fan-out on read or hybrid.

## §6 Realtime

| Transport | When | |---|---| | WebSocket ( URLSessionWebSocketTask ) | chat, live score | | SSE (Server-Sent Events: one-way stream) | ticks | | APNs (Apple Push Notification service) | backgrounded app | | Poll | last resort, exponential interval | Heartbeat 30s; reconnect with exponential backoff + jitter (random delay so all clients don’t reconnect at once — thundering herd ).

## §7 Storage on server (you only need the names)

SQL (Postgres) for orders. NoSQL / Cassandra for huge feeds. Blob store (S3) for images + CDN in front. Redis for hot keys and rate limits.

## §8 Feature flags and rollout

Feature flag (remote boolean/config so you ship code dark). Kill switch (turn off a crashing module). A/B test (experiment SDK assigns bucket; don’t bucketing on the client only if users can cheat). Phased release (App Store % rollout) + server flags together.

## §9 Metrics you should quote

- Crash-free sessions - p95 / p99 API and TTFV (Time To First View: cached vs network) - Battery / hang rate (MetricKit) - Error budget (how much unreliability you accept)

## §10 Sample 3-minute HLD speech (feed)

“Clients talk to an API gateway with OAuth tokens. GET /feed?after=cursor hits a feed service which reads a cache, then a store. Media URLs point at a CDN. The iOS app keeps SQLite for offline and NSCache for images. Writes like ‘like’ go to a write API, optimistic on device. Push via APNs when backgrounded. I’ll deep-dive pagination and the image pipeline next.” That speech is the HLD bar. Deep dives are LLD you already practiced.
