# Audio script — Sample 05 — System-design mock: Image Loading Library (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Image Loading Library.” How do you open?

Next. Q1. Interviewer: “Design Image Loading Library.” How do you open? Answer. Agenda (≤20s): “I’ll take ~5 minutes clarifying scope and scale, then a four-layer client high level design with backend touchpoints and load, then A P I/data, two deep dives on Downsample + cache tiers and Cancel / HeroWidget media, and close on failure modes, metrics, and kill switches. Does that work?” Then ask the interviewer (speak these): 1. Still images pipeline — GIF/video out unless asked? 2. L1/L2 budgets? 3. Feed integration / prefetch? 4. HeroWidget video pause separate? Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from the first minute. Follow-ups. Skip agenda?: Weak senior signal — interviewer may want different dives.. Clarify for 15 min?: Hard stop at 5 — park extras as labeled assumptions.. They refuse numbers?: State labeled estimates from daily active users context; continue..

## §1 Q2. After clarify — what does the optimal flow look like?

Next. Q2. After clarify — what does the optimal flow look like? Answer. Scripted outcomes for this mock: Image pipeline deep; video-feed-streaming as follow-up if pulled; HeroWidget pause separate media contract. Good flow: agenda → clarify Qs → confirm → high level design (4 layers + backend + load) → A P I → two crisp dives → ops last 5. Weak flow: silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops. Follow-ups. They change scope mid-high level design?: Re-confirm in/out in 20s; adjust dives; protect ops.. Backend mesh deep-dive?: Out unless asked — sketch touchpoints, stay client-owned.. Forgot to ask offline?: State online-first + last-good cache as assumption; invite correction..

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. Image pipeline as Day 03/spec; place beside feed repository. Video: AVPlayerPool sister doc if asked. CDN Cache-Control; downsample; cancel on reuse. Follow-ups. Video in scope suddenly?: Switch dive to player pool — don’t pretend ImageIO handles GIF frames.. Audio?: Aces audio — separate session category..

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. Image GET + library cancelable load. Video: feed cursor + stream URLs if pulled. Follow-ups. Thumb vs full?: List thumbs; detail full — separate cache keys.. Prefetch policy?: Next page thumbs only..

## §4 Q5. Deep dive 1 — Downsample + cache tiers?

Next. Q5. Deep dive 1 — Downsample + cache tiers? Answer. Cost eviction; memory warning clears L1; disk LRU. Never full-res decode. Follow-ups. WebP?: Accept negotiation; size win 25–35% vs JPEG per spec.. Hit rate targets?: L1 40%, combined 80%..

## §5 Q6. Deep dive 2 — Cancel / HeroWidget media?

Next. Q6. Deep dive 2 — Cancel / HeroWidget media? Answer. Cancel on reuse; generation token. If video: pause on disappear/offscreen — HeroWidget lifecycle. Follow-ups. Animated WebP?: Out unless asked — separate decoder.. Related doc?: video-feed-streaming.md..

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. Decode latency, OOM, hitch; video stall if pulled. Kill: disable prefetch. Follow-ups. Production?: HeroWidget; Aces audio/media instincts.. Instruments?: Day 17 APM continues metrics..

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. Pass bar: clarify + agenda in ≤5; high level design shows 4 layers + backend + load; A P I has cursors/idempotency as needed; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: offset pagination on dynamic feeds; main-thread SQLite/decode; inventing QPS as fact; never reaching ops; blob “architecture” with no data flow. Spine: 0–5 clarify · 5–15 high level design · 15–25 A P I · 25–40 dives · 40–45 ops. Follow-ups. Ran long on dive 1?: Park dive 2 bullets; protect ops 5 min.. Forgot load?: One sentence: daily active users → labeled QPS, cursor cost, single-flight.. Invented crash-free %?: Forbidden — use resume-backed numbers or label as target..
