# Sample 05 — System-design mock: Infinite Social Feed (Q&A)

> Guided **mock interview** flow. Speak answers aloud against a 45‑min timer. 
> **Source:** [`ios-system-design/docs/social-feed.md`](../../../../ios-system-design/docs/social-feed.md) · timing: [`cheatsheet.md`](../../../../ios-system-design/docs/cheatsheet.md) 
> **Angle:** Day 05 — feed HLD with async/await & actors, plus UI + data management for long scrolls. 
> **Brain puzzles** at the bottom — cover → think → check.
>
> **How to use:** Say the **Answer** blocks out loud. Words in parentheses are reminders for you — skip them when speaking.

**Quick terms (say in plain English if asked):**

| Term | Plain meaning |
|---|---|
| **Cursor pagination** | Each page returns an opaque token (`next_cursor`). Next request: `after_cursor=…`. Not `?page=3` / offset — safer for a live feed. |
| **Online-first + last-good cache** | Network is primary; show SQLite last ~200 posts when offline or slow. |
| **Diffable (UIKit)** | `UICollectionViewDiffableDataSource` — apply snapshots by stable post IDs; cells reuse. |
| **Lazy list (SwiftUI)** | `List` / `LazyVStack` + `Identifiable` posts — only nearby rows materialize; same memory rules as UIKit reuse. |
| **Windowed memory** | Don’t keep 10k decoded images in RAM. Keep post *models* (or a sliding window); evict image cache for off-screen posts. |

---

### Q1. Interviewer: “Design Infinite Social Feed.” How do you open?
**Answer:**

> “I’ll take about five minutes clarifying scope and scale. Then I’ll draw a four-layer client high-level design — including UI architecture and how we manage data if someone scrolls for a very long session, say toward ten thousand posts. Then API. Two deep dives: first UI plus data windowing for long scrolls, second structured concurrency for paging and an optimistic like actor. I’ll close on failures, metrics, and kill switches. Does that plan work?
>
> Before I draw: product is infinite scroll of text and image posts with likes — cursor pagination, meaning we load the next page with an opaque `after_cursor` token, not page numbers. Online-first, with a last-good offline cache of about two hundred posts — or do you want full offline write sync?
>
> UI: I’ll cover **both UIKit and SwiftUI** for the feed surface — UIKit `UICollectionView` + Diffable, and SwiftUI `List`/`LazyVStack` with stable IDs — same ViewModel and repository underneath. Prefer one for the whiteboard default, or keep both in parallel?
>
> Scale: rough DAU and peak concurrent scrollers so I can label page QPS? Should the client stay smooth if a power user scrolls deep — thousands of posts in one session, memory and scroll hitch matter? iOS-only?
>
> Concurrency: structured concurrency for page fetch and thumb prefetch — cancel when the screen goes away or the user pull-to-refreshes — okay? Actor for the like coordinator, UI state on MainActor?
>
> Latency: next-page p99 under about five hundred milliseconds as a target? Read-heavy with sparse likes, or like storms?
>
> Out of scope unless you want them: video streaming, ML ranking, WebSocket ‘new posts’ pill — okay?”

Do **not** draw until they answer or you state labeled assumptions. Keep backend load and **client memory** in mind from minute one.

**If they give no numbers, say:**

> “I’ll assume about thirty lakh DAU, online-first plus last ~200 in SQLite, cursor pages of fifteen to twenty, and **both UI stacks**: UIKit CollectionView + Diffable, and SwiftUI Lazy list — shared MainActor ViewModel. Memory plan so a ~10k-post scroll session doesn’t OOM — windowed images, bounded in-memory models. Structured concurrency for paging; LikeActor for likes. I’ll label those — please correct me.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Skip agenda? | Don’t — they may want different dives (UI memory vs concurrency). |
| Clarify 15 min? | “Hard stop at five. Rest becomes labeled assumptions.” |
| What is a cursor? | “Opaque pagination token from the server. Client sends it back to get the next page. Avoids skip/duplicate bugs of offset on a live feed.” |
| Why mention 10k scrolls? | “Infinite feed interviews fail on memory — if we keep every decoded image, we OOM. I want that in scope early.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors + list memory — label design.
- **Shipped:** Race→actor migration instincts where resume-backed; listing scroll/perf instincts if asked.

---

### Q2. After clarify — what does the good flow look like?
**Answer:**

