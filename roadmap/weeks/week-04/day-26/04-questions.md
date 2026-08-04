# 04 — Questions + Full Spoken STAR Scripts (two-layer)

> For STAR prompts: **Answer points** = timing spine; **Full spoken answer** = 2–3 min script. Practice covering the script.

---

## Priority full scripts

### S6 — LE Bottom Sheet (conflict / impact) `(2–3 min)`

**Answer points:**
- S/T: full-screen overview too heavy
- A: E2E bottom sheet; align PM/Design/Backend contracts; reusable component
- R: **30%+** flows fewer full-screen navigations
- L: small surface + contracts > rewrite

**Agenda opener:**  
> “I’ll take ~2 minutes on the LE bottom sheet — cross-functional delivery and the navigation impact.”

**Full spoken answer:**  
> “On BookMyShow, users were taking full-screen navigations for event overview more often than they needed to — friction on high-traffic flows I shared ownership of. I led an end-to-end lightweight overview as a bottom sheet. That meant aligning Product, Design, and Backend on the API contract and content rules so we weren’t debating pixels without data. I shipped it as a reusable component and integrated it into the targeted flows. The resume outcome is that we reduced full-screen navigations for **30%+ of user flows** in that scope. The lesson I reuse is that a small UI surface with clear contracts often beats a large navigation rewrite — and conflict gets resolved by making the user impact and the interface contract explicit, not by winning a taste argument.”

**Common wrong answer:**  
> Vague “we collaborated well” with no metric or contract.

**Follow-up ladder:**
- **L1:** What did Backend push back on?
- **L2:** What would you do differently?
- **L3:** How did you measure the 30%+?

**Provenance:** Verified · S6 · BookMyShow · LE Bottom Sheet

---

### S8 — IMOC + crash-free (incident / leadership) `(2–3 min)`

**Answer points:**
- S/T: **30L+ DAU**; **99.95%+** crash-free bar; P0/P1 during peaks
- A: Crashlytics triage; IMOC coords iOS/backend/QA; mitigations + comms
- R: Sustained crash-free discipline; minimized downtime in peaks
- L: owner, blast radius, rollback > hero debug

**Agenda opener:**  
> “I’ll cover incident ownership at BookMyShow scale — IMOC and crash-free discipline.”

**Full spoken answer:**  
> “BookMyShow consumer iOS sits at **30+ lakh DAU**, so reliability isn’t abstract — we held a **99.95%+ crash-free** bar and needed fast P0/P1 response during high-traffic events. I worked Crashlytics triage with structured crash workflows, and as **IMOC** I coordinated iOS, backend, and QA when incidents hit: stabilize first, communicate blast radius, then root cause and prevent. That looked like feature guards, hotfix paths, and clear ownership instead of everyone debugging in a pile. The result was sustaining high crash-free sessions and minimizing downtime when traffic spiked. My lesson is that incident leadership is clarity of owner, blast radius, and rollback — hero debugging alone doesn’t scale.”

**Common wrong answer:**  
> Claiming sole credit for company-wide CFS; drama without process.

**Follow-up ladder:**
- **L1:** Example mitigation you drove?
- **L2:** How do you prevent recurrence?
- **L3:** Conflict during an incident?

**Provenance:** Verified · S8 · BookMyShow · IMOC / CFS

---

### S9 — District AI tooling (judgment, no worship) `(2–3 min)`

**Answer points:**
- S/T: Free Parking + MVVM/Clean migration; need velocity without surrendering design
- A: Context engineering; AI for reviews/tests inside envelope; structured logging
- R: Feature shipped; migration progressed with review discipline
- L: AI amplifies clear boundaries; you own architecture/tests
- Contrast S15/S16 if asked

**Agenda opener:**  
> “At District I used AI as an accelerator — the skill was context engineering and review judgment, not prompting theater.”

