# 03 — Production Bridge — Mock Narrative Spine

> Today’s story spine: **reliability under concurrency at BMS scale**.

---

## 1. Centerpiece — Verified · S2

**≤20s:**  
> “We gated shared dictionaries behind a serial queue API so call sites couldn’t race the storage — crashes went away on that path.”

**≤3 min STAR:** Use story-bank S2 beats — races → serial queues / RW → safe API → stress + Crashlytics → path fixed → actor coda.

**Must not:** Claim sole ownership of 99.95% CFS from S2 alone.

> **Provenance:** Verified · S2 · BookMyShow · synchronised dictionaries

---

## 2. Follow-up — S2-A1

> “For a new module I’d expose an actor with the same get/set/snapshot surface — callers await; isolation moves into the type system. That’s how I’d apply it — production was GCD.”

> **Provenance:** How I would apply it · S2-A1

---

## 3. Adjacent reliability — S8 (soft)

Use when asked about production risk / why races matter:

- 30L+ DAU  
- 99.95%+ crash-free  
- Crashlytics / IMOC culture  

Do not paste CFS onto every answer.

> **Provenance:** Verified · S8

---

## 4. Optional encore — S1

If energy allows after mock:

> “We made ad rendering a generic protocol pipeline so new creatives plugged in without forking the revenue path.”

> **Provenance:** Verified · S1

---

## 5. Social feed talk — honesty

Feed HLD is design skill. Tie ads slots to S1 *instinct* only. Scale context from S8 when asked “how big.”

---

## 6. Anti-patterns today

| Anti-pattern | Fix |
|---|---|
| New topics mid-mock | Redirect to Week 1 |
| Metric invention | Qualitative path fix |
| Skipping provenance labels on actor migration | Say Applied |
| Overlong defs | Agenda + cut |

---

## Next

Drill warm-up pool in [`04-questions.md`](04-questions.md) **before** the timed mock if any card is shaky.
