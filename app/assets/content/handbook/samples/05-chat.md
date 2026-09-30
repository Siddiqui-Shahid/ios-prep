# Sample design — iOS chat

They say: “Design messaging.” You have 45 minutes. You will not design Signal.

## Problem

1:1 or small group chat. Send, receive, catch up after a tunnel, still notify when the app is backgrounded. If you start with end-to-end crypto, you will spend the hour on a ratchet you cannot finish.

## Requirements (2 minutes — ask, then lock)

Foreground: **WebSocket** (`URLSessionWebSocketTask`, bidirectional). Background: **APNs**. Catch-up: `GET /messages?after=seq` using **server sequence**, not client time. SQLite **WAL** (Write-Ahead Logging: readers don’t block the writer as hard). Message state machine: sending → sent → delivered → read. Heartbeat about 30s; reconnect with backoff + jitter. **E2EE** (end-to-end encryption) only if you can name a double ratchet. Otherwise: TLS in transit, server encryption at rest, and you do not fake crypto.

Confirm: “1:1 plus small groups, WS in foreground, APNs in background, catch-up by seq, no ratchet. OK?”

## API and data

```
WS  /v1/chat
GET /v1/messages?thread_id=&after_seq=&limit=50
POST /v1/messages   Idempotency-Key, body, client_msg_id
```

`client_msg_id` dedupes retries. Server assigns `seq` and `server_id`.

## iOS LLD (types and sequence)

`ChatView` ← MainActor VM ← `MessageRepository` ← `ChatSocket` + `MessageAPI` + `MessageStore` actor.

Send: insert local row `sending` with UUID → try WS → if WS down, POST REST → mark `sent`. ACK upgrades to `delivered`. The row never waits for the network to exist before it appears.

Receive: WS event → persist → if seq gap, REST catch-up. Never trust WS as the only history.

Reconnect: on `NWPath` plus exponential backoff. On resume, catch-up by last seq. Do not replay the whole thread.

UI: inverted list, stable ids, prefetch older pages upward. Images use the image pipeline sample — don’t inline a second cache. Typing indicators are best-effort; drop them under load.

Failure: offline send stays `sending` in the outbox sense. Socket drop shows reconnecting; history is still disk.

## HLD (scale, cache, consistency)

Chat service + a fan-out log + Redis presence with TTL. History partitioned by thread, seq monotonic per thread. You do not need to pick Cassandra vs Postgres if you say that sentence.

APNs payload is tiny: thread id, not the whole message. Hydrate on tap. One socket multiplexes threads. Server falls back to APNs when the socket is gone.

My send is read-your-writes locally. Other devices catch up via seq.

## Tradeoffs

XMPP vs custom WS: custom WS is the interview default. Push-to-talk and rich media: park unless asked. E2EE: the senior signal is knowing when you are not qualified in 45 minutes.

## 60-second close

“If they ask me to wrap: WebSocket in foreground, APNs in background, SQLite by server seq, local sending state, reconnect then catch-up. I will not invent a ratchet on the whiteboard.”