**Full spoken answer:**  
> “At District I was shipping Free Parking billing adjustments and helping migrate patterns across MVVM and Clean Architecture without burning the regression budget. I used Cursor, Claude, and Copilot as accelerators — but only after I shaped context: module boundaries, conventions, acceptance criteria, and a review bar. AI helped with boilerplate and XCTest/XCUITest drafts; I rejected weak generations and kept human ownership on architecture and critical-path assertions. We also used structured logging to debug faster. The feature shipped and the migration moved with velocity **and** discipline. The lesson interviewers should hear: tools amplify clear thinking; they don’t replace ownership — especially when you’ve also worked consumer scale where bad releases hit **30L+ DAU**. And this is different from FinTrack/GymFlow, which are product on-device AI systems, not engineering-tooling stories.”

**Common wrong answer:**  
> “AI wrote the app” / tool-worship / conflating with S15.

**Follow-up ladder:**
- **L1:** Example of rejected AI output?
- **L2:** When do you forbid AI?
- **L3:** Team shipping junk with Copilot — what do you do?

**Provenance:** Verified · S9 · District · Context Engineering

---

### S1 — Ads refactor + HeroWidget (hard technical) `(2–3 min)`

**Answer points:**
- S/T: Highest-revenue Ads module; video in HeroWidget lifecycle
- A: POP + generics pipeline; HeroWidget pause/play; stakeholder alignment
- R: Maintainable type-safe pipeline; correct lifecycle
- L: POP + generics over inheritance; lifecycle is product contract
- No invented fill-rate %

**Agenda opener:**  
> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”

**Full spoken answer:**  
> “I owned work on BookMyShow’s highest-revenue Ads module when we needed a safer, reusable rendering path — including video ads inside a HeroWidget that had to pause and play correctly with visibility and view-controller lifecycle. I refactored rendering around protocol-oriented ad component contracts and generics so the pipeline stayed type-safe as new ad types arrived, instead of growing an inheritance thicket. I built the reusable HeroWidget with explicit pause/play tied to lifecycle so we weren’t wasting playback or glitching UI. I coordinated behavior with stakeholders without breaking the revenue path. We shipped a maintainable pipeline with lifecycle-correct video. The lesson: for revenue-critical UI, prefer protocol-oriented design and generics over deep inheritance, and treat lifecycle as part of the product contract — not an afterthought.”

**Common wrong answer:**  
> Invented fill-rate or revenue percentage.

**Follow-up ladder:**
- **L1:** Why not inheritance?
- **L2:** How test lifecycle?
- **L3:** Conflict on API shape?

**Provenance:** Verified · S1 · BookMyShow · Ads / HeroWidget

---

## Normal prompt pack (two-layer short)

### Q1. Tell me about yourself `(90–120s)`

**Answer points:** BMS scale highlights → District architecture → Raw SDK → FinTrack/GymFlow → senior iOS ownership goal

**Full spoken answer:**  
> “I’m an iOS engineer who’s owned consumer features at BookMyShow scale — **30L+ DAU** — across ads, SDUI-ish surfaces, networking security, and reliability culture toward **99.95%+ crash-free**. At District I shipped Free Parking and drove Clean/MVVM migration with disciplined AI-assisted engineering. At Raw I built reusable SDK and hybrid UIKit/SwiftUI work across NBA/WNBA apps. On the side I shipped privacy-first on-device AI in FinTrack and GymFlow. I’m targeting senior roles where I own architecture, reliability, and delivery end-to-end.”

**Provenance:** Collage of Verified stories

---

### Q2. Conflict with PM/Design `(→ S6 script above)`

Use **S6 Full spoken answer**. Points: contracts, options, **30%+**.

---

### Q3. Incident you owned `(→ S8 script above)`

Use **S8 Full spoken answer**.

---

### Q4. Mentored / led without authority `(2–3 min)`

**Answer points:** Pick S1 standards **or** S10/S14 checklist · direction + unblock + rollout ownership

