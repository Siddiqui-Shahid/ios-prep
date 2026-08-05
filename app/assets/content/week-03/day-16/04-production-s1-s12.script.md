# Audio script — Sample 04 — Production S1 and S12 (Q&A)
> Listen-only sample Q&A from `04-production-s1-s12.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S1?

Next. Q1. What can you claim under Verified · S1? Answer. Highest-revenue Ads refactor with P O P + Generics for a safer reusable rendering pipeline. HeroWidget with explicit pause/play tied to visibility, view controller lifecycle, and cell reuse. Prevented creative-type forks. Stakeholder coordination on revenue behavior. You may not invent fill-rate percentages or claim you authored NSCache/Kingfisher. Follow-ups. Provenance tag?: Verified · S 1 · BookMyShow · Ads / HeroWidget. Result without fake metrics?: Maintainable typed pipeline; lifecycle-correct video reduced wasted playback and glitches.. Lesson one-liner?: Lifecycle is part of the product contract on revenue U I..

## §1 Q2. Walk the S1 STAR spine

Next. Q2. Walk the S1 STAR spine Answer. Opener: Highest-revenue Ads — protocols, generics, video lifecycle. S/T: Safer reusable rendering; HeroWidget video needed correct pause/play. Action: P O P contracts + generics pipeline; explicit pause on visibility/view controller/reuse; no creative forks; stakeholder alignment. Result: Typed pipeline; lifecycle-correct playback (no fill-rate %). Lesson: Lifecycle = product contract. Follow-ups. Tie to Day 02 P O P?: Same capability-composition mindset — ads as module boundary (S 1 soft modularization).. Technical depth follow-up?: Off-screen pause, background pause, prepareForReuse, weak captures on player callbacks.. Behavioral angle?: Revenue stakeholders — lifecycle rules affect billing/viewability..

## §2 Q3. What can you claim under Verified · S12?

Next. Q3. What can you claim under Verified · S12? Answer. Live audio streaming for broadcasts — session, buffering, interruption mindset. Server-driven splash for cold-start freshness/flexibility. Success oriented around time-to-interactive, not vanity first-frame alone. You may not invent splash latency milliseconds or say image LRU solved audio. Follow-ups. Provenance tag?: Verified · S12 · Raw / Las Vegas Aces. Audio vs image in one sentence?: Different failure modes — AVAudioSession interruptions, not bitmap TTL.. Splash vs block launch?: Freshness without blocking forever — cache last-good (Applied design)..

## §3 Q4. Walk the S12 STAR spine

Next. Q4. Walk the S12 STAR spine Answer. Opener: Live audio + server-driven splash on Aces. S/T: Live broadcast audio; splash that wasn’t slow/inflexible. Action: Integrated streaming with session/interruption awareness; S D U I splash for freshness; TTI-oriented success metrics. Result: Richer live audio; faster/more flexible cold-start content (no invented ms). Lesson: Startup path is product surface; audio ≠ image cache. Follow-ups. S3 soft hook?: Fail-soft S D U I — bad payload shouldn’t white-screen.. Day 17 bridge?: Cold start + TTI measurement categories — not fake 847ms.. Phone call scenario?: Interruption handler + resume policy — speak from deep dive §7..

## §4 Q5. What is the combined ≤20s interview line?

Next. Q5. What is the combined ≤20s interview line? Answer. “On our highest-revenue Ads surface I built HeroWidget with explicit pause/play tied to visibility — and on Aces I shipped live audio plus a server-driven splash to tighten cold start.” Follow-ups. If only time for one story?: Match question — media lifecycle → S 1; startup/audio → S12.. Add modularization?: S 10 soft: inject ImageLoading into Stories — don’t force into S 1 STAR.. Forbidden extension?: “Splash loaded in 200ms” without evidence..

## §5 Q6. How do interview bridges map questions to stories?

Next. Q6. How do interview bridges map questions to stories? Answer. Design image loader → L1/L2/L3 + downsample math (Learning-lab). Video off-screen → S 1 HeroWidget. Phone call kills audio → S12 AVAudioSession interruptions. S D K image dependency → S 10 inject loader. Memory Graph UIImage spike → decoded L1 / no downsample (Applied triage — label honestly). Follow-ups. “Design feed images” question?: Coordinator high level design + ImageIO — then offer S 1 if ads video in same feed.. crash free sessions / crash on ads?: Separate day (Day 18) — don’t invent ad crash war story.. Learning-lab role?:../code/ImageCacheTiers.swift — practice, not BMS metric..

## §6 Q7. What must you never say about S1 and S12?

Next. Q7. What must you never say about S1 and S12? Answer. No invented fill-rate % or splash ms. No “I wrote Kingfisher” or “I invented NSCache.” No treating Aces audio as image LRU. No collapsing S 1 architecture story into a fake memory Graph ticket. Label Applied triage (memory tools) separately from Verified production stories. Follow-ups. Safe memory mention with S 1?: “Player retain cycles — weak captures and teardown” as engineering detail, not Verified metric.. After this sample?: Code sketches, then../04-questions.md.. Suggested speaking order?: S 1 STAR → S12 STAR → combined line → bridge table from memory.. After this sample 1. Read../code/HeroWidgetLifecycle.swift pause triggers. 2. Speak both STARs timed from../04-questions.md. 3. Whiteboard L1/L2/L3 + HeroWidget lifecycle in../05-exercises.md.
