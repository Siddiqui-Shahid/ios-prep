# Audio script — Sample 04 — Warm-up pool & Social Feed HLD (Q&A)
> Listen-only sample Q&A from `04-warmup-hld.md`. Spoken answers and follow-ups.

## §0 Q1. Name five warm-up topics you must have ready.

Next. Q1. Name five warm-up topics you must have ready Answer. Default mock set: (1) struct vs class, (2) copy on write, (3) weak vs unowned, (4) serial vs concurrent, (5) thread-safe dictionary. Alternate: P O P in ads, main-queue deadlock, actor isolation, Sendable, Task cancellation. IDs W1–W12 in 04 — speak from Answer points, compare to full answer. Follow-ups. Budget per def?: ~45–60s; safe dict design up to 60–90s.. All 12 before mock?: Skim 04; drill misses from flashcards.. Actor isolation warm-up?: One sentence: only one task mutates actor state at a time..

## §1 Q2. Actor isolation — warm-up answer shape?

Next. Q2. Actor isolation — warm-up answer shape? Answer. An actor serializes access to its mutable state — callers use await. Compiler enforces isolation instead of manual queue discipline. Contrast with G C D SafeDict: external serial queue vs language-supported isolation. Mention reentrancy only if follow-up asks. Follow-ups. vs class + lock?: Actor integrates with async/await; fewer forgotten lock paths.. MainActor?: U I-bound actor — common in SwiftUI/UIKit bridges.. Deep follow-up?: Reentrancy after await — deep pool D1..

## §2 Q3. Sendable — what do you say in 45s?

Next. Q3. Sendable — what do you say in 45s? Answer. Sendable marks types safe to share across concurrency domains — no unsynchronized mutable shared state. Value types often auto-Sendable; classes need careful design. @unchecked Sendable is an escape hatch — ethics question in deep pool. Tie to passing data into Tasks and actors. Follow-ups. @unchecked Sendable?: You promise thread safety — deep pool ethics.. NSDictionary Sendable?: Legacy reference types — often not without wrapping.. Interview depth?: Definition + one example (struct model vs mutable class)..

## §3 Q4. Social Feed HLD — what is the prompt?

Next. Q4. Social Feed HLD — what is the prompt? Answer. “Design the client side of a social/listing feed for a large consumer app — BookMyShow-scale. Clarify first, then high-level design only — no full LLD.” 20 min block. Honesty: design skill exercise; tie ads slots to BookMyShow Ads pipeline + HeroWidget lifecycle instinct only; cite BookMyShow I M O C + crash-free at scale for scale when asked “how big.” Follow-ups. Client only?: Yes — A P I consumption, caching, U I list — not backend microservices LLD.. Incomplete OK?: Interviewer cuts at 20 min — note gaps in retro.. Invent metrics?: No fake latency SLAs — clarify with interviewer..

## §4 Q5. What clarifying questions should you ask?

Next. Q5. What clarifying questions should you ask? Answer. Ask ~4–6 before drawing boxes: organic vs ads mixing rules? Pagination (cursor vs offset)? Offline / stale content OK? Image/video autoplay? Realtime invalidation vs pull-to-refresh? Approximate daily active users / latency targets? (May cite 30L+ daily active users as Verified BookMyShow I M O C + crash-free at scale scale — do not invent new numbers.) Follow-ups. Cursor vs offset?: Cursor stable for live feeds; offset breaks on inserts.. Ads mixing?: Slot injection without forking feed pipeline — BookMyShow Ads pipeline + HeroWidget lifecycle instinct.. Skip clarify?: Weak signal — looks like guessing requirements..

## §5 Q6. HLD bullets — caching and scroll?

Next. Q6. HLD bullets — caching and scroll? Answer. A P I: cursor pagination request/response. Caching: memory + disk tiers; TTL / invalidation sketch. Images: prefetch ahead; cancel in-flight when cell scrolls off screen. Concurrency: never block main; debounce/cancel duplicate fetches. Failure: empty, error, retry states. Ads: inject slots without duplicating entire feed pipeline. Follow-ups. Cancel on scroll away?: Same instinct as BookMyShow backend-driven header & search debounce / cancel in-flight — light metaphor.. Memory pressure?: Trim distant pages from memory cache.. Scorecard row?: MockScorecard “Mini SD — Social Feed” checks these areas..

## §6 Q7. Task cancellation — warm-up tie-in?

Next. Q7. Task cancellation — warm-up tie-in? Answer. Swift Tasks cancel cooperatively — check Task.isCancelled at await boundaries; propagate cancellation to URLSession work. Feed use case: user scrolls fast → cancel stale image loads. Do not claim a specific BMS metric — describe the pattern. Follow-ups. vs G C D cancel?: No automatic kill — cooperative for both.. Structured concurrency?: Child tasks cancel with parent scope.. Feed high level design link?: Prefetch + cancel pair is the client-side win..
