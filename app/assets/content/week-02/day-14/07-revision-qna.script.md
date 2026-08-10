# Audio script — Sample 07 — Revision Q&A (day-14) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. MVVM vs Clean — when Clean? `(45s)`

Next. Q1. MVVM vs Clean — when Clean? `(45s)` Answer. I default to M V V M for a single screen with clear U I state. I reach for Clean-style UseCases when domain rules are shared across surfaces or we’re migrating a messy feature boundary — like Free Parking at District — so the domain isn’t trapped in a ViewModel. Incremental migration beats a big-bang rewrite. Follow-ups. Probe deeper?: District Free Parking extracted billing UseCases while simpler screens stayed M V V M — Clean where shared policy lived..

## §1 Q2. Search debounce + cancel ownership? `(45s)`

Next. Q2. Search debounce + cancel ownership? `(45s)` Answer. Debounce lives in the ViewModel as presentation policy. Each new query cancels the in-flight Task; cancellation is not a user-facing error. Completions check a generation token or task identity so out-of-order responses can’t win. That’s how we kept BMS search race-safer under M V V M. Follow-ups. Probe deeper?: Debounce and Task cancel sit in SearchViewModel; the repository does not own keystroke timing..

## §2 Q3. Single-flight token refresh? `(60s)`

Next. Q3. Single-flight token refresh? `(60s)` Answer. When many calls 401 together, only one refresh runs — waiters await that Task. On success, retry originals once; on failure, fan out logout. I isolate that behind an actor or serial critical section so we don’t mutate refresh state from unstructured tasks. Blind refresh storms revoke tokens and amplify outages. Follow-ups. Probe deeper?: Ten simultaneous 401s share one refresh Task — waiters join it, then retry once, instead of starting ten refreshes..

## §3 Q4. SSL pinning failure mode? `(45–60s)`

Next. Q4. SSL pinning failure mode? `(45–60s)` Answer. Pinning reduces MITM risk by requiring expected server identity, but a bad rotation bricks clients. On Ads we moved to URLSession with HTTPS, pinning, and a host whitelist. Separately, as design, I’d require backup pins and a monitored break-glass plan — I’m not claiming I shipped that full ops runbook. Follow-ups. Probe deeper?: Ads shipped URLSession + pinning + whitelist; backup pins and break-glass stay labeled design, not a claimed runbook..

## §4 Q5. Unknown SDUI component policy? `(30–45s)`

Next. Q5. Unknown SDUI component policy? `(30–45s)` Answer. Unknown component types skip with a metric — never crash the shell. If the root is empty after filtering, show a hard fallback header or splash. Fail-soft is how S D U I survives CMS mistakes at scale. Follow-ups. Probe deeper?: Skip unknown S D U I types with a metric; never crash the header shell on a CMS typo..

## §5 Q6. SDUI vs WebView? `(45s)`

Next. Q6. SDUI vs WebView? `(45s)` Answer. S D U I with a native registry keeps accessibility, performance, and action allowlisting under app control. A WebView is fine for open-ended content you don’t want to native-render, but it’s the wrong default for a primary home header you need to trust. Follow-ups. Probe deeper?: Native registry keeps a11y and allowlisted actions; WebView is for open-ended content you refuse to native-render..

## §6 Q7. Where pause ad / story video? `(30–45s)`

Next. Q7. Where pause ad / story video? `(30–45s)` Answer. Pause when the widget leaves visibility, on viewWillDisappear, on background, and in prepareForReuse. On Ads, HeroWidget made that an explicit contract so video didn’t keep playing off-screen on a revenue surface. Follow-ups. Probe deeper?: HeroWidget and Stories both pause on disappear/background/off-screen — media without visibility policy is a product bug..

## §7 Q8. Hybrid deeplink ownership? `(60s)`

Next. Q8. Hybrid deeplink ownership? `(60s)` Answer. Parse deeplinks at the app edge into an intent, then one router owns navigation. Dual UIKit/SwiftUI stacks that try to stay forever in sync are a bug factory — Grizzlies-style hybrid work needs one owner for exits. Follow-ups. Probe deeper?: One app-edge router owns hybrid exits; dual UIKit/SwiftUI stacks trying to stay forever in sync is the failure mode..

## §8 Q9. SwiftUI identity footgun? `(45s)`

Next. Q9. SwiftUI identity footgun? `(45s)` Answer. If identity changes every render — like UUID in body — SwiftUI tears down and rebuilds state. Stories pages need stable IDs so progress and media don’t reset while paging. Follow-ups. Probe deeper?: Stable Stories page IDs keep progress across updates; UUID-in-body rebuilds state every frame..

## §9 Q10. LE Bottom Sheet impact? `(30–45s)`

Next. Q10. LE Bottom Sheet impact? `(30–45s)` Answer. LE Bottom Sheet gave a lightweight overview instead of pushing full screens for many flows — Verified 30%+ fewer full-screen navigations on those flows. The win was product contract plus implementation, not a visual gimmick. Follow-ups. Probe deeper?: LE Bottom Sheet cut full-screen navigations for 30%+ of those flows by keeping overview glanceable over context..

