# Sample 02 — Story S2 (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the ≤20s elevator pitch for S2?

**Points to:** [Production bridge · §1 Centerpiece — Verified · S2](../03-production-bridge.md#1-centerpiece--verified--s2) · [02-deep-dive · §3 Story — S2](../02-deep-dive.md#3-story--s2-10-min)

**Answer:**

> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” Label **Verified · S2 · BookMyShow · synchronised dictionaries**. Do not claim sole ownership of 99.95% CFS from this story alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Must-not? | Fake crash-percent drop you cannot prove. |
| Scale context? | 30L+ DAU / CFS culture is **S8** — cite softly, do not paste onto every beat. |
| vs generic “I fixed a race”? | Named mechanism: serial API around shared dicts. |

---

### Q2. Walk the ≤3 min STAR beats.

**Points to:** [Production bridge · §1 Centerpiece](../03-production-bridge.md#1-centerpiece--verified--s2) · [02-deep-dive · §3 Story — S2](../02-deep-dive.md#3-story--s2-10-min)

**Answer:**

> **Situation:** Shared dictionaries accessed from many threads on a high-traffic path — intermittent races/crashes. **Task:** Stop callers from touching unsynchronized storage. **Action:** Serial queue (or RW pattern) behind get/set/snapshot API; stress testing; Crashlytics to confirm path fixed. **Result:** Crashes eliminated on **that path** — qualitative, path-specific. **Lesson:** Hide concurrency; don’t trust every call site to dispatch correctly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Missing beat? | Interviewer scores STAR table in deep dive — fill each row. |
| Crashlytics role? | Confirm fix on the affected crash signature — not invented %. |
| Actor coda? | One sentence at end — leads to S2-A1 follow-up. |

---

### Q3. Required follow-up: “How would you design this today?”

**Points to:** [Production bridge · §2 Follow-up — S2-A1](../03-production-bridge.md#2-follow-up--s2-a1) · [02-deep-dive · §3 Story — S2](../02-deep-dive.md#3-story--s2-10-min)

**Answer:**

> **How I would apply it · S2-A1:** Expose an **actor** with the same get/set/snapshot surface — callers `await`; isolation moves into the type system. Production was GCD; this is migration language, not “we rewrote everything as actors last quarter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance label? | Say “Applied” or “how I’d apply it” — not Verified for actor rewrite. |
| API surface? | Keep safe methods — don’t expose raw dict + external locks. |
| Big-bang? | Module-by-module façade — deep pool D4. |

---

### Q4. Why hide the queue instead of documenting “always dispatch here”?

**Points to:** [02-deep-dive · §3 Optional follow-up](../02-deep-dive.md#3-story--s2-10-min) · Day 04 production bridge

**Answer:**

> Documentation does not survive scale — new call sites forget, copy-paste wrong queue, or mix sync/async. An API **forces** synchronization at compile/link boundaries. Same reason actors beat “please don’t touch my dict”: the type enforces the contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Performance? | Serial queue contention — acceptable vs data races on hot path fix. |
| Reader-writer variant? | Many reads, barrier writes — if profiling showed read dominance. |
| Test strategy? | Stress + thread sanitizer mindset — path-specific validation. |

---

### Q5. What must you NOT claim in S2?

**Points to:** [Production bridge · §6 Anti-patterns](../03-production-bridge.md#6-anti-patterns-today) · [README · Pass criteria](../README.md#pass-criteria-mock-1)

**Answer:**

> Do not invent fill-rate, crash-percent, or “I single-handedly raised CFS to 99.95%.” Do not say Memory Graph was your primary prod tool unless labeled Applied. Honest result: **path-specific crash reduction** after serializing dictionary access. Use **S8** only for scale/reliability culture context.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer cut line? | “Don’t invent a metric — what’s the honest result?” |
| Qualitative OK? | Yes — “crashes on this signature stopped” is strong. |
| S1 confusion? | S1 is ads POP — different story; optional encore. |

---

### Q6. How is S8 adjacent without stealing the story?

**Points to:** [Production bridge · §3 Adjacent reliability — S8](../03-production-bridge.md#3-adjacent-reliability--s8-soft) · Day 03 production bridge

**Answer:**

> When asked why races matter at BMS scale: 30L+ DAU, 99.95%+ crash-free culture, Crashlytics / IMOC — **Verified · S8**. One or two sentences max. Do not paste CFS onto every answer or imply S2 alone delivered company-wide CFS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| IMOC? | Incident management on-call culture — reliability spine. |
| Every mock answer? | No — use when risk/scale question appears. |
| vs S2 result? | S2 = specific fix; S8 = environment why it mattered. |

---

### Q7. Score yourself on S2 — what earns a 4 or 5?

**Points to:** [Foundations · §4 Scoring rubric](../01-foundations.md#4-scoring-rubric-15) · [code/MockScorecard.md](../code/MockScorecard.md)

**Answer:**

> **4:** On time (≤3 min), clear STAR, trade-off or prod hook, honest provenance. **5:** All of 4 + crisp Verified vs Applied labels + ready for actor follow-up. **2 or below:** invented metrics, missing action mechanism, or CFS ownership theft. Target **S2 ≥4** for Mock #1 pass.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Time box? | 3 min story + ~90s actor follow-up in mock script. |
| Record yourself? | Self-mock mode in deep dive §7. |
| Weak story? | Re-drill production bridge before full mock. |

---

Next: [03-mock-interview.md](03-mock-interview.md)
