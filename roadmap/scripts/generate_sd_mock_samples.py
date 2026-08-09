#!/usr/bin/env python3
"""Generate roadmap/weeks/*/day-*/sample/05-system-design-mock.md for days 01–28."""
from __future__ import annotations

from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
WEEKS = ROOT / "roadmap" / "weeks"

# day -> (week, day_folder)
DAY_PATH = {
    d: (f"week-0{(d-1)//7 + 1}" if d <= 28 else None, f"day-{d:02d}")
    for d in range(1, 29)
}
# Fix week folders: week-01 days 1-7, week-02 8-14, week-03 15-21, week-04 22-28
for d in range(1, 29):
    week_n = (d - 1) // 7 + 1
    DAY_PATH[d] = (f"week-{week_n:02d}", f"day-{d:02d}")


def q(
    n: int,
    title: str,
    answer: str,
    followups: list[tuple[str, str]],
    relate: str,
) -> str:
    rows = "\n".join(f"| {fu} | {ans} |" for fu, ans in followups)
    # Normalize answer blockquotes: ensure each line after first starts with >
    ans = answer.strip()
    ans_lines = []
    for i, line in enumerate(ans.split("\n")):
        line = line.strip()
        if not line:
            continue
        if line.startswith(">"):
            ans_lines.append(line)
        elif i == 0:
            ans_lines.append(f"> {line}")
        else:
            ans_lines.append(f"> {line}")
    ans_block = "\n".join(ans_lines)
    relate_clean = "\n".join(
        ln if ln.startswith("-") or not ln.strip() else ln
        for ln in relate.strip().splitlines()
    )
    return (
        f"### Q{n}. {title}\n\n"
        f"**Answer:**\n\n"
        f"{ans_block}\n\n"
        f"**Follow-ups:**\n\n"
        f"| Follow-up | Answer |\n"
        f"|---|---|\n"
        f"{rows}\n\n"
        f"**How can I relate to my case:**\n"
        f"{relate_clean}\n"
    )


def card(
    *,
    prompt_title: str,
    spec: str,
    angle: str,
    clarify_qs: list[str],
    clarify_outcomes: str,
    hld: str,
    hld_fu: list[tuple[str, str]],
    api: str,
    api_fu: list[tuple[str, str]],
    dive1_title: str,
    dive1: str,
    dive1_fu: list[tuple[str, str]],
    dive2_title: str,
    dive2: str,
    dive2_fu: list[tuple[str, str]],
    ops: str,
    ops_fu: list[tuple[str, str]],
    relate_shipped: str = (
        "- **Concept-only — no shipped story.** Use as interview vocabulary; "
        "hook a named case only if asked for production proof."
    ),
    light: bool = False,
) -> str:
    clarify_block = "\n".join(f"> {i}. {c}" for i, c in enumerate(clarify_qs, 1))

    def short_dive(t: str) -> str:
        s = t.split("—", 1)[-1].strip() if "—" in t else t
        return s.rstrip("?")

    dive1_short = short_dive(dive1_title)
    dive2_short = short_dive(dive2_title)

    header = (
        f"# Sample 05 — System-design mock: {prompt_title} (Q&A)\n\n"
        f"> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer.\n"
        f"> **Source:** [`ios-system-design/docs/{spec}`](../../../../ios-system-design/docs/{spec})"
        f" · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md)\n"
        f"> **Angle:** {angle}\n"
    )

    q1 = q(
        1,
        f'Interviewer: “Design {prompt_title}.” How do you open?',
        (
            f"**Agenda (≤20s):** “I’ll take ~5 minutes clarifying scope and scale, then a four-layer "
            f"client HLD with backend touchpoints and load, then API/data, two deep dives on "
            f"**{dive1_short}** and **{dive2_short}**, and close on failure modes, metrics, and "
            f"kill switches. Does that work?”\n"
            f"**Then ask the interviewer (speak these):**\n"
            + "\n".join(f"{i}. {c}" for i, c in enumerate(clarify_qs, 1))
            + "\nDo **not** draw until they answer or you state **labeled assumptions**. "
            "Keep backend load in mind from the first minute."
        ),
        [
            ("Skip agenda?", "Weak senior signal — interviewer may want different dives."),
            ("Clarify for 15 min?", "Hard stop at 5 — park extras as labeled assumptions."),
            ("They refuse numbers?", "State labeled estimates from DAU context; continue."),
        ],
        relate_shipped,
    )

    q2 = q(
        2,
        "After clarify — what does the optimal flow look like?",
        (
            f"**Scripted outcomes for this mock:** {clarify_outcomes}\n"
            "**Good flow:** agenda → clarify Qs → confirm → HLD (4 layers + backend + load) → "
            "API → two crisp dives → ops last 5.\n"
            "**Weak flow:** silent drawing, happy-path only, no QPS/TTL, invent metrics, skip ops."
        ),
        [
            ("They change scope mid-HLD?", "Re-confirm in/out in 20s; adjust dives; protect ops."),
            ("Backend mesh deep-dive?", "Out unless asked — sketch touchpoints, stay client-owned."),
            (
                "Forgot to ask offline?",
                "State online-first + last-good cache as assumption; invite correction.",
            ),
        ],
        relate_shipped,
    )

    q3 = q(3, "Walk the HLD — client layers, backend, load.", hld, hld_fu, relate_shipped)
    q4 = q(4, "Data / API — entities, endpoints, scale.", api, api_fu, relate_shipped)
    q5 = q(5, dive1_title, dive1, dive1_fu, relate_shipped)
    q6 = q(6, dive2_title, dive2, dive2_fu, relate_shipped)
    q7 = q(7, "Ops — failures, metrics, rollout, load?", ops, ops_fu, relate_shipped)

    q8_answer = (
        "**Light game-day retrieval only:** restate agenda + clarify list; skim HLD bullets — "
        "**do not** invent a new design from scratch."
        if light
        else "**Pass bar:** clarify + agenda in ≤5; HLD shows 4 layers + backend + load; "
        "API has cursors/idempotency as needed; two deep dives; ops with kill switch and "
        "concrete metrics."
    )
    q8 = q(
        8,
        "Flow scorecard — did you hit the optimal spine?",
        (
            f"{q8_answer}\n"
            "**Anti-patterns:** offset pagination on dynamic feeds; main-thread SQLite/decode; "
            "inventing QPS as fact; never reaching ops; blob “architecture” with no data flow.\n"
            "**Spine:** 0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops."
        ),
        [
            ("Ran long on dive 1?", "Park dive 2 bullets; protect ops 5 min."),
            ("Forgot load?", "One sentence: DAU → labeled QPS, cursor cost, single-flight."),
            ("Invented crash-free %?", "Forbidden — use resume-backed numbers or label as target."),
        ],
        "- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.",
    )

    # clarify_block unused after rewrite — silence lint via del
    del clarify_block

    return "\n---\n\n".join([header, q1, q2, q3, q4, q5, q6, q7, q8]) + "\n"


# ---------------------------------------------------------------------------
# Day content
# ---------------------------------------------------------------------------

DAYS: dict[int, dict] = {}

DAYS[1] = dict(
    prompt_title="Infinite Social Feed",
    spec="social-feed.md",
    angle="Week 1 Day 01 — **scope & clarify** muscle (Parallel SD: Social feed scope).",
    clarify_qs=[
        "In scope: infinite scroll text/image posts with likes — or also video / live ranking?",
        "Approximate DAU or peak concurrent scrollers? (I’ll label QPS estimates if needed.)",
        "Offline required, or online-first with last ~200 posts cached?",
        "iOS-only for this round?",
        "Pagination latency SLO — e.g. <500ms p99 for next page?",
        "Write load: like/comment rate vs read-heavy feed?",
        "Out of scope OK: ML ranking, WebSocket “new posts” pill unless you want it?",
    ],
    clarify_outcomes="iOS social feed; cursor pagination; online-first + SQLite last ~200; ~30L DAU consumer context labeled; out: video streaming + ranking ML.",
    hld="""**Presentation:** UICollectionView + DiffableDataSource (or SwiftUI List with stable IDs).
> **Domain:** FeedViewModel — paging state, optimistic likes, impression dwell.
> **Data:** FeedRepository coordinates Network + SQLite cache.
> **Platform:** URLSession, image pipeline (decode off main), analytics batcher.
> **Backend touchpoints:** Feed service behind API gateway/CDN; like mutation API; impression ingest (not ranking).
> **Load:** Prefer **cursor** (`after_cursor`, limit 15–20) — O(1) server cost vs offset. Prefetch next page ~70% scroll. Cache TTL ~5 min; JSON ~8–12KB/page. Labeled QPS from DAU × sessions × pages/session — never fake precision.""",
    hld_fu=[
        ("Four layers names?", "Presentation · domain/use cases · data/network · platform — adapt naming."),
        ("Offset pagination?", "Reject for dynamic feeds — inserts skip/duplicate; O(n) deep pages."),
        ("Where is CDN?", "Image/media CDN; feed JSON may be edge-cached briefly — say invalidate on publish if asked."),
    ],
    api="""**Entities:** Post (id, author, text, media thumbs, likeCount, cursor), LikeAction, ImpressionEvent.
> **Endpoints:** `GET /v1/feed?limit=20&after_cursor=` · `POST /v1/posts/{id}/like` (idempotent client UUID optional).
> **Scale:** Page 15–20; field-mask thumbs not full images; `Accept-Encoding: gzip`. Impressions batched — not per-frame.
> **Consistency:** Cursor opaque; mid-scroll inserts don’t shift offsets.""",
    api_fu=[
        ("Pull-to-refresh?", "New head request; merge with cursor continuity; avoid wiping in-flight page."),
        ("Like storms?", "Optimistic UI; server dedupe; client single-flight per post id."),
    ],
    dive1_title="Deep dive 1 — Cursor pagination & prefetch?",
    dive1="""Trigger next page ~70% scroll depth; cancel/coalesce duplicate page requests; keep one in-flight next-page task.
> Prefetch image thumbs via image pipeline for upcoming cells. Never decode full-res on main.
> If page fails: keep existing list, show inline retry — don’t blank the feed.""",
    dive1_fu=[
        ("User at top with new posts?", "“New posts” pill or insert only when near top — don’t jump scroll position."),
        ("Prefetch stampede?", "Single-flight page task + generation token on reload."),
    ],
    dive2_title="Deep dive 2 — Optimistic like + offline cache?",
    dive2="""Optimistic like flips UI immediately; persist intent; on failure rollback Diffable snapshot + toast.
> Offline: load last ~200 from SQLite off main thread; show Offline/Cached badge; queue like if product allows.
> Impressions: ≥50% visible for ≥1s — batch upload.""",
    dive2_fu=[
        ("SQLite on main?", "Never — background/async; hop to MainActor for UI."),
        ("OOM while scrolling?", "Clear L1 image cache; keep feed text models."),
    ],
    ops="""**Metrics:** scroll hitch rate, TTFF cached <1s target, cache hit >80%, page p99, like success rate.
> **Failures:** 5xx → show SQLite + Cached; empty first launch offline → native empty + retry.
> **Rollout:** flag to disable prefetch aggressiveness; kill switch → shorter page size.
> **Load:** after outage, jittered backoff so clients don’t thundering-herd the feed origin.""",
    ops_fu=[
        ("Invent QPS?", "Forbidden as fact — DAU + labeled estimate only."),
        ("Kill switch?", "Remote config: disable video/heavy media; reduce prefetch."),
    ],
    relate_shipped="""- **Design if asked:** Feed caching/pagination judgment — label design, not a claimed BMS feed rewrite.
- **Shipped hooks if asked for lists:** BookMyShow listing/search instrumentation instincts (Firebase Performance) — not feed product ownership.
- **Don’t claim:** Invented feed QPS or ranking ownership.""",
)