## §10 Q11. Array as queue issue? `(30s)`

Next. Q11. Array as queue issue? `(30s)` Answer. Array.removeFirst shifts elements — O(n) per dequeue. I’d use a deque, two-stack queue, or ring, and I’d say that cost if I ever demo Array naively. Follow-ups. Probe deeper?: Array.removeFirst is O(n) per dequeue — say amortized O(1) only for a real deque or two-stack queue..

## §11 Q12. District AI tooling — senior framing? `(45–60s)`

Next. Q12. District AI tooling — senior framing? `(45–60s)` Answer. At District, AI assisted inside a Context Engineering envelope — protocols, patterns, and tests I still owned. Senior signal isn’t ‘AI wrote the app’; it’s architecture judgment, review, and XCTest/XCUITest discipline around the migration. Follow-ups. Probe deeper?: Senior framing is Context Engineering plus review ownership — never ‘AI wrote Free Parking.’. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “MVVM vs Clean — when Clean?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “MVVM vs Clean — when Clean?” — how do you answer without jargon? `(60–90s)` Answer. “I default to M V V M for a single screen with clear U I state. I reach for Clean-style UseCases when domain rules are shared across surfaces or we’re migrating a messy feature boundary — like Free Parking at District — so the domain isn’t trapped in a ViewModel. Incremental migration beats a big-bang rewrite.” Follow-ups. What concept is this really?: M V V M vs Clean — when Clean. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Search debounce + cancel ownership” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Search debounce + cancel ownership” just broke under load. What do you check first? `(60–90s)` Answer. “Debounce lives in the ViewModel as presentation policy. Each new query cancels the in-flight Task; cancellation is not a user-facing error. Completions check a generation token or task identity so out-of-order responses can’t win. That’s how we kept BMS search race-safer under M V V M.” Follow-ups. What concept is this really?: Search debounce + cancel ownership. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Single-flight token refresh”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Single-flight token refresh”. How do you diagnose? `(60–90s)` Answer. “When many calls 401 together, only one refresh runs — waiters await that Task. On success, retry originals once; on failure, fan out logout. I isolate that behind an actor or serial critical section so we don’t mutate refresh state from unstructured tasks. Blind refresh storms revoke tokens and amplify outages.” Follow-ups. What concept is this really?: Single-flight token refresh. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “SSL pinning failure mode”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “SSL pinning failure mode”. What do you say and what fix do you propose? `(60–90s)` Answer. “Pinning reduces MITM risk by requiring expected server identity, but a bad rotation bricks clients. On Ads we moved to URLSession with HTTPS, pinning, and a host whitelist. Separately, as design, I’d require backup pins and a monitored break-glass plan — I’m not claiming I shipped that full ops runbook.” Follow-ups. What concept is this really?: SSL pinning failure mode. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Unknown SDUI component policy”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Unknown SDUI component policy”? `(60–90s)` Answer. “Unknown component types skip with a metric — never crash the shell. If the root is empty after filtering, show a hard fallback header or splash. Fail-soft is how S D U I survives CMS mistakes at scale.” Follow-ups. What concept is this really?: Unknown S D U I component policy. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “SDUI vs WebView” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “SDUI vs WebView” and how you’d correct it? `(60–90s)` Answer. “S D U I with a native registry keeps accessibility, performance, and action allowlisting under app control. A WebView is fine for open-ended content you don’t want to native-render, but it’s the wrong default for a primary home header you need to trust.” Follow-ups. What concept is this really?: S D U I vs WebView. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Where pause ad / story video?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Where pause ad / story video?” — how do you answer without jargon? `(60–90s)` Answer. “Pause when the widget leaves visibility, on viewWillDisappear, on background, and in prepareForReuse. On Ads, HeroWidget made that an explicit contract so video didn’t keep playing off-screen on a revenue surface.” Follow-ups. What concept is this really?: Where pause ad / story video. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Hybrid deeplink ownership” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Hybrid deeplink ownership” just broke under load. What do you check first? `(60–90s)` Answer. “Parse deeplinks at the app edge into an intent, then one router owns navigation. Dual UIKit/SwiftUI stacks that try to stay forever in sync are a bug factory — Grizzlies-style hybrid work needs one owner for exits.” Follow-ups. What concept is this really?: Hybrid deeplink ownership. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T1. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. Main-thread rule under pressure? `(90–120s)`

Next. T2. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Cancellation honesty? `(90–120s)`

Next. T3. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Cache invalidation trap? `(90–120s)`

Next. T4. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Security theater vs real pinning? `(90–120s)`

Next. T5. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. SDUI unknown component in prod? `(90–120s)`

Next. T6. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. DI vs singletons under test? `(90–120s)`

Next. T7. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Prefetch that hurts scrolling? `(90–120s)`

Next. T8. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Actor reentrancy surprise? `(90–120s)`

Next. T9. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. They push you to invent a metric you don’t have? `(90–120s)`

Next. T10. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
