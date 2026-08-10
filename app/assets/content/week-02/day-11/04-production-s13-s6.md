# Sample 04 — Hybrid UI, deeplinks & LE Bottom Sheet (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under Hybrid UI / deeplinks?
**Answer:**

> Memphis Grizzlies: you **designed SwiftUI + UIKit interop architecture** with deliberate lifecycle and sizing — not ad-hoc hosting. **Deep linking** with navigation/lifecycle handling and cold-start readiness queue mindset. **Mixpanel** and **Airship** integrated so push taps route through the **same navigation story** as deeplinks. Lesson: interop costs (identity, lifecycle, hosting) must be **designed**, not bolted.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.” |
| Forbidden? | Invent Grizzlies crash-free %; dual stacks “in sync” as virtue. |
| Push vs deeplink? | Same router — Hybrid UI / deeplinks discipline. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What can you claim under BookMyShow LE Bottom Sheet?
**Answer:**

> BookMyShow **LE Bottom Sheet**: lightweight event overview surface. Led end-to-end delivery; aligned PM, Design, Backend on API/content contracts. Shipped reusable component into high-traffic flows. Result: **30%+ fewer full-screen navigations** for user flows (resume metric). Lesson: small UI surfaces with clear contracts beat large rewrites for navigation pain.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “I shipped a reusable LE Bottom Sheet that reduced full-screen navigations for 30%+ of user flows by keeping event overview in context.” |
| Invent other nav %? | **Forbidden** — only resume **30%+**. |
| Engineering details OK? | Detents, VoiceOver, analytics open/dismiss — Learning-lab + honest design. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do you insert BookMyShow Ads pipeline + HeroWidget lifecycle lifecycle in a hybrid/cells answer?
**Answer:**

> When asked where ads video pauses: disappear, offscreen, background — **HeroWidget** protocolised that behavior on the revenue-critical Ads module. Tie to `viewWillDisappear`, visibility threshold, and `prepareForReuse` stopping the player in cells. Lifecycle is part of the product contract (BookMyShow Ads pipeline + HeroWidget lifecycle).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent fill-rate %? | **Forbidden** — stay qualitative on revenue impact. |
| Cell reuse link? | Same pause/cancel discipline as full-screen VC. |
| BookMyShow Ads pipeline + HeroWidget lifecycle vs Hybrid UI / deeplinks? | BookMyShow Ads pipeline + HeroWidget lifecycle = Ads HeroWidget; Hybrid UI / deeplinks = hybrid nav/deeplinks — complementary stories. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow Ads pipeline + HeroWidget lifecycle
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q4. What must you never invent for Day 11 production stories?
**Answer:**

> Do not invent nav reduction % beyond resume **30%+**. Do not claim continuous dual NavigationPath + UINavigationController sync as best practice. Do not claim Airship/Mixpanel integration without lifecycle discipline when asked about navigation. Do not invent Grizzlies crash-free percentages or exact hosting API trivia as verified production war stories unless labeled Learning-lab.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hosting sizingOptions API? | Learning-lab teaching detail — OK if labeled. |
| “Why not pure SwiftUI?” | Legacy UIKit + velocity; hybrid with one nav owner. |
| Prefetch data bills? | Bound concurrency, cancel, Low Data Mode — honest engineering response. |

**How can I relate to my case:**
- **Shipped:** None for this prompt — keep it conceptual unless they ask for a case.
- **Design if asked:** N/A
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How do interviewer pushes map to strong replies?
**Answer:**

> **Pure SwiftUI?** Legacy + ship velocity; hybrid with one owner. **New tab for LE?** Tabs change IA; sheet fixes local friction; 30%+ metric. **Hosting height broken?** Intrinsic/sizing ownership; nested scroll fights. **Prefetch bills?** Bound concurrency, cancel, Low Data Mode. **Push wrong screen?** Single router; same path as deeplinks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s Hybrid UI / deeplinks practice? | Hybrid need → interop + deeplink owner → Mixpanel/Airship same path → design-cost lesson. |
| 60s BookMyShow LE Bottom Sheet practice? | Nav fatigue → sheet + contracts → 30%+ → small surface lesson. |
| 3 min combo? | Add cell reuse / ads pause if interviewer asks implementation depth. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. What is the Day 11 production topic mapping?
**Answer:**

