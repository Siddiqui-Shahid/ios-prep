# Audio script — Sample 03 — Brief B: SDUI renderer (Q&A)
> Listen-only sample Q&A from `03-brief-b-sdui.md`. Spoken answers and follow-ups.

## §0 Q1. What is Brief B asking for?

Next. Q1. What is Brief B asking for? Answer. Server-driven U I renderer: JSON document of components (type, props, optional children) → native views. Support ≥3 types (e.g. text, image, button / vstack). Unknown type → safe fallback. Include schemaVersion check. Unit-test decoding + unknown-type fallback. Follow-ups. Clarify at 0:15?: Which 3 types minimum; nested depth; actions on button or display-only.. Crash on unknown?: Never — placeholder + analytics stub.. Cut lines?: CMS tooling, live reload, expression language, Figma parity..

## §1 Q2. What architecture in 90s?

Next. Q2. What architecture in 90s? Answer. JSON → SDUIDocument (Codable, schemaVersion) → ComponentNode enum/protocol + factory → SDUIRenderer → SwiftUI/UIKit. Unknown → PlaceholderView + log stub. Say: “Tests: decode fixture, three types, unknown doesn’t throw. Cut: actions DSL, live reload.” Follow-ups. enum vs protocol?: enum faster in 3 hrs; protocol if extensibility story.. Recursive render?: vstack children — DFS-shaped (Day 22 nod).. Feature flag?: Optional — default fallback leaf..

## §2 Q3. Must-have acceptance for Brief B?

Next. Q3. Must-have acceptance for Brief B? Answer. (1) Decode sample JSON. (2) Render ≥3 types. (3) Unknown type does not crash — placeholder + analytics stub. (4) Nested children for one container. (5) Tests: decoder + factory fallback. Follow-ups. schemaVersion mismatch?: Fail-soft — fallback document or empty state; say policy.. Missing props?: Default values — don’t force-unwrap.. Deep nesting?: Optional max-depth guard — design nod to BookMyShow backend-driven header & search/BookMyShow I M O C + crash-free at scale..

## §3 Q4. Decode + factory — what to whiteboard?

Next. Q4. Decode + factory — what to whiteboard? Answer. SDUIDocument { schemaVersion, root: ComponentDTO }. DTO: type, props, children. Factory switch type →.text,.image,.vstack, default:.unknown(type). Renderer never force-unwraps. Maps to Day 22 serialize reversibility + Day 24 S D U I versioning instinct. Follow-ups. Props typing?: [String: String] interview-simple; say production would typed decode.. Unknown analytics?: Stub logger — unknown_component(type) event.. Codable polymorphism?: DTO + factory simpler than nested enums in 3 hrs..

## §4 Q5. How do unknown components connect to production BookMyShow backend-driven header & search?

Next. Q5. How do unknown components connect to production BookMyShow backend-driven header & search? Answer. Backend-driven header/search — unknown CMS component types must not crash app. Same fail-soft as Brief B placeholder. ≤20s: “Machine round S D U I slice mirrors shipped instinct: contracts, fallbacks, observable state.” Do not claim the 3hr project is BookMyShow production code. Follow-ups. Audio streaming + server-driven splash (Aces) splash?: Server-driven schema flexibility + client resilience.. schemaVersion?: Like A P I versioning — reject or degrade gracefully.. STAR timing?: Hooks only — full BookMyShow backend-driven header & search on Day 26..

## §5 Q6. Meaningful tests for Brief B?

Next. Q6. Meaningful tests for Brief B? Answer. test_decodeSampleJSON, test_rendersTextImageVStack, test_unknownTypeMapsToPlaceholder, optional test_schemaVersionMismatch. Test decoder + factory — renderer smoke optional. Unknown path must not throw. Follow-ups. Snapshot tests?: Weak alone — decoding tests pass bar.. Fixture JSON in bundle?: Clean pattern for test target.. Nested vstack test?: One fixture with children — acceptance #4..

## §6 Q7. Brief B trade-offs?

Next. Q7. Brief B trade-offs? Answer. SwiftUI AnyView faster than UIKit factory in 3 hrs — say assumption. Recursive render depth unbounded → mention iterative or max-depth design. Actions DSL and live reload are cut lines. Figma pixel parity loses to safe decode + 3 types. Follow-ups. Pick B if?: Weaker on S D U I — Day 27 SD prep ROI.. Connect Brief A?: List can host S D U I cells — out of scope unless surplus.. Debrief?: Sample 04..
