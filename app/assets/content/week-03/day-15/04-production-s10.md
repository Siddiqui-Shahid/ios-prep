# Sample 04 — Production S10 (Q&A)

> Guided teaching. Separates **Verified** resume facts from **How I would apply it** extensions so you never blur them in an interview.

---

### Q1. What can you claim under Verified · S10?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map) · [§2 Verified S10 STAR](../03-production-bridge.md#2-verified-s10--star-2-3-min)

**Answer:**

> You designed a **standalone reusable Stories SDK** with a deliberate **public API** surface. You kept **isolation** from app-specific networking shortcuts — hosts inject content, analytics, and loaders. You drove **adoption across portfolio apps** (NBA/WNBA) so feature parity did not mean copy-paste forks. You may **not** invent “N apps × M% faster build” without evidence, claim Needle open-source unless true, or collapse S10 and S11 (scoreboard) into one careless claim.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20-second Verified line? | “I shipped Stories as a standalone SDK with a clear public API and injected host dependencies — one module, multiple apps, no copy-paste forks.” |
| What is S11 adjacent? | Live scoreboard Raw ownership — separate story. |
| Learning-lab vs Verified? | `code/` Package + DI sketches are illustrative — not portfolio metrics. |

---

### Q2. Walk the S10 STAR spine in under three minutes

**Points to:** [Production bridge · §2 Verified S10](../03-production-bridge.md#2-verified-s10--star-2-3-min)

**Answer:**

> **Opener:** Standalone Stories SDK for portfolio reuse. **S/T:** Instagram-style fan Stories across NBA/WNBA apps — not one-off UI per app. **Action:** Public API; host-injected deps; hidden internals; portfolio adoption; versioning as quality. **Result:** One implementation leveraged by multiple apps → faster feature parity. **Lesson:** SDK quality = API + versioning + independence from host shortcuts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag to say aloud? | Verified · S10 · Raw / Miami Heat · Stories SDK portfolio reuse. |
| What not to invent in Result? | Percent faster builds or adoption timelines without data. |
| Action item interviewers probe? | How hosts inject theme and `ImageLoading`. |

---

### Q3. How do Applied extensions extend S10 without overclaiming?

**Points to:** [Production bridge · §4 Applied extensions](../03-production-bridge.md#4-applied-extensions-speak-carefully)

**Answer:**

> Label **How I would apply it** when describing design detail beyond Verified facts. Examples: host injects `ImageLoading` for shared cache policy (Day 16); UIHostingController façade for UIKit hosts (S13 soft); protocolised theme tokens instead of hardcoded Heat colors. These extend boundaries — they are not substitute proof for portfolio adoption.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Image loader line? | Host injects loader so portfolio shares one cache policy — design detail, not a separate Verified story. |
| Theming line? | Protocolised tokens — don’t hardcode brand colors in SDK. |
| When say “Applied” aloud? | Any detail you cannot tie to shipped S10 evidence. |

---

### Q4. How do S1 and S4 hook softly without stealing S10?

**Points to:** [Production bridge · §5 Adjacent hooks](../03-production-bridge.md#5-adjacent-hooks)

**Answer:**

> **S1 soft:** Ads as revenue module with POP+Generics API — modularization of *behavior* even if packaging was pod-era. **S4 soft:** Packaging vs architecture — Ads networking ownership lived behind a module boundary; CocoaPods vs SPM is not the same question as “is the boundary clean?” **S9 soft:** Independently testable modules. Keep S10 as the hero modularization proof; use soft hooks only when the interviewer pivots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lead with S1 on modularization question? | No — lead S10; mention S1 if ads/module boundary comes up. |
| S4 one-liner? | Clean boundary can exist in legacy packaging — measure the graph, not the tool fad. |
| S9 one-liner? | Module boundaries enable test doubles and keep AI inside architecture. |

---

### Q5. What must you never say about Stories modularization?

**Points to:** [Production bridge · Forbidden](../03-production-bridge.md#1-provenance-map)

**Answer:**

> Do not invent build-time or adoption percentages. Do not claim you open-sourced an internal Needle fork unless true. Do not merge S10 Stories SDK with S11 scoreboard as one undifferentiated “Raw modules” story. Do not describe Learning-lab Package.swift as “what we shipped to production” without labeling it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Checklist before speaking? | Verified vs Applied labeled? Public API named? Host injection mentioned? |
| Safe Learning-lab phrasing? | “In the lab I sketch Package + composition root — production proof is S10.” |
| If asked “how much faster?” | Honest: parity and reuse — measure build if you have Build Timing data. |

---

### Q6. How does S10 answer “design a reusable feature module”?

**Points to:** [Deep dive · §5 Stories SDK](../02-deep-dive.md#5-stories-sdk-as-reusable-module-deep) · [Production bridge · §3 Interview line](../03-production-bridge.md#3-interview-line-20s)

**Answer:**

> Whiteboard: standalone package → public entry + callbacks + errors → inject theme, analytics, content provider, image loader → demo host → second production host → semver. Tie to Verified: you did this for Stories across portfolio apps. Emphasize **what crosses the boundary** (protocols) vs **what stays internal** (VCs, SwiftUI, networking shortcuts).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public vs internal rule? | If a host needs it, protocol or public type; else hide. |
| Cross-feature navigation? | Host router handles deeplink exit — SDK does not import Checkout Impl. |
| Testability hook? | Injected deps → mock content and loaders in demo host tests. |

---

### Q7. Give a full honest answer mixing architecture and S10

**Points to:** [Production bridge · §3 Interview line](../03-production-bridge.md#3-interview-line-20s) · [Foundations · §3 Golden rule](../01-foundations.md#3-golden-dependency-rule)

**Answer:**

> “Features depend on peer Interfaces, never Impls — App is the composition root. For portfolio reuse I shipped Stories as a standalone SDK (Verified S10): public API, host-injected theme/analytics/loaders, adoption across NBA/WNBA apps. I’d extend that boundary with injected `ImageLoading` and protocolised theming (Applied) — SDK quality is API stability and host independence, not folder moves.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified? | Standalone SDK, public API, portfolio adoption. |
| Where is Applied? | Image loader and theme injection design detail. |
| After this sample? | [`../code/`](../code/), then [`../04-questions.md`](../04-questions.md). |

---

## After this sample

1. Skim [`../code/Package.swift`](../code/Package.swift) and [`../code/StoriesPublicAPI.swift`](../code/StoriesPublicAPI.swift).
2. Speak S10 STAR timed from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Whiteboard Interface/Impl + composition root in [`../05-exercises.md`](../05-exercises.md).
