# Sample 01 — Crash pipeline and CFS (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What is the crash SDK pipeline end to end?
**Answer:**

> **Init** (fast, ~10ms class) → register handlers → breadcrumb ring on happy path. On **crash** (signal / uncaught / fatalError path): **async-signal-safe** write to preallocated mmap/disk → terminate. **Next launch:** discover report → upload → server **symbolicates** with matching **dSYM**. No malloc, ObjC, or network inside the signal handler.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why init early? | Launch crashes must report — defer heavy analytics, not crash SDK (Day 17). |
| sigaction role? | POSIX fatals — SEGV, ABRT, etc. |
| try/catch covers this? | No — signals and many fatals bypass Swift error handling. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What is crash-free sessions (CFS)?
**Answer:**

> **CFS:** sessions without a **fatal crash** (vendor definitions vary slightly — say Crashlytics sessions). **BookMyShow IMOC + crash-free at scale:** sustained **99.95%+** at **30+ lakh DAU**. Non-fatals ≠ crashes — still triage if user-impacting. **OOM/jetsam** often lacks clean client stack. **Hangs** may not count against CFS — users still churn.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Trap phrase? | “CFS is fine so the app isn’t freezing.” |
| OOM vs crash in CFS? | Vendor-dependent — often separate from clean fatal crashes. |
| Non-fatals on payment path? | Promote to P1 even if CFS unchanged. |

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q3. Why must BookMyShow synchronised dictionaries and BookMyShow IMOC + crash-free at scale stay separate in speech?
**Answer:**

> **BookMyShow IMOC + crash-free at scale** = CFS + Crashlytics triage + **IMOC** (system of reliability at scale). **BookMyShow synchronised dictionaries** = synchronised dictionaries fixed **races on a shared-state path** — one engineering input among many. **BookMyShow synchronised dictionaries ⊂ reliability work, but BookMyShow synchronised dictionaries ⇏ “I alone made 99.95% CFS.”** Say: dictionaries removed intermittent race crashes on that path; CFS was sustained by triage, incident process, and many fixes.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Forbidden script? | “We hit 99.95% CFS because I synchronised the dictionaries.” |
| OK script add-on? | “That path fix contributed; CFS was the operational system.” |
| One-minute drill? | Foundations §9 — speak CFS + IMOC + BookMyShow synchronised dictionaries path without collapsing causality. |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

---

### Q4. Crash vs OOM vs hang — compare briefly?
**Answer:**

> **Crash:** fatal signal/exception — often clean stack if handlers work — **moves CFS**. **OOM/jetsam:** SIGKILL from memory pressure — often heuristic, not normal catchable path — vendor-dependent CFS impact. **Hang:** main blocked — hang detector / MetricKit — often **does not** move CFS. All three hurt users; only fatal crashes fit the classic CFS story cleanly.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| OOM detection limits? | Next-launch heuristics + MetricKit exit diagnostics on delay. |
| Lab for OOM suspicion? | Memory Graph + Allocations — cycles ≠ Leaks (Day 17). |
| Hang vs watchdog? | Hang observed; OS may kill if unresponsive long enough. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What is the triage workflow in six steps?
**Answer:**

> (1) **Detect** — spike / CFS drop alert. (2) **Classify** — new vs regressed; top stacks; version %; journey tags. (3) **Reproduce** — symbolicated stack + breadcrumbs + device/OS matrix. (4) **Mitigate** — flag off, pause rollout, hotfix path. (5) **Fix** — root cause + regression test. (6) **Write-up** — blameless postmortem for P0/P1.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Mitigate before perfect RCA? | Yes — user harm down first (IMOC pillar). |
| Unsymbolicated spike? | Check dSYM CI break before blaming new code. |
| Journey tags? | Breadcrumbs / custom keys — which screen flow. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What is IMOC in one breath?
**Answer:**

> As **IMOC**, coordinate **iOS + backend + QA** on **P0/P1** during high-traffic events. Pillars: **single owner**, **blast radius** (feature, %, geo, payment path), **mitigate first**, **cadenced comms**, **handoff + postmortem** with actionable follow-ups (alerts, tests, runbooks).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Blast radius example? | “12% on 4.2.1, checkout India, UPI path.” |
| vs lone-hero debugging? | IMOC = owner + comms + mitigate — not only stack reading. |
| Peak sale pressure? | Cadence updates on a clock — stakeholders need predictability. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What should the teach-back checklist cover?
**Answer:**

> Pipeline: capture → persist → upload → symbolicate. Async-signal-safe one-liner. CFS definition + 99.95% / 30L context (BookMyShow IMOC + crash-free at scale). **BookMyShow synchronised dictionaries contributes; does not solely cause CFS.** IMOC pillars. Hang gap vs CFS. Next: signal safety and OOM honesty in sample 02.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| dSYM keyword? | UUID match for readable stacks. |
| Breadcrumb keyword? | Last-N event trail — filled on happy path. |
| Next sample? | [02-signal-safety-oom.md](02-signal-safety-oom.md) |

**How can I relate to my case:**
- **Shipped:** BookMyShow synchronised dictionaries; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Do not steal BookMyShow IMOC / crash-free culture credit for a path-specific dictionary race fix — keep scopes separate.

Next: [02-signal-safety-oom.md](02-signal-safety-oom.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is crash-free sessions (CFS)

**Ask yourself:** What is crash-free sessions (CFS)?

**Answer:** “**CFS:** sessions without a **fatal crash** (vendor definitions vary slightly — say Crashlytics sessions). **BookMyShow IMOC + crash-free at scale:** sustained **99.95%+** at **30+ lakh DAU**. Non-fatals ≠ crashes — still triage if user-impacting. **OOM/jetsam** often lacks clean client stack. **Hangs** may not count against CFS — users still churn.”

### Puzzle B — Why must BookMyShow synchronised dictionaries and BookMyShow IMOC + crash-free a

**Ask yourself:** Why must BookMyShow synchronised dictionaries and BookMyShow IMOC + crash-free at scale stay separate in speech?

**Answer:** “**BookMyShow IMOC + crash-free at scale** = CFS + Crashlytics triage + **IMOC** (system of reliability at scale). **BookMyShow synchronised dictionaries** = synchronised dictionaries fixed **races on a shared-state path** — one engineering input among many. **BookMyShow synchronised dictionaries ⊂ reliability work, but BookMyShow synchronised dictionaries ⇏ “I alone made 99.95% CFS.”** Say: dictionaries removed intermittent race crashes on that path; CFS was sustained by triage, incident process, and many fixes.”

### Puzzle C — Crash vs OOM vs hang — compare briefly

**Ask yourself:** Crash vs OOM vs hang — compare briefly?

**Answer:** “**Crash:** fatal signal/exception — often clean stack if handlers work — **moves CFS**. **OOM/jetsam:** SIGKILL from memory pressure — often heuristic, not normal catchable path — vendor-dependent CFS impact. **Hang:** main blocked — hang detector / MetricKit — often **does not** move CFS. All three hurt users; only fatal crashes fit the classic CFS story cleanly.”
