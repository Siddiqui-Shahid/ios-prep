# Sample 04 — Debrief & structure Q&A (Q&A)

> Guided teaching. Post-build and architecture-style questions — how to **structure answers** after the 3hr session.

---

### Q1. How do I self-grade with the rubric?

**Points to:** [Deep dive · Rubrics](../02-deep-dive.md#rubrics-15) · [Exercises · Pass/fail](../05-exercises.md#4-pass--fail)

**Answer:**

> Score 1–5 on: **Correctness**, **Architecture**, **Cache or SDUI depth**, **Tests**, **Communication**, **Time honesty**. **Pass bar:** average ≥3.5, **correctness ≥4**, **tests ≥3**. A polished unfinished core scores low on correctness and time honesty even if UI pretty.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 3 on tests? | Borderline — pass needs ≥3 rubric dimension, prefer 4+ on correctness. |
| Document gaps? | README in buffer — time honesty dimension. |
| Debrief mandatory? | [`../05-exercises.md`](../05-exercises.md) §3 — 60 min. |

---

### Q2. How do I structure a post-build architecture answer?

**Points to:** [Questions · Sample architecture answers](../04-questions.md#tricky--sample-architecture-answers) · [Deep dive · Trade-offs](../02-deep-dive.md#trade-offs)

**Answer:**

> **(1)** Restate goal in one sentence. **(2)** Layer diagram aloud (UI → VM → protocol → sources). **(3)** One decision you made + trade-off (SWR cache vs LRU; enum factory vs protocol). **(4)** One cut line you chose and why. **(5)** One test that proves the risky path (stale response / unknown type). Under 90s unless asked to deep-dive.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| “What would you do with 2 more hours?” | Disk cache, error retry, 4th component, UI test — prioritized list. |
| “What failed?” | Honest — generation bug, forgot removeFirst cost — plus fix. |
| Over-engineered? | Admit if yes — what minimal slice would be. |

---

### Q3. Brief A debrief — cache policy question?

**Points to:** [Deep dive · Cache policy](../02-deep-dive.md#cache-policy-options-pick-one-say-why) · [Brief A state machine](../02-deep-dive.md#brief-a--state-machine-teach)

**Answer:**

> Name policy picked: **SWR** shows stale immediately, fetches fresh, swaps on success; **generation id** drops stale responses. Trade-off: user may see outdated data briefly vs blank spinner. Failure on refresh keeps stale + error banner — nonblocking. Test: mock cache hit then network update.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| TTL? | Optional enhancement — say “would add TTL field in production.” |
| Disk vs memory? | Disk survives kill — cost serialization + invalidation. |
| Pagination + cache? | Cache page 1 only vs full list — pick and defend. |

---

### Q4. Brief B debrief — unknown type question?

**Points to:** [Deep dive · Brief B](../02-deep-dive.md#brief-b--sdui-component-renderer) · [Production bridge · S3](../03-production-bridge.md#verified--s3)

**Answer:**

> Factory `default` → `.unknown(type)` → **PlaceholderView** with visible “unsupported” + analytics stub. Renderer never crashes on bad server JSON. **schemaVersion** mismatch: degrade to empty or minimal doc — policy stated at clarify. Same instinct as CMS unknown widgets in S3-shaped apps — without claiming this repo is BMS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Log PII in props? | Strip in analytics — coarse event only. |
| Retry decode? | No — fail-soft UI; fix server schema. |
| Max nesting depth? | Design: placeholder after N — crash-free culture. |

---

### Q5. “Why protocol repository / factory?” — structure?

**Points to:** [Deep dive · Suggested architectures](../02-deep-dive.md#suggested-architecture) · [Trade-offs](../02-deep-dive.md#trade-offs)

**Answer:**

> **Testability** — inject fake remote/cache or JSON fixture without UI. **Progress** — vertical slice on stub before network/CMS ready. **Swap** — live API or new component types without rewriting VM/renderer. Cost: extra types/files — acceptable in 3hr rubric for architecture ≥4.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| God ViewModel anti-pattern? | All logic in VM with no protocol — rubric architecture 1–2. |
| Over-abstract? | 5 protocols for one screen — say what you’d collapse given time. |
| S9 AI scaffold? | OK if **you** chose boundaries and reviewed tests. |

---

### Q6. Production bridge — what may I say after the round?

**Points to:** [Production bridge · ≤20s](../03-production-bridge.md#20s) · [S3 · S9 · S12](../03-production-bridge.md)

**Answer:**

> ≤20s: “In machine rounds I optimize for a tested vertical slice — same bias shipping SDUI and list UX: contracts, fallbacks, and observable state.” S3: pagination/debounce + SDUI fallback thinking. S9: you own architecture if AI helped tests. S12: server-driven splash — schema resilience. **Do not claim** the 3hr build is production BMS code.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Resume bullet from today? | Learning-lab — describe as practice, not shipped feature. |
| 30L DAU mention? | Only behavioral drift — not machine round proof. |
| Day 27 link? | Brief B prep for SDUI system design. |

---

### Q7. Exit — what should I record after debrief?

**Points to:** [Exercises · Debrief](../05-exercises.md#3-debrief-60-min--mandatory) · [Questions · Suggested record set](../04-questions.md#suggested-record-set)

**Answer:**

> Rubric scores written. 60s demo recording or bullet script. Three architecture Q&A spoken from [`../04-questions.md`](../04-questions.md). Cut lines README committed. One improvement for next machine round (e.g. “tests before 2:30”, “SWR stated at 0:18”). Pass/fail against bar — if fail, one focused redo block scheduled.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Build both briefs later? | Second session — don’t combine in one 3hr. |
| No Xcode artifact? | Today’s artifact **is** the project — no `code/` folder. |
| Week 4 exit? | Day 26+ behavioral/architecture — this day is build muscle. |

---

Next: [`../04-questions.md`](../04-questions.md) · [`../05-exercises.md`](../05-exercises.md) timed run