**Full spoken answer (S1-angled):**  
> “I lead without waiting for a title by setting the technical standard and unblocking others. On the Ads refactor I defined protocol contracts so teammates could add ad types without forking the pipeline, and I made lifecycle rules explicit in HeroWidget so reviewers had a clear bar. That’s mentorship through architecture — people move faster when the envelope is obvious. Same pattern later with SDK boundaries and migration checklists on other teams.”

**Provenance:** Verified · S1; soft S10/S14

---

### Q5. How do you use AI in your workflow? `(45–90s)`

**Answer points:** S9 spine compressed · not autopilot · contrast product AI

**Full spoken answer:**  
> “I use AI inside a strict envelope — clear module boundaries, acceptance criteria, and review. It accelerates boilerplate and test drafts; I still own architecture and reject bad output. That’s District context engineering. Separately, FinTrack and GymFlow are product on-device AI with privacy and fail-soft — different story.”

**Provenance:** Verified · S9; contrast S15/S16

---

### Q6. Biggest impact metric? `(30–45s)`

**Answer points:** Pick one and scope it honestly

**Full spoken answer:**  
> “The cleanest product metric is the LE bottom sheet — **30%+** fewer full-screen navigations on targeted flows. For reliability context I cite **99.95%+ crash-free** and **30L+ DAU** ownership environment — with honest scope wording.”

**Provenance:** Verified · S6 · S8

---

## Tricky prompts

### T1. Tell me about a failure `(90–120s)`

**Answer points:** Real miss · impact · process change · prevention · no humblebrag

**Full spoken answer (template — fill with your real miss):**  
> “I’ll use a real miss, not a humblebrag. [Name the miss — e.g. under-specified pin rotation readiness / SDUI unknown-type gap / race that escaped]. Impact was [user or eng cost]. I owned the fix and changed process by [checklist / test / guard / review bar]. I know it won’t recur because [detection + ownership].”

**Provenance:** Honest personal; do not invent

---

### T2. Team leans on Copilot and ships junk `(90–120s)`

**Answer points:** Review bar · critical paths human-designed tests · pair on architecture · measure escaped defects · teach context engineering

**Full spoken answer:**  
> “I don’t ban tools and I don’t shrug. I set a review bar, require human-designed tests on money/identity/crash paths, pair on architecture so context is shared, and watch escaped defects. I teach the same context-engineering habit I used at District — tools stay, accountability stays.”

**Provenance:** Verified · S9 judgment

---

### T3. Why senior vs mid? `(90–120s)`

**Answer points:** Scope 30L+ · revenue module · reliability · SDK thinking · cross-functional metrics · incidents · migration judgment · privacy-aware AI

**Full spoken answer:**  
> “Senior for me means scope and judgment: shipping on **30L+ DAU** surfaces, owning revenue-critical UI architecture, participating in **99.95%+** crash-free culture and incident coordination, delivering measurable UX wins like **30%+** nav reduction, designing reusable SDK boundaries, migrating architecture with checklists, and separating product AI privacy work from engineering-tooling AI. Mid executes tickets; senior owns trade-offs and blast radius.”

**Provenance:** Verified collage

---

### T4. Did AI do the District migration? `(90–120s)`

Use compressed **S9** script; emphasize rejected output + human architecture ownership.

---

### T5. Push back on a bad deadline `(90–120s)`

**Answer points:** Make risk visible · MVP cut · protect crash-free class outcomes · escalate with data

**Full spoken answer:**  
> “I make quality and reliability risk visible with options: cut scope to an MVP, shift date, or accept explicit risk — I don’t silent-hero overtime as the only plan. At consumer scale I’d protect crash-free and incident load the way we treated P0/P1 seriousness at BookMyShow. I escalate with data, not vibes.”

**Provenance:** Soft Verified · S8 / S6 negotiation style

---

## Suggested record set

S6, S8, S9, S1 full scripts + T2.
