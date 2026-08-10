# Mock talk tracks (speak aloud)

> Verified stories only where labeled. Time yourself.

---

## Track A — Ads architecture (~5:00)

> “I’ll cover problem scope, the type-safe POP and generics pipeline, HeroWidget lifecycle, URLSession pinning and whitelist, and trade-offs versus SDUI for media.
>
> Context: our highest-revenue Ads module needed safer reusable rendering, and video inside HeroWidget needed correct pause and play with lifecycle — not fire-and-forget players.
>
> Component model: we refactored around protocol-oriented ad contracts and generics so new creatives plugged into one pipeline instead of inheritance forks. That kept the revenue path typed and testable.
>
> HeroWidget: pause and play are tied to visibility, view-controller appear/disappear, app background, and cell reuse. prepareForReuse stops the player. Lifecycle is part of the product contract because wasted playback and glitches hurt a revenue surface.
>
> Networking: we moved Ads off Alamofire onto URLSession so we owned HTTPS, SSL pinning, and a domain whitelist. Pinning without rotation thinking is an outage generator — as design I’d require backup pins and a monitored break-glass plan, without claiming I shipped that full ops runbook.
>
> Trade-offs: I’d let CMS configure placement, but I’d keep the video renderer native. SDUI is great for content velocity; it’s the wrong default for this player. Happy to go deeper on pinning, POP, or cell reuse.”

**Stop. Invite questions.**

---

## Track B — SDUI architecture (~5:00)

> “I’ll define SDUI scope, schema and versioning, registry and allowlisted actions, fail-soft fallback, then BMS header and Aces splash — and limits versus native Ads.
>
> Problem: we needed content and layout velocity without app releases, without turning CMS mistakes into crashes.
>
> Pipeline: fetch payload, version gate, parse, map types through a component registry, lay out, and only execute allowlisted actions.
>
> Resilience: unknown types skip with metrics — never crash. Keep last-known-good cache. If the root is empty, show a hard fallback header or splash. That’s fail-soft at the shell.
>
> Production: at BookMyShow we shipped a backend-driven header and MVVM search with debounce and cancel. On Aces we used a server-driven splash for fresher cold-start content and integrated live audio — measuring time-to-interactive, not vanity first-frame alone.
>
> Trade-offs: new component kinds still need an app release. Revenue video Ads I’d still keep native with an explicit lifecycle contract. SDUI owns configuration and content surfaces that must move fast. Questions welcome.”

**Stop. Invite questions.**

---

## S1 STAR (~2:30)

> “I’ll walk through our highest-revenue Ads refactor — protocols, generics, and video lifecycle.
>
> Situation: Ads needed a safer reusable rendering path; HeroWidget video needed correct pause/play.
>
> Action: I drove a protocol-oriented component model with generics for a type-safe pipeline; built HeroWidget with visibility and VC lifecycle pause/play; kept new ad types behind protocols so we didn’t fork; coordinated behavior with stakeholders on a revenue path.
>
> Result: a maintainable typed pipeline and fewer lifecycle glitches on a module that mattered for revenue — I’m not going to invent a fill-rate percentage.
>
> Lesson: for revenue UI, POP plus generics beat inheritance trees, and lifecycle is a product contract.”

---

## S3 STAR (~2:30)

> “I’ll cover our backend-driven header and search UX under MVVM.
>
> Situation: the main header needed to be CMS-driven; search needed debounce and explicit states.
>
> Action: generalised protocol-driven header implementation; search with debouncing, loading/empty/error, cancel-safe requests; backend contract so many content changes didn’t need app release; fail-soft rendering mindset for bad payloads.
>
> Result: faster header iteration and race-safer search.
>
> Lesson: SDUI is schema plus fallbacks — not just render JSON.”

---

## Spice openers

**S4 (~15s):** Ads Alamofire → URLSession with HTTPS, pinning, whitelist. 
**S12 (~20–40s):** Aces live audio + server-driven splash; optimize time-to-interactive. 
**S9 (~30–45s):** District Clean/MVVM migration; AI inside human-owned envelope + tests. 
**S6 (~20s):** Bottom sheet → 30%+ fewer full-screen navs on targeted flows.
