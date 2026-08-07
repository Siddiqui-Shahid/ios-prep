# Audio script — Sample 01 — Cache tiers (Q&A)
> Listen-only sample Q&A from `01-cache-tiers.md`. Spoken answers and follow-ups.

## §0 Q1. What is the image loading pipeline, in plain words?

Next. Q1. What is the image loading pipeline, in plain words? Answer. Showing a remote image is a pipeline, not Data(contentsOf:). Ask for a URL at a target pixel size. Check memory (L1) for a decoded image already sized. Else check disk (L2) for bytes → decode/downsample off main. Else download, downsample, store, display. If the cell scrolled away — cancel and ignore late results. Video adds: don’t play when invisible. Live audio adds: session interruptions — not bitmap TTL. Follow-ups. Why target pixel size first?: Decoded bitmap size drives RAM — display size × scale, not original JPEG dimensions.. Cancel on scroll?: Prevents wrong image flash and wasted decode/network work.. Video vs image lifecycle?: Ads video needs pause/play contract; images need cancel + cache tiers..

## §1 Q2. What are L1, L2, and L3?

Next. Q2. What are L1, L2, and L3? Answer. L1 is memory cache of decoded images (NSCache or custom LRU actor). L2 is disk cache of encoded bytes under Caches/. L3 is network/CDN (+ optional HTTP URLCache for raw bytes). L1 keys must include url + targetSize. L1 evicts on memory warning and cost limits; L2 uses LRU + TTL (~7d) — OS may purge; that’s OK for images. Follow-ups. L1 cost model?: ≈ decoded bytes — width × height × 4 for ARGB8888.. Write policy?: Decode → L1 immediately for U I; write L2 async — don’t block main on disk.. L3 alone enough?: No — see URLCache question below..

## §2 Q3. What decoded-size math must you quote?

Next. Q3. What decoded-size math must you quote? Answer. A 1000×1000 ARGB8888 image is roughly 4 MB decoded (1000 × 1000 × 4 bytes). Thirty full-res feed thumbnails in L1 is catastrophe. Always downsample to display size and key L1 by url + targetSize — not URL alone (avatar vs hero would collide or waste RAM). Follow-ups. Same URL, two sizes?: Two L1 entries — different keys — or you get blurry/huge wrong reuse.. Why not full-res in L1 “for zoom”?: Feed cells don’t need it — decode on demand for zoom if product requires.. Senior one-liner?: “Decoded size dominates RAM; bytes on disk are cheap by comparison.”.

## §3 Q4. Why is URLCache alone insufficient?

Next. Q4. Why is URLCache alone insufficient? Answer. URLCache may store response bytes, but U I still needs downsampled decode, memory pressure policy, dedupe across image views, and cancellation on cell reuse. Senior line: “HTTP cache ≠ UIImage cache.” L3 complements L1/L2 — it does not replace them. Follow-ups. What URLCache gives you?: Raw byte reuse on repeat requests — still CPU to decode unless L2/L1 hit.. Dedupe across views?: Coordinator tracks in-flight tasks per key — URLCache doesn’t fan-out to N image views.. ETag / HTTP cache role?: Bandwidth savings at L3 — orthogonal to decoded L1 eviction..

## §4 Q5. What is scroll-safe loading in five rules?

Next. Q5. What is scroll-safe loading in five rules? Answer. (1) Cancel when off-screen. (2) Dedup same cache key — one in-flight fetch, N observers. (3) Priority: visible cells prefetch. (4) Cap prefetch on fast fling. (5) Never decode JPEG on main — stay under ~16ms frame budget at 60Hz. Follow-ups. Generation / token pattern?: Capture expected URL or request id; ignore completion if mismatch after reuse.. Prefetch footgun?: Decode storms on fling — bound concurrency and cancel when scroll direction changes.. SwiftUI note?:.task(id: url) helps cancellation — still reason about view identity..

## §5 Q6. What are dedup and generation tokens?

Next. Q6. What are dedup and generation tokens? Answer. Dedup: one in-flight fetch per cache key; multiple image views attach as observers; fan-out on complete. Generation / token: on cell reuse, increment or replace token; when async work completes, ignore result if token doesn’t match — prevents wrong image in cell even if cancel raced. Follow-ups. prepareForReuse duties?: Clear image, cancel prior request, bump token.. Cancel last observer policy?: Some loaders cancel Task when last observer detaches — policy choice.. Symptom without tokens?: Avatar from previous row flashes on fast scroll..

## §6 Q7. What should I say after foundations?

Next. Q7. What should I say after foundations? Answer. “Draw L1 memory decoded, L2 disk bytes, L3 network. Quote ~4MB for 1000×1000 decoded. Key by url + targetSize. URLCache is not UIImage cache. Scroll-safe: cancel, dedup, prioritize visible, cap prefetch, decode off main. HeroWidget pauses video when off-screen — different contract from image TTL.” Follow-ups. NSCache vs Dictionary for L1?: NSCache evicts under pressure; Dictionary needs manual purge + isolation (actor/lock).. Memory warning action?: Trim L1; pause non-visible media/decodes; keep L2.. Next sample?: 02-image-pipeline.md — ImageIO and coordinator high level design..
