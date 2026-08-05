# Sample 04 — Production provenance walls (Q&A)

> Guided teaching. Each answer stands alone; **Points to** shows where the full module expands the idea.

---

### Q1. What can you claim for S1 (Ads / HeroWidget)?

**Points to:** [Production bridge · S1](../03-production-bridge.md) · [Questions · S1](../04-questions.md#s1--ads-refactor--herowidget-hard-technical-23-min)

**Answer:**

> **Allowed:** POP, generics, HeroWidget lifecycle, revenue-critical module ownership, maintainable type-safe pipeline, pause/play tied to visibility and view-controller lifecycle.  
> **Forbidden:** Invented fill-rate % or revenue percentage.  
> Spine: highest-revenue Ads → POP + generics pipeline → HeroWidget lifecycle → stakeholder alignment without breaking revenue path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not inheritance? | Protocol-oriented design scales ad types without a class thicket. |
| How test lifecycle? | Visibility + VC lifecycle — explicit pause/play rules. |
| Conflict on API shape? | Same S6 instinct — contract and user impact. |

---

### Q2. What can you claim for S6 (LE bottom sheet)?

**Points to:** [Production bridge · S6](../03-production-bridge.md) · [Questions · S6](../04-questions.md#s6--le-bottom-sheet-conflict--impact-23-min)

**Answer:**

> **Allowed:** **30%+** fewer full-screen navigations on **targeted flows**; cross-functional alignment on API contract; reusable bottom sheet component.  
> **Forbidden:** “All of BMS navigation −30%” or any overclaim beyond resume scope.  
> Always pair the metric with “in that scope” or “targeted flows.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer challenges 30%+? | Clarify measurement scope — nav reduction on flows you shipped, not whole app. |
| No metric in follow-up? | Weak answer — S6 needs the number or a crisp qualitative outcome. |
| Design-only story? | Still need your technical ownership — component + contracts. |

---

### Q3. What can you claim for S8 (IMOC / crash-free)?

**Points to:** [Production bridge · S8](../03-production-bridge.md) · [Questions · S8](../04-questions.md#s8--imoc--crash-free-incident--leadership-23-min)

**Answer:**

> **Allowed:** **30L+ DAU** context, **99.95%+** crash-free discipline on your paths, IMOC coordination on P0/P1, Crashlytics triage, stabilize-communicate-prevent.  
> **Forbidden:** Sole ownership of all company crash-free sessions; drama without process.  
> Wording: “helped drive” / “participated in culture” — honest scope.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| IMOC every incident? | No — describe role when you held it during peaks. |
| Hero debug story? | Fine as one Action step — lesson still rollback + owner. |
| Backend blame? | No — coordination and blast radius, not blame theater. |

---

### Q4. What can you claim for S9 (District AI tooling)?

**Points to:** [Production bridge · S9](../03-production-bridge.md) · [Questions · S9](../04-questions.md#s9--district-ai-tooling-judgment-no-worship-23-min)

**Answer:**

> **Allowed:** Context engineering, AI-assisted tests/reviews inside envelope, Clean/MVVM migration discipline, structured logging, rejected bad generations.  
> **Forbidden:** “AI wrote the app”; mixing S15/S16 product AI into tooling answer.  
> Contrast line ready: FinTrack/GymFlow = product on-device systems.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Name the tools? | Cursor, Claude, Copilot — as accelerators, not authors. |
| XCTest/XCUITest drafts? | Allowed — with human review on assertions. |
| S15 if they ask privacy? | Pivot cleanly — on-device, fail-soft, no cloud sync of finance data. |

---

### Q5. What metrics are forbidden to invent?

**Points to:** [Production bridge](../03-production-bridge.md) · [Questions · S1 common wrong](../04-questions.md#s1--ads-refactor--herowidget-hard-technical-23-min)

**Answer:**

> **Fill-rate %** on Ads. **Company-wide** navigation reduction. **Sole** crash-free ownership. **Revenue %** lift you didn’t measure. **Fake** failure stories. **Fake** IMOC war stories. If it’s not on the resume or story bank with Verified tag, don’t say it in interview pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approximate numbers OK? | No — crisp allowed metrics or qualitative outcome. |
| “Significantly improved”? | Weaker than **30%+** or **99.95%+** when you have them. |
| Story bank location? | [`../../../stories/story-bank.md`](../../../stories/story-bank.md) |

---

### Q6. How do you answer “biggest impact metric?”

**Points to:** [Questions · Q6](../04-questions.md#q6-biggest-impact-metric-3045s)

**Answer:**

> Pick **one** and scope honestly:  
> “The cleanest product metric is the LE bottom sheet — **30%+** fewer full-screen navigations on targeted flows. For reliability context I cite **99.95%+ crash-free** and **30L+ DAU** ownership environment — with honest scope wording.”  
> Don’t stack three metrics as if each was your solo achievement.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They want one number only? | S6 **30%+** for product impact; S8 for reliability culture. |
| Side project metric? | FinTrack/GymFlow only if question invites — default BMS trio. |
| No metric role? | Crisp qualitative outcome + lesson — still better than invented %. |

---

### Q7. What is the S1 full script spine for recording?

**Points to:** [Questions · S1 Full spoken answer](../04-questions.md#s1--ads-refactor--herowidget-hard-technical-23-min)

**Answer:**

> Opener: “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.”  
> S/T: Ads module + video in HeroWidget lifecycle.  
> A: POP + generics pipeline; explicit pause/play; stakeholder alignment.  
> R: Maintainable type-safe pipeline; lifecycle-correct video.  
> L: POP + generics over inheritance; lifecycle is product contract.  
> Record at 2–3 min; practice from **Answer points** then full script in [`../04-questions.md`](../04-questions.md).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Priority record set? | S6, S8, S9, S1 + T2 (Copilot junk). |
| Voice memo artifact? | Yes — Day 26 has no code/; voice is the deliverable. |
| Provenance tag? | Verified · S1 · BookMyShow · Ads / HeroWidget |

---

Next: [`../04-questions.md`](../04-questions.md) for full spoken scripts · [`../05-exercises.md`](../05-exercises.md) for record reps
