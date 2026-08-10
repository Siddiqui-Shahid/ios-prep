# Sample 04 — Debrief & structure Q&A (Q&A)

> Guided teaching. Post-build and architecture-style questions — how to **structure answers** after the 3hr session.

---

### Q1. How do I self-grade with the rubric?
**Answer:**

> Score 1–5 on: **Correctness**, **Architecture**, **Cache or SDUI depth**, **Tests**, **Communication**, **Time honesty**. **Pass bar:** average ≥3.5, **correctness ≥4**, **tests ≥3**. A polished unfinished core scores low on correctness and time honesty even if UI pretty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 3 on tests? | Borderline — pass needs ≥3 rubric dimension, prefer 4+ on correctness. |
| Document gaps? | README in buffer — time honesty dimension. |
| Debrief mandatory? | [`../05-exercises.md`](../05-exercises.md) §3 — 60 min. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. How do I structure a post-build architecture answer?
**Answer:**

> **(1)** Restate goal in one sentence. **(2)** Layer diagram aloud (UI → VM → protocol → sources). **(3)** One decision you made + trade-off (SWR cache vs LRU; enum factory vs protocol). **(4)** One cut line you chose and why. **(5)** One test that proves the risky path (stale response / unknown type). Under 90s unless asked to deep-dive.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “What would you do with 2 more hours?” | Disk cache, error retry, 4th component, UI test — prioritized list. |
| “What failed?” | Honest — generation bug, forgot removeFirst cost — plus fix. |
| Over-engineered? | Admit if yes — what minimal slice would be. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. Brief A debrief — cache policy question?
**Answer:**

> Name policy picked: **SWR** shows stale immediately, fetches fresh, swaps on success; **generation id** drops stale responses. Trade-off: user may see outdated data briefly vs blank spinner. Failure on refresh keeps stale + error banner — nonblocking. Test: mock cache hit then network update.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TTL? | Optional enhancement — say “would add TTL field in production.” |
| Disk vs memory? | Disk survives kill — cost serialization + invalidation. |
| Pagination + cache? | Cache page 1 only vs full list — pick and defend. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Brief B debrief — unknown type question?
**Answer:**

> Factory `default` → `.unknown(type)` → **PlaceholderView** with visible “unsupported” + analytics stub. Renderer never crashes on bad server JSON. **schemaVersion** mismatch: degrade to empty or minimal doc — policy stated at clarify. Same instinct as CMS unknown widgets in BookMyShow backend-driven header & search-shaped apps — without claiming this repo is BMS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Log PII in props? | Strip in analytics — coarse event only. |
| Retry decode? | No — fail-soft UI; fix server schema. |
| Max nesting depth? | Design: placeholder after N — crash-free culture. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. “Why protocol repository / factory?” — structure?
**Answer:**

> **Testability** — inject fake remote/cache or JSON fixture without UI. **Progress** — vertical slice on stub before network/CMS ready. **Swap** — live API or new component types without rewriting VM/renderer. Cost: extra types/files — acceptable in 3hr rubric for architecture ≥4.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| God ViewModel anti-pattern? | All logic in VM with no protocol — rubric architecture 1–2. |
| Over-abstract? | 5 protocols for one screen — say what you’d collapse given time. |
| District Free Parking + Clean/MVVM + AI tooling AI scaffold? | OK if **you** chose boundaries and reviewed tests. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Production bridge — what may I say after the round?
**Answer:**

> ≤20s: “In machine rounds I optimize for a tested vertical slice — same bias shipping SDUI and list UX: contracts, fallbacks, and observable state.” BookMyShow backend-driven header & search: pagination/debounce + SDUI fallback thinking. District Free Parking + Clean/MVVM + AI tooling: you own architecture if AI helped tests. Audio streaming + server-driven splash (Aces): server-driven splash — schema resilience. **Do not claim** the 3hr build is production BMS code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume bullet from today? | Learning-lab — describe as practice, not shipped feature. |
| 30L DAU mention? | Only behavioral drift — not machine round proof. |
| Day 27 link? | Brief B prep for SDUI system design. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Exit — what should I record after debrief?
**Answer:**

> Rubric scores written. 60s demo recording or bullet script. Three architecture Q&A spoken from [07-revision-qna.md](07-revision-qna.md). Cut lines README committed. One improvement for next machine round (e.g. “tests before 2:30”, “SWR stated at 0:18”). Pass/fail against bar — if fail, one focused redo block scheduled.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Build both briefs later? | Second session — don’t combine in one 3hr. |
| No Xcode artifact? | Today’s artifact **is** the project — no `code/` folder. |
| Week 4 exit? | Day 26+ behavioral/architecture — this day is build muscle. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Tricky debrief T1 — cache served stale event prices; defend?
**Answer:**

