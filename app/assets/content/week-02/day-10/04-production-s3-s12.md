# Sample 04 — Backend-driven UI & Aces splash (Q&A)

> Guided teaching. Separates **shipped** named cases from **design-if-asked** and **lab-only** so you never blur them in an interview.

---

### Q1. What can you claim under BookMyShow backend-driven header & search for the header?
**Answer:**

> BookMyShow backend-driven header & search for Day 10: BMS **backend-driven / CMS header**; **generalised, protocol-driven** main-screen implementation; API contracts so many **layout/content changes** didn’t require App Store release when possible. Client stayed **native and structured** — not a WebView rewrite of chrome. Search debounce/MVVM is a **sibling** beat (Day 08) on the same surface family. You may **not** claim JS eval SDUI or that a named VersionGate framework was a resume bullet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s BookMyShow backend-driven header & search line? | “Backend-driven header with protocolised client so many layout changes didn’t need a release — I’d pair version gates and fail-soft unknowns as design.” |
| Result? | Faster header content iteration; clearer client contracts. |
| Lesson? | SDUI needs schema/versioning/fallbacks — not just “render JSON.” |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What is BookMyShow backend-driven header & search-A1 and how do you speak it under pushback?
**Answer:**

> **BookMyShow backend-driven header & search-A1 — How I would apply it:** schema `schemaVersion` gate rejecting incompatible majors to fallback; unknown component **skip** never crash; **empty-root hard fallback**; dual-publish for breaking changes; canary payloads; kill switch to native default. Script: “On BMS we shipped a backend-driven header. Separately, as design, I’d require version gates and unknown skip with hard fallbacks — CMS velocity without those controls becomes crash velocity. I’m not claiming a named production VersionGate service as a resume bullet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| VersionGate type in resume? | BookMyShow backend-driven header & search-A1 design — illustrative code only in learning-lab. |
| Unknown skip verified as named system? | Speak policy; label design unless later verified. |
| “Backend broke schema for everyone”? | Gate + fallback + canary + kill switch — client must survive. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q3. What is the BookMyShow backend-driven header & search STAR in plain steps?
**Answer:**

> **Situation:** Main header iteration gated by App Store more than necessary. **Action:** Migrated toward generalised protocol-driven main-screen header from CMS/backend; contracted APIs for layout/content flexibility; kept rendering native via structured schema mindset (registry conceptually). Paired with search MVVM improvements on related surfaces. **Result:** Faster content iteration; clearer contracts. **Lesson:** Compatibility design (BookMyShow backend-driven header & search-A1) is what keeps CMS velocity from becoming crash velocity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s practice version? | Release-gated header → protocolised CMS header → faster iteration → versioning/fallback design lesson. |
| WebView pushback? | Native registry + schema — WebView is a tool, not the architecture. |
| Skip makes empty UI? | Skip children; empty root → hard fallback; alert on skip rate spikes. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q4. What can you claim under Audio streaming + server-driven splash (Aces) for Aces splash?
**Answer:**

> Audio streaming + server-driven splash (Aces): Las Vegas Aces **server-driven splash**; cold-start **flexibility and freshness**; context of **live audio streaming** work alongside splash. Treat startup as product surface: cached/flexible content with safe defaults over blocking forever on network. **Do not invent cold-start milliseconds** or latency savings percentages on resume.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s Audio streaming + server-driven splash (Aces) line? | “Server-driven splash for cold-start flexibility with safe defaults so startup never depended on perfect network.” |
| Audio vs splash blocking? | Don’t serialize audio init and splash network on one main-thread chain. |
| “What ms did splash save?” | Speak flexibility/freshness — no invented ms. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces)
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q5. How do you contrast SDUI with native Ads (BookMyShow Ads pipeline + HeroWidget lifecycle)?
**Answer:**

> “Why not SDUI the ads video?” — **Config/placement** may be CMS-driven; **media lifecycle** (pause/play, memory, viewability) stays **native** per BookMyShow Ads pipeline + HeroWidget lifecycle HeroWidget/ads pipeline. Don’t claim Ads was fully SDUI. SDUI header promos may *point* at native ad surfaces — different layers. Strong reply keeps revenue media guarantees separate from layout slots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| BookMyShow Ads pipeline + HeroWidget lifecycle hook? | Type-safe ads pipeline — verified separate story. |
| WebView for ad creative? | Third-party creative URLs are separate from API host whitelist (Day 09). |
| SDUI alone → 99.95%? | Forbidden overclaim — BookMyShow IMOC + crash-free at scale is culture; SDUI skip helps blast radius. |

