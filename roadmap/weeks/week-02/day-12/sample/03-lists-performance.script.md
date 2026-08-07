# Audio script — Sample 03 — Lists & performance (Q&A)
> Listen-only sample Q&A from `03-lists-performance.md`. Spoken answers and follow-ups.

## §0 Q1. When do I use `List` vs `LazyVStack` vs eager `VStack`?

Next. Q1. When do I use `List` vs `LazyVStack` vs eager `VStack`? Answer. List: platform list behaviors, edit modes, large collections. LazyVStack in ScrollView: custom scroll layouts, large stacks. Eager VStack: tiny static content only — death for thousands of rows because every child’s body runs up front. Lazy containers build on demand as rows enter the viewport. Follow-ups. Lazy still janks?: Profile data path — image decode, main-thread JSON, god observable — not only container.. 10k rows in VStack?: Never for production — memory and layout cost explode.. UITableView cousin?: Same “only visible cells matter” idea — Day 11 reuse discipline..

## §1 Q2. What are the row-level performance rules?

Next. Q2. What are the row-level performance rules? Answer. Stable Identifiable — never UUID() per body. Avoid id: \.self when value equality changes often. Don’t observe entire catalog inside each row — pass row models. Precompute formatted strings in model. Images: async + decode/size budgets. Scope animations — don’t.animation the whole tree. Follow-ups. Format JSON in row body?: Bad — precompute in model or cached formatter.. Row observes root @Observable?: Pulls entire catalog invalidations into row — pass slice.. Shadows and blurs on every row?: Expensive — use sparingly; measure..

## §2 Q3. What is an invalidation storm?

Next. Q3. What is an invalidation storm? Answer. One monolithic @Observable with many fields, read by a root view, invalidates a huge subtree when any field changes. Legacy ObservableObject can broadcast coarsely too. Fix: split models — player vs chrome vs catalog — and pass slices into children so rows only observe what they need. Follow-ups. Observation unread fields?: @Observable skips invalidation for unread properties — but root still reads too much if model is god-object.. Whole screen redraw symptom?: Typing in search refreshes unrelated chrome — split state.. Equatable View micro-opt?: Useful for rare-changing expensive subtrees — measure first; don’t sprinkle early..

## §3 Q4. How should Stories player lists handle progress updates?

Next. Q4. How should Stories player lists handle progress updates? Answer. StoriesPlayerModel (@Observable) owns timeline: idle → loading → playing ⇄ paused → finished. Views render progress from model — not ad-hoc view timers alone. Stable page IDs in ForEach so progress ticks don’t reset identity. Pause on onDisappear and scene background. Adjacent media prefetch with budget (Day 11). Follow-ups. CTA navigation?: Host callback — S D K doesn’t push tickets view controller internally.. Image bytes?: Injectable loader protocol — host variance.. UIKit host?: UIHostingController façade OK — public A P I shouldn’t force one nav paradigm..

## §4 Q5. What belongs in `body` vs the model for list screens?

Next. Q5. What belongs in `body` vs the model for list screens? Answer. body: compose views from state; cheap cached formatting. Model /.task: network fetch, sorting large arrays, disk writes. Fetch inside body is an anti-pattern. Sort 10k rows every body call will jank even inside LazyVStack. Follow-ups..task(id:)?: Refetch when stable id changes — not every body pass.. Cancel on disappear?: Same discipline as UIKit — pause and cancel work.. Testing list logic?: XCTest observable model / UseCase primary — not ViewInspector alone..

## §5 Q6. How does SDUI connect to list identity?

Next. Q6. How does SDUI connect to list identity? Answer. Registry-rendered S D U I trees should use server-stable node ids for ForEach /.id. Array indices break when CMS inserts a banner above — rows jump, state attaches to wrong node, analytics lie. Same stable-ID discipline as native SwiftUI lists. Follow-ups. Unknown node type?: Skip + metric — Day 10 fail-soft.. Mock #2 S D U I track?: Version gate + registry + fallback — Day 14.. Native vs S D U I list?: Both need stable identity — different data source, same rule..

## §6 Q7. What is the lists + performance decision card?

Next. Q7. What is the lists + performance decision card? Answer. Large collections → lazy container + stable ids + cheap body. Split models to avoid storms. Images async with budgets. No UUID in body. Stories: model timeline + stable page ids + pause on disappear. Profile before micro-opts like Equatable View. Follow-ups. AnyView erasure?: Rare need — kills optimization and clarity.. All @State tiny screen?: OK; async spaghetti if you never hoist domain.. Next topic?: Stories S D K (Raw / Miami Heat) production — 04-production-s10.md..

## §7 Q8. Is Equatable View conformance worth it?

Next. Q8. Is Equatable View conformance worth it? Answer. Treat it as a measured micro-opt. Equatable View can help expensive subtrees that rarely change, but sprinkling it everywhere early is noise. Prefer narrowing observation first. Measure before and after. Understanding how Observation already tracks accesses matters more than ritual Equatable. Simple Text rows usually don’t need it; a heavy chart leaf with rare updates might. Follow-ups. When yes?: Heavy chart leaf, rare updates.. When no?: Simple Text rows — don’t sprinkle.. AnyView instead?: Usually worse for clarity and optimization..

## §8 Q9. How do you test SwiftUI state logic?

Next. Q9. How do you test SwiftUI state logic? Answer. Unit-test observable models and UseCases in XCTest — that’s where Stories phase transitions and pause rules live. Snapshots are optional for chrome. UITests cover critical open/close paths only. Flaky sleep-based UITests are a smell — same testing culture as District’s review gates (District Free Parking + Clean/M V V M + AI tooling). ViewInspector is an optional aid, not the primary strategy. Follow-ups. District Free Parking + Clean/M V V M + AI tooling link?: Tests as gate, not theater.. ViewInspector?: Optional aid — don’t rely exclusively.. Async tests?: Swift Testing / XCTest async..
