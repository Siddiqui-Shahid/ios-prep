# Questions 11–20 — auth, growth, commerce, realtime

## Q11. Design OAuth / biometric authentication

**Answer:**

> “**OAuth2 + PKCE** (Proof Key for Code Exchange: stops intercepted auth codes on a public client). Tokens in **Keychain**. **Secure Enclave** (hardware key for biometrics / `LAContext`). Refresh is **single-flight**. Multi-device logout: server token family revoke. I don’t store JWT in UserDefaults. **ATS** (App Transport Security: HTTPS by default) stays on.”

## Q12. Design push notifications

**Answer:**

> “**APNs** device token is not a user id; it rotates — server maps user → tokens. Small payload; hydrate on tap. **Silent** (`content-available: 1`) is throttled. **Provisional** vs alert permission. Tap routes through a coordinator; **cold start** (app launched from killed) must not race the token. Android twin is FCM if they ask cross-platform.”

## Q13. Design feature flags and kill switches

**Answer:**

> “Flags are remote config with a local cache so launch works offline. Eval is synchronous on the main path — no network in `body`. **Kill switch** (turn off a crashing module in minutes). **A/B** bucket from the server (stable user id hash), not a coin flip each launch. Phased App Store % plus server flags together. Never wait App Review to disable a bad path.”

## Q14. Design search with autocomplete

**Answer:**

> “**Debounce** ~300ms (wait until typing pauses). Cancel in-flight `Task` so an old response doesn’t overwrite a new query (**race**). **FTS5** (SQLite full-text) for offline. Remote: `GET /search?q=&cursor=`. Show cached recents immediately. Empty, loading, error states. I do not search on every keystroke on cellular.”

## Q15. Design an e-commerce catalog

**Answer:**

> “Image-heavy grid: same image pipeline as Q2. Cursor pages. Cart is a local draft synced with **idempotent** adds. Price and stock are **short TTL** (Time To Live) or bypass cache — stale money is not OK; stale hero image is. Wishlist outbox when offline. Prefetch next row of thumbnails only.”

## Q16. Design Airbnb-style search + booking

**Answer:**

> “Map + grid share the same bounding box query; **debounce** map moves (~800ms). **BlurHash** (tiny placeholder) then image. Inventory **hold** (short Redis TTL, e.g. 15 min) then payment. Booking **draft** on disk so a killed app can resume. Conflict 409 → refresh calendar. Same payment rules as Q9.”

## Q17. Design realtime location tracking (rides)

**Answer:**

> “Don’t stream 1Hz GPS for 100k riders. Batch by time or meters. **CLLocationManager** accuracy vs **significant-change**. Server: WebSocket in-trip, APNs if backgrounded. Client: Kalman or simple smoothing; map **delta** render. Battery guard: stop when trip ends. Encode polyline.”

## Q18. Design a live delivery tracker (DoorDash-shaped)

**Answer:**

> “Order **state machine** (placed → preparing → picked → arriving → delivered). Hybrid: WebSocket foreground, APNs background, poll as last resort. **ActivityKit** / Live Activity if I know it — else I say lock-screen via APNs. Driver location throttled (Q17). Don’t animate every meter on a 60fps timer if the map is off-screen.”

## Q19. Design a calendar client

**Answer:**

> “Events from CalDAV/Google; **RRule** (RFC 5545 recurrence). Expand instances in a window, not infinite materialization. **UICollectionView** custom layout or SwiftUI lazy grid with stable ids. Conflicts: 409 + user. Silent APNs to sync. Time zones are data, not device-only.”

## Q20. Design a collaborative editor

**Answer:**

> “I name **OT** (Operational Transform: Google Docs-style) vs **CRDT** (Conflict-free Replicated Data Type: merge without a central un-do). On iOS in 45 minutes I will **not** implement either from scratch. I propose: op log + server serializes, presence via WebSocket, document checkpoints in SQLite, catch-up by version. Honest scope is the senior signal.”
