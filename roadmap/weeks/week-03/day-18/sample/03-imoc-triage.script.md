# Audio script — Sample 03 — IMOC and triage (Q&A)
> Listen-only sample Q&A from `03-imoc-triage.md`. Spoken answers and follow-ups.

## §0 Q1. What do you do in the first ten minutes of a P0?

Next. Q1. What do you do in the first ten minutes of a P0? Answer. (1) Confirm spike is real — not symbolication outage or bad deploy tag. (2) Declare I M O C / war-room channel. (3) Blast radius: version %, feature flag, geo, payment path? (4) Mitigate: pause phased release, kill switch, disable feature. (5) Comms cadence: next update in N minutes. User harm down before perfect RCA. Follow-ups. Fake spike example?: dSYM pipeline broken — stacks all <unknown.. Mitigate vs debug first?: Mitigate — I M O C pillar.. Payment path?: Highest blast radius — escalate comms frequency..

## §1 Q2. Mitigate vs hotfix — when which lever?

Next. Q2. Mitigate vs hotfix — when which lever? Answer. Remote config / feature flag — fast, preferred when path is optional. Pause phased rollout — binary already bad for a %. Hotfix — native crash on mandatory path; trade review latency vs user harm. Staff default: flags and rollout pause before App Store emergency unless unavoidable. Follow-ups. Kill switch example?: Disable optional Stories S D K entry — not payment core without fallback.. Hotfix cost?: Process, review time, regression risk — justify with blast radius.. Backend mitigate?: Fallback A P I response while i O S fix ships — I M O C coordinates both..

## §2 Q3. How do you stop iOS vs backend blame spirals?

Next. Q3. How do you stop iOS vs backend blame spirals? Answer. Force shared timeline with correlation IDs and % failing by layer. Mitigate user harm first — fallback U I, disable feature, pause rollout. RCA second. I M O C owns the channel and cadence — not “my stack vs your stack.” Follow-ups. Correlation ID example?: Checkout request id in breadcrumb + backend log.. % by layer?: “80% fail on A P I 503” vs “20% client decode” — focuses fix.. Behavioral interview angle?: Conflict → shared timeline + mitigate first..

## §3 Q4. How do you classify a Crashlytics spike?

Next. Q4. How do you classify a Crashlytics spike? Answer. New vs regressed (version compare). Top symbolicated stacks. Affected version % and device/OS matrix. Journey tags from breadcrumbs. Separate fatals (crash free sessions) from non-fatals (quality). Confirm symbolication healthy before treating as new native bug. Follow-ups. Regressed signal?: Spike on latest version only — bisect release.. Flaky reproduce?: Race crashes (S 2 path) — device matrix + stress.. Non-fatal flood?: Sample/group — don’t page on volume alone..

## §4 Q5. What is S2’s correct technical framing?

Next. Q5. What is S2’s correct technical framing? Answer. S 2 was: shared async maps hit from multiple queues → races → intermittent crashes; fixed with G C D serial queues / RW locks and safe A P I boundary. S 2 was not: single explanation for org-wide 99.95% crash free sessions. OK: “Removed race crashes on that path.” Not OK: “S 2 is why we have 99.95% crash free sessions.” Follow-ups. S 2-A1 greenfield?: Swift actor with same A P I boundary mindset — Applied.. try/catch myth?: SEGV/races need concurrency discipline + handlers — not catch alone.. Provenance?: Verified · S 2 path-scoped; Verified · S 8 system..

## §5 Q6. What IMOC pillars map to behavioral prompts?

Next. Q6. What IMOC pillars map to behavioral prompts? Answer. Conflict: I M O C forces shared timeline vs blame. Pressure / peak sale: mitigate first, cadenced comms. Leadership: owner clarity, handoff, postmortem actions. Technical depth: add S 2 path + signal-safety vocabulary — but S 8 STAR leads on incident ownership questions. Follow-ups. Postmortem output?: Alerts, tests, runbooks — not blame names.. Handoff?: Document state when shift ends — I M O C continuity.. Peak traffic BMS context?: 30L+ daily active users — reliability is product during sales..

## §6 Q7. Whiteboard the crash SDK in ten minutes — what to include?

Next. Q7. Whiteboard the crash SDK in ten minutes — what to include? Answer. Handlers → mmap writer → breadcrumb ring (happy path) → next-launch uploader → dSYM symbolication. Call out signal safety and “no upload in handler.” Init early but fast. Default interview assumption: Crashlytics-class vendor unless you evidence in-house S D K. Follow-ups. Forbidden claim?: “I wrote our in-house signal handler” without evidence.. CI box on diagram?: dSYM upload per build — Day 20.. Next sample?: 04-production-s8-s2.md — Verified STAR language.. Next: 04-production-s8-s2.md.
