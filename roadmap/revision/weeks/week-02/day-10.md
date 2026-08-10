# Day 10 — SDUI / CMS · Schema Versioning · Fallbacks

> Week 2 · Revision pass ~45–60 min  
> Full study: [weeks/week-02/day-10/](../../../weeks/week-02/day-10/README.md)  
> Sample Q&A (guided): [weeks/week-02/day-10/sample/](../../../weeks/week-02/day-10/sample/README.md)

## 1. Outcome

Explain aloud, in plain sentences:

- SDUI mental model: schema → version gate → registry → **native** render
- Fail-soft rules: unknown component skip + metric; empty root hard fallback
- Component registry, allowlisted actions, cold-start splash path
- BookMyShow backend-driven header & search BMS backend-driven header and Audio streaming + server-driven splash (Aces) Aces server-driven splash
- What SDUI is not — and where native Ads media stays native (BookMyShow Ads pipeline + HeroWidget lifecycle)

## 2. Concept refresh (simple)

### 2.1 SDUI flow

Backend sends structured schema → client checks `schemaVersion` → registry maps type strings to native Swift views → render. Updates ship via CMS/API without App Store when contracts allow.

### 2.2 Fail-soft hierarchy

| Failure | Client behavior |
|---|---|
| Unknown component type | **Skip + metric** — never crash; render siblings |
| Incompatible schema major | Reject to cached/default fallback |
| Empty root payload | **Hard fallback** — blank chrome unacceptable |

### 2.3 Registry + actions

Registry is a type→factory map. Actions are **allowlisted** (deeplink, dismiss, analytics) — not arbitrary code execution. Cold-start splash: parse early, show cached/default while fetching.

### 2.4 Critical truths (pin)

| Claim | Truth |
|---|---|
| SDUI def | Schema → version gate → registry → **native** render |
| Not SDUI | JS eval, whole-app WebView, arbitrary code in JSON |
| Unknown component | **Skip + metric** — never crash |
| Empty root | Hard fallback — blank chrome unacceptable |
| BookMyShow backend-driven header & search verified | BMS backend-driven / protocolised header |
| BookMyShow backend-driven header & search-A1 | Schema versioning + unknown fallback = **design** |
| Audio streaming + server-driven splash (Aces) verified | Aces server-driven splash — **no invented ms** |
| Ads media | BookMyShow Ads pipeline + HeroWidget lifecycle native lifecycle — config maybe SDUI, video stays native |

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [Sample Q&A](../../../weeks/week-02/day-10/sample/) | Guided cards |
| Must | Full modules [01–03](../../../weeks/week-02/day-10/01-foundations.md) | Gaps |
| Drill | [07-revision-qna](../../../weeks/week-02/day-10/sample/07-revision-qna.md) | Timed answers |

Suggested sample order: `01-sdui-foundations` → `02-schema-version-fallbacks` → `03-registry-actions-splash` → `04-production-s3-s12`.

## 4. Map to your work

**BookMyShow backend-driven header & search:** BMS backend-driven / protocolised main-screen header; API contracts for layout/content changes without release when possible.  
**Audio streaming + server-driven splash (Aces):** Aces server-driven splash — cold-start flexibility; audio streaming context — **no invented latency ms**.  
**BookMyShow backend-driven header & search-A1:** Schema versioning + unknown-component fallback as **design emphasis** — not a named shipped framework.

**Interview line (≤20s):** “I made BMS’s header backend-driven with a protocolised client so content could move faster — with native rendering and fail-soft fallbacks, not a WebView rewrite.”

→ [BookMyShow backend-driven header & search Header](../../stories/story-bank.md#s3--backend-driven-header--search-bookmyshow) · [Audio streaming + server-driven splash (Aces) Splash](../../stories/story-bank.md#s12--aces-audio--server-driven-splash)

## 5. Flash prompts

1. SDUI in one sentence — schema to native render
2. Three things that are **not** SDUI
3. Unknown component arrives — exact client behavior
4. Empty root vs unknown sibling — different severity
5. Registry + allowlisted actions — why not eval JSON
6. BookMyShow backend-driven header & search-A1: breaking schema from backend — design answer
7. BookMyShow backend-driven header & search ≤20s pitch
8. Audio streaming + server-driven splash (Aces) splash — verified scope, no invented ms

## 6. Timed drills

| Drill | Budget |
|---|---|
| SDUI flow whiteboard | 60s |
| Fail-soft hierarchy (unknown vs empty root) | 60s |
| BookMyShow backend-driven header & search-A1 versioning design | 90s |
| BookMyShow backend-driven header & search ≤20s pitch | 20s |
| BookMyShow backend-driven header & search full STAR | 2–3 min |

Expand from [sample cards](../../../weeks/week-02/day-10/sample/) and [07-revision-qna](../../../weeks/week-02/day-10/sample/07-revision-qna.md) answer points.
