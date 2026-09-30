# Sample design — realtime location (rides)

They say: “Design driver and rider location.” Battery first, then the map.

## Problem

Driver moves. Rider watches a car. 100k concurrent trips would melt you if every phone streams GPS at 1Hz. The senior answer starts with sampling, not with a prettier pin.

## Requirements (2 minutes — ask, then lock)

Don’t stream 1Hz for everyone. Batch by time or meters. `CLLocationManager`: accuracy versus significant-change, distance filter on. In-trip: **WebSocket**. Backgrounded: **APNs** / cheaper cadence. Smooth on the rider map; don’t redraw every point at 60fps if off-screen. Stop everything when the trip ends.

Confirm: “In-trip WS, batched points, rider interpolates, no 1Hz, permissions are when-in-use unless legal says always. OK?”

## API and data

```
WS  /v1/trips/{id}/location
POST /v1/trips/{id}/points   batch of { lat, lon, ts, acc }
```

Server assigns trip id. Encode polyline for the rider snapshot so catch-up is one payload.

## iOS LLD (types and sequence)

Driver: CL → filter / simple smooth → batch 3–4 points / 4s while active, about 15s in background if the OS allows. Heartbeat 30s on the socket.

Rider: WS → interpolate ~4s → map polyline delta. Don’t bind raw GPS to `MKAnnotation` every Hertz.

Permissions: when-in-use versus always is a product/legal sentence. Say you will not silently upgrade. Battery: significant-change when the trip is idle. Kill the socket on end.

Failure: socket drop → rider last polyline plus “reconnecting.” Driver queues a small batch on disk (a tiny outbox, not the full sync engine).

## HLD (scale, cache, consistency)

Gateway → location service → a log → ETA service → Redis Geo for nearby. Rider fan-out on trip id, not a global firehose. If they want numbers, label them: 2–4s active updates, not 1Hz.

The rider can be a few seconds behind. That is eventual and honest. The driver should see their own last batched send locally so the UI doesn’t jump.

## Tradeoffs

Kalman versus “average last N”: say simple first; Kalman if they are a maps company. Live Activities: nice; not required to pass. Background location without a trip: don’t.

## 60-second close

“If they ask me to wrap: batch points, distance filter, WebSocket in-trip, APNs as backup, interpolate on the rider, stop on trip end. I will not stream 1Hz GPS to impress the board.”