DAYS[2] = dict(
    prompt_title="Server-Driven UI Engine",
    spec="sdui-engine.md",
    angle="Day 02 — typed **ComponentRegistry** (POP/generics parallel).",
    clarify_qs=[
        "Which surfaces — home header/splash-style screens, or entire app shell?",
        "DAU / how often layouts refresh from CMS?",
        "Online-first with last-good disk cache, or offline-first?",
        "iOS-only?",
        "Unknown component policy — skip vs hard fail?",
        "Schema versioning — major mismatch force update?",
        "Out of scope: CMS admin UI and executing JS on device?",
    ],
    clarify_outcomes="iOS SDUI for CMS-driven surfaces; online-first + last-good cache; unknown → EmptyView; out: CMS admin, client JS.",
    hld="""**Layers:** Screen VC/SwiftUI → SDUI ViewModel → Parser/Registry/LayoutResolver → Network + FallbackEngine disk.
> **Backend:** CMS → Layout API → CDN/gateway → client. Payload <50KB gzip target.
> **Load:** `refresh_ttl` e.g. 3600s; stale-while-revalidate; don’t refetch every scroll frame. Parse <16ms to avoid hitch.""",
    hld_fu=[
        ("Where is type safety?", "Registry maps string type → native builder; unknown types no-crash."),
        ("Backend CMS?", "Out — you own client contract + fallbacks."),
    ],
    api="""`GET /v1/screens/{screenId}` with Client-Version / schema version headers.
> Tree of components: type, props, children, actions, analytics payload.
> Nested `fetch_more` for lists — don’t invent a full scripting language.""",
    api_fu=[
        ("Breaking schema?", "Major version bump; unsupported → cache or force-update screen."),
        ("Payload too large?", "Split screens; field-mask; gzip; CDN."),
    ],
    dive1_title="Deep dive 1 — ComponentRegistry & unknown types?",
    dive1="""Dictionary type → `AnyView`/UIView builder. Missing type → EmptyView + metric `unknown_component`.
> Prefer protocol + generics for prop decoding where possible — fail soft per node, not whole tree.""",
    dive1_fu=[
        ("Crash on unknown?", "Never — skip node; keep siblings."),
        ("POP link?", "Registry as composition of typed factories — Day 02 vocabulary."),
    ],
    dive2_title="Deep dive 2 — FallbackEngine & schema versioning?",
    dive2="""On success: write last-good JSON to disk. On network fail: serve disk (<50ms target).
> Version gate: skip unsupported majors; remote kill switch → native scaffold.""",
    dive2_fu=[
        ("Empty first launch offline?", "Native scaffold + retry — don’t crash."),
        ("Stale layout forever?", "TTL + force-refresh path; show subtle stale if needed."),
    ],
    ops="""schema_fetch_latency, cache_hit, unknown_component count, crash-free on SDUI surfaces.
> Kill switch: remote config disables SDUI → native. Timeout → disk cache.""",
    ops_fu=[
        ("Force update UX?", "Only on unsupported major — don’t brick minors."),
        ("Relate production?", "BookMyShow backend-driven header & search / Aces splash — design judgment + verified hooks."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow backend-driven header & search; Audio streaming + server-driven splash (Aces) family.
- **Don’t claim:** You built the entire CMS.""",
)

DAYS[3] = dict(
    prompt_title="Image Loading Library",
    spec="image-loading-library.md",
    angle="Day 03 — **memory / decode** (ARC & Instruments parallel).",
    clarify_qs=[
        "In scope: download + decode + L1/L2 cache + cancel on reuse — or also GIF/video?",
        "Memory budget for decoded L1 (e.g. ~50MB)?",
        "CDN only GET, or custom image API?",
        "Must support WebP/AVIF accept negotiation?",
        "Out of scope: upload, editing, CDN architecture?",
        "Cell reuse cancel required?",
    ],
    clarify_outcomes="Still-image pipeline; L1 ~50MB NSCache + disk ~500MB; cancel on reuse; out: GIF/video decode, upload, CDN design.",
    hld="""**Pipeline:** URL → (dedupe) → L1 NSCache → L2 disk → network CDN → ImageIO downsample → display.
> **Threads:** download/decode off main; MainActor only for UIImage assignment.
> **Load:** Cache-Control max-age ~7d; Accept webp/avif; decoded cost = width×height×4 — always downsample to view size.""",
    hld_fu=[
        ("Where ARC bites?", "Retain cycles in completion handlers; cancel tokens on deinit/reuse."),
        ("Three tiers?", "Memory / disk / network — write-around for decoded often."),
    ],
    api="""`GET {image_url}` with Cache-Control. Library API: `load(url, targetSize, priority) → Task` cancelable.
> Dedupe identical in-flight URLs; priority boost for on-screen.""",
    api_fu=[
        ("Same URL two cells?", "One download; fan-out completions."),
        ("Auth images?", "Inject headers via session; don’t put tokens in URL query if avoidable."),
    ],
    dive1_title="Deep dive 1 — 3-tier cache?",
    dive1="""L1 cost-based NSCache (~50MB) responds to memory warnings. L2 disk LRU (~500MB). Network last.
> Combined hit target >80%; L1 >40%.""",
    dive1_fu=[
        ("Memory warning?", "Clear L1; keep disk."),
        ("Disk full?", "LRU free ~20%; continue."),
    ],
    dive2_title="Deep dive 2 — Downsample, dedupe, cancel?",
    dive2="""ImageIO create thumbnail at display size — never full decode then scale.
> Cancel on `prepareForReuse`; generation token ignores stale completions. Decode p50 <10ms / p99 <50ms targets from spec.""",
    dive2_fu=[
        ("GIF asked?", "Out of scope unless pulled — separate decoder + memory budget."),
        ("Main-thread decode?", "Classic hitch — always background."),
    ],
    ops="""L1/L2 hit rates, decode latency, OOM rate <0.1% target, scroll hitch.
> Kill: disable high-res prefetch under memory pressure.""",
    ops_fu=[
        ("HeroWidget link?", "Pause/cancel media on disappear — same cancel discipline."),
        ("Instruments?", "Allocations + Time Profiler for decode spikes — Day 03 tools."),
    ],
    relate_shipped="""- **Shipped instincts:** BookMyShow Ads / HeroWidget lifecycle — cancel and visibility discipline.
- **Don’t claim:** You wrote Kingfisher/SDWebImage.""",
)

DAYS[4] = dict(
    prompt_title="Offline-First Sync Engine",
    spec="offline-sync-engine.md",
    angle="Day 04 — **queues / concurrency** (GCD & thread-safety parallel).",
    clarify_qs=[
        "Which domain entities sync — notes, cart, settings?",
        "Conflict policy — LWW OK, or need OT/CRDT?",
        "DAU and expected dirty-queue depth at peak?",
        "BGAppRefresh required?",
        "Auth in scope or assume tokens exist?",
        "Out: rich media upload pipeline?",
    ],
    clarify_outcomes="SQLite source of truth; push-then-pull delta; LWW; batch ≤50; BG ≤30s; out: OT collab, media upload.",
    hld="""**Actor SyncEngine** serializes push→pull; Feature VMs read SQLite.
> **Backend:** `/sync/push` + `/sync/pull?since=` with sync_token cursor.
> **Load:** Batch ≤50 records; min BG interval ~15m; local R/W <50ms; don’t block UI — Day 04 queue discipline.""",
    hld_fu=[
        ("Why actor vs serial queue?", "Compile-time isolation; same single-writer idea as SafeDict."),
        ("Pull before push?", "Prefer push then pull to reduce lost local writes."),
    ],
    api="""`POST /v1/sync/push` body: dirty records + client timestamps.
> `GET /v1/sync/pull?since=&limit=100` → server changes + new sync_token.
> Tombstones for deletes; idempotent record ids.""",
    api_fu=[
        ("Invalid token?", "Full resync path — rare, metric it."),
        ("Partial push failure?", "Retry batch with backoff; don’t clear dirty until ACK."),
    ],
    dive1_title="Deep dive 1 — SyncEngine actor & dirty flags?",
    dive1="""Single-flight sync task; coalesce triggers (foreground, reachability, manual).
> Optimistic UI reads local first; mark dirty; sync async.""",
    dive1_fu=[
        ("Concurrent syncs?", "Actor prevents — one pipeline."),
        ("GCD barrier analog?", "Same exclusive writer mental model as Day 04 barriers."),
    ],
    dive2_title="Deep dive 2 — BG tasks & LWW conflicts?",
    dive2="""BGAppRefresh budget ~30s — batch and checkpoint. LWW via server timestamp; surface conflict UI only if product requires.
> Tombstones until pull confirms.""",
    dive2_fu=[
        ("OT asked?", "Out — say collaborative editor is a different prompt."),
        ("Battery?", "<2%/day sync budget target from spec — batch aggressively."),
    ],
    ops="""Sync success >99.5% target, p99 <5s, dirty queue length alerts, BG completion rate.
> Kill: pause sync; read-only local.""",
    ops_fu=[
        ("Thundering herd online?", "Jitter reconnect; exponential backoff."),
        ("Relate S2?", "Thread-safe shared state — sync actor as production-shaped answer."),
    ],
    relate_shipped="""- **Design if asked:** Offline sync — label design.
- **Shipped parallel:** Synchronised dictionaries / actor migration instincts (BookMyShow concurrency stories).""",
)

DAYS[5] = dict(
    prompt_title="Infinite Social Feed",
    spec="social-feed.md",
    angle="Day 05 — **Feed HLD** with async/await & actors (Parallel SD).",
    clarify_qs=[
        "Same feed scope as Day 01 — confirm cursor + offline cache?",
        "DAU / peak?",
        "Structured concurrency for page+image tasks OK?",
        "Actor for like coordinator?",
        "Out: video + ranking?",
    ],
    clarify_outcomes="Full client HLD for feed; async page tasks; actor for like single-flight; out: video/ranking.",
    hld="""Same 4 layers as Day 01, but call out **Task** trees: parent screen task cancels on disappear; page fetch child; image loads detached with priority.
> **LikeActor** serializes per-post mutations. Repository `async` APIs; MainActor UI.
> **Backend/load:** unchanged — cursor pages, CDN images, TTL 5m.""",
    hld_fu=[
        ("GCD vs async?", "Prefer structured concurrency for page lifecycle; GCD OK inside image decode pools."),
        ("Sendable feed models?", "Value models across actors; no UIKit in domain."),
    ],
    api="""Same `GET /v1/feed` + `POST like`. Emphasize cancellation: ignore stale page if newer pull-to-refresh started (generation token).""",
    api_fu=[
        ("Race two pages?", "Generation token / task cancel — Day 05 race vocabulary."),
        ("Actor reentrancy?", "Keep like actor work short; hop out for network."),
    ],
    dive1_title="Deep dive 1 — Structured concurrency for paging?",
    dive1="""`async let` / task group for parallel thumb prefetch of a page; cancel on scroll away.
> Don’t unstructured `Task {}` without tying to view lifetime.""",
    dive1_fu=[
        ("Priority inversion?", "Match QoS; avoid sync waits on main."),
        ("Prefetch actor?", "Optional ImagePipeline actor — single flight URLs."),
    ],
    dive2_title="Deep dive 2 — Optimistic like actor?",
    dive2="""Actor owns in-flight like set; UI awaits result; rollback on throw.
> Offline queue as separate durable store — actor coordinates drain.""",
    dive2_fu=[
        ("Many likes spam?", "Coalesce toggle; last state wins to server."),
        ("MainActor isolation?", "UI state on MainActor; network off."),
    ],
    ops="""Same feed ops + concurrency metrics: cancelled task rate, like actor wait time.
> Kill: disable parallel thumb prefetch under thermal.""",
    ops_fu=[
        ("Hang from await on main?", "Never block main with sync network."),
        ("Day 21 link?", "Same spine — deepen API/ops later."),
    ],
    relate_shipped="""- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.""",
)

DAYS[6] = dict(
    prompt_title="Search Autocomplete",
    spec="search-autocomplete.md",
    angle="Day 06 DSA day — still a full **search** SD mock (debounce ≈ cancel in-flight).",
    clarify_qs=[
        "Autocomplete only, or full results page too?",
        "Offline Trie/FTS required?",
        "DAU and peak QPS on typeahead?",
        "Latency SLO — p99 <200ms remote?",
        "Debounce interval expectation (e.g. 300ms)?",
        "Out: ML ranking / ES internals?",
    ],
    clarify_outcomes="Autocomplete + full results; debounce 300ms; cancel in-flight; offline Trie/FTS; out: ML ranking.",
    hld="""**UI** Search bar → ViewModel → **local Trie/recent** first → remote autocomplete → results list with cursor.
> **Backend:** autocomplete service (often Redis/ES) + search service behind gateway.
> **Load:** Debounce 300ms cuts QPS massively; limit 10 suggest / 20 results; drop stale by request_id.""",
    hld_fu=[
        ("Why local first?", "Perceived latency <10ms; works offline."),
        ("DSA link?", "Two-pointer/window intuition ≠ Trie — say cancel/debounce maps to concurrency story."),
    ],
    api="""`GET /v1/search/autocomplete?q=&limit=10`
> `GET /v1/search/results?q=&cursor=&limit=20`
> Client sends monotonic `request_id`; ignore older responses.""",
    api_fu=[
        ("Empty query?", "Show recent/local only — no remote storm."),
        ("Rate limit 429?", "Backoff; keep last good suggestions."),
    ],
    dive1_title="Deep dive 1 — Debounce + cancel?",
    dive1="""Timer 300ms; cancel previous `URLSessionTask`/`Task`; race guard with request_id.
> Maps to interview line: cancel in-flight work (BMS search instincts) — not an algorithm brag.""",
    dive1_fu=[
        ("Leading vs trailing debounce?", "Trailing for search — wait until pause."),
        ("Parallel results fetch?", "Only after submit or explicit results mode."),
    ],
    dive2_title="Deep dive 2 — Trie + FTS5 offline?",
    dive2="""Recent queries in Trie/memory; catalog slice in SQLite FTS5 (<10MB target).
> Sync index on foreground with version/ETag.""",
    dive2_fu=[
        ("Index too big?", "Shard by category; trim rare terms."),
        ("Security?", "Don’t put PII in analytics query text raw."),
    ],
    ops="""Autocomplete p50/p99, zero-result rate, offline freshness, cancel rate.
> Kill: disable remote typeahead → local only.""",
    ops_fu=[
        ("Thundering herd?", "Debounce + jitter on reconnect."),
        ("Invent CTR?", "Forbidden."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow backend-driven header & search — debounce/cancel instincts.
- **Don’t claim:** You own ES ranking.""",
)

DAYS[7] = dict(
    prompt_title="Infinite Social Feed",
    spec="social-feed.md",
    angle="Day 07 Mock #1 — **full LLD mock** (Feed LLD Parallel SD).",
    clarify_qs=[
        "Confirm feed vs networking/SDUI prompt for this mock?",
        "DAU, offline, iOS-only?",
        "Which two dives — pagination/prefetch + optimistic like?",
        "Impressions required?",
        "Out: video, ranking, WebSocket?",
    ],
    clarify_outcomes="Full 45‑min feed mock; dives: pagination/prefetch + optimistic like/offline; impressions batched; out: video/ranking.",
    hld="""Draw end-to-end: CDN images → Feed API → Repository (SQLite + network) → VM → Diffable list.
> Call out memory <150MB, 60 FPS, page <500ms p99, TTL 5m, last 200 offline — from spec NFRs.
> **Load:** cursor pages 15–20; prefetch one page; single-flight refresh.""",
    hld_fu=[
        ("Timebox HLD?", "≤10 min — then API."),
        ("Skip backend?", "At least gateway + feed + like + analytics — one box each."),
    ],
    api="""Full contract: feed page JSON shape, cursor opaque, like POST, impression batch POST.
> Error model: retry idempotent GET; careful POST like.""",
    api_fu=[
        ("Idempotent like?", "Client mutation id or server toggle semantics — state aloud."),
        ("Field masking?", "List payload thumbs only."),
    ],
    dive1_title="Deep dive 1 — Pagination LLD?",
    dive1="""State machine: idle → loading → loaded/failed; append vs reset; prefetch threshold; generation token.
> Diffable: append snapshots without full reload.""",
    dive1_fu=[
        ("Duplicate IDs?", "Merge by id; stable identity."),
        ("Scroll jump?", "Avoid reloadData; animate append."),
    ],
    dive2_title="Deep dive 2 — Optimistic like LLD?",
    dive2="""Local state → UI → network → commit/rollback; offline queue; conflict if server unlike.
> Threading: DB off main; UI MainActor.""",
    dive2_fu=[
        ("Double tap?", "Debounce UI; one in-flight."),
        ("Analytics?", "Impression ≠ like; separate pipelines."),
    ],
    ops="""Full ops closer: hitch, TTFF, cache hit, like success, 5xx degrade, kill prefetch, rollout flag.
> Self-score clarify/HLD/dives/ops after mock.""",
    ops_fu=[
        ("Mock #3 difference?", "Day 21 is SDUI/networking 45‑min staff mock — same spine."),
        ("Sync-dict story?", "≤3 min production bridge if behavioral pulled — not inside SD."),
    ],
    relate_shipped="""- **Design:** Full feed LLD.
- **Production bridge separate:** Sync-dict ≤3 min story for Mock #1 coding/iOS segment — don’t conflate.""",
)

DAYS[8] = dict(
    prompt_title="App Modularization & DI",
    spec="app-modularization.md",
    angle="Day 08 — architecture modules (MVVM/Clean parallel).",
    clarify_qs=[
        "Monorepo feature modules or multi-repo?",
        "SPM only, or CocoaPods mix?",
        "Build time budget (incremental <30s)?",
        "DI style — constructor, Needle, Factory?",
        "Dynamic frameworks limit concern?",
        "Out: full CI scripts / git branching?",
    ],
    clarify_outcomes="App→Feature→Domain→Core; Interface vs Impl; composition-root DI; static preferred; out: CI deep dive.",
    hld="""**Topology:** App composition root wires Feature interfaces; Features depend on Domain protocols; Core = network/storage/design system.
> **No feature→feature Impl deps.** Backend N/A beyond shared Network client.
> **Load/build:** 100–300 modules possible; incremental <30s target; ≤~6 dynamic historically — prefer static.""",
    hld_fu=[
        ("Clean vs modules?", "Modules are boundaries; Clean/MVVM live inside features."),
        ("Circular deps?", "Break with Interface modules — compile-time fail is good."),
    ],
    api="""Protocol contracts: `CheckoutBuildable`, `CheckoutDependency`. Factory/Needle components at composition root.
> Network as `APIClientProtocol` in Core — features never import URLSession directly if avoidable.""",
    api_fu=[
        ("Test seams?", "Swap Impl in tests via Interface."),
        ("Binary size?", "Track mb; avoid duplicate symbols across dynamics."),
    ],
    dive1_title="Deep dive 1 — Interface / Impl split?",
    dive1="""FeatureAInterface exposed to App; FeatureAImpl private. Prevents secretly coupled features and speeds compile.""",
    dive1_fu=[
        ("Who owns navigation?", "App coordinator depends on buildable interfaces."),
        ("Shared UI kit?", "DesignSystem in Core — version carefully."),
    ],
    dive2_title="Deep dive 2 — Composition-root DI?",
    dive2="""Construct graph once at launch; pass dependencies down. Avoid service locators in features.
> Needle/Factory trees mirror module graph.""",
    dive2_fu=[
        ("Runtime optional deps?", "Protocols + null objects; still wired at root."),
        ("District migration?", "Clean/MVVM migration = boundaries + review bar — District Free Parking story."),
    ],
    ops="""build_time_seconds, binary_size_mb, dyld_launch_time. Fail CI on new circular deps.
> Kill: feature flag whole module entry points.""",
    ops_fu=[
        ("Launch regression?", "Fewer dynamics; defer non-critical modules."),
        ("Sev-1 bad module?", "Flag off surface; hotfix train — platform EM vocabulary."),
    ],
    relate_shipped="""- **Shipped:** District Free Parking + Clean/MVVM + AI tooling (architecture migration judgment).
- **Stories SDK:** module boundary instincts (Raw / Miami Heat).""",
)

DAYS[9] = dict(
    prompt_title="Networking Layer / HTTP Client",
    spec="networking-layer.md",
    angle="Day 09 — Parallel SD Networking layer.",
    clarify_qs=[
        "REST URLSession client with interceptors — GraphQL/WS out?",
        "Auth refresh + SSL pinning in scope?",
        "DAU and peak RPS to origin?",
        "Timeout defaults (~30s)?",
        "Offline cache layer in or out?",
        "iOS-only?",
    ],
    clarify_outcomes="URLSession APIClient; auth interceptor; single-flight refresh; SPKI pinning; retries on idempotent GET; out: GraphQL/WS, image SDK.",
    hld="""Features → APIClient (build→intercept→execute→decode→map errors) → Auth/Retry/Tracing → URLSession + SPKI + allowlist → URLCache/Keychain.
> **Backend:** API gateway; `/auth/refresh`.
> **Load:** HTTP/2 multiplex; gzip; timeout ~30s; paginate huge JSON; pin rotation 60–90d.""",
    hld_fu=[
        ("Alamofire?", "Prefer URLSession when owning trust/pinning — BMS migration story."),
        ("Where pinning sits?", "URLSessionDelegate challenge — before bytes."),
    ],
    api="""`APIEndpoint` + `request(_:) async throws`. 401 → refresh coordinator; retry 408/429/5xx on idempotent GET only; never blind-retry charge POST.""",
    api_fu=[
        ("Idempotency-Key?", "For mutations that must be exactly-once."),
        ("Tracing?", "X-Request-ID on all calls."),
    ],
    dive1_title="Deep dive 1 — Interceptor pipeline?",
    dive1="""Ordered interceptors: auth header → retry → tracing. Decode Codable on background; map to domain errors.""",
    dive1_fu=[
        ("URLProtocol tests?", "Inject fakes without hitting network."),
        ("Priority/cancel?", "Task cancel propagates to URLSessionTask."),
    ],
    dive2_title="Deep dive 2 — Single-flight 401 refresh?",
    dive2="""N parallel 401s → one actor-owned refresh; waiters await; success retries once; failure → logout clear Keychain.""",
    dive2_fu=[
        ("Refresh 401?", "Logout — avoid infinite loop."),
        ("Pin mismatch?", "Fail closed; backup pins + rotation design."),
    ],
    ops="""p50/p90/p99, 5xx rate, refresh fail→logout, pin fail metrics. Kill: loosen retries; break-glass pin design (label design vs shipped).""",
    ops_fu=[
        ("Thundering herd?", "Jitter backoff ≤3 retries."),
        ("Production?", "BookMyShow SSL pinning + URLSession migration Ads proof."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow SSL pinning + URLSession migration (Ads networking).
- **Don’t claim:** Invented pin rotation runbook if not shipped — say design.""",
)

DAYS[10] = dict(
    prompt_title="Server-Driven UI Engine",
    spec="sdui-engine.md",
    angle="Day 10 — Parallel SD SDUI engine (full contract).",
    clarify_qs=[
        "Home/header/splash surfaces vs whole app?",
        "DAU and layout refresh cadence?",
        "Online-first + last-good cache?",
        "Deep dives: schema versioning+fallback and action routing?",
        "Out: CMS admin, JS execution?",
    ],
    clarify_outcomes="SDUI engine client; schema versioning; FallbackEngine; ActionHandler; out: CMS/JS.",
    hld="""CMS → Layout API/CDN → Network → Parser → Version check → Registry → LayoutResolver → SwiftUI/UIKit → ActionHandler + analytics.
> **Load:** <50KB gzip; parse <16ms; cache <50ms; refresh_ttl; stale-while-revalidate.""",
    hld_fu=[
        ("Native vs SDUI trade-off?", "SDUI for CMS velocity; native for critical path performance."),
        ("Ads HeroWidget?", "Protocolised native widgets can sit beside SDUI nodes."),
    ],
    api="""Screen JSON tree; actions: deeplink, API, dismiss; analytics envelopes server-defined.
> Client-Version header; force-refresh query.""",
    api_fu=[
        ("A/B layouts?", "Server returns experiment component tree; client logs exposure."),
        ("Nested lists?", "fetch_more contract — don’t boil pagination inside every node."),
    ],
    dive1_title="Deep dive 1 — Schema versioning + unknown fallback?",
    dive1="""Major mismatch → force update or last-good. Unknown component → EmptyView + metric. Never crash parse of one bad node.""",
    dive1_fu=[
        ("Partial tree fail?", "Drop node; render rest."),
        ("Migration?", "Additive props first; breaking = major."),
    ],
    dive2_title="Deep dive 2 — Action routing?",
    dive2="""ActionHandler routes deeplink/native/web; validates allowlist; fires analytics then navigate.
> Fail soft on unknown action type.""",
    dive2_fu=[
        ("Open redirect?", "Allowlist hosts/schemes."),
        ("Offline action?", "Queue or disable with UI."),
    ],
    ops="""fetch latency, cache hit, unknown_component, crash-free. Kill → native scaffold.""",
    ops_fu=[
        ("Production?", "BMS backend-driven header; Aces splash."),
        ("Day 21?", "Reuse this spine in Mock #3."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow backend-driven header & search; Aces server-driven splash.""",
)

DAYS[11] = dict(
    prompt_title="Deep Linking & Universal Links",
    spec="deep-linking-universal-links.md",
    angle="Day 11 — hybrid UI / deeplink router parallel.",
    clarify_qs=[
        "Universal Links + custom schemes both?",
        "Deferred links after install?",
        "Cold-start queue required?",
        "Auth-gated routes?",
        "Out: push payload design, Android App Links?",
    ],
    clarify_outcomes="UL + schemes; router+coordinator; cold-start pendingRoute; deferred optional; out: push deep design.",
    hld="""OS openURL → AppDelegate/Scene → DeepLinkRouter match → Coordinator navigate. If UI not ready (<500ms), queue pendingRoute.
> **Backend:** AASA hosted; deferred fingerprint API.
> **Load:** AASA <128KB; OS caches ~24h; routing <100ms target.""",
    hld_fu=[
        ("Hybrid UIKit/SwiftUI?", "One router owns path — Grizzlies interop lesson."),
        ("Push vs deeplink?", "Same router — don’t fork navigation."),
    ],
    api="""AASA at `/.well-known/apple-app-site-association`. `GET /v1/deep-link/deferred?fingerprint=`.
> Route table: pattern → builder.""",
    api_fu=[
        ("Unsigned links?", "Validate path allowlist; strip dangerous query."),
        ("AASA fail?", "Smart Banner / custom scheme fallback."),
    ],
    dive1_title="Deep dive 1 — Router + Coordinator?",
    dive1="""Parse URL → typed Route → Coordinator presents. Unknown route → metric + home fallback.""",
    dive1_fu=[
        ("Auth wall?", "Queue route post-login."),
        ("Multiple windows?", "Scene-aware routing."),
    ],
    dive2_title="Deep dive 2 — Deferred + cold-start queue?",
    dive2="""Pending route until root ready; deferred match within ~72h; fail → organic open.""",
    dive2_fu=[
        ("Race login?", "Hold route until session."),
        ("Hijack?", "HTTPS UL preferred over custom schemes."),
    ],
    ops="""Open rate, unknown route %, routing latency. Kill: disable deferred; UL only.""",
    ops_fu=[
        ("Production?", "Hybrid UI / deeplinks Verified — Grizzlies."),
        ("Mixpanel/Airship?", "Push taps through same router."),
    ],
    relate_shipped="""- **Shipped:** Memphis Grizzlies Hybrid UI / deeplinks; Mixpanel/Airship routing discipline.""",
)

DAYS[12] = dict(
    prompt_title="Short-form Video Feed",
    spec="video-feed-streaming.md",
    angle="Day 12 — SwiftUI lists / identity parallel (player pool).",
    clarify_qs=[
        "Short-form vertical feed — record/upload out?",
        "DAU and bitrate caps on cellular?",
        "AVPlayer pool size (e.g. 3)?",
        "Low Power / thermal guards?",
        "Cursor pagination OK?",
    ],
    clarify_outcomes="3-player pool; prefetch ~80%; ABR + Low Power; cursor feed; out: upload/transcode.",
    hld="""Feed VM → page cursor → AVPlayerPool (prev/current/next) → Video CDN. Thumb pipeline separate.
> **Backend:** Feed service + Redis; Video CDN.
> **Load:** limit 10; JSON <15KB; ~15MB/player; memory <150MB; TTFF <300ms target.""",
    hld_fu=[
        ("Why pool?", "Avoid alloc/teardown hitch each swipe."),
        ("SwiftUI identity?", "Stable IDs for cells; don’t recreate players on identity churn."),
    ],
    api="""`GET /v1/feed?cursor=&limit=10` with stream URLs + thumb. Optional `X-Network-Quality`.""",
    api_fu=[
        ("Tokenized CDN URLs?", "Refresh before expiry; don’t log secrets."),
        ("Prefetch bytes?", "One ahead; not entire catalog."),
    ],
    dive1_title="Deep dive 1 — AVPlayerPool sliding window?",
    dive1="""Keep prev/current/next; on swipe recycle farthest; pause offscreen. OOM → empty pool.""",
    dive1_fu=[
        ("Cell reuse?", "Detach player; clear; generation token."),
        ("Background?", "Pause all; release some."),
    ],
    dive2_title="Deep dive 2 — Prefetch + ABR?",
    dive2="""PrefetchEngine at ~80% progress; NWPathMonitor drops to 240p (~200Kbps) on poor path; Low Power disables prefetch.""",
    dive2_fu=[
        ("Stall metric?", "<1% views target; drop quality."),
        ("Audio session?", "Mix/duck policy explicit."),
    ],
    ops="""TTFF, stall rate, thumb cache >95%, memory. Kill: force 240p; disable autoplay.""",
    ops_fu=[
        ("HeroWidget pause?", "Same disappear/offscreen pause contract."),
        ("Stories SDK?", "List identity + media lifecycle."),
    ],
    relate_shipped="""- **Shipped instincts:** HeroWidget lifecycle pause; Stories SDK list identity.
- **Don’t claim:** TikTok-scale ABR ownership.""",
)

DAYS[13] = dict(
    prompt_title="Instant Messaging & Chat",
    spec="messaging-chat.md",
    angle="Day 13 DSA day — full **chat** SD mock (state machines).",
    clarify_qs=[
        "1:1 + group text? Media?",
        "E2EE in scope or conceptual only?",
        "DAU and message QPS?",
        "Offline queue required?",
        "WebSocket + REST history?",
        "Out: WebRTC calls?",
    ],
    clarify_outcomes="WS realtime + REST history; SQLite; UUID idempotency; media presign; E2EE concepts only unless asked; out: calls.",
    hld="""Chat UI → VM → MessageRepository (SQLite) → WSClient + REST. Presence optional.
> **Backend:** WS gateway; history service; S3 presign; pubsub.
> **Load:** history cursor 50; heartbeat 30s; reconnect ≤60s jitter; store <500MB.""",
    hld_fu=[
        ("Why WS?", "Bidirectional low latency — cheatsheet transport table."),
        ("APNs?", "Wake when backgrounded — push system sister prompt."),
    ],
    api="""`wss://…/v1/chat` events: send/ack/incoming. `GET /threads`, `GET /threads/{id}/messages?cursor=`.
> Client message UUID for idempotency.""",
    api_fu=[
        ("Exactly-once?", "At-least-once + idempotent UUID."),
        ("Ordering?", "Server seq per thread; local pending bubble."),
    ],
    dive1_title="Deep dive 1 — WS reconnect + heartbeat?",
    dive1="""30s ping; detect zombie; exponential backoff + jitter; resume with last_ack seq.""",
    dive1_fu=[
        ("App killed?", "Pending queue drain on launch."),
        ("Stampede?", "Jitter reconnect."),
    ],
    dive2_title="Deep dive 2 — Message state machine?",
    dive2="""local→sending→sent→delivered→read; fail→failed+retry. Offline enqueue. Media: upload presign then send message referencing URL.""",
    dive2_fu=[
        ("Partial group ack?", "Per-recipient receipts if product needs."),
        ("E2EE?", "Keys high-level only unless pulled deep."),
    ],
    ops="""Delivery p99, queue depth, WS drop rate. Kill: force polling mode.""",
    ops_fu=[
        ("Battery?", "<2%/hr active chat target — batch presence."),
        ("Security?", "TLS; token auth on WS."),
    ],
    relate_shipped="""- **Concept-only** unless you have chat ownership — don’t invent.""",
)

DAYS[14] = dict(
    prompt_title="Mobile Payment Checkout",
    spec="payment-checkout.md",
    angle="Day 14 Mock #2 Parallel SD — **Payment** primary; Search as sister follow-up.",
    clarify_qs=[
        "Apple Pay / card tokenization — which methods?",
        "Idempotency exactly-once required?",
        "DAU and checkout QPS peak?",
        "3DS in scope?",
        "Poll vs webhook-driven client?",
        "Out: marketplace splits, bank acquiring internals?",
        "If time: Search autocomplete sister prompt?",
    ],
    clarify_outcomes="Tokenized checkout; Idempotency-Key; payment FSM + SQLite recovery; poll status; 3DS; out: acquiring internals. Search = follow-up only.",
    hld="""Checkout UI → Payment VM (FSM) → Repository (SQLite intent) → Merchant API → PSP (Stripe/Adyen). Pinning on payment hosts.
> **Load:** Idempotency TTL 24h; API timeout 30s; poll ≤5m every 5s; never double-charge on retry.
> **Sister:** Search debounce/cancel if interviewer switches — don’t mix into payment HLD.""",
    hld_fu=[
        ("PCI?", "No raw PAN on device if tokenized — Apple Pay/PSP fields."),
        ("Ads Mock #2?", "Architecture talk may be Ads/SDUI — this card is Payment SD spine."),
    ],
    api="""`POST /v1/payments/initiate` + `Idempotency-Key`. `GET /v1/payments/{id}/status`. 3DS challenge URL handling.""",
    api_fu=[
        ("Retry POST?", "Same Idempotency-Key — never new key on unknown outcome."),
        ("4xx vs 5xx?", "4xx no retry charge; 5xx → poll status."),
    ],
    dive1_title="Deep dive 1 — Idempotency exactly-once?",
    dive1="""Client UUID key persisted before call; retries reuse key; server dedupe 24h.""",
    dive1_fu=[
        ("Lost response?", "Poll by payment id — don’t re-initiate new key."),
        ("Clock skew?", "Server TTL authoritative."),
    ],
    dive2_title="Deep dive 2 — Poller + mid-kill recovery?",
    dive2="""Persist FSM in SQLite; on launch resume poll until terminal. Timeout → poll not fail toast.""",
    dive2_fu=[
        ("User kills app?", "Resume pending payment screen."),
        ("Search follow-up?", "Debounce 300ms + cancel — search-autocomplete.md."),
    ],
    ops="""Success >99.5% target, latency, 3ds rate. Kill: disable method; maintenance banner.""",
    ops_fu=[
        ("Invent auth rates?", "Forbidden."),
        ("Pinning?", "Payment hosts — networking sister dive."),
    ],
    relate_shipped="""- **Design:** Payment FSM — label design unless resume-backed checkout ownership.
- **Search sister:** BMS search debounce instincts.""",
)

DAYS[15] = dict(
    prompt_title="App Modularization & DI",
    spec="app-modularization.md",
    angle="Day 15 — Parallel SD App modularization (Stories SDK module).",
    clarify_qs=[
        "SDK as SPM binary vs source module?",
        "Host app DI integration?",
        "Binary size / launch budget?",
        "Interface for host navigation?",
        "Out: full release train EM prompt?",
    ],
    clarify_outcomes="Stories-style feature module; Interface/Impl; host composition root; size/launch budgets.",
    hld="""Same module topology; emphasize **SDK boundary**: public Interface, private Impl, minimal Host API.
> Metrics: binary_size, dyld, incremental build.""",
    hld_fu=[
        ("Static vs dynamic for SDK?", "Static often simpler; dynamic if replacement needed."),
        ("Versioning?", "Semver Interface; avoid breaking hosts."),
    ],
    api="""`StoriesSDK.start(dependency:)` ; host provides analytics/network protocols.""",
    api_fu=[
        ("Callback hell?", "Async sequences / delegates thin."),
        ("Tests?", "Host fakes via Interface."),
    ],
    dive1_title="Deep dive 1 — SDK boundary?",
    dive1="""No leaking UIKit subclasses across boundary unless intentional; dependency inversion for network/analytics.""",
    dive1_fu=[
        ("God SDK?", "Split packages — stories core vs UI."),
        ("DI in SDK?", "Accept deps; don’t create global singletons."),
    ],
    dive2_title="Deep dive 2 — Build & launch cost?",
    dive2="""Budget incremental builds; avoid resource duplication; measure pre-main.""",
    dive2_fu=[
        ("Too many modules?", "Coalesce leaf packages; keep Interface stable."),
        ("CI?", "Module-level test targets."),
    ],
    ops="""Size/launch gates in CI; flag to disable SDK entry.""",
    ops_fu=[
        ("Production?", "Stories SDK (Raw / Miami Heat) module thinking."),
        ("Platform EM?", "Day 26/27 can widen to release trains."),
    ],
    relate_shipped="""- **Shipped:** Stories SDK module boundaries (Raw / Miami Heat).""",
)

DAYS[16] = dict(
    prompt_title="Image Loading Library",
    spec="image-loading-library.md",
    angle="Day 16 — Parallel SD Image loading (video via follow-ups).",
    clarify_qs=[
        "Still images pipeline — GIF/video out unless asked?",
        "L1/L2 budgets?",
        "Feed integration / prefetch?",
        "HeroWidget video pause separate?",
    ],
    clarify_outcomes="Image pipeline deep; video-feed-streaming as follow-up if pulled; HeroWidget pause separate media contract.",
    hld="""Image pipeline as Day 03/spec; place beside feed repository. Video: AVPlayerPool sister doc if asked.
> CDN Cache-Control; downsample; cancel on reuse.""",
    hld_fu=[
        ("Video in scope suddenly?", "Switch dive to player pool — don’t pretend ImageIO handles GIF frames."),
        ("Audio?", "Aces audio — separate session category."),
    ],
    api="""Image GET + library cancelable load. Video: feed cursor + stream URLs if pulled.""",
    api_fu=[
        ("Thumb vs full?", "List thumbs; detail full — separate cache keys."),
        ("Prefetch policy?", "Next page thumbs only."),
    ],
    dive1_title="Deep dive 1 — Downsample + cache tiers?",
    dive1="""Cost eviction; memory warning clears L1; disk LRU. Never full-res decode.""",
    dive1_fu=[
        ("WebP?", "Accept negotiation; size win 25–35% vs JPEG per spec."),
        ("Hit rate targets?", "L1 >40%, combined >80%."),
    ],
    dive2_title="Deep dive 2 — Cancel / HeroWidget media?",
    dive2="""Cancel on reuse; generation token. If video: pause on disappear/offscreen — HeroWidget lifecycle.""",
    dive2_fu=[
        ("Animated WebP?", "Out unless asked — separate decoder."),
        ("Related doc?", "video-feed-streaming.md."),
    ],
    ops="""Decode latency, OOM, hitch; video stall if pulled. Kill: disable prefetch.""",
    ops_fu=[
        ("Production?", "HeroWidget; Aces audio/media instincts."),
        ("Instruments?", "Day 17 APM continues metrics."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow Ads pipeline + HeroWidget lifecycle; Aces audio streaming.""",
)

DAYS[17] = dict(
    prompt_title="App Performance Monitoring",
    spec="app-performance-monitoring.md",
    angle="Day 17 — Parallel SD APM.",
    clarify_qs=[
        "Cold start, hang, network, memory in scope?",
        "Crash SDK separate?",
        "Batch upload budget?",
        "MetricKit OK?",
        "Overhead SLO <1% CPU?",
    ],
    clarify_outcomes="APM client: cold start, hang>250ms, network templates, MetricKit; crash separate; batch gzip upload.",
    hld="""Instrumentation SDK → ring buffers → batch uploader → ingest/TSDB. Never block main.
> **Load:** batch ≤~500KB gzip; background upload; sampling under load.""",
    hld_fu=[
        ("URL template anti-pattern?", "Normalize `/users/123` → `/users/{id}` or cardinality explodes."),
        ("Firebase Performance?", "BMS traces — listing/checkout/search."),
    ],
    api="""`POST /v1/metrics/batch` gzip. Local persistence if offline.""",
    api_fu=[
        ("PII in spans?", "Scrub — no tokens/emails."),
        ("Kill switch?", "Remote disable SDK if it hangs."),
    ],
    dive1_title="Deep dive 1 — Cold start measurement?",
    dive1="""process start/sysctl → first frame; break pre-main vs post-main. Target cold <1.2s class from spec.""",
    dive1_fu=[
        ("Pre-main heavy?", "Dyld/frameworks — modularization link."),
        ("P90 >2s?", "P1 alert."),
    ],
    dive2_title="Deep dive 2 — Hang watchdog?",
    dive2="""Main-thread ping; >250ms hang candidate; stack capture carefully; don’t deadlock in handler.""",
    dive2_fu=[
        ("False positives?", "Debugger attached; breakpoints."),
        ("Hitch vs hang?", "Hitch frame budget; hang multi-hundred ms."),
    ],
    ops="""Upload success; cold p90; hang rate; network p99. Kill APM if self-hurting.""",
    ops_fu=[
        ("Production?", "BookMyShow Firebase Performance traces."),
        ("Crash-free?", "Pair with crash SDK day — don’t conflate."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow Firebase Performance traces (journey instrumentation).""",
)

DAYS[18] = dict(
    prompt_title="Crash Reporting SDK",
    spec="crash-reporting-sdk.md",
    angle="Day 18 — Parallel SD Crash SDK.",
    clarify_qs=[
        "Signals + NSException + Swift fatal?",
        "OOM heuristics?",
        "Breadcrumb budget?",
        "Upload next launch?",
        "Out: server symbolication internals?",
    ],
    clarify_outcomes="Async-signal-safe write; breadcrumbs; OOM next launch; upload; out: backend grouping deep dive.",
    hld="""Handlers → mmap crash file → next launch uploader → ingest + dSYM.
> **Constraints:** signal handler — no malloc/ObjC. Init <10ms.""",
    hld_fu=[
        ("Why mmap?", "Safe under crash constraints."),
        ("99.95%+ CFS?", "Ops culture — BookMyShow IMOC participation — don’t claim sole ownership."),
    ],
    api="""`POST /v1/crashes/report`, non-fatal endpoint. Missing dSYM hold ~7d.""",
    api_fu=[
        ("Upload fail?", "SQLite retry queue."),
        ("PII in breadcrumbs?", "Redact."),
    ],
    dive1_title="Deep dive 1 — Signal-safe handler?",
    dive1="""POSIX signals write preallocated buffer only; never lock/malloc.""",
    dive1_fu=[
        ("Swift errors?", "Fatal vs caught — nonfatal API separate."),
        ("Hang vs crash?", "Watchdog separate path."),
    ],
    dive2_title="Deep dive 2 — OOM + breadcrumbs?",
    dive2="""Next-launch heuristic if jetsam; ring ~100 breadcrumbs <1µs write.""",
    dive2_fu=[
        ("False OOM?", "Label heuristic."),
        ("dSYM?", "Upload in CI; match build UUID."),
    ],
    ops="""Crash-free sessions/users, symbolication %, upload success. Kill: disable nonfatal spam.""",
    ops_fu=[
        ("IMOC?", "Incident coordination vocabulary — BookMyShow."),
        ("SDK size?", "Init budget sacred."),
    ],
    relate_shipped="""- **Shipped culture:** BookMyShow IMOC + crash-free at scale (participating — not inventing %).""",
)

DAYS[19] = dict(
    prompt_title="Mobile Security & Zero-Trust Engine",
    spec="mobile-security-privacy-engine.md",
    angle="Day 19 — Parallel SD Security engine (+ pinning).",
    clarify_qs=[
        "Pinning + Keychain + App Attest in scope?",
        "Jailbreak checks severity?",
        "Which hosts pinned?",
        "Biometric step-up for which actions?",
        "Out: HSM/server audit?",
    ],
    clarify_outcomes="SPKI pinning; Secure Enclave/Keychain; App Attest; SQLCipher optional; jailbreak policy; out: server HSM.",
    hld="""Trust layer beside networking: pin delegate, attest assertions on critical ops, encrypted storage.
> **Backend:** gateway verifies attest; pin high-value hosts only.
> **Load:** attest token <2KB; cache keyId; don’t re-gen key every request.""",
    hld_fu=[
        ("Pin all hosts?", "No — high-value; backup pins; rotation."),
        ("Persistence tree?", "Secrets→Keychain; not UserDefaults."),
    ],
    api="""Attestation challenge → Apple attest; `generateAssertion` on sensitive calls. Pinning via URLSession challenge.""",
    api_fu=[
        ("Pin fail?", "Fail closed; metric; backup pin."),
        ("Biometry reset?", "Keys invalidate — re-enroll."),
    ],
    dive1_title="Deep dive 1 — Secure Enclave + biometrics?",
    dive1="""SEP keygen; Face ID gated; AccessibleAfterFirstUnlock for background needs carefully.""",
    dive1_fu=[
        ("Background refresh tokens?", "Accessibility class trade-off — state aloud."),
        ("Passcode fallback?", "Yes for UX."),
    ],
    dive2_title="Deep dive 2 — App Attest + SPKI?",
    dive2="""Attest integrity; pin SPKI SHA-256 of DER — not raw SecKey bytes. Rotation: ship client before rotate.""",
    dive2_fu=[
        ("Break-glass?", "Design label if not shipped runbook."),
        ("Jailbreak?", "Terminate sensitive session policy."),
    ],
    ops="""Pin fail rate, attest fail, jailbreak hits. Kill: disable attest soft; never silently disable pin in prod without gate.""",
    ops_fu=[
        ("Production?", "BookMyShow SSL pinning + whitelist."),
        ("Payment link?", "PCI — tokenization + pin."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow SSL pinning + domain allowlist.""",
)

DAYS[20] = dict(
    prompt_title="Push Notification System",
    spec="push-notification-system.md",
    angle="Day 20 — Parallel SD Push (deeplink/CI sister).",
    clarify_qs=[
        "Display + silent + BG processing?",
        "Token register every launch?",
        "Deep link on open?",
        "Payload ≤4KB OK?",
        "Out: rich NSE deep dive, chat WS?",
    ],
    clarify_outcomes="Token lifecycle; display/silent; router on tap; APNs fanout backend sketch; out: NSE deep, WS chat.",
    hld="""App ↔ Device token API ↔ Push Service ↔ APNs HTTP/2. Client: register, display, silent ≤30s, route.
> **Load:** payload ≤4KB; silent ~3/hr; priority 10 vs 5; collapse-id.""",
    hld_fu=[
        ("Same as deeplink?", "Tap → same DeepLinkRouter."),
        ("CI/CD?", "Mention phased release — don’t boil CI unless asked."),
    ],
    api="""`PUT /v1/devices/{userId}/push-token`, DELETE invalidate. Server→APNs. Client handles UNNotification.""",
    api_fu=[
        ("410 Unregistered?", "Invalidate token server-side."),
        ("Denied permission?", "Settings CTA — don’t spam."),
    ],
    dive1_title="Deep dive 1 — Token lifecycle?",
    dive1="""Register every launch; rotate on change; dedupe server-side; multi-device.""",
    dive1_fu=[
        ("Logout?", "DELETE token binding."),
        ("Sandbox vs prod?", "Correct APNs env — classic footgun."),
    ],
    dive2_title="Deep dive 2 — Silent push + deferred?",
    dive2="""Silent ≤30s work; throttle; fallback BGAppRefresh. Deferred install links sister to deeplink doc.""",
    dive2_fu=[
        ("iOS throttling?", "Expect coalescing — design resilient sync."),
        ("Security?", "Don’t put secrets in payload."),
    ],
    ops="""Delivery, CTR (labeled ranges only), invalidate on 410. Kill: stop campaign; collapse-id.""",
    ops_fu=[
        ("Production?", "Grizzlies push via Airship/Mixpanel routing discipline."),
        ("Invent open rates?", "Forbidden as personal fact."),
    ],
    relate_shipped="""- **Shipped:** Grizzlies push/deeplink router discipline (Mixpanel/Airship).""",
)

DAYS[21] = dict(
    prompt_title="Networking Layer + SSL Pinning",
    spec="networking-layer.md",
    angle="Day 21 Mock #3 — **alternate** to SDUI-heavy samples 01–04 (Prompt B).",
    clarify_qs=[
        "First-party networking + auth + SPKI pinning?",
        "30L+ DAU context OK?",
        "Out: backend mesh / Android?",
        "Dives: single-flight refresh + SPKI rotation?",
        "Ops with p50/p90?",
    ],
    clarify_outcomes="Networking+pinning 45‑min mock; refresh actor; pin rotation design; SDUI is the other prompt — pick one live.",
    hld="""Features → protocols → APIClient → interceptors → URLSession + SPKI + allowlist → URLCache/Keychain/reachability.
> Prefer URLSession when owning trust. Load: HTTP/2, gzip, timeout 30s, pin rotate ≤90d.""",
    hld_fu=[
        ("SDUI instead?", "If Prompt A chosen, switch cards — don’t mix mid-draw."),
        ("Four layers?", "Yes + data flow arrows."),
    ],
    api="""APIEndpoint async throws; 401 refresh coordinator; retry only transient on idempotent GET; pin challenge.""",
    api_fu=[
        ("Charge POST retry?", "Never blind — idempotency or poll."),
        ("Backup pins?", "Ship before rotate; break-glass design labeled."),
    ],
    dive1_title="Deep dive 1 — Single-flight refresh?",
    dive1="""Actor-owned refresh; waiters; success retry once; failure logout.""",
    dive1_fu=[
        ("N parallel 401?", "One refresh."),
        ("Refresh endpoint pin?", "Same trust policy."),
    ],
    dive2_title="Deep dive 2 — SPKI pin rotation?",
    dive2="""Pin SHA-256 of SPKI DER; backup pins; client before server rotate; mismatch terminate + metric.""",
    dive2_fu=[
        ("Outage from bad pin?", "Backup + staged rollout."),
        ("Whitelist?", "Domain allowlist beside pin."),
    ],
    ops="""p50/p90/p99, 5xx, refresh fail, pin fail. Kill retries; break-glass design. Score with Day 21 rubric.""",
    ops_fu=[
        ("Production?", "BMS pinning + URLSession migration."),
        ("Cheatsheet?", "ios-system-design/docs/cheatsheet.md spine."),
    ],
    relate_shipped="""- **Shipped:** BookMyShow SSL pinning + URLSession migration.
- **Design:** pin rotation / break-glass if not personal runbook.""",
)

DAYS[22] = dict(
    prompt_title="Collaborative Document Editor",
    spec="collaborative-editor.md",
    angle="Day 22 DSA trees day — **OT collab** SD mock.",
    clarify_qs=[
        "Multi-user realtime text — rich formatting out?",
        "OT vs CRDT preference?",
        "Max concurrent editors (~100)?",
        "Offline op log?",
        "Presence/cursors?",
    ],
    clarify_outcomes="OT transforms; WS sequencer; offline op queue; presence; out: rich ACLs/folders.",
    hld="""Editor UI → OT engine → pending op queue → WS → server sequencer. Snapshot store periodically.
> **Load:** presence ~500ms; batch ops ~500ms; snapshot ~100 ops; sync <100ms target.""",
    hld_fu=[
        ("CRDT instead?", "Valid — state trade-off; pick one and go deep."),
        ("Tree DSA link?", "Op transform ≠ tree problem — don’t force."),
    ],
    api="""`GET /docs/{id}/snapshot`; WS `submit_ops` / `apply_ops` / `presence`.""",
    api_fu=[
        ("Desync?", "Hash mismatch → full snapshot reload."),
        ("ACL?", "Out unless asked."),
    ],
    dive1_title="Deep dive 1 — OT transform engine?",
    dive1="""Transform local vs remote ops against revision; apply optimistically; ACK revisions.""",
    dive1_fu=[
        ("Cursor presence?", "Separate channel; ephemeral."),
        ("CPU?", "Metric OT time; compact history."),
    ],
    dive2_title="Deep dive 2 — Pending queue + desync?",
    dive2="""Queue offline; replay on reconnect; if >1000 ops warn/compact; desync → snapshot.""",
    dive2_fu=[
        ("Partial apply?", "Atomic per revision batch."),
        ("Conflict UX?", "Rare with OT — still handle snapshot."),
    ],
    ops="""Sync latency, desync rate, OT CPU. Kill: read-only mode.""",
    ops_fu=[
        ("Redis presence?", "Backend sketch only."),
        ("Invent editors count?", "Use labeled ≤100 from spec."),
    ],
    relate_shipped="""- **Concept-only** — collaborative editor design vocabulary.""",
)

DAYS[23] = dict(
    prompt_title="Realtime Location / Ride Tracking",
    spec="realtime-location-tracking.md",
    angle="Day 23 DSA day — **realtime geo** SD mock.",
    clarify_qs=[
        "Driver TX + rider map RX?",
        "Battery budget?",
        "Update interval 2–4s active?",
        "WS transport?",
        "Out: dispatch matching / payments?",
    ],
    clarify_outcomes="CoreLocation filtered batching; WS; rider interpolation; offline queue; out: matching/payments.",
    hld="""Driver: CL → filter/Kalman → batch → WS. Rider: WS → interpolate 4s → map polyline delta.
> **Backend:** WS; Kafka; ETA; Redis Geo.
> **Load:** 2–4s active / 15s BG; batch 3–4 pts/4s; heartbeat 30s.""",
    hld_fu=[
        ("Why not raw GPS every Hz?", "Battery + noise — distanceFilter."),
        ("Map 60fps?", "Interpolate; don’t redraw every point naively."),
    ],
    api="""`wss://…/trips/{id}` `location_batch`, `driver_update`, `eta_seconds`.""",
    api_fu=[
        ("Dead zone?", "SQLite burst upload later."),
        ("Rider WS down?", "HTTP poll 5s fallback."),
    ],
    dive1_title="Deep dive 1 — CL + battery?",
    dive1="""accuracy + distanceFilter; Low Power mode coarsens; thermal aware.""",
    dive1_fu=[
        ("Background modes?", "Declare honestly; App Review."),
        ("Privacy?", "Purpose strings; stop when trip ends."),
    ],
    dive2_title="Deep dive 2 — Rider interpolation?",
    dive2="""Animate between updates; polyline delta; ETA separate channel.""",
    dive2_fu=[
        ("Teleport snap?", "Smooth with max jump threshold."),
        ("Heap/hash DSA?", "Irrelevant — don’t force."),
    ],
    ops="""Fix accuracy, freshness p99, battery SLA. Kill: reduce frequency.""",
    ops_fu=[
        ("DoorDash sister?", "ActivityKit tracker — different prompt."),
        ("Invent ETA accuracy?", "Forbidden."),
    ],
    relate_shipped="""- **Concept-only** — realtime location design.""",
)

DAYS[24] = dict(
    prompt_title="On-Device LLM / AI Engine",
    spec="on-device-llm-ai-engine.md",
    angle="Day 24 — Parallel on-device AI (FinTrack/GymFlow).",
    clarify_qs=[
        "On-device inference + local RAG?",
        "Cloud hybrid fallback allowed?",
        "RAM budget ≤500MB?",
        "PII must not leave device by default?",
        "Streaming tokens to UI?",
        "Out: training/quant math?",
    ],
    clarify_outcomes="HybridAIRouter; on-device RAG; thermal/memory guards; streaming; PII scrub before cloud; out: training.",
    hld="""UI stream ← Router ← (local ANE model + vector store) OR cloud SSE. Unmap weights on memory warning.
> **Load:** cloud if >~2k tokens or thermal serious; KV-cache example ~128MB; TTFT <100ms class.""",
    hld_fu=[
        ("FinTrack vs GymFlow?", "Same shape — BM25 vs MiniLM knobs."),
        ("Tooling AI?", "District Copilot ≠ product on-device — separate story."),
    ],
    api="""Local AsyncSequence tokens; cloud SSE TLS; never log raw financial text.""",
    api_fu=[
        ("Fail-soft?", "Rules/TF-IDF if model absent."),
        ("Kill?", "Remote disable generative; retrieval-only."),
    ],
    dive1_title="Deep dive 1 — HybridAIRouter?",
    dive1="""Policy: privacy class → local only; else thermal/size → cloud; mid-stream switch on thermal.""",
    dive1_fu=[
        ("User toggle?", "Respect; default private for finance."),
        ("Hallucination?", "Ground in retrieved docs; cite."),
    ],
    dive2_title="Deep dive 2 — RAG + memory/thermal?",
    dive2="""HNSW/VSS top-K; purge KV on warning; throttle gen; hard stop ~1024 tokens.""",
    dive2_fu=[
        ("Embeddings size?", "INT8 MiniLM — GymFlow angle."),
        ("Battery?", "Throttle; prefer plug-in for large jobs."),
    ],
    ops="""TTFT, tok/s, memory, thermal events, cloud fallback rate. Kill generative path.""",
    ops_fu=[
        ("Production?", "FinTrack/GymFlow learning-lab — label honestly."),
        ("Cheatsheet?", "AI stack section."),
    ],
    relate_shipped="""- **Lab / side projects:** FinTrack on-device AI; GymFlow embeddings — don’t claim BMS product AI.
- **District:** tooling AI separate.""",
)

DAYS[25] = dict(
    prompt_title="E-Commerce Catalog & Discovery",
    spec="e-commerce-catalog.md",
    angle="Day 25 machine round bridge — **list + cache** (Brief A).",
    clarify_qs=[
        "Image grid catalog + search + cart/wishlist?",
        "Checkout/payments out?",
        "Cursor pagination + 70% prefetch?",
        "Offline cart queue?",
        "ETag prices?",
    ],
    clarify_outcomes="Catalog grid; image pipeline; cursor; search debounce; optimistic cart; out: checkout payments (sister).",
    hld="""Catalog UI → VM → CatalogRepo (network+cache) + ImagePipeline + CartQueue.
> **Backend:** Catalog API + CDN; cart sync; ETag 304.
> **Load:** limit 20; debounce 300ms; L1 images ~50MB; thumbs 50–100KB WebP.""",
    hld_fu=[
        ("Brief B SDUI?", "Different machine brief — don’t build both in 3h."),
        ("Diffable?", "Stable product ids."),
    ],
    api="""`GET /v1/catalog?cursor=&limit=20&category=&sort=` ; `POST /v1/cart/items` ; search with debounce.""",
    api_fu=[
        ("Stale price?", "ETag/If-None-Match; invalidate on focus."),
        ("Page fail?", "Inline retry; keep list."),
    ],
    dive1_title="Deep dive 1 — Image grid + prefetch?",
    dive1="""Downsample; prefetch next page at 70%; cancel reuse — machine-round vertical slice.""",
    dive1_fu=[
        ("Memory?", "Cost cache; warning clears L1."),
        ("120Hz?", "Prefer frames — avoid main decode."),
    ],
    dive2_title="Deep dive 2 — Optimistic cart offline?",
    dive2="""Local queue; sync when online; conflict merge; don’t pretend payment.""",
    dive2_fu=[
        ("Payment asked?", "Defer to payment-checkout prompt."),
        ("Wishlist?", "Same offline queue pattern."),
    ],
    ops="""scroll_hitch, image_cache_hit, search_latency, cart_add_success. Kill: disable prefetch.""",
    ops_fu=[
        ("Debrief bridge?", "≤20s SDUI/list UX contracts — Day 25 debrief."),
        ("Invent GMV?", "Forbidden."),
    ],
    relate_shipped="""- **Design / lab:** list+cache vertical slice for machine round.
- **Don’t claim:** production BMS catalog rewrite.""",
)

DAYS[26] = dict(
    prompt_title="Mobile Platform Engineering (EM/Staff)",
    spec="mobile-platform-engineering-em.md",
    angle="Day 26 behavioral day — **platform EM** SD mock (leadership via systems).",
    clarify_qs=[
        "Release train + feature-flag kill switches?",
        "Crash-free gate for phased rollout?",
        "Monorepo Interface/Impl?",
        "Sev-1 expectations?",
        "Out: product feature HLD?",
    ],
    clarify_outcomes="Phased 1→100% rollout; auto-pause gates; flag kill <5m; Sev-1 playbook; build budgets.",
    hld="""Platform view: monorepo modules → CI budgets → ASC phased release → Remote Config kill → IMOC.
> **Load/governance:** weekly train; flags mandatory on new surfaces; pause if CFS <99.85% class.""",
    hld_fu=[
        ("Product SD instead?", "Redirect — this prompt is platform/EM."),
        ("AI tooling?", "District envelope — review bar, not platform train."),
    ],
    api="""Remote Config kill-switch; ASC halt rollout; expedited review path (process).""",
    api_fu=[
        ("Who flips kill?", "On-call + EM; SLA <5m."),
        ("Canary metrics?", "CFS, hang, 5xx ≥3× baseline → pause."),
    ],
    dive1_title="Deep dive 1 — Phased rollout gates?",
    dive1="""1→2→5→10→20→50→100%; auto pause; don’t vibe-ship.""",
    dive1_fu=[
        ("Hotfix during phase?", "Halt; flag; expedite."),
        ("CI flaky?", "<1.5% flaky budget."),
    ],
    dive2_title="Deep dive 2 — Sev-1 triage?",
    dive2="""Flag kill <5m → halt ASC → communicate → hotfix train. Breadcrumbs from crash SDK.""",
    dive2_fu=[
        ("Blame?", "Systems first — IMOC culture."),
        ("Mentorship?", "Standards via architecture envelopes — Day 26 STAR."),
    ],
    ops="""CFS >99.9% target, hang <0.1%, kill SLA, CI time. This *is* the ops-heavy prompt.""",
    ops_fu=[
        ("Production?", "IMOC + crash-free culture participation; Ads protocol standards as leadership."),
        ("Invent Sev counts?", "Forbidden."),
    ],
    relate_shipped="""- **Shipped culture:** BookMyShow IMOC + crash-free; Ads protocol mentorship-through-architecture.
- **District:** AI tooling judgment envelope.""",
)

DAYS[27] = dict(
    prompt_title="Auth: OAuth2 PKCE + Biometrics",
    spec="authentication-oauth-biometric.md",
    angle="Day 27 Expert Mock #4 — **SD segment** auth prompt.",
    clarify_qs=[
        "OAuth2 PKCE + biometric step-up?",
        "Token TTLs?",
        "Single-flight refresh on concurrent 401?",
        "SSO ASWebAuthenticationSession?",
        "Out: IdP server internals?",
    ],
    clarify_outcomes="PKCE; Keychain tokens; actor refresh; Face ID step-up; logout revoke; out: IdP internals.",
    hld="""Login UI → AuthService → ASWebAuth session → Keychain → APIClient interceptors.
> **Backend:** `/authorize`, `/token`, logout revoke.
> **Load:** access 15m–1h; Keychain no iCloud sync; SSO ~1–3s.""",
    hld_fu=[
        ("SDUI/network alt?", "Expert may pick — same 45‑min spine."),
        ("Pinning?", "Auth hosts high-value — security sister."),
    ],
    api="""PKCE authorize→token; refresh grant; logout revoke. Biometric gate before revealing refresh token usage for step-up.""",
    api_fu=[
        ("Refresh fail?", "Logout clear Keychain."),
        ("Multi-device revoke?", "Server invalidate refresh family."),
    ],
    dive1_title="Deep dive 1 — PKCE exchange?",
    dive1="""code_verifier/challenge; no client secret in public app; state CSRF.""",
    dive1_fu=[
        ("Custom scheme hijack?", "Universal Links / ephemeral session preferred."),
        ("Keychain accessibility?", "AfterFirstUnlock vs WhenUnlocked — trade-off."),
    ],
    dive2_title="Deep dive 2 — Single-flight refresh?",
    dive2="""Same as networking dive — actor; waiters; one refresh; failure logout.""",
    dive2_fu=[
        ("Biometric fail?", "Passcode fallback; limit retries."),
        ("Ops last 5?", "Protect — metrics + kill SSO provider."),
    ],
    ops="""Refresh success, login funnel, biometric fail rate. Kill: force re-login; disable SSO provider.""",
    ops_fu=[
        ("Tie to Mock #4?", "Coding + iOS deep dive + this SD — calendar discipline."),
        ("Openers?", "Day 27 warmup scripts."),
    ],
    relate_shipped="""- **Design:** PKCE/biometric auth — label unless resume-backed auth ownership.
- **Networking proof:** BMS pinning/URLSession for trust story.""",
)

DAYS[28] = dict(
    prompt_title="Social Feed (warm retrieval)",
    spec="cheatsheet.md",
    angle="Day 28 game day — **light retrieval only** (no new HLD from scratch).",
    clarify_qs=[
        "Only restate agenda + clarify list — confirm?",
        "Which prompt might appear — feed / SDUI / networking / on-device AI?",
        "Ops block still last 5?",
        "No new diagrams today?",
    ],
    clarify_outcomes="Warm retrieval: agenda, clarify Qs, spine times, kill-switch reminder. Pivot kit: FinTrack/GymFlow if AI. No new design invention.",
    hld="""**Do not draw a new full HLD today.** Skim remembered 4 layers + backend touchpoints for the likely prompt.
> If forced: Social Feed one-liner — cursor pages, SQLite last-good, image pipeline, optimistic like — then stop and protect calm.""",
    hld_fu=[
        ("Interviewer asks deep dive?", "Park: “I’ll use the standard spine — clarify already done in warmup.”"),
        ("Forgot numbers?", "DAU labeled; NFR from cheatsheet — don’t invent."),
    ],
    api="""Retrieve only: cursor > offset; Idempotency-Key on payments; debounce search; single-flight refresh.""",
    api_fu=[
        ("Blank mind?", "Speak agenda first — buys 20s."),
        ("Wrong prompt?", "Re-clarify in/out 30s."),
    ],
    dive1_title="Deep dive 1 — Cheatsheet spine only?",
    dive1="""0–5 clarify · 5–15 HLD · 15–25 API · 25–40 dives · 40–45 ops. Say it once aloud.""",
    dive1_fu=[
        ("Skip sleep for study?", "No — game day rule."),
        ("Flashcards only?", "Yes — stories + openers."),
    ],
    dive2_title="Deep dive 2 — Pivot kit?",
    dive2="""On-device AI: privacy, local RAG, thermal, fail-soft — FinTrack/GymFlow. Networking: refresh+pin. SDUI: registry+fallback.""",
    dive2_fu=[
        ("New topic appears?", "Clarify hard; use 4 layers; pick two dives; protect ops."),
        ("Behavioral?", "2-min STAR openers ready."),
    ],
    ops="""Remember: failure modes, concrete metrics, kill switch. Last five minutes sacred.""",
    ops_fu=[
        ("Calm opener?", "“Five minutes on scope, then architecture, deep dives, and ops.”"),
        ("Draw today?", "Skim only."),
    ],
    relate_shipped="""- **Game day:** flashcards + stories only — no new claims.
- **Pivot:** FinTrack/GymFlow labeled lab; BMS verified stories only.""",
    light=True,
)


def main() -> None:
    assert set(DAYS) == set(range(1, 29)), f"missing days: {set(range(1,29))-set(DAYS)}"
    written = 0
    for day, meta in sorted(DAYS.items()):
        week, day_folder = DAY_PATH[day]
        dest = WEEKS / week / day_folder / "sample" / "05-system-design-mock.md"
        if not dest.parent.is_dir():
            raise SystemExit(f"missing sample dir: {dest.parent}")
        text = card(**meta)
        dest.write_text(text, encoding="utf-8")
        written += 1
        print(f"wrote {dest.relative_to(ROOT)}")
    print(f"generated {written} SD mock samples")


if __name__ == "__main__":
    main()
