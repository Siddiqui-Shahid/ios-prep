# Audio script — Sample 01 — Crash pipeline and CFS (Q&A)
> Listen-only sample Q&A from `01-crash-pipeline-cfs.md`. Spoken answers and follow-ups.

## §0 Q1. What is the crash SDK pipeline end to end?

Next. Q1. What is the crash SDK pipeline end to end? Answer. Init (fast, ~10ms class) → register handlers → breadcrumb ring on happy path. On crash (signal / uncaught / fatalError path): async-signal-safe write to preallocated mmap/disk → terminate. Next launch: discover report → upload → server symbolicates with matching dSYM. No malloc, ObjC, or network inside the signal handler. Follow-ups. Why init early?: Launch crashes must report — defer heavy analytics, not crash S D K (Day 17).. sigaction role?: POSIX fatals — SEGV, ABRT, etc.. try/catch covers this?: No — signals and many fatals bypass Swift error handling..

## §1 Q2. What is crash-free sessions (CFS)?

Next. Q2. What is crash-free sessions (CFS)? Answer. crash free sessions: sessions without a fatal crash (vendor definitions vary slightly — say Crashlytics sessions). Verified S 8: sustained 99.95%+ at 30+ lakh daily active users. Non-fatals ≠ crashes — still triage if user-impacting. OOM/jetsam often lacks clean client stack. Hangs may not count against crash free sessions — users still churn. Follow-ups. Trap phrase?: “crash free sessions is fine so the app isn’t freezing.”. OOM vs crash in crash free sessions?: Vendor-dependent — often separate from clean fatal crashes.. Non-fatals on payment path?: Promote to P1 even if crash free sessions unchanged..

## §2 Q3. Why must S2 and S8 stay separate in speech?

Next. Q3. Why must S2 and S8 stay separate in speech? Answer. S 8 = crash free sessions + Crashlytics triage + I M O C (system of reliability at scale). S 2 = synchronised dictionaries fixed races on a shared-state path — one engineering input among many. S 2 ⊂ reliability work, but S 2 ⇏ “I alone made 99.95% crash free sessions.” Say: dictionaries removed intermittent race crashes on that path; crash free sessions was sustained by triage, incident process, and many fixes. Follow-ups. Forbidden script?: “We hit 99.95% crash free sessions because I synchronised the dictionaries.”. OK script add-on?: “That path fix contributed; crash free sessions was the operational system.”. One-minute drill?: Foundations §9 — speak crash free sessions + I M O C + S 2 path without collapsing causality..

## §3 Q4. Crash vs OOM vs hang — compare briefly

Next. Q4. Crash vs OOM vs hang — compare briefly Answer. Crash: fatal signal/exception — often clean stack if handlers work — moves crash free sessions. OOM/jetsam: SIGKILL from memory pressure — often heuristic, not normal catchable path — vendor-dependent crash free sessions impact. Hang: main blocked — hang detector / MetricKit — often does not move crash free sessions. All three hurt users; only fatal crashes fit the classic crash free sessions story cleanly. Follow-ups. OOM detection limits?: Next-launch heuristics + MetricKit exit diagnostics on delay.. Lab for OOM suspicion?: Memory Graph + Allocations — cycles ≠ Leaks (Day 17).. Hang vs watchdog?: Hang observed; OS may kill if unresponsive long enough..

## §4 Q5. What is the triage workflow in six steps?

Next. Q5. What is the triage workflow in six steps? Answer. (1) Detect — spike / crash free sessions drop alert. (2) Classify — new vs regressed; top stacks; version %; journey tags. (3) Reproduce — symbolicated stack + breadcrumbs + device/OS matrix. (4) Mitigate — flag off, pause rollout, hotfix path. (5) Fix — root cause + regression test. (6) Write-up — blameless postmortem for P0/P1. Follow-ups. Mitigate before perfect RCA?: Yes — user harm down first (I M O C pillar).. Unsymbolicated spike?: Check dSYM CI break before blaming new code.. Journey tags?: Breadcrumbs / custom keys — which screen flow..

## §5 Q6. What is IMOC in one breath?

Next. Q6. What is IMOC in one breath? Answer. As I M O C, coordinate i O S + backend + QA on P0/P1 during high-traffic events. Pillars: single owner, blast radius (feature, %, geo, payment path), mitigate first, cadenced comms, handoff + postmortem with actionable follow-ups (alerts, tests, runbooks). Follow-ups. Blast radius example?: “12% on 4.2.1, checkout India, UPI path.”. vs lone-hero debugging?: I M O C = owner + comms + mitigate — not only stack reading.. Peak sale pressure?: Cadence updates on a clock — stakeholders need predictability..

## §6 Q7. What should the teach-back checklist cover?

Next. Q7. What should the teach-back checklist cover? Answer. Pipeline: capture → persist → upload → symbolicate. Async-signal-safe one-liner. crash free sessions definition + 99.95% / 30L context (S 8). S 2 contributes; does not solely cause crash free sessions. I M O C pillars. Hang gap vs crash free sessions. Next: signal safety and OOM honesty in sample 02. Follow-ups. dSYM keyword?: UUID match for readable stacks.. Breadcrumb keyword?: Last-N event trail — filled on happy path.. Next sample?: 02-signal-safety-oom.md. Next: 02-signal-safety-oom.md.
