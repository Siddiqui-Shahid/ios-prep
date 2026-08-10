# Sample 04 — Provenance honesty & named cases (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim for BookMyShow Ads pipeline + HeroWidget lifecycle (Ads / HeroWidget)?
**Answer:**

> **Allowed:** POP, generics, HeroWidget lifecycle, revenue-critical module ownership, maintainable type-safe pipeline, pause/play tied to visibility and view-controller lifecycle. 
> **Forbidden:** Invented fill-rate % or revenue percentage. 
> Spine: highest-revenue Ads → POP + generics pipeline → HeroWidget lifecycle → stakeholder alignment without breaking revenue path.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why not inheritance? | Protocol-oriented design scales ad types without a class thicket. |
| How test lifecycle? | Visibility + VC lifecycle — explicit pause/play rules. |
| Conflict on API shape? | Same BookMyShow LE Bottom Sheet instinct — contract and user impact. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q2. What can you claim for BookMyShow LE Bottom Sheet (LE bottom sheet)?
**Answer:**

> **Allowed:** **30%+** fewer full-screen navigations on **targeted flows**; cross-functional alignment on API contract; reusable bottom sheet component. 
> **Forbidden:** “All of BMS navigation −30%” or any overclaim beyond resume scope. 
> Always pair the metric with “in that scope” or “targeted flows.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Interviewer challenges 30%+? | Clarify measurement scope — nav reduction on flows you shipped, not whole app. |
| No metric in follow-up? | Weak answer — BookMyShow LE Bottom Sheet needs the number or a crisp qualitative outcome. |
| Design-only story? | Still need your technical ownership — component + contracts. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What can you claim for BookMyShow IMOC + crash-free at scale (IMOC / crash-free)?
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

**How can I relate to my case:**
- **Shipped:** BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q4. What can you claim for District Free Parking + Clean/MVVM + AI tooling (District AI tooling)?
**Answer:**

> **Allowed:** Context engineering, AI-assisted tests/reviews inside envelope, Clean/MVVM migration discipline, structured logging, rejected bad generations. 
> **Forbidden:** “AI wrote the app”; mixing FinTrack on-device AI/GymFlow on-device AI product AI into tooling answer. 
> Contrast line ready: FinTrack/GymFlow = product on-device systems.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Name the tools? | Cursor, Claude, Copilot — as accelerators, not authors. |
| XCTest/XCUITest drafts? | Allowed — with human review on assertions. |
| FinTrack on-device AI if they ask privacy? | Pivot cleanly — on-device, fail-soft, no cloud sync of finance data. |

**How can I relate to my case:**
- **Shipped:** FinTrack on-device AI; GymFlow on-device AI; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. What metrics are forbidden to invent?
**Answer:**

> **Fill-rate %** on Ads. **Company-wide** navigation reduction. **Sole** crash-free ownership. **Revenue %** lift you didn’t measure. **Fake** failure stories. **Fake** IMOC war stories. If it’s not on the resume or story bank with Verified tag, don’t say it in interview pressure.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Approximate numbers OK? | No — crisp allowed metrics or qualitative outcome. |
| “Significantly improved”? | Weaker than **30%+** or **99.95%+** when you have them. |
| Story bank location? | [`../../../stories/story-bank.md`](../../../stories/story-bank.md) |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How do you answer “biggest impact metric?”?
**Answer:**

> Pick **one** and scope honestly: 
> “The cleanest product metric is the LE bottom sheet — **30%+** fewer full-screen navigations on targeted flows. For reliability context I cite **99.95%+ crash-free** and **30L+ DAU** ownership environment — with honest scope wording.” 
> Don’t stack three metrics as if each was your solo achievement.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| They want one number only? | BookMyShow LE Bottom Sheet **30%+** for product impact; BookMyShow IMOC + crash-free at scale for reliability culture. |
| Side project metric? | FinTrack/GymFlow only if question invites — default BMS trio. |
| No metric role? | Crisp qualitative outcome + lesson — still better than invented %. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Attributing 99.95%+ CFS to a single ticket; inventing DAU figures.

---

### Q7. What is the BookMyShow Ads pipeline + HeroWidget lifecycle full script spine for recording?
**Answer:**

> Opener: “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.” 
> S/T: Ads module + video in HeroWidget lifecycle. 
> A: POP + generics pipeline; explicit pause/play; stakeholder alignment. 
> R: Maintainable type-safe pipeline; lifecycle-correct video. 
> L: POP + generics over inheritance; lifecycle is product contract. 
> Record at 2–3 min; practice from **Answer points** then full script in [07-revision-qna.md](07-revision-qna.md).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Priority record set? | BookMyShow LE Bottom Sheet, BookMyShow IMOC + crash-free at scale, District Free Parking + Clean/MVVM + AI tooling, BookMyShow Ads pipeline + HeroWidget lifecycle + T2 (Copilot junk). |
| Voice memo artifact? | Yes — Day 26 has no code/; voice is the deliverable. |
| Provenance tag? | BookMyShow Ads pipeline + HeroWidget lifecycle · BookMyShow · Ads / HeroWidget |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow LE Bottom Sheet; BookMyShow IMOC + crash-free at scale; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

Next: [07-revision-qna.md](07-revision-qna.md) for full spoken scripts · [`../05-exercises.md`](../05-exercises.md) for record reps

---

## Brain puzzles (cover → think → check)

### Puzzle A — What can you claim for BookMyShow LE Bottom Sheet (LE bottom sheet)

**Ask yourself:** What can you claim for BookMyShow LE Bottom Sheet (LE bottom sheet)?

**Answer:** “**Allowed:** **30%+** fewer full-screen navigations on **targeted flows**; cross-functional alignment on API contract; reusable bottom sheet component. 
> **Forbidden:** “All of BMS navigation −30%” or any overclaim beyond resume scope. 
> Always pair the metric with “in that scope” or “targeted flows.”

### Puzzle B — What can you claim for BookMyShow IMOC + crash-free at scale (IMOC / crash-free)

**Ask yourself:** What can you claim for BookMyShow IMOC + crash-free at scale (IMOC / crash-free)?

**Answer:** “**Allowed:** **30L+ DAU** context, **99.95%+** crash-free discipline on your paths, IMOC coordination on P0/P1, Crashlytics triage, stabilize-communicate-prevent. 
> **Forbidden:** Sole ownership of all company crash-free sessions; drama without process. 
> Wording: “helped drive” / “participated in culture” — honest scope.”

### Puzzle C — What can you claim for District Free Parking + Clean/MVVM + AI tooling (District

**Ask yourself:** What can you claim for District Free Parking + Clean/MVVM + AI tooling (District AI tooling)?

**Answer:** “**Allowed:** Context engineering, AI-assisted tests/reviews inside envelope, Clean/MVVM migration discipline, structured logging, rejected bad generations. 
> **Forbidden:** “AI wrote the app”; mixing FinTrack on-device AI/GymFlow on-device AI product AI into tooling answer. 
> Contrast line ready: FinTrack/GymFlow = product on-device systems.”
