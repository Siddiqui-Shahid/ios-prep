# 05 — Exercises

> Prefer speaking before peeking.

## A. Conceptual

### A1. Pipeline recall
Draw: CMS → … → native view, including unknown + version reject branches.

**Solution:**
```text
Fetch → Version gate (reject → Fallback)
 → Parse → Registry (unknown → skip+metric)
 → Native views + Action allowlist
 → Fallback: disk LKG / baked default / empty-root hard fallback
```

### A2. S3 vs S3-A1 (two sentences)
**Solution:** S3 verified = backend-driven protocolised header. S3-A1 = schema versioning + unknown fallback spoken as design, not a named shipped runbook bullet.

### A3. T/F
1. Unknown components should crash to alert QA.  
2. Splash should wait indefinitely for fresh CMS.  
3. Actions must be allowlisted.  
4. Invented ms are OK if “about right.”  
5. Empty root after skips needs hard fallback.

**Solution:** 1F 2F 3T 4F 5T

### A4. Provenance rewrite
> “I built VersionGate and cut splash by 400ms with SDUI JS.”

**Solution:** “I worked on BMS backend-driven header and Aces server-driven splash. Schema versioning and unknown-component fallback I’d insist on as design (S3-A1). Splash improved flexibility/freshness — I don’t claim a millisecond figure or JS-eval SDUI.”

## B. Coding

### B1. SchemaVersionGate
Open `code/SchemaVersionGate.swift`. What happens at maxSupported+1?

**Solution:** `rejectTooNew` → caller should fallback.

### B2. Registry chaos
Using `ComponentRegistry`, resolve a tree with one unknown child; assert sibling remains and metric fires.

### B3. FallbackEngine
Explain why `cacheKey` includes userId for personalized headers.

**Solution:** Prevent cross-account cache leak; clear on logout.

## C. Speaking

1. S3 opener 20s + S3-A1 design sentence.  
2. S12 opener 20s without ms.  
3. T2 breaking schema 120s.  
4. T7 Ads vs SDUI 90s.

## D. Whiteboard (5 min)
SDUI HLD + BMS header types you’d register + fallback rules.

## E. Timed drill
Q3, Q4, Q10 + T2, T7. Score with timing guide. Log versioning + unknown policy misses.

## F. Flashcards

| Front | Back |
|---|---|
| SDUI | Schema → native registry · Trap: JS eval · Prod: S3 |
| Unknown | Skip + metric · Trap: crash · Prod: S3-A1 |
| Fallback | LKG + baked · Trap: blank · Prod: S12 |
| Action | Allowlist · Trap: any URL · Prod: security |
| S3-A1 | Design versioning · Trap: overclaim shipped ops · Prod: honesty |


## G. Deeper drills

### G1. Dual-publish narrative (60s)
Speak how you’d roll a breaking header schema without force-upgrading 30L users.

**Solution sketch:** Ship client supporting vN+1 behind capability; backend dual-publishes; canary % on new major; watch schema_reject/unknown metrics; then ramp. Old clients keep vN.

### G2. Minimum splash tree
List 3 nodes that must survive skip storms on Aces-style splash.

**Solution:** Brand/logo; optional legal/age gate if required; primary CTA or enter-app affordance. Promo sparkles are skippable.

### G3. Action allowlist table
Write 5 action types you’d allow and 2 you’d reject.

**Solution allow:** open_deeplink, open_url (https+allowlist host), refresh_module, dismiss, track_event (validated).  
**Reject:** eval_js, open_url with arbitrary scheme, send_sms to CMS-provided number without confirm, raw intent broadcasts.

### G4. Map S3 search vs S3 header
One paragraph: which day owns which beat.

**Solution:** Day 08 owns search MVVM debounce/cancel/states. Day 10 owns header SDUI schema/registry/fallback. Same story ID S3; different interview angles.

### G5. Incident timeline (whiteboard)
Backend ships unknown `type=heroVideoAutoplay` to 100% by mistake. Write T0–T60 minute client+ops response.

**Solution sketch:**  
T0 metrics spike unknown_component / maybe battery complaints if somehow rendered.  
T5 confirm payload; enable kill switch to baked header if available.  
T15 canary rollback server-side; client already skipping if unregistered.  
T30 verify fallback/header chrome healthy; Crashlytics quiet.  
T60 postmortem: dual-publish + canary requirement; contract test gap.

### G6. Privacy cache scenario
User A logs out; User B logs in on same device. What must be true?

**Solution:** Header/splash cache keys differ by user; logout clears A’s keys; B never sees A’s promos or PII-bearing payload.

### G7. Speak Ads contrast (45s)
Without naming invent metrics.

**Solution:** “For revenue media I’d keep pause/play native — S1 HeroWidget — and let SDUI configure placement. Schema shouldn’t own the video lifecycle.”
