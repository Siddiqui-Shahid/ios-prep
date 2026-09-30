# HLD — scale, sync, and worked product sketches

## Sizing mini-math (do it on paper once)

Assume **5 million DAU**, 20 feed opens/user/day, 1 request per open, peak 4× average.

`QPS_avg = 5e6 * 20 / 86400 ≈ 1157`

`QPS_peak ≈ 4600`

A single well-indexed Postgres read replica can often handle this for **metadata**; images never come from Postgres — they come from **object storage + CDN**.

If an image is 200KB and each user sees 50/day: `5e6 * 50 * 200KB` ≈ **50 TB/day** egress — this is why CDN and aggressive client caches matter. Interviewers like that you **noticed media dwarfs JSON**.

## Offline sync engine (deep dive)

**Sync** (replicating local writes to server and remote changes down).

Patterns:

1. **Last-write-wins** (timestamp; simple; can lose data).
2. **CRDT** (Conflict-free Replicated Data Type: merge without locks — overkill for most list apps).
3. **Operational transform** (Google Docs; you will rarely implement this on iOS in 45 minutes — name it and decline to fake it).
4. **Row version / 409 Conflict** then prompt the user.

**Outbox** (SQLite table of pending mutations; a loop drains when online). Fields: `id`, `type`, `payload`, `created_at`, `tries`, `status`.

**Background:** `BGTaskScheduler` + `URLSession` background. Never promise exact hourly sync.

**Clock:** don’t trust device time for conflict; prefer server `updated_at` + monotonic `op_id`.

## Push

APNs device token is **not** a user id; it rotates. Store mapping server-side. Payload small; fetch hydrate on tap. **Provisional** / **alert** / **silent** (content-available: 1) — silent is heavily throttled; do not build sync only on silent push.

## Worked sketch: ticket / event listing (BookMyShow-shaped, not a claim)

**HLD boxes:** iOS → API Gateway → Catalog service → Redis (hot events) → Postgres. Seat map: **short TTL hold** in Redis (2 minutes) then payment. **Idempotent** booking. Images/CDN. SDUI (Server-Driven UI: JSON describes widgets so you ship offers without an App Store build).

**Mobile constraints:** seat map memory; don’t decode a 8K PNG. Feature flag for payment SDK.

**Failure:** hold expired → 409 → refresh map. Network drop after pay → poll order id.

## Worked sketch: chat

Gateway → connection balancer → chat service → Kafka/queue → fanout → Redis presence. iOS: WebSocket in foreground, APNs in background, SQLite messages, catch-up `GET /messages?after=seq`. **Ordering:** server sequence numbers, not client timestamps.

## Worked sketch: location tracking (delivery)

Throttled GPS (`CLLocationManager` significant-change vs kCLLocationAccuracyBest). Batch points. Don’t stream 1Hz to server from 100k riders — that’s a bill and a battery crime. Encode polyline, send every N seconds or M meters.

## Security HLD

TLS everywhere. Token refresh **single-flight**. Rotate refresh tokens. Pinning optional. **PII** (Personally Identifiable Information) minimization. Screenshot flag on payment screens (`isSecureTextEntry`, screen capture notify).

## Checklist before you say “I’m done”

- [ ] Scale number spoken
- [ ] Client cache layers named
- [ ] Pagination is cursor
- [ ] One consistency sentence
- [ ] One failure + metric
- [ ] One mobile constraint (battery, offline, or store version)

If all six are checked, you sound senior even if the boxes are simple.