**How can I relate to my case:**
- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; BookMyShow IMOC + crash-free at scale
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented fill-rate % or sole credit for ads revenue.

---

### Q6. What must you never say about Day 10 production stories?
**Answer:**

> Never claim: CMS JavaScript eval; invented cold-start ms; BookMyShow backend-driven header & search-A1 as a shipped named framework on resume; SDUI alone produced crash-free rate; Ads video fully SDUI. Always label **BookMyShow backend-driven header & search / Audio streaming + server-driven splash (Aces)** vs **Design: BookMyShow backend-driven header & search-A1** when discussing version gates, unknown skip, dual-publish, and kill switches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag BookMyShow backend-driven header & search? | BookMyShow backend-driven header & search · BookMyShow · backend-driven header. |
| Provenance tag Audio streaming + server-driven splash (Aces)? | Audio streaming + server-driven splash (Aces) · Raw/Aces · server-driven splash. |
| 3 min practice? | Add unknown skip, dual-publish, cache privacy, Ads contrast, honest BookMyShow backend-driven header & search-A1 label. |

**How can I relate to my case:**
- **Shipped:** Audio streaming + server-driven splash (Aces); BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q7. What should you be able to say after Day 10 sample + modules?
**Answer:**

> “SDUI is versioned schema mapped to a native registry — unknown types skip with metrics, incompatible majors fall back, actions are allowlisted. On BMS I shipped a backend-driven protocolised header; on Aces a server-driven splash with safe defaults. Schema versioning and unknown fallbacks I’d insist on as design so CMS experiments don’t become crash experiments.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda opener from day README? | Schema + registry + version gates + fail-soft → BMS header + Aces splash → BookMyShow backend-driven header & search-A1 design. |
| Metric to mention? | `sdui_unknown_component`, `sdui_fallback_used`, `sdui_schema_reject`. |
| Week 2 arc? | Day 08 MVVM search → Day 09 network/security → Day 10 SDUI header/splash. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** N/A for this prompt.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

Back to: [README.md](README.md) · Main questions: [07-revision-qna.md](07-revision-qna.md)

---

## Brain puzzles (cover → think → check)

### Puzzle A — What is BookMyShow backend-driven header & search-A1 and how do you speak it und

**Ask yourself:** What is BookMyShow backend-driven header & search-A1 and how do you speak it under pushback?

**Answer:** “**BookMyShow backend-driven header & search-A1 — How I would apply it:** schema `schemaVersion` gate rejecting incompatible majors to fallback; unknown component **skip** never crash; **empty-root hard fallback**; dual-publish for breaking changes; canary payloads; kill switch to native default. Script: “On BMS we shipped a backend-driven header. Separately, as design, I’d require version gates and unknown skip with hard fallbacks — CMS velocity without those controls becomes crash velocity. I’m not claiming a named production VersionGate service as a resume bullet.”

### Puzzle B — What is the BookMyShow backend-driven header & search STAR in plain steps

**Ask yourself:** What is the BookMyShow backend-driven header & search STAR in plain steps?

**Answer:** “**Situation:** Main header iteration gated by App Store more than necessary. **Action:** Migrated toward generalised protocol-driven main-screen header from CMS/backend; contracted APIs for layout/content flexibility; kept rendering native via structured schema mindset (registry conceptually). Paired with search MVVM improvements on related surfaces. **Result:** Faster content iteration; clearer contracts. **Lesson:** Compatibility design (BookMyShow backend-driven header & search-A1) is what keeps CMS velocity from becoming crash velocity.”

### Puzzle C — What can you claim under Audio streaming + server-driven splash (Aces) for Aces 

**Ask yourself:** What can you claim under Audio streaming + server-driven splash (Aces) for Aces splash?

**Answer:** “Audio streaming + server-driven splash (Aces): Las Vegas Aces **server-driven splash**; cold-start **flexibility and freshness**; context of **live audio streaming** work alongside splash. Treat startup as product surface: cached/flexible content with safe defaults over blocking forever on network. **Do not invent cold-start milliseconds** or latency savings percentages on resume.”
