# Audio script — Sample design — offline-first sync

## §0 Introduction

Sample design — offline-first sync They say: “Design sync so the app works on the train.” This is not iCloud hand-waving. This is an outbox .

## §1 Problem

User likes, drafts, and form fields must survive airplane mode. Later the radio returns. Two devices exist. Clocks lie. If you start with “we’ll use CloudKit,” they will ask about your own backend and you will stall.

## §2 Requirements (2 minutes — ask, then lock)

Local SQLite is the source of truth the UI reads. An outbox table holds id, type, payload, tries, status, createdAt. Drain when NWPath is satisfied. BGTaskScheduler is best-effort background work, not cron — never promise hourly sync. Conflicts return 409 , then last-write-wins or a user prompt — pick one and say why. Don’t trust the device clock; prefer server updated at . Idempotency-Key on writes. Silent APNs is throttled; never the only wake-up. Confirm: “SQLite is truth, outbox for writes, pull by server sequence, APNs is a hint. Likes can last-write-wins; notes prompt the user. Good?”

## §3 API and data

POST /v1/sync/push body: [{ op id, type, payload }] GET /v1/sync/pull?after={serverSeq} Or per-resource REST with the same outbox wrapping it. op id is the idempotency key. Pull returns a server sequence, not “all rows since ISO timestamp from the phone.”

## §4 iOS LLD (types and sequence)

Types: SyncStore actor (SQLite WAL), OutboxDrainer , PullApplier , PathMonitor . UI never writes the network first. Write: UI mutates the local row → insert outbox → try drain. If offline, the UI already shows local truth. That is the product. Drain: take a batch → POST → mark done or increment tries. After N failures, surface a banner; don’t infinite-loop. Pull: GET after seq → apply in a transaction → bump seq. Never apply on main. Conflict: 409 → fetch the server entity → LWW on updated at from the server , or ask the user for a note field. Calendar and money get the prompt. Feed likes can LWW. Foreground: drain on path satisfied and on scenePhase active. Background: schedule BGAppRefreshTask ; treat it as a maybe.

## §5 HLD (scale, cache, consistency)

Server serializes per-user or per-entity. Redis is not your source of truth. Postgres holds seq. Push (APNs) is a hint to pull. If APNs is dropped, the next open still pulls. That is how you stay honest about Apple’s budget. Scale: batch ops. Don’t POST one like per request from a queue of 400. My writes are read-your-writes locally. Other devices catch up via seq. That is the consistency speech.

## §6 Tradeoffs

CRDT vs “server wins”: CRDTs are a 45-minute trap unless they asked for a collaborative editor. Say so. Core Data CloudKit is fine for Apple-only personal data, not your multi-platform backend. Sync the active screen first; syncing everything ships later.

## §7 60-second close

“If they ask me to wrap: SQLite is truth, outbox drains with idempotent ops, pull by server sequence, APNs is a hint, BGTask is best-effort, clocks are not keys. Conflicts are a product sentence, not a shrug.”