> Hybrid architecture → **Hybrid UI / deeplinks** Verified. Deeplink router ownership → **Hybrid UI / deeplinks** Verified. Mixpanel/Airship → **Hybrid UI / deeplinks** Verified. LE sheet + 30%+ → **BookMyShow LE Bottom Sheet** Verified. HeroWidget pause → **BookMyShow Ads pipeline + HeroWidget lifecycle** Verified. Cell/prefetch/hosting code samples → **Learning-lab**. Exact hosting sizingOptions → Learning-lab unless you personally shipped that API choice.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hybrid UI / deeplinks + BookMyShow LE Bottom Sheet same interview? | Yes — hybrid nav (Hybrid UI / deeplinks) and sheet metric (BookMyShow LE Bottom Sheet) are different beats; don’t merge into one fake project. |
| Analytics double-count? | Pick one screen owner — hybrid risk (Deep dive §20). |
| Full questions? | [07-revision-qna.md](07-revision-qna.md) for timed practice. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks; BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q7. How do you keep Mixpanel screen-name / analytics from double-counting?
**Answer:**

> Hybrid risk: UIKit parent and SwiftUI child both fire `screen_view`. **Pick one screen owner per visible surface.** Fire screen analytics from appear/disappear with that owner in mind. Representable `update` storms must not re-fire viewed events on every body pass. Route Airship push taps through the **same deeplink router** as universal links so engagement and navigation share one story (Hybrid UI / deeplinks). Gate SDK init on privacy consent.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Dual host trap? | Parent hosting VC + child SwiftUI both logging “viewed” for one surface. |
| Background fetch? | Separate from screen viewed — don’t conflate engagement signals. |
| Push vs deeplink? | Same router; Mixpanel/Airship must not invent a second navigation path. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q8. What engineering details matter for a bottom sheet (detents, VoiceOver, analytics)?
**Answer:**

> **Detents:** medium for overview, large for expanded details; grabber aids discoverability and accessibility. **VoiceOver:** move focus to the sheet title on present; restore focus on dismiss. **Analytics:** fire open / CTA / dismiss — do **not** count the underlying list screen as finished while the sheet is up. Keyboard must not cover inputs if the sheet has search. Reuse a shared component API across listing surfaces (BookMyShow LE Bottom Sheet LE pattern). Label detent/VoiceOver details Learning-lab unless you personally shipped those choices; the Verified resume beat is the **30%+** fewer full-screen navigations.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Sheet vs push? | Sheet for glanceable overview + context; push for deep hierarchy. |
| Why not a new tab? | Tabs change IA; sheet fixes local friction. |
| Invent more nav %? | Forbidden — only resume **30%+**. |

**How can I relate to my case:**
- **Shipped:** BookMyShow LE Bottom Sheet
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What can you claim under BookMyShow LE Bottom Sheet

**Ask yourself:** What can you claim under BookMyShow LE Bottom Sheet?

**Answer:** “BookMyShow **LE Bottom Sheet**: lightweight event overview surface. Led end-to-end delivery; aligned PM, Design, Backend on API/content contracts. Shipped reusable component into high-traffic flows. Result: **30%+ fewer full-screen navigations** for user flows (resume metric). Lesson: small UI surfaces with clear contracts beat large rewrites for navigation pain.”

### Puzzle B — How do you insert BookMyShow Ads pipeline + HeroWidget lifecycle lifecycle in a 

**Ask yourself:** How do you insert BookMyShow Ads pipeline + HeroWidget lifecycle lifecycle in a hybrid/cells answer?

**Answer:** “When asked where ads video pauses: disappear, offscreen, background — **HeroWidget** protocolised that behavior on the revenue-critical Ads module. Tie to `viewWillDisappear`, visibility threshold, and `prepareForReuse` stopping the player in cells. Lifecycle is part of the product contract (BookMyShow Ads pipeline + HeroWidget lifecycle).”

### Puzzle C — What must you never invent for Day 11 production stories

**Ask yourself:** What must you never invent for Day 11 production stories?

**Answer:** “Do not invent nav reduction % beyond resume **30%+**. Do not claim continuous dual NavigationPath + UINavigationController sync as best practice. Do not claim Airship/Mixpanel integration without lifecycle discipline when asked about navigation. Do not invent Grizzlies crash-free percentages or exact hosting API trivia as verified production war stories unless labeled Learning-lab.”