> “For this mock I’ll assume: iOS social feed; cursor pages; online-first plus SQLite last ~200; power-user scroll depth toward ten thousand posts — so UI reuse / lazy loading and data windowing are first-class. I’ll speak **UIKit and SwiftUI** both for presentation, one shared domain/data stack. Async page tasks; LikeActor for single-flight likes. Out: video and ranking.
>
> Good flow: agenda, clarify, confirm, HLD with four layers plus dual UI plus memory, API, two deep dives, last five minutes ops.
>
> Weak flow: drawing only boxes with no UI/data plan, picking UIKit or SwiftUI with no memory story, keeping every post+image forever in RAM, inventing QPS as fact, skipping ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Scope changes mid-HLD? | “Re-confirm in/out in twenty seconds. Adjust dives. Protect ops.” |
| Full backend deep dive? | “Sketch touchpoints; stay client-owned unless they ask.” |
| Forgot offline? | “Assumption: online-first plus last-good cache — correct me if wrong.” |
| Forgot memory? | “Assumption: Diffable list + image cache eviction + optional model window — correct me if you want full 10k models in RAM.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q3. Walk the HLD — UI architecture, layers, backend, load?
**Answer:**

> “Four client layers, with UI and data called out because long scroll is the hard part. Presentation supports **both UIKit and SwiftUI**; domain and data stay shared.
>
> **Presentation — UIKit:** `UICollectionView` + compositional layout + `UICollectionViewDiffableDataSource`. Snapshot keyed by `postID` → cell models. Cell reuse; estimated / self-sizing heights tuned to avoid hitch. `UICollectionViewDataSourcePrefetching` loads next cursor page and nearby thumbs around ~70% scroll. `UIRefreshControl` for pull-to-refresh starts a new generation. Optional: `UITableView` + Diffable if the feed is single-column text-heavy.
>
> **Presentation — SwiftUI:** Same ViewModel. `List` or `ScrollView` + `LazyVStack` with `ForEach(posts)` where `Post: Identifiable`. Lazy containers only build nearby rows — that’s the reuse equivalent. `.refreshable` for pull-to-refresh. Trigger next page with `onAppear` on a near-end row or a sentinel footer. Prefer `AsyncImage` only with a shared image pipeline underneath (cache + cancel), not unbounded default loading. Can host UIKit cells via `UIViewRepresentable` if a complex media cell already exists.
>
> **Shared contract:** Both UIs read `@MainActor FeedViewModel` (posts, paging flags, errors). Neither talks to the network directly. Optimistic like updates one post in the model; UIKit applies a small Diffable delta, SwiftUI re-renders that row from identity.
>
> **Domain:** `FeedViewModel` on MainActor — paging state, visible window, optimistic likes, impression dwell. Owns a parent `Task` for the screen; children for page fetch and prefetch. UIKit: start/cancel in `viewIsAppearing` / `deinit` or a hosted task. SwiftUI: `.task { }` / `.task(id:)` tied to the view.
>
> **Data:** `FeedRepository` — network + SQLite. Bounded in-memory post models. SQLite last-good ~200. Image pipeline shared by both UIs: download → decode **off main** → capped L1 → disk. Off-screen: cancel loads; purge L1 under memory pressure.
>
> **Platform:** URLSession, image pipeline, analytics batcher.
>
> **10k-scroll data management:** We do **not** hold ten thousand decoded bitmaps. UIKit reuses ~a screenful of cells; SwiftUI keeps ~a screenful of materialized views. Post metadata can grow (lightweight structs); still trim on memory warning and keep cursors. Never decode full-res on main.
>
> **Backend / load:** `GET` feed with `after_cursor` + limit 15–20; CDN for images; like `POST`. Cache TTL ~5 minutes where safe. Labeled QPS from DAU — never fake precision.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Why both UIKit and SwiftUI? | “Interviews often ask either. Same architecture: shared ViewModel + repository; only the list surface changes.” |
| Why Diffable? | “UIKit: stable IDs, small animated updates for one like toggle — no full `reloadData`.” |
| SwiftUI identity? | “`Identifiable` + stable `postID`. Don’t use array indices as IDs — like toggles and inserts will glitch.” |
| UITableView okay? | “Yes — same Diffable reuse idea. CollectionView is nicer for mixed media.” |
| Mix UIKit in SwiftUI? | “Yes — `UIViewRepresentable` / `UIViewControllerRepresentable` for a battle-tested media cell; still drive state from the ViewModel.” |
| Keep all 10k models? | “Text models are small; images are not. Cap image cache hard. Trim far models on memory warning.” |
| GCD vs async? | “Structured concurrency for page lifecycle. GCD fine inside decode pools.” |
| Sendable models? | “Value `Post` models across actors. No UIKit/SwiftUI types in domain/data.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Listing scroll / Firebase Performance instincts if asked — not a claimed BMS feed rewrite.

---

### Q4. Data / API — entities, paging, cancel, memory?
**Answer:**

