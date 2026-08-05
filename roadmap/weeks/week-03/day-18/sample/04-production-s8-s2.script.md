# Audio script — Sample 04 — Production S8 and S2 (Q&A)
> Listen-only sample Q&A from `04-production-s8-s2.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S8?

Next. Q1. What can you claim under Verified · S8? Answer. 30+ lakh daily active users, sustained 99.95%+ crash-free sessions, Crashlytics triage with structured workflows, I M O C coordination for P0/P1 during high-traffic events. Mitigations first: feature guards, rollout pause, hotfix path, cadenced comms. crash free sessions as sustained operational bar — not a slide metric. Forbidden: invented downtime minutes, “I wrote in-house signal handler” by default, “crash free sessions proves no hangs.” Follow-ups. ≤20s line?: “At 30L+ daily active users we held 99.95%+ crash-free — Crashlytics triage plus I M O C on P0/P1s, not just fixing stacks alone.”. Provenance tag?: Verified · S 8 · BookMyShow · 30L+ daily active users · 99.95%+ crash free sessions · I M O C. Lesson?: Incident leadership = owner + blast radius + rollback — not lone-hero debugging..

## §1 Q2. Walk the S8 STAR spine

Next. Q2. Walk the S8 STAR spine Answer. Opener: Sustaining 99.95%+ crash free sessions at 30L+ daily active users. S/T: Consumer ticketing at very large daily active users — reliability as product during peak; structured crash response and multi-team command. Action: Crashlytics triage workflow; I M O C across i O S/backend/QA; mitigate first; crash free sessions as operational bar. Result: Sustained high crash free sessions; reduced peak-event downtime impact through ownership and blast-radius thinking. Lesson: Owner + mitigate + comms — not stack reading alone. Follow-ups. Action detail interviewers want?: Detect → classify → reproduce → mitigate → fix → write-up.. Result without fake stats?: Sustained bar + reduced impact — no invented minute counts.. Behavioral emphasis?: Cadenced comms under peak sale pressure..

## §2 Q3. How do you add S2 without stealing S8?

Next. Q3. How do you add S2 without stealing S8? Answer. OK (≤90s add-on): “Separately, shared async dictionaries had intermittent race crashes. We gated access with G C D serial queues and RW locks behind a safe A P I — removed concurrent-access crashes on that path. That contributed to reliability. I’m not claiming one fix is the whole 99.95% crash free sessions story — triage, incident process, and many inputs including concurrency hygiene.” Forbidden: “We hit 99.95% because I synchronised dictionaries.” Follow-ups. S 2-A1?: Greenfield → Swift actor — How I would apply it.. When lead S 2 vs S 8?: Incident/leadership → S 8; concurrency depth → S 2 add-on after.. Provenance split?: S 8 system · S 2 path-scoped..

## §3 Q4. What must you never say about S8 and S2 together?

Next. Q4. What must you never say about S8 and S2 together? Answer. Never: S 2 alone caused/delivered 99.95% crash free sessions. Never: in-house signal handler unless evidenced. Never: invented crash counts or downtime minutes. Never: crash free sessions proves no hangs/OOM pain. Never: merge S 8 I M O C story into fake memory Graph war story. Follow-ups. crash free sessions honesty drill?: Foundations §9 — one minute continuous speak, restart if “because dictionaries.”. Hang gap phrase?: “crash free sessions fine — still check hangs and MetricKit.”. Memory tools if asked?: Applied triage — Graph/Allocations, not Leaks for cycles..

## §4 Q5. How do behavioral variants use the same facts?

Next. Q5. How do behavioral variants use the same facts? Answer. Conflict: I M O C timeline vs blame spiral. Pressure: peak traffic mitigate-first + comms clock. Leadership: owner, handoff, postmortem actions. Technical: S 2 races + signal-safety vocabulary as add-on — same Verified S 8 spine, different emphasis per prompt. Follow-ups. STAR time budget?: 2–3 min — opener 10s, action ~90s.. Mid-STAR memory question?: Short Applied triage sentence — return to I M O C narrative.. Postmortem?: Blameless — alerts/tests/runbooks as outputs..

## §5 Q6. How does S8 bridge to Days 17 and 20?

Next. Q6. How does S8 bridge to Days 17 and 20? Answer. Day 17: crash free sessions may be fine while users freeze — hang/OOM observability separate. Perf p90 culture (S5) complements crash free sessions — don’t trust crash-free alone for UX. Day 20: release trains pause on perf/crash free sessions gates; dSYM upload CI. Reliability is ops + engineering — not one dictionary fix. Follow-ups. Jetsam clusters?: OOM heuristics + memory lab — not always crash free sessions fatal.. Peak + perf?: S5 p90 and S 8 crash free sessions both matter during events.. Security launch cost?: Day 19 — measure; don’t silently regress startup..

## §6 Q7. Give a full honest answer mixing S8 and S2

Next. Q7. Give a full honest answer mixing S8 and S2 Answer. “At 30L+ daily active users we held 99.95%+ crash-free sessions through Crashlytics triage and I M O C coordination on P0/P1s (Verified S 8) — mitigate first, blast radius, cadenced comms. Separately, synchronised shared async dictionaries removed intermittent race crashes on that path (Verified S 2) — one reliability input among many. I don’t collapse those into one causal story. Hangs and OOM still need their own observability even when crash free sessions looks fine.” Follow-ups. Verified in paragraph?: Scale, crash free sessions bar, I M O C, triage workflow.. S 2 in paragraph?: Path-scoped race fix — contributed, not sole cause.. Honesty closing?: crash free sessions ≠ full UX health..

## §7 Q8. What is the one-minute CFS honesty drill?

Next. Q8. What is the one-minute CFS honesty drill? Answer. Speak continuously: “Crash-free at ninety-nine point nine five percent on thirty-plus lakh daily active users was sustained through Crashlytics triage workflows and I M O C coordination on P0/P1s during peak traffic. Separately, synchronised dictionaries removed intermittent race crashes on a shared async state path — that contributed to reliability. I don’t collapse those into one causal story.” Stop. If you said “because of dictionaries,” restart. Follow-ups. Why drill?: Interviews tempt false causality — muscle memory prevents it.. After this sample?: Code notes,../04-questions.md,../05-exercises.md.. Primary provenance?: S 8 I M O C/crash free sessions system + S 2 path honesty.. After this sample 1. Skim../code/BreadcrumbRing.swift and../code/CrashReportNotes.swift. 2. Time S 8 STAR + S 2 add-on from../04-questions.md. 3. Run the one-minute crash free sessions honesty drill aloud until clean.
