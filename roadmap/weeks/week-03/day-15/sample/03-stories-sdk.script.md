# Audio script — Sample 03 — Stories SDK extraction (Q&A)
> Listen-only sample Q&A from `03-stories-sdk.md`. Spoken answers and follow-ups.

## §0 Q1. Why treat Stories as a product SDK, not a copied folder?

Next. Q1. Why treat Stories as a product SDK, not a copied folder? Answer. Portfolio apps (NBA/WNBA) needed Instagram-style fan Stories without copy-paste U I per brand. A standalone package with a stable public A P I lets one implementation serve multiple hosts. Hosts inject theme, analytics, and media loaders. Internals stay hidden; entry points, callbacks, and errors are explicit. Versioning and adoption discipline turn modularization into product leverage, not just compile-time tidiness. Follow-ups. What hosts must supply?: Theme tokens, analytics, StoriesContentProviding, image loader protocols.. What S D K must not own?: Host-specific networking shortcuts, hardcoded branding, permanent third-party loader lock-in.. Public A P I sketch?:../code/StoriesPublicAPI.swift.

## §1 Q2. What is the extraction sequence you can whiteboard?

Next. Q2. What is the extraction sequence you can whiteboard? Answer. Identify the public surface → inject host dependencies (theme, analytics, content, loaders) → build a demo app host → prove second production host → semantic version the package → deprecate breaking changes carefully. Each step reduces risk before portfolio-wide adoption. Follow-ups. Why demo app host first?: Proves S D K runs without the original app’s hidden shortcuts.. Versioning rule of thumb?: Additive minor; breaking = major + release notes.. S11 adjacent note?: Live scoreboard is separate Raw ownership — don’t collapse with S 10 carelessly..

## §2 Q3. Should the Stories SDK own the image pipeline?

Next. Q3. Should the Stories SDK own the image pipeline? Answer. No — don’t hardcode Kingfisher (or any loader) inside the S D K forever. Inject ImageLoading from the host so every portfolio app shares one cache policy, downsample rules, and memory pressure behavior. The S D K stays reusable; hosts control media infrastructure. Follow-ups. Day 16 connection?: L1/L2/L3 tiers and downsample math live in the host loader.. S D K without injection?: Each app forks cache behavior — parity breaks under memory pressure.. UIKit host for SwiftUI internals?: UIHostingController façade; deeplink exits via host router (S13 soft)..

## §3 Q4. How do you keep Core from becoming a junk drawer?

Next. Q4. How do you keep Core from becoming a junk drawer? Answer. Put true shared entities (User id) in a small kernel. Keep checkout-only DTOs in Checkout Interface/Impl. Reject “maybe useful someday” types in Core — that recreates hidden coupling and slows every dependent module. Shared models need the same discipline as shared U I. Follow-ups. When is Core justified?: Infrastructure abstractions and genuinely cross-cutting domain ids — not feature U I models.. Symptom of junk drawer?: Every feature imports Core and nobody knows who owns a type.. Refactor path?: Move misplaced DTOs back to feature Interfaces incrementally..

## §4 Q5. Build times got worse after many modules — why?

Next. Q5. Build times got worse after many modules — why? Answer. Common causes: Interface targets changing too often (every Impl rebuilds), over-fine package splits, too many dynamic frameworks, poor CI caching. Fix by measuring Build Timing Summary, merging leaf packages, stabilizing Interfaces, and preferring static internal linking. Modularization is a trade-off — measure, don’t assume more targets = faster. Follow-ups. Forbidden interview claim?: “80 modules cut build by X%” without evidence.. Chatty Interface symptom?: Small DTO churn in Interface forces wide rebuilds.. Ego split?: One screen ≠ one SPM product without team boundary justification..

## §5 Q6. How does modularization connect to testability?

Next. Q6. How does modularization connect to testability? Answer. Features that depend on protocols can be tested with injected fakes — no live network or singletons. Clean/M V V M inside the module boundary (S9 soft) keeps AI and juniors inside an architecture envelope. Module boundaries are where you enforce “no.shared in Impl.” Follow-ups. What does Interface enable in tests?: Mock NetworkProviding, mock cart, mock builders — constructor injection.. S 1 soft connection?: Ads as revenue module with P O P boundary — modularization of behavior.. Without Interface split?: Tests reach for globals or duplicate production wiring hacks..

## §6 Q7. What SDK versioning mistakes hurt portfolio adoption?

Next. Q7. What SDK versioning mistakes hurt portfolio adoption? Answer. Breaking public A P I without major version bumps; hiding internal VCs that hosts started reaching into; hardcoding host branding; owning third-party dependencies permanently. S D K quality = A P I surface + versioning + independence from host shortcuts — that’s the S 10 lesson, not just “we moved files into a package.” Follow-ups. Additive change example?: New optional callback on entry builder — minor bump.. Breaking change example?: Renaming public entry type — major + migration notes.. Next sample?: 04-production-s10.md — Verified interview language.. Next: 04-production-s10.md.
