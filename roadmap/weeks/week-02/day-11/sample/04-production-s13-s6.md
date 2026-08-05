# Sample 04 — Production S13 / S6 / S1 (Q&A)

> Guided teaching. Separates **Verified** resume facts from **Learning-lab** demos so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S13?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§2 S13 STAR](../03-production-bridge.md#2-s13-star-23-min)

**Answer:**

> Memphis Grizzlies: you **designed SwiftUI + UIKit interop architecture** with deliberate lifecycle and sizing — not ad-hoc hosting. **Deep linking** with navigation/lifecycle handling and cold-start readiness queue mindset. **Mixpanel** and **Airship** integrated so push taps route through the **same navigation story** as deeplinks. Lesson: interop costs (identity, lifecycle, hosting) must be **designed**, not bolted.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.” |
| Forbidden? | Invent Grizzlies crash-free %; dual stacks “in sync” as virtue. |
| Push vs deeplink? | Same router — S13 discipline. |

---

### Q2. What can you claim under Verified · S6?

**Points to:** [Production bridge · §3 S6 STAR](../03-production-bridge.md#3-s6-star-beat-23-min-or-impact-answer) · [Foundations · §7 LE Bottom Sheet](../01-foundations.md#7-le-bottom-sheet--product-picture-s6)

**Answer:**

> BookMyShow **LE Bottom Sheet**: lightweight event overview surface. Led end-to-end delivery; aligned PM, Design, Backend on API/content contracts. Shipped reusable component into high-traffic flows. Result: **30%+ fewer full-screen navigations** for user flows (resume metric). Lesson: small UI surfaces with clear contracts beat large rewrites for navigation pain.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s pitch? | “I shipped a reusable LE Bottom Sheet that reduced full-screen navigations for 30%+ of user flows by keeping event overview in context.” |
| Invent other nav %? | **Forbidden** — only resume **30%+**. |
| Engineering details OK? | Detents, VoiceOver, analytics open/dismiss — Learning-lab + honest design. |

---

### Q3. How do you insert S1 lifecycle in a hybrid/cells answer?

**Points to:** [Production bridge · §4 S1 lifecycle hook](../03-production-bridge.md#4-s1-lifecycle-hook-3045s-insert) · [Deep dive · §2 Ads / video visibility](../02-deep-dive.md#2-ads--video-visibility-s1)

**Answer:**

> When asked where ads video pauses: disappear, offscreen, background — **HeroWidget** protocolised that behavior on the revenue-critical Ads module. Tie to `viewWillDisappear`, visibility threshold, and `prepareForReuse` stopping the player in cells. Lifecycle is part of the product contract (Verified · S1).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Invent fill-rate %? | **Forbidden** — stay qualitative on revenue impact. |
| Cell reuse link? | Same pause/cancel discipline as full-screen VC. |
| S1 vs S13? | S1 = Ads HeroWidget; S13 = hybrid nav/deeplinks — complementary stories. |

---

### Q4. What must you never invent for Day 11 production stories?

**Points to:** [Production bridge · §1 Forbidden](../03-production-bridge.md#1-provenance-map) · [README · Provenance reminder](../README.md#provenance-reminder)

**Answer:**

> Do not invent nav reduction % beyond resume **30%+**. Do not claim continuous dual NavigationPath + UINavigationController sync as best practice. Do not claim Airship/Mixpanel integration without lifecycle discipline when asked about navigation. Do not invent Grizzlies crash-free percentages or exact hosting API trivia as verified production war stories unless labeled Learning-lab.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hosting sizingOptions API? | Learning-lab teaching detail — OK if labeled. |
| “Why not pure SwiftUI?” | Legacy UIKit + velocity; hybrid with one nav owner. |
| Prefetch data bills? | Bound concurrency, cancel, Low Data Mode — honest engineering response. |

---

### Q5. How do interviewer pushes map to strong replies?

**Points to:** [Production bridge · §7 Interviewer pushes](../03-production-bridge.md#7-interviewer-pushes)

**Answer:**

> **Pure SwiftUI?** Legacy + ship velocity; hybrid with one owner. **New tab for LE?** Tabs change IA; sheet fixes local friction; 30%+ metric. **Hosting height broken?** Intrinsic/sizing ownership; nested scroll fights. **Prefetch bills?** Bound concurrency, cancel, Low Data Mode. **Push wrong screen?** Single router; same path as deeplinks.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s S13 practice? | Hybrid need → interop + deeplink owner → Mixpanel/Airship same path → design-cost lesson. |
| 60s S6 practice? | Nav fatigue → sheet + contracts → 30%+ → small surface lesson. |
| 3 min combo? | Add cell reuse / ads pause if interviewer asks implementation depth. |

---

### Q6. What is the Day 11 production topic mapping?

**Points to:** [Production bridge · §6 Topic mapping](../03-production-bridge.md#6-topic-mapping)

**Answer:**

> Hybrid architecture → **S13** Verified. Deeplink router ownership → **S13** Verified. Mixpanel/Airship → **S13** Verified. LE sheet + 30%+ → **S6** Verified. HeroWidget pause → **S1** Verified. Cell/prefetch/hosting code samples → **Learning-lab**. Exact hosting sizingOptions → Learning-lab unless you personally shipped that API choice.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S13 + S6 same interview? | Yes — hybrid nav (S13) and sheet metric (S6) are different beats; don’t merge into one fake project. |
| Analytics double-count? | Pick one screen owner — hybrid risk (Deep dive §20). |
| Full questions? | [`../04-questions.md`](../04-questions.md) for timed practice. |

---

Back to: [README.md](README.md)
