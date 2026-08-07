# Audio script — Revision guide — Crash Reporting, Observability & Incident Response (IMOC)
> Listen-only revision day guide from `day-18.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Crash S D K pipeline: capture → async-signal-safe persist → next-launch upload → dSYM symbolication Crash vs OOM vs hang — and why crash free sessions can look fine while users report freezes BookMyShow I M O C + crash-free at scale: 30L+ daily active users, 99.95%+ crash free sessions, Crashlytics triage, I M O C on P0/P1.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Crash pipeline

Next. 2.1 Crash pipeline. 2.1 Crash pipeline.

## §3 2.2 Failure modes beyond crashes

Next. 2.2 Failure modes beyond crashes. 2.2 Failure modes beyond crashes.

## §4 2.3 IMOC triage

Next. 2.3 IMOC triage. Mitigate first (feature flag, rollback, hotfix path) → communicate → root-cause → postmortem. Concurrency fixes are one contributor, not the whole crash free sessions story.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow I M O C + crash-free at scale: BookMyShow — 30L+ daily active users, sustained 99.95%+ crash free sessions via Crashlytics workflows and I M O C on P0/P1 incidents. BookMyShow synchronised dictionaries: G C D serial-queue / RW sync dictionaries eliminated path-scoped race crashes — contributes to reliability, does not solely own crash free sessions. Interview line (≤20s): “At 30L+ daily active users we ran I M O C on crash spikes — mitigate first, symbolicate with dSYM, and treat concurrency fixes as one path among many toward 99.95% crash free sessions.” → BookMyShow I M O C + crash-free at scale I M O C · BookMyShow synchronised dictionaries Concurrency.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Crash capture → persist → upload → symbolicate — say it in order 2. What is async-signal-safe in a handler? 3. try/catch vs signal crash — why different 4. OOM vs crash — crash free sessions and detection differences.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
