# 02 — Deep Dive: Crash SDK, OOM, IMOC

---

## 1. Signal handling (what “safe” means)

### 1.1 Handler responsibilities (conceptual)

```text
On fatal signal:
  1. Suspend other threads (implementation-dependent; be honest it’s delicate)
  2. Capture backtrace / registers into PREALLOCATED buffer
  3. write() to mmap / file descriptor — no malloc
  4. Reset handler / abort to terminate
```

### 1.2 Forbidden in-handler

| Forbidden | Why |
|---|---|
| `malloc` / new objects | Allocator locks / reentrancy |
| Obj-C / many Swift runtime calls | May allocate or lock |
| Normal logging (`OSLog`, print frameworks) | May deadlock |
| Taking locks | Deadlock if crash held the lock |
| Starting network upload | Not signal-safe; wrong time |

### 1.3 Allowed mindset

- Preallocate crash region at init
- Async-signal-safe syscalls only (`write`, etc.)
- Breadcrumbs already in a lock-free ring filled on the happy path

**Interview line:**  
> “The crash path is about surviving long enough to persist a report — not about doing a full-featured dump with normal APIs.”

---

## 2. Breadcrumbs

| Design | Detail |
|---|---|
| Structure | Ring buffer, last N events (~50–100 class) |
| Content | Navigations, key actions, HTTP status codes |
| Scrub | Tokens, auth headers, PII — at source |
| Concurrency | Lock-free / careful — crash may interrupt |

**Privacy incident:** breadcrumbs with auth headers → treat as Sev; rotate; lint forbidden keys.

---

## 3. Symbolication & dSYM

```text
Build UUID in report
  → server finds matching dSYM
  → load address + frame offset → function/file/line
```

| Failure | Symptom | Fix |
|---|---|---|
| Missing dSYM upload in CI | Unreadable stacks | Fix pipeline; re-upload |
| Mismatched build | Wrong/partial symbols | UUID discipline |
| Bitcode legacy confusion | Old advice | Modern: always upload dSYMs you ship |

**CI link (Day 20):** every TestFlight/App Store build uploads symbols.

---

## 4. OOM detection (honest limits)

- `SIGKILL` from jetsam is **not** a normal catchable crash path
- Next-launch heuristics: high last footprint + no clean exit + no crash file
- MetricKit OOM / exit diagnostics arrive on delay
- Memory Graph / Allocations (Day 17) for lab reproduction — **cycles ≠ Leaks**

---

## 5. Upload reliability

| Do | Don’t |
|---|---|
| Persist on crash; upload next cold start | Network inside signal handler |
| Backoff + quota awareness | Delete last report naively before ack |
| Cap pending reports | Unlimited disk fill |

---

## 6. Non-fatals & alert hygiene

- Group, sample, fix top offenders
- Don’t equate non-fatal volume with CFS
- Promote to P1 when user-impacting critical path (payments)

---

## 7. IMOC deep dive — scripts you can speak

### 7.1 First 10 minutes

1. Confirm spike is real (not symbolication outage / bad deploy tag)
2. Declare IMOC / channel
3. Blast radius: version %, feature flag, geo, payment?
4. Mitigate: pause phased release / kill switch / disable feature
5. Comms cadence: next update in N minutes

### 7.2 Mitigate vs hotfix

| Lever | When |
|---|---|
| Remote config / flag | Fast; preferred when path optional |
| Pause phased rollout | Binary already bad for % |
| Hotfix | Native crash on mandatory path; review latency trade-off |

### 7.3 Cross-team blame spiral

Force shared timeline + correlation IDs + % failing by layer. Mitigate user harm first (fallback, disable). RCA second.

---

## 8. S2 concurrency — correct framing

**What S2 was:** shared async maps hit from multiple queues → races → intermittent crashes; fixed with **GCD serial queues** / RW locks and a safe API boundary.

**What S2 was not:** the single explanation for org-wide **99.95% CFS**.

| OK to say | Not OK to say |
|---|---|
| “Removed race crashes on that shared state path” | “S2 is why we have 99.95% CFS” |
| “One reliability engineering input among triage + IMOC + others” | “Dictionaries alone held CFS” |

> **Provenance:** Verified · S2 · path-scoped; Verified · S8 · CFS/IMOC system

**Today’s Applied:** greenfield → Swift `actor` (S2-A1) with same API surface mindset.

---

## 9. Trade-offs

| Choice | When | Cost |
|---|---|---|
| Vendor Crashlytics | Fast symbolication pipeline | Vendor + privacy review |
| In-house crash SDK | Staff SD / special needs | Signal-safety correctness risk |
| Heavy breadcrumbs | Debuggability | CPU + PII risk |
| Crash SDK first | Reliable launch reports | Must stay fast |
| Non-fatal spam | Noise | Alert fatigue |
| Always hotfix | Rare true need | Process cost; prefer flags |
| Blame culture | Never | Kills reporting |

---

## 10. Failure modes

| Mode | Senior response |
|---|---|
| try/catch will catch SEGV | No — signals/fatalError need handlers + discipline |
| CFS fine, users freeze | Hang/OOM/MetricKit — Day 17 |
| Unsymbolicated spike | dSYM CI break |
| iOS vs backend war room | IMOC timeline, mitigate first |
| Breadcrumbs logged tokens | Scrub + rotate + Sev |

---

## 11. Optional citations

- `ios-system-design/docs/crash-reporting-sdk.md`
- Apple Understanding crashes / MetricKit diagnostics
- Stories S8, S2

Chapter is self-contained without opening them.
