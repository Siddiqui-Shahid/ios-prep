# 03 — Production Bridge: BMS Header, Aces Splash, S3-A1 Design

> Convert theory into interview stories without overclaiming.

## 1. Provenance map for today

| ID | Label | Exact claim you may make |
|---|---|---|
| **S3** | Verified | BMS **backend-driven / CMS header**; generalised **protocol-driven** main-screen; API contracts for layout/content changes without release when possible; search debounce/MVVM is sibling (Day 08) |
| **S3-A1** | How I would apply it | **Schema versioning** + **unknown-component fallback** as **design** — not “I shipped a named VersionGate framework as a resume bullet” |
| **S12** | Verified | Aces **server-driven splash**; cold-start flexibility/freshness; audio streaming context — **no invented ms** |
| Learning-lab | Illustrative | Gate / registry / fallback code in this chapter |

### Forbidden overclaims

- “We eval CMS JavaScript.”
- Invented cold-start latency numbers.
- “S3-A1 was our production VersioningService I named in resume.”
- “SDUI alone produced 99.95% crash-free.”
- Claiming Ads HeroWidget was fully SDUI (S1 is native lifecycle).

## 2. Verified S3 — STAR (2–3 min)

### Opener (~10s)

> “I’ll walk through making BookMyShow’s main header backend-driven with a protocolised client so content could move faster without waiting on releases.”

### Situation / Task

Main header needed CMS/backend-driven flexibility; content and layout iteration was gated by app releases more than necessary.

### Action

1. Migrated header toward a **generalised, protocol-driven** main-screen implementation.
2. Contracted APIs with backend so many layout/content changes didn’t need App Store.
3. Kept client native and structured — not a WebView rewrite of chrome.
4. Paired with search MVVM improvements (debounce/states) on the same surface family.

### Result

Faster content iteration on header; clearer client contracts.

### Lesson

SDUI needs schema/versioning and client fallbacks — not just “render JSON.” That lesson is why S3-A1 design matters in interviews.

> **Provenance:** Verified · S3 · BookMyShow · backend-driven header

## 3. S3-A1 — Versioning & unknown fallback as design

When asked “what if backend sends a new component type / breaking schema?”, answer as **design judgment**:

| Design element | Intent |
|---|---|
| `schemaVersion` gate | Reject incompatible majors to fallback |
| Unknown component skip | Never crash; metric + continue siblings |
| Empty-root hard fallback | Blank header/splash is unacceptable |
| Dual-publish | Breaking changes need runway |
| Canary payloads | % expose before 100% |
| Kill switch | Feature-flag back to native default |

**Script fragment:**

> “On BMS we shipped a backend-driven, protocolised header. Separately, as design, I’d require schema version gates and unknown-component skip with hard fallbacks — CMS velocity without those controls becomes crash velocity. I’m not claiming a named production VersionGate service as a resume bullet; I’m claiming the header work and the compatibility design I’d insist on.”

> **Provenance:** How I would apply it · S3-A1 · schema versioning / unknown-component fallback as design

## 4. Verified S12 — Aces splash STAR beat

### Opener (~10s)

> “On Las Vegas Aces I revamped splash to be server-driven so cold-start content could stay fresh and flexible — alongside live audio streaming work.”

### Action highlights

1. Server-driven splash content path.
2. Treat startup as product surface: prefer cached/flexible content with safe defaults over blocking forever.
3. Audio streaming integrated as separate live capability — don’t serialize everything on launch.

### Result

Richer live audio; more flexible cold-start content. **Do not invent ms.**

### Lesson

Measure time-to-interactive; cache + timeout-to-default.

> **Provenance:** Verified · S12 · Raw/Aces · server-driven splash

## 5. Interview lines (≤20s)

**S3:**  
> “I made the BMS main header backend-driven with a protocolised client so many layout changes didn’t need a release — and I’d pair that with version gates and fail-soft unknowns as design.”

**S12:**  
> “On Aces I shipped a server-driven splash for colder-start flexibility and freshness, with safe defaults so startup never depended on a perfect network.”

## 6. Topic mapping

| Topic | Verified? | How to speak |
|---|---|---|
| Backend-driven header | Yes · S3 | Shipped direction |
| Protocol-driven main screen | Yes · S3 | Shipped |
| Schema VersionGate type | S3-A1 design | Design I’d apply |
| Unknown skip policy | S3-A1 design | Design; aligns with crash-free culture |
| Aces server splash | Yes · S12 | Shipped |
| Exact cold-start ms | No | Do not invent |
| JS eval SDUI | No | Never |
| Ads fully SDUI | No | S1 native media |

## 7. Interviewer pushes

| Push | Strong reply |
|---|---|
| “Isn’t that a WebView?” | Native registry + schema; WebView is a tool, not the architecture. |
| “Backend broke schema for everyone.” | Gate + fallback + canary + kill switch; client must survive (S8 culture). |
| “Skip makes empty UI.” | Skip children; empty root → hard fallback; alert on skip spikes. |
| “Why not SDUI the ads video?” | Config maybe; media lifecycle native — S1. |
| “What ms did splash save?” | Speak flexibility/freshness; no invented ms. |

## 8. Practice versions

**60s S3:** problem (release-gated header) → protocolised CMS header → faster iteration → lesson (versioning/fallback design).

**60s S12:** inflexible splash → server-driven splash + safe defaults → flexible cold start → lesson (TTI mindset).

**3 min:** add unknown skip, dual-publish, cache privacy, Ads contrast, honest S3-A1 label.

## 9. Links

- Code: [code/](code/)
- Questions: [04-questions.md](04-questions.md)
- Revision: [../../../revision/weeks/week-02/day-10.md](../../../revision/weeks/week-02/day-10.md)
- Stories: [S3](../../../stories/story-bank.md)#s3--backend-driven-header--search-bookmyshow · [S12](../../../stories/story-bank.md)#s12--audio-streaming--server-driven-splash-raw--las-vegas-aces
