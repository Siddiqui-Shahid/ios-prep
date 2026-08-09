# Audio script — Sample 05 — System-design mock: Image Loading Library (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Image Loading Library.” How do you open?

Next. Q1. Interviewer: “Design Image Loading Library.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on 3-tier cache and Downsample, dedupe, cancel, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. In scope: download + decode + L1/L2 cache + cancel on reuse — or also GIF/video? 2. Memory budget for decoded L1 (e.g. ~50MB)? 3. CDN only GET, or custom image A P I? 4. Must support WebP/AVIF accept negotiation? 5. Out of scope: upload, editing, CDN architecture? 6. Cell reuse cancel required? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Still-image pipeline; L1 ~50MB NSCache + disk ~500MB; cancel on reuse; out: GIF/video decode, upload, CDN design. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load.

Next. Q3. Walk the HLD — client layers, backend, load Answer. Pipeline: URL → (dedupe) → L1 NSCache → L2 disk → network CDN → ImageIO downsample → display. Threads: download/decode off main; MainActor only for UIImage assignment. Load: Cache-Control max-age ~7d; Accept webp/avif; decoded cost = width×height×4 — always downsample to view size. Follow-ups. Where A R C bites?: Retain cycles in completion handlers; cancel tokens on deinit/reuse.. Three tiers?: Memory / disk / network — write-around for decoded often..

## §3 Q4. Data / API — entities, endpoints, scale.

Next. Q4. Data / API — entities, endpoints, scale Answer. GET {image_url} with Cache-Control. Library A P I: load(url, targetSize, priority) → Task cancelable. Dedupe identical in-flight URLs; priority boost for on-screen. Follow-ups. Same URL two cells?: One download; fan-out completions.. Auth images?: Inject headers via session; don’t put tokens in URL query if avoidable..

## §4 Q5. Deep dive 1 — 3-tier cache?

Next. Q5. Deep dive 1 — 3-tier cache? Answer. L1 cost-based NSCache (~50MB) responds to memory warnings. L2 disk LRU (~500MB). Network last. Combined hit target 80%; L1 40%. Follow-ups. Memory warning?: Clear L1; keep disk.. Disk full?: LRU free ~20%; continue..

## §5 Q6. Deep dive 2 — Downsample, dedupe, cancel?

Next. Q6. Deep dive 2 — Downsample, dedupe, cancel? Answer. ImageIO create thumbnail at display size — never full decode then scale. Cancel on prepareForReuse; generation token ignores stale completions. Decode p50 <10ms / p99 <50ms targets from spec. Follow-ups. GIF asked?: Out of scope unless pulled — separate decoder + memory budget.. Main-thread decode?: Classic hitch — always background..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. L1/L2 hit rates, decode latency, OOM rate <0.1% target, scroll hitch. Kill: disable high-res prefetch under memory pressure. Follow-ups. HeroWidget link?: Pause/cancel media on disappear — same cancel discipline.. Instruments?: Allocations + Time Profiler for decode spikes — Day 03 tools..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