> For the machine round I optimized perceived performance with **SWR** on a generic list. In production at consumer scale I’d **classify fields**: price and seat availability get **short TTL or bypass cache**, pull-to-refresh is obvious, UI shows **last-updated**, and caches are **keyed per user/session**. Stale generic metadata is acceptable; **stale money is not**. Document that split in the README as the next hardening step. Learning-lab + soft BookMyShow IMOC + crash-free at scale/BookMyShow backend-driven header & search judgment — no fake incident.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Cross-user cache? | Never for personalized/price paths — session or user key. |
| SWR still OK? | Yes for non-money metadata; money fields bypass or micro-TTL. |
| Provenance? | Practice hardening note — not a Verified BMS outage story. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q9. Tricky debrief T2 — why not generate the whole app with AI?
**Answer:**

> AI can **scaffold boilerplate**, but **I own** architecture, edge cases, and tests, and I must **explain every line** to the proctor. Same District rule — accelerator inside a review bar, **not author of record**. Provenance: District Free Parking + Clean/MVVM + AI tooling judgment applied to machine-round honesty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is AI OK? | Boilerplate + tests you reviewed and can defend. |
| Proctor asks “did AI write this?” | Yes where it helped; here’s the seam I chose and the test I wrote. |
| Rubric risk? | Can’t explain → architecture/communication score collapses. |

**How can I relate to my case:**
- **Shipped:** District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q10. Tricky debrief T3 — unfinished image loading = fail?
**Answer:**

> Image pipeline was an **explicit cut line** at minute twenty. Core pagination and cache work; cells use **placeholders**. In production I’d plug a shared image loader — soft nod to lifecycle-sensitive media (HeroWidget-class work) — but finishing images here would have **traded away tests**. Honesty > spiraling. Soft BookMyShow Ads pipeline + HeroWidget lifecycle media lifecycle nod · learning-lab cuts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| When is cut a fail? | If core acceptance (pager/cache) unfinished — images alone aren’t. |
| Say cut when? | Minute ~20 clarify — write in README. |
| Placeholder enough? | For 3hr yes if core paths tested. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q11. Tricky debrief T4 — show concurrency bugs in your pager?
**Answer:**

> ViewModel holds a **monotonic requestID**. Each fetch captures the id; **only matching ids commit**. Refresh **cancels** the in-flight Task. State mutations hop to **MainActor**. I won’t append page N+1 from a **stale task** after a reset. Same class of discipline as serializing shared mutable maps — don’t let concurrent writers corrupt state. Soft BookMyShow synchronised dictionaries.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Generation vs cancel? | Both — cancel stops work; generation drops late commits. |
| Out-of-order pages? | Guard in-flight + id check before append. |
| Actor instead? | Fine if VM/`@MainActor` — say why you picked it. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q12. Tricky debrief T5 — proctor asks you to add auth mid-round?
**Answer:**

> **Acknowledge**, park auth behind an **AuthProviding** dependency on the remote data source, **stub a static token** now, and **document** real refresh as out of scope. I won’t rebuild the pager to chase auth unless the brief made it **acceptance-critical**. Learning-lab honesty — protect the vertical slice.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| If auth is acceptance-critical? | Narrowest stub that unblocks fetch — still don’t overbuild. |
| Where does token live? | Injected provider — not hard-coded across layers. |
| README line? | “Auth: stubbed; refresh/Keychain out of scope.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [07-revision-qna.md](07-revision-qna.md) · [`../05-exercises.md`](../05-exercises.md) timed run

---

## Brain puzzles (cover → think → check)

### Puzzle A — How do I structure a post-build architecture answer

**Ask yourself:** How do I structure a post-build architecture answer?

**Answer:** “**(1)** Restate goal in one sentence. **(2)** Layer diagram aloud (UI → VM → protocol → sources). **(3)** One decision you made + trade-off (SWR cache vs LRU; enum factory vs protocol). **(4)** One cut line you chose and why. **(5)** One test that proves the risky path (stale response / unknown type). Under 90s unless asked to deep-dive.”

### Puzzle B — Brief A debrief — cache policy question

**Ask yourself:** Brief A debrief — cache policy question?

**Answer:** “Name policy picked: **SWR** shows stale immediately, fetches fresh, swaps on success; **generation id** drops stale responses. Trade-off: user may see outdated data briefly vs blank spinner. Failure on refresh keeps stale + error banner — nonblocking. Test: mock cache hit then network update.”

### Puzzle C — Brief B debrief — unknown type question

**Ask yourself:** Brief B debrief — unknown type question?

**Answer:** “Factory `default` → `.unknown(type)` → **PlaceholderView** with visible “unsupported” + analytics stub. Renderer never crashes on bad server JSON. **schemaVersion** mismatch: degrade to empty or minimal doc — policy stated at clarify. Same instinct as CMS unknown widgets in BookMyShow backend-driven header & search-shaped apps — without claiming this repo is BMS.”
