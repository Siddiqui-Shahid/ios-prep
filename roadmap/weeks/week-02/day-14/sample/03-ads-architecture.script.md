# Audio script — Sample 03 — Track A: Ads architecture (Q&A)
> Listen-only sample Q&A from `03-ads-architecture.md`. Spoken answers and follow-ups.

## §0 Q1. What is Track A’s 5-minute agenda opener?

Next. Q1. What is Track A’s 5-minute agenda opener? Answer. “I’ll cover problem scope, type-safe component pipeline with P O P and generics, HeroWidget lifecycle, networking and pinning on URLSession, and trade-offs versus S D U I for media.” Deliver in first 20 seconds. Scope revenue Ads — not entire app architecture. Follow-ups. ≤20s variant?: “Revenue Ads architecture — P O P/generics, HeroWidget lifecycle, URLSession pinning.”. Wrong opener?: Jumping to pinning without scope — interviewer lost.. Time if over 20s?: Cut examples; keep nouns: P O P, HeroWidget, URLSession, trade-offs..

## §1 Q2. What is the Ads problem context beat?

Next. Q2. What is the Ads problem context beat? Answer. Highest-revenue Ads module needed safer reusable rendering. Video inside HeroWidget needed correct pause/play with lifecycle — visibility, view controller disappear, background. Revenue-critical surface: stakeholder coordination and correctness matter. No invented fill-rate percentages. Follow-ups. S 1 provenance?: Verified · BookMyShow · Ads / HeroWidget.. Why revenue framing?: Explains strict lifecycle + security choices.. CMS role?: May configure placement — renderer stays native..

## §2 Q3. How do POP and generics shape the Ads pipeline?

Next. Q3. How do POP and generics shape the Ads pipeline? Answer. Protocol-oriented ad component contracts + generics pipeline — not inheritance trees. New creatives plug in without forking the revenue path. Compile-time safety vs Any casts. Generics inside; type erasure only at mixed-list or module boundary if needed — erasure isn’t free (Day 02). Follow-ups. Why not inheritance?: Fragile base on ad variants; P O P composes capabilities.. Associated types pain?: Stay generic, erase at boundary, or closed enum — Day 02.. S 10 cousin?: Reusable protocol surfaces — Stories S D K boundary instinct..

## §3 Q4. What is the HeroWidget lifecycle contract?

Next. Q4. What is the HeroWidget lifecycle contract? Answer. Visibility / view controller lifecycle / background → pause/play policy. prepareForReuse stops player in feed cells. Lifecycle is part of the product contract, not plumbing. Full-screen: view controller disappear hooks. In-feed: visibility threshold. Background: app lifecycle notification. Follow-ups. Off-screen playback failure?: Visibility + disappear pause.. Wrong creative in cell?: Cancel + generation token — Day 11.. S D U I the player?: Weak — see Q6 bridge..

## §4 Q5. What is the URLSession / pinning beat? (S4)

Next. Q5. What is the URLSession / pinning beat? (S4) Answer. Alamofire → URLSession on high-traffic revenue module. HTTPS, SSL pinning, domain whitelist — you owned the stack. Pin rotation, backup pins, break-glass as Applied design (S4-A1) — not “I shipped the ops runbook.” Watch TLS failure rate; don’t claim pinning alone owns crash-free (S 8 culture reference only). Follow-ups. Pin mismatch outage?: Backup pins + staged rotation design; I M O C leadership if tricky mock.. Whitelist why?: Reduce attack surface on revenue endpoints.. Single-flight?: Refresh waiters — Day 09; pairs with auth on same module..

## §5 Q6. What trade-offs close Track A vs SDUI?

Next. Q6. What trade-offs close Track A vs SDUI? Answer. Keep revenue media native — lifecycle, billing viewability, typed players. CMS may configure placement; S D U I for config ≠ S D U I for the player. Bridge: “I’d S D U I placement and campaign config; I’d keep the video renderer native with HeroWidget’s pause/play contract.” Invite questions at 5:00. Follow-ups. Why not S D U I video?: Weak lifecycle/typing for revenue media.. S D U I header?: S3 — different surface, complementary story.. Full script?: code/MockTalkTracks.md § Track A..

## §6 Q7. What Ads failure modes should I mention if time allows?

Next. Q7. What Ads failure modes should I mention if time allows? Answer. Off-screen playback → visibility + disappear pause. Pin mismatch outage → backup pins + rotation design. Cell reuse wrong creative → cancel + clear + generation token. Refresh stampede → single-flight waiters. Mention 2–3 max in 3:30–4:30 window — don’t blow the agenda. Follow-ups. Invent metrics?: Forbidden — fill-rate %, CTR, fake crash deltas.. S 1 STAR after talk?: Block 4 — 2–3 min full STAR.. Also read S D U I sample?: Skim 04-sdui-architecture.md 20 min after recording.. Back to: README.md · S D U I track: 04-sdui-architecture.md.
