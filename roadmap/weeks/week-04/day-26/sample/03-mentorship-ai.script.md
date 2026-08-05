# Audio script — Sample 03 — Mentorship & AI judgment (Q&A)
> Listen-only sample Q&A from `03-mentorship-ai.md`. Spoken answers and follow-ups.

## §0 Q1. How do you lead without a manager title?

Next. Q1. How do you lead without a manager title? Answer. “Leadership was setting technical direction, unblocking others, and owning rollout checklists — not waiting for a manager title.” S 1 angle: define protocol contracts on Ads so teammates add ad types without forking the pipeline; explicit HeroWidget lifecycle rules so reviewers have a clear bar. S 10/S14: S D K boundaries and zero-regression checklists. Mentorship through architecture — people move faster when the envelope is obvious. Follow-ups. Concrete unblock example?: Review bar, pairing on contract, or checklist before rollout.. vs “I mentored juniors”?: Name the standard you set, not vague coaching.. No direct reports?: Fine — senior is scope and standards, not headcount..

## §1 Q2. How do you answer “how do you use AI in your workflow?”

Next. Q2. How do you answer “how do you use AI in your workflow?” Answer. 45–90s compressed S9: “I use AI inside a strict envelope — clear module boundaries, acceptance criteria, and review. It accelerates boilerplate and test drafts; I still own architecture and reject bad output. That’s District context engineering. Separately, FinTrack and GymFlow are product on-device AI with privacy and fail-soft — different story.” Timed opener: “At District I used AI as an accelerator for migration/tests — the skill was context engineering and review judgment, not prompting theater.” Follow-ups. Example rejected AI output?: Weak test assertion or wrong module boundary — you rewrote it.. When forbid AI?: Money, identity, crash paths — human-designed tests and architecture.. Copilot on critical path?: Allowed for boilerplate; not for sole design of revenue logic..

## §2 Q3. What is wrong vs senior AI tooling behavior (S9)?

Next. Q3. What is wrong vs senior AI tooling behavior (S9)? Answer. Wrong: “AI writes my code; I’m 10×.” Senior: (1) Problem — migration/tests needed leverage without surrendering design. (2) Shaped context — modules, conventions, acceptance, review bar. (3) Rejected bad generations; human oracle on critical tests. (4) Separate product AI (S15/S16). (5) Lesson: tools amplify clear thinking; ownership stays yours at 30L+ daily active users stakes. Follow-ups. Structured logging tie-in?: Debug faster during migration — part of S9 envelope, not separate brag.. “Did AI do the migration?”: No — AI assisted; you own architecture and review.. Team ships junk with Copilot?: See T2 — review bar + human tests on critical paths..

## §3 Q4. What if the team leans on Copilot and ships junk?

Next. Q4. What if the team leans on Copilot and ships junk? Answer. “I don’t ban tools and I don’t shrug. I set a review bar, require human-designed tests on money/identity/crash paths, pair on architecture so context is shared, and watch escaped defects. I teach the same context-engineering habit I used at District — tools stay, accountability stays.” Follow-ups. Escalate to manager?: After setting bar and measuring escapes — with data, not moralizing.. Ban Copilot?: No — ban unreviewed critical-path merges.. Junior dev dependency?: Pair on context shaping — teach the envelope, not prompts..

## §4 Q5. Why senior vs mid?

Next. Q5. Why senior vs mid? Answer. “Senior for me means scope and judgment: shipping on 30L+ daily active users surfaces, owning revenue-critical U I architecture, participating in 99.95%+ crash-free culture and incident coordination, delivering measurable UX wins like 30%+ nav reduction, designing reusable S D K boundaries, migrating architecture with checklists, and separating product AI privacy work from engineering-tooling AI. Mid executes tickets; senior owns trade-offs and blast radius.” Follow-ups. What mid still does well?: Executes well within a defined envelope — senior defines the envelope.. Raw / side projects role?: S D K thinking (S 10) and on-device AI (S15) show breadth.. Overclaim risk?: “Participating in” crash-free culture — not “I am the crash free sessions number.”.

## §5 Q6. How do you answer mentorship prompts in 2–3 min?

Next. Q6. How do you answer mentorship prompts in 2–3 min? Answer. Pick S 1 standards or S 10/S14 checklist — direction + unblock + rollout ownership. S 1-angled script: Ads protocol contracts + HeroWidget lifecycle bar = mentorship through architecture. Same pattern for S D K boundaries and migration checklists on other teams. Result: teammates ship faster inside a clear envelope. Lesson: leadership is making the path obvious, not holding gatekeeper meetings. Follow-ups. Formal mentor program?: Optional — technical standard-setting counts.. Conflict while mentoring?: Contract clarity — same S6 instincts.. No story ID?: Default S 1 or S 10 — both are resume-backed..

## §6 Q7. Did AI do the District migration?

Next. Q7. Did AI do the District migration? Answer. Compressed S9: AI accelerated drafts inside context and review; you rejected weak output and kept human ownership on architecture and critical-path assertions. Feature shipped; migration progressed with velocity and discipline. If they push: name one module boundary or test you rewrote after rejecting AI output. Follow-ups. Free Parking feature role?: Shipped billing adjustments — AI was leverage, not author.. M V V M/Clean migration?: Checklists + review bar — same S9 envelope.. FinTrack pivot?: “Different story — product on-device AI, not tooling.”. Next: 04-production-provenance.md.
