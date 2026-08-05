# Audio script — Sample 03 — Cache & scroll performance (Q&A)
> Listen-only sample Q&A from `03-cache-scroll.md`. Spoken answers and follow-ups.

## §0 Q1. Where does caching sit in the SDUI HLD?

Next. Q1. Where does caching sit in the SDUI HLD? Answer. FallbackEngine beside parser/registry/renderer: serves last-good layout from disk when network fails. Flow: CMS → Layout A P I → client → parse/registry/render → cache on success. Online-first default from clarify; cache is resilience + perceived speed — not sole source of truth for irreplaceable user actions. Follow-ups. Cache on every fetch?: Yes — update after successful parse; etag if A P I supports.. Memory vs disk?: Disk for layout JSON survival; NSCache for decoded images in session.. Kill switch?: Remote config disables S D U I → native scaffold — ops closer..

## §1 Q2. What is the SDUI cache/freshness policy?

Next. Q2. What is the SDUI cache/freshness policy? Answer. Last-good layout with TTL and stale-while-revalidate: show cached immediately, fetch in background, swap when fresh arrives. First launch empty cache → native scaffold — don’t white-screen home. Major schema unsupported → disk cache or force-update — product call. Follow-ups. Poison layout?: Validate before cache write; checksum/version gate.. Fallback hit rate metric?: Ops metric — spikes mean A P I/CDN pain.. Splash server-driven?: S12 family — freshness without blocking forever..

## §2 Q3. Unknown component vs cache — how do they interact?

Next. Q3. Unknown component vs cache — how do they interact? Answer. Cache stores parsed layout; on render, unknown types → EmptyView/placeholder + non-fatal metric sdui_unknown_type — never crash the tree. Cached layout with new CMS experiment types still renders partial U I. Server can strip unsupported components for old schema clients. Follow-ups. JSON decode fails entire home?: Refuse — partial decode or component-level tolerance.. Force-update vs cache?: Unsupported major schema — product decision.. S3-A1 label?: Unknown fallback = design judgment hook..

## §3 Q4. How do lists scroll in SDUI — pagination model?

Next. Q4. How do lists scroll in SDUI — pagination model? Answer. Pagination inside list components — cursor fetch_more action, not usually paginating the whole screen JSON. Keep screen payload lean (~50KB gzip mindset). List component requests next page via A P I; renderer appends rows — scroll performance stays native collection/table where possible. Follow-ups. Whole screen pagination?: Rare — heavy initial parse; bad for time-to-first-paint.. Cursor vs offset?: Prefer cursor for feeds — stable under inserts.. S D U I native list host?: Registry maps list type to UICollectionView/List — senior pattern..

## §4 Q5. When do you deep-dive images vs scroll vs cache?

Next. Q5. When do you deep-dive images vs scroll vs cache? Answer. Media-heavy layouts: deep-dive downsample, off-main decode, prefetch — Day 16 family. Otherwise: name image pipeline once; spend dive time on versioning, actions, cache. Scroll jank → mention frame budget, parse off hot path, reuse cells. Timeboxed judgment — don’t draw buttons 20 minutes. Follow-ups. Parse on main thread?: Bad — hitch scroll; background parse + main render.. Hero images in header S D U I?: S3 proof — protocol-driven header; cache tiers.. WebView for list?: Trade-off beat — perf vs iteration speed..

## §5 Q6. Networking mock — where does cache sit?

Next. Q6. Networking mock — where does cache sit? Answer. URLCache / app cache beside URLSession pin layer and Keychain token store. Interceptors handle auth; cache policy per endpoint — GET feed vs never-cache POST. Poison cache and idempotency are failure modes in ops closer. Refresh single-flight prevents stampede — separate from cache but adjacent. Follow-ups. Retry GET from cache?: Stale-while-revalidate pattern for idempotent reads.. POST booking retry?: Idempotency-Key — no blind retry — Q11 in 04.. Pin fail + cached response?: Don’t serve stale over broken trust on sensitive hosts..

## §6 Q7. Scroll + cache ops metrics to mention?

Next. Q7. Scroll + cache ops metrics to mention? Answer. S D U I: layout fetch p50/p90, fallback hit rate, unknown-type rate, journey trace on home scroll, crash free sessions 99.95%+ bar. Networking: journey p50/p90 (S5), pin failure rate, 401/refresh rate. Rollout: flags, phased %, pause if p90 cliffs — I M O C (S 8). Averages alone don’t close a senior mock. Follow-ups. Scroll metric name?: Journey trace home feed — instrument start/stop.. Fallback spike?: CDN/A P I incident signal — ops response.. Next topic?: Scoring — 04-scoring-rubric.md.. Next: 04-scoring-rubric.md.
