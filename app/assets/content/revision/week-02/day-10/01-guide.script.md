# Audio script — Revision guide — SDUI / CMS · Schema Versioning · Fallbacks
> Listen-only revision day guide from `day-10.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: S D U I mental model: schema → version gate → registry → native render Fail-soft rules: unknown component skip + metric; empty root hard fallback Component registry, allowlisted actions, cold-start splash path.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 SDUI flow

Next. 2.1 SDUI flow. Backend sends structured schema → client checks schemaVersion → registry maps type strings to native Swift views → render. Updates ship via CMS/A P I without App Store when contracts allow.

## §3 2.2 Fail-soft hierarchy

Next. 2.2 Fail-soft hierarchy. 2.2 Fail-soft hierarchy.

## §4 2.3 Registry + actions

Next. 2.3 Registry + actions. Registry is a type→factory map. Actions are allowlisted (deeplink, dismiss, analytics) — not arbitrary code execution. Cold-start splash: parse early, show cached/default while fetching.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. Suggested sample order: 01-sdui-foundations → 02-schema-version-fallbacks → 03-registry-actions-splash → 04-production-s3-s12.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow backend-driven header & search: Book My Show backend-driven / protocolised main-screen header; A P I contracts for layout/content changes without release when possible. Audio streaming + server-driven splash (Aces): Aces server-driven splash — cold-start flexibility; audio streaming context — no invented latency ms. BookMyShow backend-driven header & search-A1: Schema versioning + unknown-component fallback as design emphasis — not a named shipped framework. Interview line (≤20s): “I made Book My Show’s header backend-driven with a protocolised client so content could move faster — with native rendering and fail-soft fallbacks, not a WebView rewrite.”.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. S D U I in one sentence — schema to native render 2. Three things that are not S D U I 3. Unknown component arrives — exact client behavior 4. Empty root vs unknown sibling — different severity.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 07-revision-qna answer points.