> “Entities: `Post` — id, author, text, thumb URL, likeCount, likedByMe; opaque cursor for the page edge; `LikeAction`; batched `ImpressionEvent`.
>
> Endpoints: `GET /v1/feed?limit=20&after_cursor=…` returns posts + `next_cursor`. `POST /v1/posts/{id}/like` — idempotent client request id optional.
>
> Client data path: append page into repository → ViewModel publishes posts → **UIKit** applies a Diffable snapshot, **SwiftUI** observes the same array/`@Observable` model and updates the Lazy list. Prefetch next page once, single-flight.
>
> Cancellation: pull-to-refresh or a newer page request bumps a **generation token** or cancels the old `Task`. Ignore stale responses so the feed doesn’t jump backward.
>
> Memory: page JSON is small; decoded images dominate. Bound image cache (e.g. MB + count). On memory warning: clear L1 images, cancel prefetch TaskGroup, keep visible cells. Optional: trim in-memory posts older than N pages from the viewport; user scroll-back refetches via cursor or disk.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Two pages racing? | “Generation token + cancel — only apply if still current.” |
| Offset pagination? | “Reject for live feeds — inserts cause skips/duplicates; deep offsets get expensive.” |
| Actor reentrancy on like? | “Keep actor work short; hop out for network; re-validate after await.” |
| OOM at 10k? | “Almost always images + unbounded caches — not the string fields. Cap and evict.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q5. Deep dive 1 — UI + data management for ~10k scrolls?
**Answer:**

> “Goal: butter-smooth scroll after a long session without OOM — same rules in **UIKit and SwiftUI**.
>
> **UIKit:** Reused cells only. Diffable snapshot keyed by `postID`. Avoid huge `reloadData`. Cache measured heights or use stable estimated sizes. `prefetchDataSource` / end-of-list trigger requests the next cursor page once. `UIRefreshControl` cancels the previous page generation.
>
> **SwiftUI:** `List` or `LazyVStack` + `ForEach` with stable `Identifiable` IDs — lazy = only nearby rows exist. Next page via near-end `onAppear` or footer sentinel; `.refreshable` for refresh. Don’t put heavy work in `body`. Images go through the shared pipeline (cancel on disappear), not unbounded `AsyncImage` alone. Bridge to UIKit with `UIViewRepresentable` if a cell is too complex.
>
> **Shared data layers:** (1) Network pages via cursor. (2) In-memory post buffer — lightweight. (3) SQLite last-good ~200. (4) Image pipeline with hard caps; decode off main; downscale to cell size — both UIs use it.
>
> **Eviction:** Visible + small prefetch window stay hot. Scroll away → cancel image tasks. Memory warning → purge L1, shrink prefetch. Trim far models if needed; keep cursors for scroll-back.
>
> **Concurrency:** UIKit parent Task from appear/disappear; SwiftUI `.task`. Prefetch thumbs in a **capped** TaskGroup (4–6). Leaving the screen cancels the tree.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Pick one UI? | “I’ll default the whiteboard to UIKit Diffable, then mirror the same flow in SwiftUI Lazy list — interviewer’s choice which to deepen.” |
| SwiftUI identity bugs? | “Stable `postID` only. Index-based IDs break likes and inserts.” |
| Keep full history for scroll-back? | “Bounded ring or reload by cursor/disk; never keep all bitmaps.” |
| Hitch while appending page? | “UIKit: apply snapshot on MainActor without decoding. SwiftUI: append models on MainActor; don’t decode in `body`.” |

**How can I relate to my case:**
- **Design:** Feed list memory — label design.
- **Shipped:** Listing instrumentation instincts where resume-backed.

---

### Q6. Deep dive 2 — Structured concurrency + optimistic like actor?
**Answer:**

> “**Paging:** When a page arrives, prefetch thumbs with `async let` or a TaskGroup under the screen task. Pull-to-refresh cancels the previous page task. I don’t fire unstructured `Task { }` with no owner — UIKit ties a parent Task to appear/disappear; SwiftUI uses `.task`.
>
> **Likes:** `LikeActor` owns in-flight work per post. UI flips optimistically on MainActor, awaits the network (off main), rolls back on failure. Spam taps: coalesce — last intended liked/unliked state wins; one network call, not one per tap. After `await`, re-check state — actor reentrancy can interleave.
>
> Offline like queue can sit in SQLite; the actor coordinates drain so we don’t double-post.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Many taps? | “Coalesce; don’t fire one network call per tap.” |
| MainActor? | “UI state on MainActor; network and decode off main.” |
| Priority? | “Visible page > nearby thumbs > far prefetch. Don’t block main with sync waits.” |
| Prefetch actor? | “Optional ImagePipeline actor for single-flight URLs.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q7. Ops — failures, metrics, kill switch?
**Answer:**

