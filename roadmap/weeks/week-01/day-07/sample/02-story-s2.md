# Sample 02 — Story: BookMyShow synchronised dictionaries (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the ≤20s elevator pitch for BookMyShow synchronised dictionaries?

**Answer:**

> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.” Label **BookMyShow synchronised dictionaries · BookMyShow · synchronised dictionaries**. Do not claim sole ownership of 99.95% CFS from this story alone.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Must-not? | Fake crash-percent drop you cannot prove. |
| Scale context? | 30L+ DAU / CFS culture is **BookMyShow IMOC + crash-free at scale** — cite softly, do not paste onto every beat. |
| vs generic “I fixed a race”? | Named mechanism: serial API around shared dicts. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q2. Walk the ≤3 min STAR beats.

**Answer:**

> **Situation:** Shared dictionaries accessed from many threads on a high-traffic path — intermittent races/crashes. **Task:** Stop callers from touching unsynchronized storage. **Action:** Serial queue (or RW pattern) behind get/set/snapshot API; stress testing; Crashlytics to confirm path fixed. **Result:** Crashes eliminated on **that path** — qualitative, path-specific. **Lesson:** Hide concurrency; don’t trust every call site to dispatch correctly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Missing beat? | Interviewer scores STAR table in deep dive — fill each row. |
| Crashlytics role? | Confirm fix on the affected crash signature — not invented %. |
| Actor coda? | One sentence at end — leads to Design: actor SafeDict (not shipped) follow-up. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q3. Required follow-up: “How would you design this today?”

**Answer:**

> **Design: actor SafeDict (not shipped):** Expose an **actor** with the same get/set/snapshot surface — callers `await`; isolation moves into the type system. Production was GCD; this is migration language, not “we rewrote everything as actors last quarter.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Named-case label? | Say “Applied” or “how I’d apply it” — not Verified for actor rewrite. |
| API surface? | Keep safe methods — don’t expose raw dict + external locks. |
| Big-bang? | Module-by-module façade — deep pool D4. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Design: actor SafeDict (not shipped)
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

---

### Q4. Why hide the queue instead of documenting “always dispatch here”?

**Answer:**

> Documentation does not survive scale — new call sites forget, copy-paste wrong queue, or mix sync/async. An API **forces** synchronization at compile/link boundaries. Same reason actors beat “please don’t touch my dict”: the type enforces the contract.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Performance? | Serial queue contention — acceptable vs data races on hot path fix. |
| Reader-writer variant? | Many reads, barrier writes — if profiling showed read dominance. |
| Test strategy? | Stress + thread sanitizer mindset — path-specific validation. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What must you NOT claim in BookMyShow synchronised dictionaries?

**Answer:**

> Do not invent fill-rate, crash-percent, or “I single-handedly raised CFS to 99.95%.” Do not say Memory Graph was your primary prod tool unless labeled Applied. Honest result: **path-specific crash reduction** after serializing dictionary access. Use **BookMyShow IMOC + crash-free at scale** only for scale/reliability culture context.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer cut line? | “Don’t invent a metric — what’s the honest result?” |
| Qualitative OK? | Yes — “crashes on this signature stopped” is strong. |
| BookMyShow Ads pipeline + HeroWidget lifecycle confusion? | BookMyShow Ads pipeline + HeroWidget lifecycle is ads POP — different story; optional encore. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q6. How is BookMyShow IMOC + crash-free at scale adjacent without stealing the story?

**Answer:**

> When asked why races matter at BMS scale: 30L+ DAU, 99.95%+ crash-free culture, Crashlytics / IMOC — **BookMyShow IMOC + crash-free at scale**. One or two sentences max. Do not paste CFS onto every answer or imply BookMyShow synchronised dictionaries alone delivered company-wide CFS.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| IMOC? | Incident management on-call culture — reliability spine. |
| Every mock answer? | No — use when risk/scale question appears. |
| vs BookMyShow synchronised dictionaries result? | BookMyShow synchronised dictionaries = specific fix; BookMyShow IMOC + crash-free at scale = environment why it mattered. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q7. Score yourself on BookMyShow synchronised dictionaries — what earns a 4 or 5?

**Answer:**

> **4:** On time (≤3 min), clear STAR, trade-off or prod hook, honest provenance. **5:** All of 4 + crisp Verified vs Applied labels + ready for actor follow-up. **2 or below:** invented metrics, missing action mechanism, or CFS ownership theft. Target **BookMyShow synchronised dictionaries ≥4** for Mock #1 pass.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Time box? | 3 min story + ~90s actor follow-up in mock script. |
| Record yourself? | Self-mock mode in deep dive §7. |
| Weak story? | Re-drill production bridge before full mock. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Exact crash %, “fixed all BMS crashes,” or claiming lab SafeDict.swift was the shipped file.

Next: [03-mock-interview.md](03-mock-interview.md)

---

