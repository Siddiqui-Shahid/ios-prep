# Audio script — Sample spoken answers (cover → speak → check)

## §0 Introduction

Sample spoken answers (cover → speak → check) Each A is a target length. Record yourself on the train if you have earphones.

## §1 Q. Walk me through ARC.

A (45s): “ARC is Automatic Reference Counting: each strong reference increments a count; at zero, deinit runs. It is not a tracing GC. Cycles happen when objects own each other, especially closures capturing self. I break them with weak delegates and [weak self] on escaping closures. I verify with Memory Graph, not guesswork.”

## §2 Q. GCD or Swift Concurrency?

A (45s): “New code is async/await with actors for isolation and MainActor for UI. I still read GCD because queues and DispatchGroup exist in production. I don’t mix hops randomly. I cancel Tasks when views disappear.”

## §3 Q. Design a feed (HLD, 3 min).

A: “Clarify DAU and offline. Client → gateway → feed service → cache → store. Media on CDN. iOS: SQLite + memory cache, cursor GET /feed?after= . Likes optimistic with overlay. Background: APNs, not a forever socket. Deep dive: pagination and images. Ops: p95 TTFV, crash-free, kill switch.”

## §4 Q. Design a feed (LLD, 3 min).

A: “FeedView, FeedViewModel on MainActor, FeedRepository, HTTPClient protocol, FeedStore actor. Appear: emit cache, then network. URLSession shared. Decode off main. Pagination appends. ImageLoader coalesces by URL and cancels on reuse. Tests fake the client.”

## §5 Q. How do you paginate?

A (30s): “Cursor, not page index. Server opaque token. Client stores nextCursor. Duplicate ids: upsert by id so rotations don’t double-insert.”

## §6 Q. Offline writes?

A (45s): “Outbox table in SQLite: id, type, payload, tries, status. Drain when NWPath becomes satisfied. Idempotency keys on the wire. Conflicts: 409 then last-write-wins or user prompt depending on the entity. BGTaskScheduler is best-effort.”

## §7 Q. Images and memory?

A (45s): “Decoded cost is width × height × 4. Downsample to view size before cache. NSCache with cost and memory warnings. Disk for original or medium. Prefetch next few URLs only. Don’t keep 4K bitmaps in a table view.”

## §8 Q. Payments on mobile?

A (60s): “No PAN on our servers if we can tokenize. Local order id persisted first. POST with Idempotency-Key. 3DS may background us; we reconcile with GET order. Disable double tap. Receipt only after terminal state. Tokens in Keychain.”

## §9 Q. SDUI?

A (45s): “Server-Driven UI: JSON describes sections so marketing changes without a binary. Client has a widget registry; unknown types skip for forward compatibility. Version the schema. Cache the document. Don’t put executable code in JSON.”

## §10 Q. You have 60–90 minutes on the Mumbai–Pune train. How do you prep?

A (20s): “I follow Trip A or B in this app: fifteen minutes of basics, twenty of LLD, twenty-five of HLD, then one of the thirty machine-design questions. I don’t binge the archived four-week track.”

## §11 Indirect questions (they disguise the same topics)

| They say | You hear | |---|---| | “Why did the list jump?” | Pagination identity / diffable | | “Users on airplane mode?” | Cache + outbox | | “It works on Wi-Fi not 4G” | payload size, timeouts, retries | | “App was killed in payment” | persisted order id | | “Battery drain complaints” | GPS, polling, background location |

## §12 Tricky

Q. Is weak self always required? A: No. Non-escaping closures don’t need it. unowned only if lifetime is certain. Don’t sprinkle weak without a cycle. Q. Should every screen be SwiftUI? A: No. Interop and performance still pick UIKit. I decide per screen. Q. Redis on the iPhone? A: No. Redis is server-side. On device: SQLite, NSCache, files, Keychain.
