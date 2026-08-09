# Sample 05 — System-design mock: Image Loading Library (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.  
> **Source:** [`ios-system-design/docs/image-loading-library.md`](../../../../ios-system-design/docs/image-loading-library.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)  
> **Angle:** Day 03 — **memory / decode** (ARC & Instruments parallel).  
> **Brain puzzles** at the bottom — ownership twists interviewers love.

---

### Q1. Interviewer: “Design Image Loading Library.” How do you open?

**Answer:**

> “I’ll take about five minutes clarifying scope and scale. Then a four-layer client high-level design with backend touchpoints and load. Then API and data. Two deep dives: three-tier cache, and downsample plus dedupe plus cancel. I’ll close on failures, metrics, and kill switches. Does that plan work?
>
> Before I draw: download, decode, L1/L2 cache, cancel on reuse — or also GIF and video? Rough memory budget for decoded L1 — say around 50MB? CDN only GET, or a custom image API? WebP/AVIF accept negotiation? Out of scope for me: upload, editing, CDN architecture — okay? Cell reuse cancel required?”

Do **not** draw until they answer or you state labeled assumptions. Keep backend load in mind from minute one.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | “Don’t — they may want different dives.” |
| Clarify 15 min? | “Hard stop at five. Rest becomes labeled assumptions.” |
| No numbers? | “Give labeled DAU estimates and continue.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q2. After clarify — what does the good flow look like?

**Answer:**

> “For this mock: still-image pipeline; L1 around 50MB NSCache plus disk around 500MB; cancel on reuse. Out: GIF/video decode, upload, CDN design.
>
> Good flow: agenda, clarify, confirm, HLD with four layers plus backend plus load, API, two deep dives, last five minutes ops.
>
> Weak flow: drawing in silence, only happy path, inventing QPS as fact, skipping ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scope changes mid-HLD? | “Re-confirm in/out in twenty seconds. Adjust dives. Protect ops.” |
| Forgot offline? | “Assumption: online-first plus last-good cache — correct me if wrong.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q3. Walk the HLD — client layers, backend, load

**Answer:**

> “Pipeline: URL, then dedupe, then L1 NSCache, then L2 disk, then network CDN, then ImageIO downsample, then display. Download and decode off main; MainActor only for UIImage assignment. Load: Cache-Control max-age around seven days; Accept webp/avif; decoded cost is width times height times four — always downsample to view size. Where ARC bites: retain cycles in completion handlers; cancel tokens on deinit and reuse.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Three tiers? | “Memory, disk, network — write-around for decoded often.” |
| Forever L1? | “NSCache with a cost limit and memory warnings — not a singleton forever map of VCs.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q4. Data / API — entities, endpoints, scale

**Answer:**

> “GET the image URL with Cache-Control. Library API: load with url, target size, priority — returns a cancelable Task. Dedupe identical in-flight URLs; priority boost for on-screen. Completions capture weak owners so a recycled cell doesn’t keep a request graph alive forever.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Same URL two cells? | “One download; fan-out completions.” |
| Auth images? | “Inject headers via session; don’t put tokens in URL query if avoidable.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q5. Deep dive 1 — 3-tier cache?

**Answer:**

> “L1 cost-based NSCache around 50MB responds to memory warnings. L2 disk LRU around 500MB. Network last. Combined hit target above 80%; L1 above 40%. On memory warning clear L1, keep disk. Disk full — LRU free about 20% and continue. This is bounded cache design — not a singleton that forever retains screens.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why NSCache not Dictionary? | “Cost limits and purge under pressure — Dictionary forever-grows.” |
| Decode into L1 full-res? | “No — downsample first or you blow the budget.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q6. Deep dive 2 — Downsample, dedupe, cancel?

**Answer:**

> “ImageIO create thumbnail at display size — never full decode then scale. Cancel on prepareForReuse; generation token ignores stale completions. Decode p50 under 10ms / p99 under 50ms as labeled targets from the spec. Same cancel discipline as Task-outlives-screen on Day 03 — don’t let a completion strongly own the cell or VC.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| GIF asked? | “Out of scope unless pulled — separate decoder plus memory budget.” |
| Main-thread decode? | “Classic hitch — always background.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q7. Ops — failures, metrics, rollout, load?

**Answer:**

> “Track L1/L2 hit rates, decode latency, OOM rate under 0.1% as a target, scroll hitch. Kill switch: disable high-res prefetch under memory pressure. Instruments angle from Day 03: Allocations for decode spikes and abandoned heaps; Memory Graph if a loader completion keeps a VC alive; Crashlytics for jetsam clusters — Graph doesn’t replace fleet signals.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| HeroWidget link? | “Pause and cancel media on disappear — same cancel discipline.” |
| Invented crash-free %? | “Forbidden — use resume-backed numbers or label as target.” |

**How can I relate to my case:**
- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Shipped:** BookMyShow IMOC + crash-free at scale — only for reliability culture framing, not fake image-lib metrics.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.

---

### Q8. Flow scorecard — did you hit the optimal spine?

**Answer:**

> “Pass bar: clarify plus agenda in five minutes or less; HLD shows four layers plus backend plus load; API has cancel and dedupe; two deep dives; ops with kill switch and concrete metrics. Anti-patterns: main-thread decode; unbounded Dictionary cache; inventing QPS as fact; never reaching ops; blob architecture with no data flow. Spine: zero to five clarify, five to fifteen HLD, fifteen to twenty-five API, twenty-five to forty dives, forty to forty-five ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Ran long on dive 1? | “Park dive 2 bullets; protect ops five minutes.” |
| Forgot load? | “One sentence: DAU to labeled QPS, cache TTL, single-flight.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Completion keeps the cell

Loader stores `onSuccess` that strongly captures the cell/VC. User scrolls away; request finishes late.

**Ask:** What happens?

**Answer:** Ownership can keep the cell/VC alive or apply a stale image. Use `[weak self]` / weak cell, cancel on reuse, generation token.

---

### Puzzle B — Forever Dictionary “cache”

Someone uses `static var cache = [URL: UIImage]()` with no eviction.

**Ask:** Cycle or abandoned?

**Answer:** Often **no two-node cycle** — a live singleton root forever retains images (and maybe screens if you stash wrong things). Abandoned from product view. Prefer cost-limited NSCache + disk LRU.

---

### Puzzle C — Jetsam vs Graph in the mock

Crashlytics shows jetsam during big events. Interviewer asks which tool finds the retain cycle.

**Answer:** Crashlytics signals **fleet pressure**. **Memory Graph** finds ownership edges for a suspected cycle. Don’t say Leaks found the cycle; don’t say Crashlytics draws the graph.

---

### Puzzle D — Autoreleasepool around decode

Decode loop spikes watermark. Candidate wraps the whole library in `autoreleasepool` and claims cycles are fixed.

**Answer:** Pool can help **temporary** ObjC peaks. It does **not** fix retain cycles or unbounded caches. Still need cancel, weak completions, and bounded L1.

---

Next: [06-module-drills.md](06-module-drills.md)
