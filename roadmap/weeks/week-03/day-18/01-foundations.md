# 01 — Foundations: Crash Reporting & Incidents

> Mental model first. Hard rule burned in early: **S2 ≠ sole cause of CFS**.

---

## 0. North star

**Catch fatals safely, make stacks readable, triage with process, lead incidents with mitigate-first ownership — and never attribute org-wide CFS to a single dictionary fix.**

---

## 1. Crash SDK pipeline

```text
Init (<~10ms class) → register handlers → breadcrumb ring
Crash (signal / uncaught / fatalError path)
  → async-signal-safe write to preallocated mmap/disk
  → terminate
Next launch → discover report → upload → server symbolicates with dSYM
```

| Keyword | Why interviewers listen |
|---|---|
| `sigaction` / signal handlers | POSIX fatals (SEGV, ABRT, …) |
| Uncaught Obj-C / Swift fatal paths | Not covered by `try` |
| **Async-signal-safe** | No alloc, ObjC, Swift runtime, locks in handler |
| Lock-free breadcrumb buffer | Safe-ish context for last N events |
| dSYM UUID match | Readable stacks in Crashlytics |

---

## 2. What crash-free sessions (CFS) means

- **CFS:** sessions without a **fatal crash** (vendor definitions vary slightly — say Crashlytics sessions)
- **Verified · S8:** sustained **99.95%+** at **30+ lakh DAU** — operational excellence under peak load
- Non-fatals ≠ crashes — still triage if user-impacting
- **OOM / jetsam:** often no clean client stack; heuristics + MetricKit exit reasons (Day 17)
- **Hangs:** may not count against CFS — users still churn

### Honesty bound (memorize)

```text
S8  = CFS + Crashlytics triage + IMOC (system of reliability)
S2  = synchronised dictionaries fixed races on a shared-state PATH
S2 ⊂ reliability work, but S2 ⇏ "I alone made 99.95% CFS"
```

**Say aloud:** “Synchronised dictionaries removed intermittent race crashes on that shared state path. Crash-free at 99.95% was sustained by triage workflows, incident command, and many fixes — not one API.”

> **Provenance:** Verified · S8 · CFS/IMOC; Verified · S2 · path-scoped races — do not merge into one causal claim

---

## 3. Triage workflow

1. **Detect** — spike / CFS drop alert
2. **Classify** — new vs regressed; top stacks; version %; journey tags
3. **Reproduce** — symbolicated stack + breadcrumbs + device/OS matrix
4. **Mitigate** — flag off, pause phased rollout, hotfix path
5. **Fix** — root cause + regression test
6. **Write-up** — blameless postmortem for P0/P1

---

## 4. IMOC (leadership proof)

As **IMOC**, coordinate **iOS + backend + QA** on **P0/P1** during high-traffic events.

| Pillar | Meaning |
|---|---|
| Single owner | One incident commander / clear channel |
| Blast radius | Feature, %, geo, payment path? |
| Mitigate first | User harm down before perfect RCA |
| Cadenced comms | Ops/customer updates on a clock |
| Handoff + postmortem | Actions: alerts, tests, runbooks |

---

## 5. Glossary

| Term | Meaning |
|---|---|
| Async-signal-safe | APIs safe inside signal handlers |
| Breadcrumb | Last-N event trail for context |
| dSYM | Debug symbols for symbolication |
| Symbolication | Map addresses → functions/lines |
| Non-fatal | Caught/logged error, not session crash |
| Jetsam / OOM | Memory pressure kill |
| IMOC | Incident Management On-Call / commander role |
| Blast radius | Scope of user impact |

---

## 6. Crash vs OOM vs hang

| | Crash | OOM | Hang |
|---|---|---|---|
| Typical signal | Fatal signal/exception | SIGKILL / jetsam | Main blocked |
| Clean stack? | Often yes (if handlers work) | Often heuristic | Hang detector / MetricKit |
| Moves CFS? | Yes (fatal) | Vendor-dependent / often separate | Often **no** |

**Trap:** “CFS is fine so the app isn’t freezing.”

---

## 7. Launch ordering preview

- Prefer **crash SDK early** so launch crashes report
- Keep init **fast** (budget milliseconds-class)
- Defer heavy analytics (Day 17 launch budget)

---

## 8. Teach-back checklist

1. Pipeline: capture → persist → upload → symbolicate  
2. Async-signal-safe one-liner  
3. CFS definition + 99.95% / 30L context (S8)  
4. **S2 contributes; does not solely cause CFS**  
5. IMOC pillars  
6. Hang gap vs CFS  

## 9. One-minute CFS honesty drill

Speak continuously:

> “Crash-free at ninety-nine point nine five percent on thirty-plus lakh DAU was sustained through Crashlytics triage workflows and IMOC coordination on P0/P1s during peak traffic. Separately, synchronised dictionaries removed intermittent race crashes on a shared async state path — that contributed to reliability. I don’t collapse those into one causal story.”

Stop. If you said “because of dictionaries,” restart.

Next: [`02-deep-dive.md`](02-deep-dive.md).
