# Day 16 — Image/Video Pipelines, Caching & Memory Pressure

> Week 3 · Revision pass ~45–60 min  
> Full study: [weeks/week-03/day-16/](../../../weeks/week-03/day-16/README.md)  
> Sample Q&A (guided): [weeks/week-03/day-16/sample/](../../../weeks/week-03/day-16/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- End-to-end **image pipeline**: L1 memory → L2 disk → network, with **downsample-before-decode-to-display-size**
- Why **decoded bitmap size** (`width × height × 4`) dominates RAM — not JPEG file size
- Request **deduplication**, **cancellation**, and cell **reuse** for scroll performance
- How **HeroWidget** pause/play ties video ads to visibility/lifecycle on a revenue-critical path
- How **Aces live audio** differs from image caching (session, interruptions, splash)
- Memory-pressure strategy: `NSCache` costs, purge on warnings, never decode full-res on main

## 2. Concept refresh (simple)

### 2.1 Image pipeline

```text
load(url, targetSize)
  → L1 NSCache (key: url + targetSize)
  → L2 disk → ImageIO downsample → L1 → UI
  → network fetch → downsample → store → notify
```

Use `CGImageSourceCreateThumbnailAtIndex` — decode at display size, not full resolution.

### 2.2 Decoded size math

1000×1000 ARGB8888 ≈ **4 MB** decoded. A 200 KB JPEG on disk can still blow RAM if decoded full-res.

### 2.3 Scroll-safe loading

Cancel on cell reuse; dedupe in-flight requests; match generation token before applying image to cell.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| HTTP cache | **Not** a UIImage cache — still need decode + L1 policy |
| Decoded 1000×1000 ARGB | ≈ **4 MB** — key by **url + targetSize** |
| Wrong image in cell | Missing cancel/token on reuse |
| HeroWidget | Pause when off-screen / background / reuse — **product contract** |
| Aces audio | **Not** image LRU — AVAudioSession + interruptions |
| BookMyShow Ads pipeline + HeroWidget lifecycle / Audio streaming + server-driven splash (Aces) | **No** invented fill-rate % or splash ms |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-03/day-16/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-03/day-16/01-foundations.md) | Gaps |
| Deepen | [social-feed.md](../../../ios-system-design/docs/social-feed.md) | Feed cache HLD |
| Drill | [07-revision-qna](../../../weeks/week-03/day-16/sample/07-revision-qna.md) | Timed answers |

## 4. Map to your work

**BookMyShow Ads pipeline + HeroWidget lifecycle:** BookMyShow Ads — HeroWidget pause/play on revenue-critical video; POP + Generics pipeline.  
**Audio streaming + server-driven splash (Aces):** Aces audio streaming + server-driven splash — session/interruptions, not bitmap LRU.  
**Soft:** Stories SDK (Raw / Miami Heat) — inject image loader into Stories SDK; don’t hardcode a loader inside the SDK.

**Interview line (≤20s):** “I treat image caching as decoded-bitmap policy — downsample, dedupe, cancel on reuse — and HeroWidget video as a lifecycle contract, not a cache problem.”

→ [BookMyShow Ads pipeline + HeroWidget lifecycle Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [Audio streaming + server-driven splash (Aces) Aces](../../stories/story-bank.md#s12--audio-streaming--server-driven-splash-raw--las-vegas-aces)

## 5. Flash prompts

1. L1 / L2 / L3 cache tiers — what each holds
2. Decoded bitmap math — quote the 1000×1000 example
3. Why cache key is url + targetSize, not URL alone
4. Wrong image in reused cell — root cause and fix
5. ImageIO downsample — why before decode, not after
6. HeroWidget — when to pause video
7. Aces audio vs image cache — what differs
8. Memory warning — what to purge first
9. BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s — no invented fill-rate %
10. URLCache — what it does and doesn’t do for UIImages

## 6. Timed drills

| Drill | Budget |
|---|---|
| Image pipeline diagram | 60s |
| Decoded size math | 30s |
| Scroll cancel + dedupe | 45s |
| HeroWidget lifecycle | 45s |
| Aces audio vs image cache | 45s |
| BookMyShow Ads pipeline + HeroWidget lifecycle ≤20s pitch | 20s |

Expand from [sample cards](../../../weeks/week-03/day-16/sample/) and [07-revision-qna](../../../weeks/week-03/day-16/sample/07-revision-qna.md) answer points.
