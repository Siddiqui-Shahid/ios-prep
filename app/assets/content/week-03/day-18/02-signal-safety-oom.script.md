# Audio script — Sample 02 — Signal safety and OOM (Q&A)
> Listen-only sample Q&A from `02-signal-safety-oom.md`. Spoken answers and follow-ups.

## §0 Q1. What does async-signal-safe mean in the crash path?

Next. Q1. What does async-signal-safe mean in the crash path? Answer. In a signal handler you may only use APIs guaranteed async-signal-safe — typically preallocated buffers and syscalls like write. Forbidden: malloc, ObjC/Swift runtime calls, normal logging, locks, network upload. The crash path survives long enough to persist a report — not to run a full-featured dump with normal frameworks. Follow-ups. Why no malloc?: Allocator locks and reentrancy — crash may have interrupted malloc.. Why no locks?: Deadlock if crash held the lock.. Interview one-liner?: “Persist preallocated — don’t allocate in the handler.”.

## §1 Q2. What happens conceptually inside the handler?

Next. Q2. What happens conceptually inside the handler? Answer. On fatal signal: suspend other threads (implementation-dependent — be honest it’s delicate) → capture backtrace/registers into preallocated buffer → write to mmap/file descriptor → reset handler / abort to terminate. Breadcrumbs were already recorded on the happy path into a lock-free ring. Follow-ups. Upload when?: Next cold start — backoff, quota — never in handler.. Suspend threads caveat?: Delicate — vendor SDKs differ; don’t overclaim custom handler expertise.. Learning-lab?:../code/CrashReportNotes.swift.

## §2 Q3. How should breadcrumbs be designed?

Next. Q3. How should breadcrumbs be designed? Answer. Ring buffer, last N events (~50–100 class): navigations, key actions, HTTP status codes — scrub tokens, auth headers, PII at source. Filled on happy path with lock-free / careful concurrency — crash may interrupt mid-write. Privacy incident if auth headers logged → Sev, rotate, lint forbidden keys. Follow-ups. Sketch?:../code/BreadcrumbRing.swift. Heavy breadcrumbs cost?: CPU + PII risk — balance debuggability.. Forbidden keys lint?: CI guard against Authorization in breadcrumb payloads..

## §3 Q4. How does symbolication work and fail?

Next. Q4. How does symbolication work and fail? Answer. Report carries build UUID → server finds matching dSYM → load address + frame offset → function/file/line. Failures: missing dSYM upload in CI (unreadable stacks), mismatched build UUID, legacy bitcode confusion. Day 20 CI link: every TestFlight/App Store build uploads symbols. Follow-ups. Spike “new crash” but stacks obfuscated?: Symbolication outage — confirm before code panic.. Hotfix readability?: Same UUID discipline for hotfix binaries.. Default vendor?: Crashlytics workflows — don’t claim in-house handler unless evidenced..

## §4 Q5. What are honest limits of OOM detection?

Next. Q5. What are honest limits of OOM detection? Answer. Jetsam SIGKILL is not a normal catchable crash path. Use next-launch heuristics (high last footprint + no clean exit + no crash file), MetricKit OOM/exit diagnostics on delay, and lab Memory Graph / Allocations for reproduction. Be honest: OOM stacks are often heuristic, not as clean as SEGV with good handlers. Follow-ups. Pair with Day 16?: Decoded L1 spikes under peak events → jetsam clusters.. Cycles in OOM story?: Abandoned heaps contribute — Graph, not Leaks.. User Documents?: Never wipe on memory pressure — L2 image cache OK to lose..

## §5 Q6. What are upload reliability rules?

Next. Q6. What are upload reliability rules? Answer. Do: persist on crash; upload next cold start; backoff + quota; cap pending reports. Don’t: network inside signal handler; delete last report before server ack; unlimited disk fill from queued reports. Follow-ups. Offline users?: Reports queue — upload when connectivity returns.. Duplicate uploads?: Idempotency / dedupe on server side — client retries safely.. Launch budget?: Crash S D K init fast — heavy work after first frame where possible..

## §6 Q7. What non-fatal error hygiene matters?

Next. Q7. What non-fatal error hygiene matters? Answer. Group, sample, fix top offenders. Don’t equate non-fatal volume with crash free sessions. Promote to P1 when user-impacting on critical path (payments). Alert fatigue kills incident response — same discipline as breadcrumb PII. Follow-ups. vs fatal triage?: Non-fatals inform quality; crash free sessions tracks session fatals.. Payment non-fatal?: Treat as Sev even if crash-free.session continues.. OSLog in handler?: Explicit trap — dedicated Q8..

## §7 Q8. Why is OSLog / logging inside a signal handler a trap?

Next. Q8. Why is OSLog / logging inside a signal handler a trap? Answer. OSLog and normal logging frameworks are not async-signal-safe. Calling them from a signal handler is how you get a secondary crash or deadlock. The crash writer must use a precomputed path — mmap and safe writes — without allocating. Breadcrumbs are recorded earlier on the happy path so the handler only persists what’s already there. Common wrong answer: “Just OSLog from the signal handler.” Follow-ups. What is allowed?: Limited async-signal-safe syscalls (write, etc.) into preallocated buffers.. Where do logs go then?: Happy-path breadcrumbs + next-launch upload — never a full logger in-handler.. Next sample?: 03-imoc-triage.md — incident command..
