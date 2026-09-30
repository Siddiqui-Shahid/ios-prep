# Sample design — infinite social feed

You are on the whiteboard. They say: “Design an infinite social feed for iOS.”

Do not start drawing UITableView. Start talking.

## Problem

A home timeline of posts with text, images, maybe video thumbs. Users scroll forever, pull to refresh, like, and come back tomorrow on the train with bad radio.

## Requirements (2 minutes — ask, then lock)

If they ask nothing, *you* ask:

- **DAU** (Daily Active Users): I label an assumption, e.g. 5 million, unless they give a number. I do not invent QPS as a fact.
- Offline: last good feed on disk, or online-only? I assume last-good cache.
- Write path: likes only, or compose too? I park compose unless they want it.
- Pagination: **cursor** (opaque server token), never `page=5` on a live feed.
- Freshness: pull-to-refresh plus optional push. Not a 1Hz WebSocket unless they insist.

Then confirm in one sentence: “Infinite read feed, likes, cursor pages of 20, last-good offline, images via CDN. Compose out. Does that work?”

## API and data

Entities: `Post` (id, author, body, media URLs, likeCount, likedByMe, createdAt). `Cursor` is base64 the server understands. You never decode it on the client to “page 7”.

```
GET /v1/feed?after={cursor}&limit=20
→ { items: [Post], next_cursor: String?, etag: String }
POST /v1/posts/{id}/likes
Idempotency-Key: uuid
```

**ETag** (cache validator): warm launch sends `If-None-Match`. 304 means keep disk. Offset pagination duplicates or skips when a new post inserts at the top. That is why seniors say cursor.

Load math you can say without lying: 5M DAU × 20 opens × 1 request, peak ~4× average. You label it as an estimate. Server cost of a cursor is O(1) at any depth if they did it right.

## iOS LLD (types and sequence)

Speak the types while you box them:

| Type | Role | Thread |
|---|---|---|
| `FeedView` | list | `@MainActor` |
| `FeedViewModel` | `LoadState`, `loadMore` | MainActor |
| `FeedRepository` | cache then network | async |
| `FeedAPI` | URLSession | background callbacks |
| `FeedStore` | SQLite actor | actor |
| `ImagePipeline` | decode + L1/L2 | not main |
| `LikeOverlay` | pending likes by id | memory |

**Cold start:** empty store → spinner → GET → persist → render. Prefetch the first five image URLs.

**Warm start:** read SQLite → paint immediately (**stale-while-revalidate**: show disk, refresh behind) → merge by id.

**Pagination:** one in-flight `loadMore`. Cancel it on pull-to-refresh. Do not fire two pages when the phone rotates.

**Likes:** **optimistic** (UI first). Keep `LikeOverlay` so **read-your-writes** holds: my like must not flicker when the stale feed page returns. Rollback on 4xx.

**Images:** coalesce by URL. Cancel on cell reuse. Downsample off main. A 1000×1000 **ARGB** bitmap is 4 MB decoded. Thirty of those in L1 is how you get **Jetsam** (OS kills you for memory).

Failure: no network + cache → banner + rows. No cache → empty + retry. Decode error on one item → drop that row, do not blank the list.

## HLD (scale, cache, consistency)

Boxes: iOS → API gateway → Feed service → Redis hot timeline → Postgres source → media **CDN** (edge cache for bytes).

Cache: L1 `NSCache` for decoded thumbs (cost = pixels × 4), L2 disk for JSON + image files, HTTP cache with ETag.

Consistency: other people’s posts can be **eventual** (replicas catch up). Mine cannot flicker. That is the only consistency speech they need unless they push further.

Single-flight the first page. Do not stampede the API from every cell.

## Tradeoffs

- WebSocket for “new posts”: nicer, more battery and reconnect work. Pull-to-refresh is honest for v1.
- Core Data vs SQLite: either is fine if writes are off main and you can explain a merge. I pick SQLite + actor because the interview stays in types you can draw in five minutes.
- Prefetch 3 vs 10 images: 3 is the adult answer on cellular.

## 60-second close

“If they ask me to wrap: the hard part is not the list. It is cursor pagination, stale-while-revalidate, coalesced images, and a like overlay so my writes don’t flicker. Offline is last-good disk, not a fake sync engine. I would not use page numbers on a live feed.”
