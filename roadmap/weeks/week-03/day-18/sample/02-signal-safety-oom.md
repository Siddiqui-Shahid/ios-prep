# Sample 02 — Signal safety and OOM (Q&A)

> Guided teaching. Each answer stands alone and ends with **How can I relate to my case** using named work — never S-codes.

---

### Q1. What does async-signal-safe mean in the crash path?
**Answer:**

> In a signal handler you may only use APIs guaranteed **async-signal-safe** — typically preallocated buffers and syscalls like `write`. **Forbidden:** malloc, ObjC/Swift runtime calls, normal logging, locks, network upload. The crash path survives long enough to **persist a report** — not to run a full-featured dump with normal frameworks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why no malloc? | Allocator locks and reentrancy — crash may have interrupted malloc. |
| Why no locks? | Deadlock if crash held the lock. |
| Interview one-liner? | “Persist preallocated — don’t allocate in the handler.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q2. What happens conceptually inside the handler?
**Answer:**

> On fatal signal: suspend other threads (implementation-dependent — be honest it’s delicate) → capture backtrace/registers into **preallocated** buffer → `write` to mmap/file descriptor → reset handler / abort to terminate. Breadcrumbs were already recorded on the happy path into a lock-free ring.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Upload when? | Next cold start — backoff, quota — never in handler. |
| Suspend threads caveat? | Delicate — vendor SDKs differ; don’t overclaim custom handler expertise. |
| Learning-lab? | [`../code/CrashReportNotes.swift`](../code/CrashReportNotes.swift) |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How should breadcrumbs be designed?
**Answer:**

> **Ring buffer**, last N events (~50–100 class): navigations, key actions, HTTP status codes — **scrub** tokens, auth headers, PII at source. Filled on happy path with lock-free / careful concurrency — crash may interrupt mid-write. Privacy incident if auth headers logged → Sev, rotate, lint forbidden keys.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sketch? | [`../code/BreadcrumbRing.swift`](../code/BreadcrumbRing.swift) |
| Heavy breadcrumbs cost? | CPU + PII risk — balance debuggability. |
| Forbidden keys lint? | CI guard against `Authorization` in breadcrumb payloads. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. How does symbolication work and fail?
**Answer:**

> Report carries **build UUID** → server finds matching **dSYM** → load address + frame offset → function/file/line. Failures: missing dSYM upload in CI (unreadable stacks), mismatched build UUID, legacy bitcode confusion. **Day 20 CI link:** every TestFlight/App Store build uploads symbols.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Spike “new crash” but stacks obfuscated? | Symbolication outage — confirm before code panic. |
| Hotfix readability? | Same UUID discipline for hotfix binaries. |
| Default vendor? | Crashlytics workflows — don’t claim in-house handler unless evidenced. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. What are honest limits of OOM detection?
**Answer:**

> Jetsam `SIGKILL` is **not** a normal catchable crash path. Use next-launch heuristics (high last footprint + no clean exit + no crash file), **MetricKit** OOM/exit diagnostics on delay, and lab **Memory Graph / Allocations** for reproduction. Be honest: OOM stacks are often heuristic, not as clean as SEGV with good handlers.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pair with Day 16? | Decoded L1 spikes under peak events → jetsam clusters. |
| Cycles in OOM story? | Abandoned heaps contribute — Graph, not Leaks. |
| User Documents? | Never wipe on memory pressure — L2 image cache OK to lose. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q6. What are upload reliability rules?
**Answer:**

> **Do:** persist on crash; upload next cold start; backoff + quota; cap pending reports. **Don’t:** network inside signal handler; delete last report before server ack; unlimited disk fill from queued reports.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Offline users? | Reports queue — upload when connectivity returns. |
| Duplicate uploads? | Idempotency / dedupe on server side — client retries safely. |
| Launch budget? | Crash SDK init fast — heavy work after first frame where possible. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. What non-fatal error hygiene matters?
**Answer:**

> Group, sample, fix top offenders. Don’t equate non-fatal volume with CFS. Promote to P1 when user-impacting on critical path (payments). Alert fatigue kills incident response — same discipline as breadcrumb PII.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| vs fatal triage? | Non-fatals inform quality; CFS tracks session fatals. |
| Payment non-fatal? | Treat as Sev even if crash-free.session continues. |
| OSLog in handler? | Explicit trap — dedicated Q8. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. Why is OSLog / logging inside a signal handler a trap?
**Answer:**

> **OSLog and normal logging frameworks are not async-signal-safe.** Calling them from a signal handler is how you get a **secondary crash or deadlock**. The crash writer must use a **precomputed path** — mmap and safe writes — without allocating. **Breadcrumbs are recorded earlier on the happy path** so the handler only persists what’s already there. Common wrong answer: “Just OSLog from the signal handler.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What *is* allowed? | Limited async-signal-safe syscalls (`write`, etc.) into preallocated buffers. |
| Where do logs go then? | Happy-path breadcrumbs + next-launch upload — never a full logger in-handler. |
| Next sample? | [03-imoc-triage.md](03-imoc-triage.md) — incident command. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

Next: [03-imoc-triage.md](03-imoc-triage.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What happens conceptually inside the handler

**Ask yourself:** What happens conceptually inside the handler?

**Answer:** “On fatal signal: suspend other threads (implementation-dependent — be honest it’s delicate) → capture backtrace/registers into **preallocated** buffer → `write` to mmap/file descriptor → reset handler / abort to terminate. Breadcrumbs were already recorded on the happy path into a lock-free ring.”

### Puzzle B — How should breadcrumbs be designed

**Ask yourself:** How should breadcrumbs be designed?

**Answer:** “**Ring buffer**, last N events (~50–100 class): navigations, key actions, HTTP status codes — **scrub** tokens, auth headers, PII at source. Filled on happy path with lock-free / careful concurrency — crash may interrupt mid-write. Privacy incident if auth headers logged → Sev, rotate, lint forbidden keys.”

### Puzzle C — How does symbolication work and fail

**Ask yourself:** How does symbolication work and fail?

**Answer:** “Report carries **build UUID** → server finds matching **dSYM** → load address + frame offset → function/file/line. Failures: missing dSYM upload in CI (unreadable stacks), mismatched build UUID, legacy bitcode confusion. **Day 20 CI link:** every TestFlight/App Store build uploads symbols.”
