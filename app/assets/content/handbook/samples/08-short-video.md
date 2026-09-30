# Sample design — short-form video feed

They say: “Design Reels.” Players are the scarce resource, not the list.

## Problem

Vertical swipe, autoplay, sound off until unmute. Cellular. Thermal. Low Power Mode. If you keep ten **AVPlayer** instances, you will thermal-throttle and then Jetsam.

## Requirements (2 minutes — ask, then lock)

Pool **3 AVPlayers** (previous, current, next). Not ten decoders. Prefetch the next URL. Cap resolution on poor radio (for example 240p). Tear down the player two away. Impressions: 50% visible plus 1s. Same **cursor** feed as the social feed. Pause immediately off-screen.

Confirm: “Cursor pages of clips, three-player pool, ABR, Low Power means no prefetch. Upload out of scope. Good?”

## API and data

```
GET /v1/reels?after=&limit=10
→ { items: [{ id, hls_url, thumb, duration }], next_cursor }
```

Optional `X-Network-Quality`. Tokenized CDN URLs: refresh before expiry, don’t log secrets. JSON stays small. Video bytes are the CDN’s problem.

## iOS LLD (types and sequence)

`FeedVM` owns cursor plus identity. `AVPlayerPool` maps index → player. Prefetch about one ahead. **ABR** (adaptive bitrate) is the player plus HLS ladder, not your Swift decoder. You do not decode frames on CPU.

SwiftUI: stable ids. Recreating the player on identity churn is how you hitch. Memory warning: shrink the pool to 1. Low Power: no prefetch, lower rung. Audio session: playback; mix with others only if product says so.

Cold start: thumb first, then first segment. Warm: resume index from disk if you must, but do not restore ten players.

## HLD (scale, cache, consistency)

Feed service + Redis + **Video CDN** (HLS segments). Transcode is out of the iOS interview unless they ask — you sketch “ladder exists at the CDN.” Limit 10; playlist tiny; label a per-player memory budget; **TTFF** (time to first frame) as a metric, not a fantasy SLA.

Other people’s new clips can be eventual. The player currently on screen must not restart because a refresh merged the list wrong — identity by clip id.

## Tradeoffs

Custom renderer: no. AVPlayer. Prefetch 80% of next versus one segment / one quality rung ahead: the second one. Upload/record: out unless they expand scope.

## 60-second close

“If they ask me to wrap: three-player pool, cursor feed, prefetch one, ABR plus Low Power, tear down far players. I will not keep ten decoders or invent a codec.”
