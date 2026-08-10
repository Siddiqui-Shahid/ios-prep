# Audio script — Sample 05 — System-design mock: Image Loading Library (Q&A)
> Listen-only sample Q&A from `05-system-design-mock.md`. Spoken answers and follow-ups.

## §0 Q1. Interviewer: “Design Image Loading Library.” How do you open?

Next. Q1. Interviewer: “Design Image Loading Library.” How do you open? Answer. “I’ll take about five minutes clarifying scope and scale. Then a four-layer client high-level design with backend touchpoints and load. Then A P I and data. Two deep dives: three-tier cache, and downsample plus dedupe plus cancel. I’ll close on failures, metrics, and kill switches. Does that plan work? Before I draw: download, decode, L1/L2 cache, cancel on reuse — or also GIF and video? Rough memory budget for decoded L1 — say around 50MB? CDN only GET, or a custom image A P I? WebP/AVIF accept negotiation? Out of scope for me: upload, editing, CDN architecture — okay? Cell reuse cancel required?” Do not draw until they answer or you state labeled assumptions. Keep backend load in mind from minute one. Follow-ups. Skip agenda?: “Don’t — they may want different dives.”. Clarify 15 min?: “Hard stop at five. Rest becomes labeled assumptions.”. No numbers?: “Give labeled daily active users estimates and continue.”.

## §1 Q2. After clarify — what does the good flow look like?

Next. Q2. After clarify — what does the good flow look like? Answer. “For this mock: still-image pipeline; L1 around 50MB NSCache plus disk around 500MB; cancel on reuse. Out: GIF/video decode, upload, CDN design. Good flow: agenda, clarify, confirm, high level design with four layers plus backend plus load, A P I, two deep dives, last five minutes ops. Weak flow: drawing in silence, only happy path, inventing QPS as fact, skipping ops.” Follow-ups. Scope changes mid-high level design?: “Re-confirm in/out in twenty seconds. Adjust dives. Protect ops.”. Forgot offline?: “Assumption: online-first plus last-good cache — correct me if wrong.”.

## §2 Q3. Walk the HLD — client layers, backend, load?

Next. Q3. Walk the HLD — client layers, backend, load? Answer. “Pipeline: URL, then dedupe, then L1 NSCache, then L2 disk, then network CDN, then ImageIO downsample, then display. Download and decode off main; MainActor only for UIImage assignment. Load: Cache-Control max-age around seven days; Accept webp/avif; decoded cost is width times height times four — always downsample to view size. Where A R C bites: retain cycles in completion handlers; cancel tokens on deinit and reuse.” Follow-ups. Three tiers?: “Memory, disk, network — write-around for decoded often.”. Forever L1?: “NSCache with a cost limit and memory warnings — not a singleton forever map of VCs.”.

## §3 Q4. Data / API — entities, endpoints, scale?

Next. Q4. Data / API — entities, endpoints, scale? Answer. “GET the image URL with Cache-Control. Library A P I: load with url, target size, priority — returns a cancelable Task. Dedupe identical in-flight URLs; priority boost for on-screen. Completions capture weak owners so a recycled cell doesn’t keep a request graph alive forever.” Follow-ups. Same URL two cells?: “One download; fan-out completions.”. Auth images?: “Inject headers via session; don’t put tokens in URL query if avoidable.”.

## §4 Q5. Deep dive 1 — 3-tier cache?

Next. Q5. Deep dive 1 — 3-tier cache? Answer. “L1 cost-based NSCache around 50MB responds to memory warnings. L2 disk LRU around 500MB. Network last. Combined hit target above 80%; L1 above 40%. On memory warning clear L1, keep disk. Disk full — LRU free about 20% and continue. This is bounded cache design — not a singleton that forever retains screens.” Follow-ups. Why NSCache not Dictionary?: “Cost limits and purge under pressure — Dictionary forever-grows.”. Decode into L1 full-res?: “No — downsample first or you blow the budget.”.

## §5 Q6. Deep dive 2 — Downsample, dedupe, cancel?

Next. Q6. Deep dive 2 — Downsample, dedupe, cancel? Answer. “ImageIO create thumbnail at display size — never full decode then scale. Cancel on prepareForReuse; generation token ignores stale completions. Decode p50 under 10ms / p99 under 50ms as labeled targets from the spec. Same cancel discipline as Task-outlives-screen on Day 03 — don’t let a completion strongly own the cell or view controller.” Follow-ups. GIF asked?: “Out of scope unless pulled — separate decoder plus memory budget.”. Main-thread decode?: “Classic hitch — always background.”.

## §6 Q7. Ops — failures, metrics, rollout, load?

Next. Q7. Ops — failures, metrics, rollout, load? Answer. “Track L1/L2 hit rates, decode latency, OOM rate under 0.1% as a target, scroll hitch. Kill switch: disable high-res prefetch under memory pressure. Instruments angle from Day 03: Allocations for decode spikes and abandoned heaps; Memory Graph if a loader completion keeps a view controller alive; Crashlytics for jetsam clusters — Graph doesn’t replace fleet signals.” Follow-ups. HeroWidget link?: “Pause and cancel media on disappear — same cancel discipline.”. Invented crash-free %?: “Forbidden — use resume-backed numbers or label as target.”.

## §7 Q8. Flow scorecard — did you hit the optimal spine?

Next. Q8. Flow scorecard — did you hit the optimal spine? Answer. “Pass bar: clarify plus agenda in five minutes or less; high level design shows four layers plus backend plus load; A P I has cancel and dedupe; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: main-thread decode; unbounded Dictionary cache; inventing QPS as fact; never reaching ops; blob architecture with no data flow. Spine: zero to five clarify, five to fifteen high level design, fifteen to twenty-five A P I, twenty-five to forty dives, forty to forty-five ops.” Follow-ups. Ran long on dive 1?: “Park dive 2 bullets; protect ops five minutes.”. Forgot load?: “One sentence: daily active users to labeled QPS, cache TTL, single-flight.”.
