# Day 14 — Week 2 Revision + Mock #2 (Ads or SDUI)

> Week 2 · Revision pass ~45–60 min (full mock: ~5–6 hrs in full study)  
> Full study: [weeks/week-02/day-14/](../../../weeks/week-02/day-14/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-14/sample/](../../../weeks/week-02/day-14/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- Week 2 narrative: MVVM/DI → networking → SDUI → hybrid UI → SwiftUI identity → DSA composure
- Deliver a **timed 5:00 architecture talk** on **Ads OR SDUI** — pick one, not both cold
- Agenda in first 20s; hard stop at 5:00; invite questions
- BookMyShow Ads pipeline + HeroWidget lifecycle (Ads) or BookMyShow backend-driven header & search (SDUI) as core STAR; supporting stories with honest provenance
- Run Mock #2 retro: score, gotchas, weak cards → Week 3 warm-up

## 2. Concept refresh (simple)

### 2.1 Week 2 connective tissue

| Day | Spine |
|---|---|
| 08 | MVVM/Clean/DI — District Free Parking + Clean/MVVM + AI tooling migration, BookMyShow backend-driven header & search search states |
| 09 | URLSession, single-flight refresh, pinning — BookMyShow SSL pinning + URLSession migration |
| 10 | SDUI schema/registry/fallback — BookMyShow backend-driven header & search header, Audio streaming + server-driven splash (Aces) splash |
| 11 | UIKit lifecycle, hybrid — Hybrid UI / deeplinks, BookMyShow LE Bottom Sheet, BookMyShow Ads pipeline + HeroWidget lifecycle pause/play |
| 12 | SwiftUI state/identity — Stories SDK (Raw / Miami Heat) SDK isolation |
| 13 | Stack/queue/LL — agenda-first coding composure |
| 14 | Mock #2 — synthesize one 5-min track |

### 2.2 Mock #2 format

| Block | Time |
|---|---|
| Warm-up defs | 10 min |
| **5-min architecture talk** | **5:00 hard stop** |
| Mixed Week 2 Q&A | 25 min |
| Story STAR | 10 min |
| Retro + gotchas | 10–15 min |

### 2.3 Track pick (choose one tonight)

**Ads track:** POP + generics pipeline → HeroWidget lifecycle → URLSession pinning/whitelist → Design: pin rotation / break-glass (not shipped runbook) rotation design. Core STAR: **BookMyShow Ads pipeline + HeroWidget lifecycle**.

**SDUI track:** Schema → version gate → registry → fail-soft fallback → BMS header / Aces splash. Core STAR: **BookMyShow backend-driven header & search**. Bridge: SDUI **config** + native **HeroWidget renderer**.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| Pick one track | Ads **or** SDUI for 5-min talk — not both cold |
| 5-min hard stop | Agenda in first 20s; stop at 5:00 and invite questions |
| BookMyShow Ads pipeline + HeroWidget lifecycle / BookMyShow backend-driven header & search | Core STAR for Ads / SDUI tracks respectively |
| Design: pin rotation / break-glass (not shipped runbook) / BookMyShow backend-driven header & search-A1 | Pin rotation / schema fallback = **Applied design**, not shipped runbook |
| Forbidden | Invented fill-rate %, splash ms, pin shadow-traffic claims |
| Bridge | SDUI **config** + native **HeroWidget renderer** — best of both |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-14/sample/) | Synthesis + mock format |
| Must | [02-deep-dive](../../../weeks/week-02/day-14/02-deep-dive.md) | Full 5-min spines |
| Must | [MockTalkTracks](../../../weeks/week-02/day-14/code/MockTalkTracks.md) | Speak aloud |
| Drill | [05-exercises](../../../weeks/week-02/day-14/05-exercises.md) | Full Mock #2 run |

Suggested sample order: `01-week2-synthesis` → `02-mock-format` → `03-ads-architecture` **or** `04-sdui-architecture`.

## 4. Map to your work

**Ads track · Verified:** BookMyShow Ads pipeline + HeroWidget lifecycle POP+Generics + HeroWidget lifecycle; BookMyShow SSL pinning + URLSession migration Alamofire→URLSession + HTTPS + pinning + whitelist.  
**SDUI track · Verified:** BookMyShow backend-driven header & search backend-driven header; Audio streaming + server-driven splash (Aces) server-driven splash — no invented ms.  
**Design if asked:** ** Design: pin rotation / break-glass (not shipped runbook) pin rotation design; BookMyShow backend-driven header & search-A1 schema fallback design.  
**Supporting:** District Free Parking + Clean/MVVM + AI tooling AI envelope judgment; BookMyShow LE Bottom Sheet 30%+ bottom sheet; Stories SDK (Raw / Miami Heat) SDK isolation.

**Ads opener (≤20s):** “I’ll cover revenue Ads scope, POP+generics pipeline, HeroWidget lifecycle, URLSession pinning/whitelist, and trade-offs vs SDUI for media.”

**SDUI opener (≤20s):** “I’ll cover SDUI scope, schema/versioning, registry+actions, fail-soft fallback, BMS header / Aces splash, and limits vs native Ads.”

→ [BookMyShow Ads pipeline + HeroWidget lifecycle Ads](../../stories/story-bank.md#s1--ads-module-refactor--herowidget-bookmyshow) · [BookMyShow backend-driven header & search Header](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow)

## 5. Flash prompts

1. Week 2 one-sentence thread connecting Days 08–13
2. Ads vs SDUI — when native media wins
3. 5-min agenda opener for your chosen track
4. BookMyShow Ads pipeline + HeroWidget lifecycle or BookMyShow backend-driven header & search ≤20s pitch — no invented metrics
5. Design: pin rotation / break-glass (not shipped runbook) cert rotation — design answer in 45s
6. BookMyShow backend-driven header & search-A1 unknown component — design answer in 45s
7. SDUI config + native HeroWidget — hybrid bridge
8. Mock pass criteria: on time, trade-off, prod proof

## 6. Timed drills

| Drill | Budget |
|---|---|
| Chosen track 5-min talk | 5:00 |
| Week 2 warm-up pool (5 defs) | 10 min |
| BookMyShow Ads pipeline + HeroWidget lifecycle or BookMyShow backend-driven header & search full STAR | 2–3 min |
| Mock #2 full run | 60–90 min |
| Retro: top 5 weak cards | 10 min |

Expand from [sample cards](../../../weeks/week-02/day-14/sample/), [Week2Warmups](../../../weeks/week-02/day-14/code/Week2Warmups.md), and [07-revision-qna](../../../weeks/week-02/day-14/sample/07-revision-qna.md).
