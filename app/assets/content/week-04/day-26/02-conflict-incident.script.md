# Audio script — Sample 02 — Conflict & incident STARs (Q&A)
> Listen-only sample Q&A from `02-conflict-incident.md`. Spoken answers and follow-ups.

## §0 Q1. How do I structure a conflict STAR (S6)?

Next. Q1. How do I structure a conflict STAR (S6)? Answer. Five beats: (1) Name the disagreement — A P I shape, scope, or UX. (2) What you did — data, options, user impact, contracts. (3) Disagree with people, not at them. (4) Resolution with relationship intact. (5) Lesson — contracts and metrics over opinions. LE Bottom Sheet example: full-screen overview too heavy → lightweight bottom sheet → align PM/Design/Backend → reusable component → 30%+ flows fewer full-screen navigations. Follow-ups. What did Backend push back on?: A P I contract and content rules — be ready with one concrete example.. How measure 30%+?: Targeted flows in scope — clarify you don’t claim all BMS navigation.. What would you do differently?: Honest trade-off — e.g. earlier contract workshop, not “nothing.”.

## §1 Q2. What is the LE bottom sheet story in one pass?

Next. Q2. What is the LE bottom sheet story in one pass? Answer. Users took full-screen navigations for event overview more than needed — friction on high-traffic flows you shared ownership of. You led an end-to-end lightweight overview as a bottom sheet, aligned Product/Design/Backend on A P I contract and content rules, shipped a reusable component into targeted flows. Result: 30%+ fewer full-screen navigations in that scope. Lesson: small U I surface + clear contracts beats a big navigation rewrite. Follow-ups. Conflict with Design specifically?: Same story — contract and user impact, not taste war.. “Reusable component” — why matter?: Shows senior thinking — pattern others can adopt.. Overclaim risk?: Say “targeted flows” — not “all of BookMyShow nav.”.

## §2 Q3. How do I structure an incident STAR (S8)?

Next. Q3. How do I structure an incident STAR (S8)? Answer. (1) Severity + user impact at 30L+ daily active users. (2) I M O C role: stabilize → communicate → RCA → prevent. (3) Concrete technical/process action — Crashlytics triage, feature guards, hotfix paths. (4) Result tied to 99.95%+ crash-free culture and minimized downtime in peaks. (5) Lesson: ownership + blast radius + rollback hero debug alone. Follow-ups. Example mitigation you drove?: Feature guard, rollback, or hotfix path — pick one real example.. How prevent recurrence?: RCA action + checklist or monitoring — not “we tried harder.”. Conflict during incident?: Clear owner and comms channel — debate after stabilize..

## §3 Q4. What does IMOC mean in your story?

Next. Q4. What does IMOC mean in your story? Answer. Incident Manager On Call — you coordinated i O S, backend, and QA when P0/P1 hit during high-traffic events. Not solo debugging: stabilize first, communicate blast radius, then root cause and prevent. Crashlytics triage with structured workflows. Senior signal = clarity of owner and rollback, not being the only person in lldb. Follow-ups. Sole credit for 99.95%?: No — “helped drive discipline on my paths” / culture participation.. I M O C vs regular on-call?: I M O C = coordination + comms + prevent, not just fixing your module.. Drama without process?: Weak — name stabilize/communicate/prevent steps..

## §4 Q5. How do you handle disagreement without being combative?

Next. Q5. How do you handle disagreement without being combative? Answer. Bring data, options, and user impact — not “I’m right.” Make the interface contract explicit so PM/Design/Backend debate facts, not taste. Escalate early when safety, security, or revenue is at stake — costs political capital but beats silent risk. After resolution, relationship intact — you’ll ship the next feature together. Follow-ups. PM wants scope you can’t meet?: Visible risk + MVP cut + protect crash-free — see deadline pushback Q.. Design wants full rewrite?: Small surface + contracts often wins — S6 lesson.. Never disagree?: Disagree with people on trade-offs — not performative conflict..

## §5 Q6. What is a good failure STAR approach?

Next. Q6. What is a good failure STAR approach? Answer. Pick one real miss you can defend — pin rotation under-specified, S D U I unknown-type gap, race before sync maps. Spine: miss → impact → what you changed (checklist, test, guard, review bar) → how you detect recurrence. No humblebrag (“I worked too hard”). No invented failure for sympathy points. Follow-ups. S D U I unknown-type miss?: Fallback + schemaVersion (S3-A1) as process change.. Race that escaped?: Concurrency boundary + tests (S 2) as prevention.. Too much detail on the miss?: 20s miss, 90s fix + prevention — stay forward-looking..

## §6 Q7. How do you push back on a bad deadline?

Next. Q7. How do you push back on a bad deadline? Answer. Make quality and reliability risk visible with options: cut scope to MVP, shift date, or accept explicit risk — don’t silent-hero overtime as the only plan. At consumer scale, protect crash-free and incident load the way P0/P1 was treated at BookMyShow. Escalate with data, not vibes. Follow-ups. “Just work weekends”?: Name the trade-off — escaped defects and incident load at 30L+ daily active users.. No time for options meeting?: One slide or message: scope A vs B vs date — still senior.. Always say no to deadlines?: No — negotiate scope and risk visibility; sometimes MVP ship is right.. Next: 03-mentorship-ai.md.