> “Failures: page error → keep existing list + inline retry; don’t blank the feed. Like failure → rollback cell + toast. Empty first launch offline → empty state + retry. Hung spinner → timeout/cancel + last-good cache.
>
> Metrics: scroll hitch rate, TTFF with cache, page success / p99, cancelled-task rate, like success, memory warnings, image-cache hit rate, like-actor wait time.
>
> Kill switches / remote config: disable aggressive thumb prefetch under thermal or bad network; shrink page size; clear image cache more aggressively. After outage: jittered backoff so clients don’t stampede the feed origin.
>
> Never sync-network or full-res decode on main.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hang from await on main? | “Await on MainActor is fine if the awaited work isn’t blocking main.” |
| Memory metric? | “Watch jetsam / memory warning rate on long-scroll sessions — that’s the 10k signal.” |
| Later deepen? | “Same spine — more API/ops on Day 21.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q8. Scorecard — did you hit the spine?
**Answer:**

> “Pass bar: clarify and agenda in five; HLD shows four layers **plus UIKit and SwiftUI presentation, shared ViewModel, and a 10k-scroll memory plan**; API has cursors and cancel/idempotency; two deep dives (UI/data window + concurrency/like actor); ops with metrics and a kill switch.
>
> Anti-patterns: offset pagination on a live feed; decode on main; unbounded image cache; SwiftUI index IDs; inventing QPS as fact; never reaching ops.
>
> Timing: 0–5 clarify, 5–15 HLD, 15–25 API, 25–40 dives, 40–45 ops.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Long on dive 1? | “Park dive 2 as bullets; protect ops five minutes.” |
| Forgot load? | “One sentence from DAU → labeled QPS, cursor cost, single-flight.” |
| Forgot memory? | “One sentence: UIKit reuse / SwiftUI lazy, cap image cache, cancel off-screen work.” |
| Invented crash-free %? | “Forbidden — resume numbers or labeled targets only.” |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Rehearse this scorecard after every timed mock.

---

### Q9. Where does Day 05 concurrency fit in a social-feed design?
**Answer:**

> “Three places. Prefetch thumbs — TaskGroup with a concurrency cap so we don’t stampede network or RAM. Feed pagination — cancel in-flight page on pull-to-refresh or a newer request. Shared maps / like state — actor (or GCD-safe store) with the same judgment. UI stays on MainActor; heavy work hops off. I don’t invent a BookMyShow feed implementation that isn’t in the registry.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Like button? | “Optimistic UI on MainActor; LikeActor for single-flight; re-validate after network await.” |
| Offline cache? | “Last-good page locally; don’t block UI on network.” |
| 10k scroll? | “Cancel + evict images; concurrency cap is part of the memory plan.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.
- **Shipped:** Race→actor migration instincts where resume-backed.

---

### Q10. Timeouts and kill switches on the feed?
**Answer:**

> “Page fetch gets a timeout — URLSession / API deadline or race against sleep — cancel the loser. Under thermal or bad network, kill switch disables parallel thumb prefetch and tightens image cache. Metrics: cancelled task rate, like-actor wait time, page success, memory warnings. Same Day 05 lesson: cancel is cooperative; design the stop path so the user never stares at a hung spinner.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Hung spinner? | “Cancel + error or last-good cache — never leave the user stuck.” |

**How can I relate to my case:**
- **Design:** Feed HLD with actors — label design.

---

## Brain puzzles (cover → think → check)

### Puzzle A — Stale page wins

User pull-to-refreshes twice fast. First response is slow and arrives last. Feed jumps backward.

**Fix you’d say:** Cancel the first Task (or bump a generation token). Only apply results if generation still matches.

---

### Puzzle B — Like actor + network await

```swift
actor LikeCoordinator {
 var inFlight: Set<PostID> = []
 func toggle(_ id: PostID) async throws {
 inFlight.insert(id)
 try await api.like(id) // await
 inFlight.remove(id)
 }
}
```

User taps unlike while like is in flight. What’s the reentrancy worry?

**Answer:** Another `toggle` can enter during await. `inFlight` and UI optimistic state can disagree. Coalesce intended final state; re-check after await; don’t assume you still “own” the post’s like state.

---

### Puzzle C — Prefetch stampede

TaskGroup adds one child per image URL on a 50-item page with no cap.

**Ask:** What hits the network / battery / memory?

**Answer:** Up to 50 parallel downloads and decodes. Cap concurrency (e.g. 4–6), cancel on scroll away, lower priority than the visible page fetch. Unbounded prefetch is how a “10k scroll” session jetsams.

---

### Puzzle D — 10k scroll OOM

User scrolls for an hour. Feed still “works” then the app is killed. Instruments shows image memory climbing.

**Fix you’d say:** Hard-cap L1 image cache; decode to display size off main; cancel off-screen loads; on memory warning purge L1 and stop prefetch. Optionally trim far post models. UIKit cell reuse / SwiftUI lazy views alone are not enough if the cache retains every bitmap ever shown.

---

Next: [06-module-drills.md](06-module-drills.md)
