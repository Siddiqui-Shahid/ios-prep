# Sample 04 — Stories SDK (Raw / Miami Heat) (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under Stories SDK (Raw / Miami Heat)?

**Answer:**

> You designed a **standalone reusable Stories SDK** with a deliberate **public API** surface. You kept **isolation** from app-specific networking shortcuts — hosts inject content, analytics, and loaders. You drove **adoption across portfolio apps** (NBA/WNBA) so feature parity did not mean copy-paste forks. You may **not** invent “N apps × M% faster build” without evidence, claim Needle open-source unless true, or collapse Stories SDK (Raw / Miami Heat) and Live in-arena scoreboard (Raw) (scoreboard) into one careless claim.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 20-second Verified line? | “I shipped Stories as a standalone SDK with a clear public API and injected host dependencies — one module, multiple apps, no copy-paste forks.” |
| What is Live in-arena scoreboard (Raw) adjacent? | Live scoreboard Raw ownership — separate story. |
| Learning-lab vs Verified? | `code/` Package + DI sketches are illustrative — not portfolio metrics. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Live in-arena scoreboard (Raw)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. Walk the Stories SDK (Raw / Miami Heat) STAR spine in under three minutes

**Answer:**

> **Opener:** Standalone Stories SDK for portfolio reuse. **S/T:** Instagram-style fan Stories across NBA/WNBA apps — not one-off UI per app. **Action:** Public API; host-injected deps; hidden internals; portfolio adoption; versioning as quality. **Result:** One implementation leveraged by multiple apps → faster feature parity. **Lesson:** SDK quality = API + versioning + independence from host shortcuts.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag to say aloud? | Stories SDK (Raw / Miami Heat) · Raw / Miami Heat · Stories SDK portfolio reuse. |
| What not to invent in Result? | Percent faster builds or adoption timelines without data. |
| Action item interviewers probe? | How hosts inject theme and `ImageLoading`. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. How do Applied extensions extend Stories SDK (Raw / Miami Heat) without overclaiming?

**Answer:**

> Label **How I would apply it** when describing design detail beyond Verified facts. Examples: host injects `ImageLoading` for shared cache policy (Day 16); UIHostingController façade for UIKit hosts (Hybrid UI / deeplinks soft); protocolised theme tokens instead of hardcoded Heat colors. These extend boundaries — they are not substitute proof for portfolio adoption.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Image loader line? | Host injects loader so portfolio shares one cache policy — design detail, not a separate Verified story. |
| Theming line? | Protocolised tokens — don’t hardcode brand colors in SDK. |
| When say “Applied” aloud? | Any detail you cannot tie to shipped Stories SDK (Raw / Miami Heat) evidence. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. How do BookMyShow Ads pipeline + HeroWidget lifecycle and BookMyShow SSL pinning + URLSession migration hook softly without stealing Stories SDK (Raw / Miami Heat)?

**Answer:**

> **BookMyShow Ads pipeline + HeroWidget lifecycle soft:** Ads as revenue module with POP+Generics API — modularization of *behavior* even if packaging was pod-era. **BookMyShow SSL pinning + URLSession migration soft:** Packaging vs architecture — Ads networking ownership lived behind a module boundary; CocoaPods vs SPM is not the same question as “is the boundary clean?” **District Free Parking + Clean/MVVM + AI tooling soft:** Independently testable modules. Keep Stories SDK (Raw / Miami Heat) as the hero modularization proof; use soft hooks only when the interviewer pivots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Lead with BookMyShow Ads pipeline + HeroWidget lifecycle on modularization question? | No — lead Stories SDK (Raw / Miami Heat); mention BookMyShow Ads pipeline + HeroWidget lifecycle if ads/module boundary comes up. |
| BookMyShow SSL pinning + URLSession migration one-liner? | Clean boundary can exist in legacy packaging — measure the graph, not the tool fad. |
| District Free Parking + Clean/MVVM + AI tooling one-liner? | Module boundaries enable test doubles and keep AI inside architecture. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow SSL pinning + URLSession migration; District Free Parking + Clean/MVVM + AI tooling
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Claiming pin-rotation / break-glass runbook as a shipped production playbook.

---

### Q5. What must you never say about Stories modularization?

**Answer:**

> Do not invent build-time or adoption percentages. Do not claim you open-sourced an internal Needle fork unless true. Do not merge Stories SDK (Raw / Miami Heat) Stories SDK with Live in-arena scoreboard (Raw) scoreboard as one undifferentiated “Raw modules” story. Do not describe Learning-lab Package.swift as “what we shipped to production” without labeling it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Checklist before speaking? | Verified vs Applied labeled? Public API named? Host injection mentioned? |
| Safe Learning-lab phrasing? | “In the lab I sketch Package + composition root — production proof is Stories SDK (Raw / Miami Heat).” |
| If asked “how much faster?” | Honest: parity and reuse — measure build if you have Build Timing data. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat); Live in-arena scoreboard (Raw)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. How does Stories SDK (Raw / Miami Heat) answer “design a reusable feature module”?

**Answer:**

> Whiteboard: standalone package → public entry + callbacks + errors → inject theme, analytics, content provider, image loader → demo host → second production host → semver. Tie to Verified: you did this for Stories across portfolio apps. Emphasize **what crosses the boundary** (protocols) vs **what stays internal** (VCs, SwiftUI, networking shortcuts).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Public vs internal rule? | If a host needs it, protocol or public type; else hide. |
| Cross-feature navigation? | Host router handles deeplink exit — SDK does not import Checkout Impl. |
| Testability hook? | Injected deps → mock content and loaders in demo host tests. |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. Give a full honest answer mixing architecture and Stories SDK (Raw / Miami Heat)

**Answer:**

> “Features depend on peer Interfaces, never Impls — App is the composition root. For portfolio reuse I shipped Stories as a standalone SDK (Stories SDK (Raw / Miami Heat)): public API, host-injected theme/analytics/loaders, adoption across NBA/WNBA apps. I’d extend that boundary with injected `ImageLoading` and protocolised theming (Applied) — SDK quality is API stability and host independence, not folder moves.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Where is Verified? | Standalone SDK, public API, portfolio adoption. |
| Where is Applied? | Image loader and theme injection design detail. |
| After this sample? | [`../code/`](../code/), then [`../04-questions.md`](../04-questions.md). |

**How can I relate to my case:**
- **Shipped:** Stories SDK (Raw / Miami Heat)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

## After this sample

1. Skim [`../code/Package.swift`](../code/Package.swift) and [`../code/StoriesPublicAPI.swift`](../code/StoriesPublicAPI.swift).
2. Speak Stories SDK (Raw / Miami Heat) STAR timed from **Answer points** in [`../04-questions.md`](../04-questions.md).
3. Whiteboard Interface/Impl + composition root in [`../05-exercises.md`](../05-exercises.md).

---

