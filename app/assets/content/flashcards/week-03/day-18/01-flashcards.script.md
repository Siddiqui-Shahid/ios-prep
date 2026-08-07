# Audio script — Flashcards — Crash Reporting, Observability & Incident Response (IMOC)
> Listen-only flashcard Q&A from `week-03.md`. Spoken answers.

## §0 Q1. BookMyShow synchronised dictionaries alone caused 99.95% CFS

Next. BookMyShow synchronised dictionaries alone caused 99.95% crash free sessions? Answer. Forbidden — BookMyShow synchronised dictionaries ⊂ reliability; BookMyShow I M O C + crash-free at scale = system.

## §1 Q2. try/catch catches SEGV

Next. try/catch catches SEGV? Answer. No — signals need handlers + discipline.

## §2 Q3. Upload in signal handler

Next. Upload in signal handler? Answer. Never — persist async-signal-safe; upload next launch.

## §3 Q4. CFS fine ⇒ no freezes

Next. crash free sessions fine ⇒ no freezes? Answer. False — hangs/OOM may not move crash free sessions.

## §4 Q5. Leaks for retain cycles

Next. Leaks for retain cycles? Answer. Wrong tool — Graph + Allocations.

## §5 Q6. BookMyShow IMOC + crash-free at scale

Next. BookMyShow I M O C + crash-free at scale? Answer. 30L+ daily active users, 99.95%+ crash free sessions, Crashlytics triage, I M O C.
