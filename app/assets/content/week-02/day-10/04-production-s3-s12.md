# Sample 04 — Production S3, S12, and S3-A1 (Q&A)

> Guided teaching. Verified header/splash stories vs design-labeled compatibility discipline.

---

### Q1. What can you claim under Verified · S3 for the header?

**Points to:** [Production bridge · §1 Provenance map](../03-production-bridge.md#1-provenance-map-for-today) · [Production bridge · §2 Verified S3](../03-production-bridge.md#2-verified-s3--star-23-min)

**Answer:**

> Verified S3 for Day 10: BMS **backend-driven / CMS header**; **generalised, protocol-driven** main-screen implementation; API contracts so many **layout/content changes** didn’t require App Store release when possible. Client stayed **native and structured** — not a WebView rewrite of chrome. Search debounce/MVVM is a **sibling** beat (Day 08) on the same surface family. You may **not** claim JS eval SDUI or that a named VersionGate framework was a resume bullet.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s S3 line? | “Backend-driven header with protocolised client so many layout changes didn’t need a release — I’d pair version gates and fail-soft unknowns as design.” |
| Result? | Faster header content iteration; clearer client contracts. |
| Lesson? | SDUI needs schema/versioning/fallbacks — not just “render JSON.” |

---

### Q2. What is S3-A1 and how do you speak it under pushback?

**Points to:** [Production bridge · §3 S3-A1](../03-production-bridge.md#3-s3-a1--versioning--unknown-fallback-as-design) · [Foundations · §7 Provenance note](../01-foundations.md#7-schema-versioning--60s-picture)

**Answer:**

> **S3-A1 — How I would apply it:** schema `schemaVersion` gate rejecting incompatible majors to fallback; unknown component **skip** never crash; **empty-root hard fallback**; dual-publish for breaking changes; canary payloads; kill switch to native default. Script: “On BMS we shipped a backend-driven header. Separately, as design, I’d require version gates and unknown skip with hard fallbacks — CMS velocity without those controls becomes crash velocity. I’m not claiming a named production VersionGate service as a resume bullet.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| VersionGate type in resume? | S3-A1 design — illustrative code only in learning-lab. |
| Unknown skip verified as named system? | Speak policy; label design unless later verified. |
| “Backend broke schema for everyone”? | Gate + fallback + canary + kill switch — client must survive. |

---

### Q3. What is the Verified S3 STAR in plain steps?

**Points to:** [Production bridge · §2 Verified S3](../03-production-bridge.md#2-verified-s3--star-23-min) · [Deep dive · §8 BMS header](../02-deep-dive.md#8-bms-header-s3--architecture-reading)

**Answer:**

> **Situation:** Main header iteration gated by App Store more than necessary. **Action:** Migrated toward generalised protocol-driven main-screen header from CMS/backend; contracted APIs for layout/content flexibility; kept rendering native via structured schema mindset (registry conceptually). Paired with search MVVM improvements on related surfaces. **Result:** Faster content iteration; clearer contracts. **Lesson:** Compatibility design (S3-A1) is what keeps CMS velocity from becoming crash velocity.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| 60s practice version? | Release-gated header → protocolised CMS header → faster iteration → versioning/fallback design lesson. |
| WebView pushback? | Native registry + schema — WebView is a tool, not the architecture. |
| Skip makes empty UI? | Skip children; empty root → hard fallback; alert on skip rate spikes. |

---

### Q4. What can you claim under Verified · S12 for Aces splash?

**Points to:** [Production bridge · §4 Verified S12](../03-production-bridge.md#4-verified-s12--aces-splash-star-beat) · [Foundations · §9 Aces splash](../01-foundations.md#9-two-production-anchors)

**Answer:**

> Verified S12: Las Vegas Aces **server-driven splash**; cold-start **flexibility and freshness**; context of **live audio streaming** work alongside splash. Treat startup as product surface: cached/flexible content with safe defaults over blocking forever on network. **Do not invent cold-start milliseconds** or latency savings percentages on resume.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| ≤20s S12 line? | “Server-driven splash for cold-start flexibility with safe defaults so startup never depended on perfect network.” |
| Audio vs splash blocking? | Don’t serialize audio init and splash network on one main-thread chain. |
| “What ms did splash save?” | Speak flexibility/freshness — no invented ms. |

---

### Q5. How do you contrast SDUI with native Ads (S1)?

**Points to:** [Production bridge · §6 Topic mapping](../03-production-bridge.md#6-topic-mapping) · [Foundations · §10 SDUI vs Ads](../01-foundations.md#10-sdui-vs-webview-vs-native-ads)

**Answer:**

> “Why not SDUI the ads video?” — **Config/placement** may be CMS-driven; **media lifecycle** (pause/play, memory, viewability) stays **native** per Verified S1 HeroWidget/ads pipeline. Don’t claim Ads was fully SDUI. SDUI header promos may *point* at native ad surfaces — different layers. Strong reply keeps revenue media guarantees separate from layout slots.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| S1 hook? | Type-safe ads pipeline — verified separate story. |
| WebView for ad creative? | Third-party creative URLs are separate from API host whitelist (Day 09). |
| SDUI alone → 99.95%? | Forbidden overclaim — S8 is culture; SDUI skip helps blast radius. |

---

### Q6. What must you never say about Day 10 production stories?

**Points to:** [Production bridge · §1 Forbidden overclaims](../03-production-bridge.md#1-provenance-map-for-today) · [Production bridge · §7 Interviewer pushes](../03-production-bridge.md#7-interviewer-pushes)

**Answer:**

> Never claim: CMS JavaScript eval; invented cold-start ms; S3-A1 as a shipped named framework on resume; SDUI alone produced crash-free rate; Ads video fully SDUI. Always label **Verified · S3 / S12** vs **How I would apply it · S3-A1** when discussing version gates, unknown skip, dual-publish, and kill switches.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Provenance tag S3? | Verified · S3 · BookMyShow · backend-driven header. |
| Provenance tag S12? | Verified · S12 · Raw/Aces · server-driven splash. |
| 3 min practice? | Add unknown skip, dual-publish, cache privacy, Ads contrast, honest S3-A1 label. |

---

### Q7. What should you be able to say after Day 10 sample + modules?

**Points to:** [Foundations · §17 90-second script](../01-foundations.md#17-90-second-teaching-script-record-once) · [Production bridge · §5 Interview lines](../03-production-bridge.md#5-interview-lines-20s)

**Answer:**

> “SDUI is versioned schema mapped to a native registry — unknown types skip with metrics, incompatible majors fall back, actions are allowlisted. On BMS I shipped a backend-driven protocolised header; on Aces a server-driven splash with safe defaults. Schema versioning and unknown fallbacks I’d insist on as design so CMS experiments don’t become crash experiments.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Agenda opener from day README? | Schema + registry + version gates + fail-soft → BMS header + Aces splash → S3-A1 design. |
| Metric to mention? | `sdui_unknown_component`, `sdui_fallback_used`, `sdui_schema_reject`. |
| Week 2 arc? | Day 08 MVVM search → Day 09 network/security → Day 10 SDUI header/splash. |

---

Back to: [README.md](README.md) · Main questions: [../04-questions.md](../04-questions.md)
