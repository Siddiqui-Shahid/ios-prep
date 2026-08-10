# Audio script — Revision guide — Image/Video Pipelines, Caching & Memory Pressure
> Listen-only revision day guide from `day-16.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: End-to-end image pipeline: L1 memory → L2 disk → network, with downsample-before-decode-to-display-size Why decoded bitmap size (width × height × 4) dominates RAM — not JPEG file size Request deduplication, cancellation, and cell reuse for scroll performance.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Image pipeline

Next. 2.1 Image pipeline. 2.1 Image pipeline.

## §3 2.2 Decoded size math

Next. 2.2 Decoded size math. 1000×1000 ARGB8888 ≈ 4 MB decoded. A 200 KB JPEG on disk can still blow RAM if decoded full-res.

## §4 2.3 Scroll-safe loading

Next. 2.3 Scroll-safe loading. Cancel on cell reuse; dedupe in-flight requests; match generation token before applying image to cell.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow Ads pipeline + HeroWidget lifecycle: BookMyShow Ads — HeroWidget pause/play on revenue-critical video; P O P + Generics pipeline. Audio streaming + server-driven splash (Aces): Aces audio streaming + server-driven splash — session/interruptions, not bitmap LRU. Soft: Stories S D K (Raw / Miami Heat) — inject image loader into Stories S D K; don’t hardcode a loader inside the S D K. Interview line (≤20s): “I treat image caching as decoded-bitmap policy — downsample, dedupe, cancel on reuse — and HeroWidget video as a lifecycle contract, not a cache problem.”.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. L1 / L2 / L3 cache tiers — what each holds 2. Decoded bitmap math — quote the 1000×1000 example 3. Why cache key is url + targetSize, not URL alone 4. Wrong image in reused cell — root cause and fix.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
