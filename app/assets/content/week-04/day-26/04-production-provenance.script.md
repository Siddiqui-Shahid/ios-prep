# Audio script — Sample 04 — Production provenance walls (Q&A)
> Listen-only sample Q&A from `04-production-provenance.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim for S1 (Ads / HeroWidget)?

Next. Q1. What can you claim for S1 (Ads / HeroWidget)? Answer. Allowed: P O P, generics, HeroWidget lifecycle, revenue-critical module ownership, maintainable type-safe pipeline, pause/play tied to visibility and view-controller lifecycle. Forbidden: Invented fill-rate % or revenue percentage. Spine: highest-revenue Ads → P O P + generics pipeline → HeroWidget lifecycle → stakeholder alignment without breaking revenue path. Follow-ups. Why not inheritance?: Protocol-oriented design scales ad types without a class thicket.. How test lifecycle?: Visibility + view controller lifecycle — explicit pause/play rules.. Conflict on A P I shape?: Same S6 instinct — contract and user impact..

## §1 Q2. What can you claim for S6 (LE bottom sheet)?

Next. Q2. What can you claim for S6 (LE bottom sheet)? Answer. Allowed: 30%+ fewer full-screen navigations on targeted flows; cross-functional alignment on A P I contract; reusable bottom sheet component. Forbidden: “All of BMS navigation −30%” or any overclaim beyond resume scope. Always pair the metric with “in that scope” or “targeted flows.” Follow-ups. Interviewer challenges 30%+?: Clarify measurement scope — nav reduction on flows you shipped, not whole app.. No metric in follow-up?: Weak answer — S6 needs the number or a crisp qualitative outcome.. Design-only story?: Still need your technical ownership — component + contracts..

## §2 Q3. What can you claim for S8 (IMOC / crash-free)?

Next. Q3. What can you claim for S8 (IMOC / crash-free)? Answer. Allowed: 30L+ daily active users context, 99.95%+ crash-free discipline on your paths, I M O C coordination on P0/P1, Crashlytics triage, stabilize-communicate-prevent. Forbidden: Sole ownership of all company crash-free sessions; drama without process. Wording: “helped drive” / “participated in culture” — honest scope. Follow-ups. I M O C every incident?: No — describe role when you held it during peaks.. Hero debug story?: Fine as one Action step — lesson still rollback + owner.. Backend blame?: No — coordination and blast radius, not blame theater..

## §3 Q4. What can you claim for S9 (District AI tooling)?

Next. Q4. What can you claim for S9 (District AI tooling)? Answer. Allowed: Context engineering, AI-assisted tests/reviews inside envelope, Clean/M V V M migration discipline, structured logging, rejected bad generations. Forbidden: “AI wrote the app”; mixing S15/S16 product AI into tooling answer. Contrast line ready: FinTrack/GymFlow = product on-device systems. Follow-ups. Name the tools?: Cursor, Claude, Copilot — as accelerators, not authors.. XCTest/XCUITest drafts?: Allowed — with human review on assertions.. S15 if they ask privacy?: Pivot cleanly — on-device, fail-soft, no cloud sync of finance data..

## §4 Q5. What metrics are forbidden to invent?

Next. Q5. What metrics are forbidden to invent? Answer. Fill-rate % on Ads. Company-wide navigation reduction. Sole crash-free ownership. Revenue % lift you didn’t measure. Fake failure stories. Fake I M O C war stories. If it’s not on the resume or story bank with Verified tag, don’t say it in interview pressure. Follow-ups. Approximate numbers OK?: No — crisp allowed metrics or qualitative outcome.. “Significantly improved”?: Weaker than 30%+ or 99.95%+ when you have them.. Story bank location?:../../../stories/story-bank.md.

## §5 Q6. How do you answer “biggest impact metric?”

Next. Q6. How do you answer “biggest impact metric?” Answer. Pick one and scope honestly: “The cleanest product metric is the LE bottom sheet — 30%+ fewer full-screen navigations on targeted flows. For reliability context I cite 99.95%+ crash-free and 30L+ daily active users ownership environment — with honest scope wording.” Don’t stack three metrics as if each was your solo achievement. Follow-ups. They want one number only?: S6 30%+ for product impact; S 8 for reliability culture.. Side project metric?: FinTrack/GymFlow only if question invites — default BMS trio.. No metric role?: Crisp qualitative outcome + lesson — still better than invented %..

## §6 Q7. What is the S1 full script spine for recording?

Next. Q7. What is the S1 full script spine for recording? Answer. Opener: “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.” S/T: Ads module + video in HeroWidget lifecycle. A: P O P + generics pipeline; explicit pause/play; stakeholder alignment. R: Maintainable type-safe pipeline; lifecycle-correct video. L: P O P + generics over inheritance; lifecycle is product contract. Record at 2–3 min; practice from Answer points then full script in../04-questions.md. Follow-ups. Priority record set?: S6, S 8, S9, S 1 + T2 (Copilot junk).. Voice memo artifact?: Yes — Day 26 has no code/; voice is the deliverable.. Provenance tag?: Verified · S 1 · BookMyShow · Ads / HeroWidget. Next:../04-questions.md for full spoken scripts ·../05-exercises.md for record reps.
