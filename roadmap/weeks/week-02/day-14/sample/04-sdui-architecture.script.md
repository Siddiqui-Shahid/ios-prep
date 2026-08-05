# Audio script — Sample 04 — Track B: SDUI architecture (Q&A)
> Listen-only sample Q&A from `04-sdui-architecture.md`. Spoken answers and follow-ups.

## §0 Q1. What is Track B’s 5-minute agenda opener?

Next. Q1. What is Track B’s 5-minute agenda opener? Answer. “I’ll define S D U I scope, schema and versioning, registry and allowlisted actions, fail-soft fallback and cache, then BMS header and Aces splash — and limits versus native Ads.” First 20 seconds. Scope CMS-driven U I shell — not entire app rewrite. Follow-ups. ≤20s variant?: “Fail-soft S D U I pipeline — schema versioning, registry, BMS/Aces production usage.”. Fail-soft meaning?: Unknown skip; never crash; hard fallback if root empty.. Time box?: Same 5:00 hard stop as Track A..

## §1 Q2. What problem does SDUI solve?

Next. Q2. What problem does SDUI solve? Answer. Content and layout velocity without app releases for many changes. Personalisation and experimentation on shell U I. Requirement: crash-free rendering — bad CMS payload must not take down the app. BMS header/search (S3) and Aces splash (S12) as production examples — no invented splash milliseconds. Follow-ups. S3 provenance?: Verified · backend-driven header + search M V V M.. S12 provenance?: Verified · server-driven splash + audio — no fake TTFF ms.. New component types?: Still need app release for new widget code — admit limit..

## §2 Q3. What is the SDUI pipeline architecture?

Next. Q3. What is the SDUI pipeline architecture? Answer. Fetch → version gate → parse → component registry (type → renderer) → layout → allowlisted actions only. Registry maps server type strings to native views. Actions are enumerated — no arbitrary deep links or URL schemes from JSON without allowlist. Injectable dependencies at registry boundary. Follow-ups. Version gate?: Major schema mismatch → hard fallback path.. Registry vs switch soup?: Registry scales; closed enum OK for small surfaces.. Identity?: Server-stable node ids for lists — Day 12..

## §3 Q4. How does fail-soft resilience work?

Next. Q4. How does fail-soft resilience work? Answer. Unknown type → skip + metric; never throw into crash. Last-known-good cache when network fails. Empty root after parse → hard fallback header/splash shell. S3-A1: emphasize schema versioning + unknown fallback as design when pressed. Measure stability and time-to-interactive — not vanity first-frame alone. Follow-ups. Skip vs placeholder?: Product choice — skip is common fail-soft default.. Analytics?: Unknown type counts — ops visibility.. Security?: Allowlist actions — prevent CMS injection paths..

## §4 Q5. What are the BMS and Aces production beats?

Next. Q5. What are the BMS and Aces production beats? Answer. S3: backend-driven header; search with debounce, loading/empty/error, M V V M; content iteration without release for many header cases. S12: Aces live audio streaming + server-driven splash for cold-start content freshness — measure time-to-interactive, not invented splash ms. Both require fail-soft mindset. Follow-ups. Search cancel?: Debounce VM; cancel Task; ignore stale — Day 08.. Splash slow fetch?: Cached last-good splash — failure mode table.. District?: S9 separate — M V V M migration spice, not S D U I core..

## §5 Q6. What trade-offs close Track B vs native Ads?

Next. Q6. What trade-offs close Track B vs native Ads? Answer. S D U I wins velocity on shell/header/splash. Revenue video Ads often stay native (S 1) — lifecycle, viewability, typed players. New widget types still need release. Bridge: S D U I configures placement; native HeroWidget renders video. Invite questions at 5:00. Follow-ups. S D U I the video player?: Rarely — weak lifecycle/typing for revenue media.. Ads 5-min if stronger S 1?: Pick Track A — don’t do both cold.. Full script?: code/MockTalkTracks.md § Track B..

## §6 Q7. What SDUI failure modes should I mention if time allows?

Next. Q7. What SDUI failure modes should I mention if time allows? Answer. Major schema mismatch → version gate + hard fallback. Unknown node → skip, don’t throw. Action injection → allowlist only. Slow splash fetch → cached last-good splash. Mention 2–3 in trade-offs window — preserve agenda in first 20s. Follow-ups. Outage week story?: I M O C + fallback + cache — S 8 composure; no fake incident details.. S3 STAR after talk?: Block 4 — 2–3 min; spice S12 opener 20–45s.. Also read Ads sample?: Skim 03-ads-architecture.md 20 min after recording.. Back to: README.md · Ads track: 03-ads-architecture.md.
