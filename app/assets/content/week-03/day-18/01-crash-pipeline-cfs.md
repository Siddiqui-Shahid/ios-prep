# Sample 01 — Crash pipeline and CFS (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What is the crash SDK pipeline end to end?

**Points to:** [Foundations · §1 Crash SDK pipeline](../01-foundations.md#1-crash-sdk-pipeline)

**Answer:**

> **Init** (fast, ~10ms class) → register handlers → breadcrumb ring on happy path. On **crash** (signal / uncaught / fatalError path): **async-signal-safe** write to preallocated mmap/disk → terminate. **Next launch:** discover report → upload → server **symbolicates** with matching **dSYM**. No malloc, ObjC, or network inside the signal handler.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why init early? | Launch crashes must report — defer heavy analytics, not crash SDK (Day 17). |
| sigaction role? | POSIX fatals — SEGV, ABRT, etc. |
| try/catch covers this? | No — signals and many fatals bypass Swift error handling. |

---

### Q2. What is crash-free sessions (CFS)?

**Points to:** [Foundations · §2 What crash-free sessions means](../01-foundations.md#2-what-crash-free-sessions-cfs-means)

**Answer:**

> **CFS:** sessions without a **fatal crash** (vendor definitions vary slightly — say Crashlytics sessions). **Verified S8:** sustained **99.95%+** at **30+ lakh DAU**. Non-fatals ≠ crashes — still triage if user-impacting. **OOM/jetsam** often lacks clean client stack. **Hangs** may not count against CFS — users still churn.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap phrase? | “CFS is fine so the app isn’t freezing.” |
| OOM vs crash in CFS? | Vendor-dependent — often separate from clean fatal crashes. |
| Non-fatals on payment path? | Promote to P1 even if CFS unchanged. |

---

### Q3. Why must S2 and S8 stay separate in speech?

**Points to:** [Foundations · Honesty bound](../01-foundations.md#honesty-bound-memorize) · [Production bridge · §4 S2 coupling](../03-production-bridge.md#4-s2-as-technical-add-on-90s--correct-coupling)

**Answer:**

> **S8** = CFS + Crashlytics triage + **IMOC** (system of reliability at scale). **S2** = synchronised dictionaries fixed **races on a shared-state path** — one engineering input among many. **S2 ⊂ reliability work, but S2 ⇏ “I alone made 99.95% CFS.”** Say: dictionaries removed intermittent race crashes on that path; CFS was sustained by triage, incident process, and many fixes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden script? | “We hit 99.95% CFS because I synchronised the dictionaries.” |
| OK script add-on? | “That path fix contributed; CFS was the operational system.” |
| One-minute drill? | Foundations §9 — speak CFS + IMOC + S2 path without collapsing causality. |

---

### Q4. Crash vs OOM vs hang — compare briefly

**Points to:** [Foundations · §6 Crash vs OOM vs hang](../01-foundations.md#6-crash-vs-oom-vs-hang)

**Answer:**

> **Crash:** fatal signal/exception — often clean stack if handlers work — **moves CFS**. **OOM/jetsam:** SIGKILL from memory pressure — often heuristic, not normal catchable path — vendor-dependent CFS impact. **Hang:** main blocked — hang detector / MetricKit — often **does not** move CFS. All three hurt users; only fatal crashes fit the classic CFS story cleanly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| OOM detection limits? | Next-launch heuristics + MetricKit exit diagnostics on delay. |
| Lab for OOM suspicion? | Memory Graph + Allocations — cycles ≠ Leaks (Day 17). |
| Hang vs watchdog? | Hang observed; OS may kill if unresponsive long enough. |

---

### Q5. What is the triage workflow in six steps?

**Points to:** [Foundations · §3 Triage workflow](../01-foundations.md#3-triage-workflow)

**Answer:**

> (1) **Detect** — spike / CFS drop alert. (2) **Classify** — new vs regressed; top stacks; version %; journey tags. (3) **Reproduce** — symbolicated stack + breadcrumbs + device/OS matrix. (4) **Mitigate** — flag off, pause rollout, hotfix path. (5) **Fix** — root cause + regression test. (6) **Write-up** — blameless postmortem for P0/P1.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mitigate before perfect RCA? | Yes — user harm down first (IMOC pillar). |
| Unsymbolicated spike? | Check dSYM CI break before blaming new code. |
| Journey tags? | Breadcrumbs / custom keys — which screen flow. |

---

### Q6. What is IMOC in one breath?

**Points to:** [Foundations · §4 IMOC](../01-foundations.md#4-imoc-leadership-proof)

**Answer:**

> As **IMOC**, coordinate **iOS + backend + QA** on **P0/P1** during high-traffic events. Pillars: **single owner**, **blast radius** (feature, %, geo, payment path), **mitigate first**, **cadenced comms**, **handoff + postmortem** with actionable follow-ups (alerts, tests, runbooks).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Blast radius example? | “12% on 4.2.1, checkout India, UPI path.” |
| vs lone-hero debugging? | IMOC = owner + comms + mitigate — not only stack reading. |
| Peak sale pressure? | Cadence updates on a clock — stakeholders need predictability. |

---

### Q7. What should the teach-back checklist cover?

**Points to:** [Foundations · §8 Teach-back checklist](../01-foundations.md#8-teach-back-checklist)

**Answer:**

> Pipeline: capture → persist → upload → symbolicate. Async-signal-safe one-liner. CFS definition + 99.95% / 30L context (S8). **S2 contributes; does not solely cause CFS.** IMOC pillars. Hang gap vs CFS. Next: signal safety and OOM honesty in sample 02.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| dSYM keyword? | UUID match for readable stacks. |
| Breadcrumb keyword? | Last-N event trail — filled on happy path. |
| Next sample? | [02-signal-safety-oom.md](02-signal-safety-oom.md) |

---

Next: [02-signal-safety-oom.md](02-signal-safety-oom.md)
