# Audio script — Sample 04 — Production S13 / S6 / S1 (Q&A)
> Listen-only sample Q&A from `04-production-s13-s6.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S13?

Next. Q1. What can you claim under Verified · S13? Answer. Memphis Grizzlies: you designed SwiftUI + UIKit interop architecture with deliberate lifecycle and sizing — not ad-hoc hosting. Deep linking with navigation/lifecycle handling and cold-start readiness queue mindset. Mixpanel and Airship integrated so push taps route through the same navigation story as deeplinks. Lesson: interop costs (identity, lifecycle, hosting) must be designed, not bolted. Follow-ups. ≤20s pitch?: “On Grizzlies I designed SwiftUI↔UIKit interop with deliberate lifecycle and deeplink ownership — not ad-hoc hosting.”. Forbidden?: Invent Grizzlies crash-free %; dual stacks “in sync” as virtue.. Push vs deeplink?: Same router — S13 discipline..

## §1 Q2. What can you claim under Verified · S6?

Next. Q2. What can you claim under Verified · S6? Answer. BookMyShow LE Bottom Sheet: lightweight event overview surface. Led end-to-end delivery; aligned PM, Design, Backend on A P I/content contracts. Shipped reusable component into high-traffic flows. Result: 30%+ fewer full-screen navigations for user flows (resume metric). Lesson: small U I surfaces with clear contracts beat large rewrites for navigation pain. Follow-ups. ≤20s pitch?: “I shipped a reusable LE Bottom Sheet that reduced full-screen navigations for 30%+ of user flows by keeping event overview in context.”. Invent other nav %?: Forbidden — only resume 30%+.. Engineering details OK?: Detents, VoiceOver, analytics open/dismiss — Learning-lab + honest design..

## §2 Q3. How do you insert S1 lifecycle in a hybrid/cells answer?

Next. Q3. How do you insert S1 lifecycle in a hybrid/cells answer? Answer. When asked where ads video pauses: disappear, offscreen, background — HeroWidget protocolised that behavior on the revenue-critical Ads module. Tie to viewWillDisappear, visibility threshold, and prepareForReuse stopping the player in cells. Lifecycle is part of the product contract (Verified · S 1). Follow-ups. Invent fill-rate %?: Forbidden — stay qualitative on revenue impact.. Cell reuse link?: Same pause/cancel discipline as full-screen view controller.. S 1 vs S13?: S 1 = Ads HeroWidget; S13 = hybrid nav/deeplinks — complementary stories..

## §3 Q4. What must you never invent for Day 11 production stories?

Next. Q4. What must you never invent for Day 11 production stories? Answer. Do not invent nav reduction % beyond resume 30%+. Do not claim continuous dual NavigationPath + UINavigationController sync as best practice. Do not claim Airship/Mixpanel integration without lifecycle discipline when asked about navigation. Do not invent Grizzlies crash-free percentages or exact hosting A P I trivia as verified production war stories unless labeled Learning-lab. Follow-ups. Hosting sizingOptions A P I?: Learning-lab teaching detail — OK if labeled.. “Why not pure SwiftUI?”: Legacy UIKit + velocity; hybrid with one nav owner.. Prefetch data bills?: Bound concurrency, cancel, Low Data Mode — honest engineering response..

## §4 Q5. How do interviewer pushes map to strong replies?

Next. Q5. How do interviewer pushes map to strong replies? Answer. Pure SwiftUI? Legacy + ship velocity; hybrid with one owner. New tab for LE? Tabs change IA; sheet fixes local friction; 30%+ metric. Hosting height broken? Intrinsic/sizing ownership; nested scroll fights. Prefetch bills? Bound concurrency, cancel, Low Data Mode. Push wrong screen? Single router; same path as deeplinks. Follow-ups. 60s S13 practice?: Hybrid need → interop + deeplink owner → Mixpanel/Airship same path → design-cost lesson.. 60s S6 practice?: Nav fatigue → sheet + contracts → 30%+ → small surface lesson.. 3 min combo?: Add cell reuse / ads pause if interviewer asks implementation depth..

## §5 Q6. What is the Day 11 production topic mapping?

Next. Q6. What is the Day 11 production topic mapping? Answer. Hybrid architecture → S13 Verified. Deeplink router ownership → S13 Verified. Mixpanel/Airship → S13 Verified. LE sheet + 30%+ → S6 Verified. HeroWidget pause → S 1 Verified. Cell/prefetch/hosting code samples → Learning-lab. Exact hosting sizingOptions → Learning-lab unless you personally shipped that A P I choice. Follow-ups. S13 + S6 same interview?: Yes — hybrid nav (S13) and sheet metric (S6) are different beats; don’t merge into one fake project.. Analytics double-count?: Pick one screen owner — hybrid risk (Deep dive §20).. Full questions?:../04-questions.md for timed practice.. Back to: README.md.
