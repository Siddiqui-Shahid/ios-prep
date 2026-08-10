# Audio script — Sample 04 — Trees in production systems (Q&A)
> Listen-only sample Q&A from `04-production-trees.md`. Spoken answers and follow-ups.

## §0 Q1. How do trees show up in SDUI / header work (BookMyShow backend-driven header & search)?

Next. Q1. How do trees show up in SDUI / header work (BookMyShow backend-driven header & search)? Answer. CMS and header documents are nested component trees. Walking parent/child layout is DFS-shaped; processing each section depth can feel BFS-like. Schema versioning and unknown-type fallbacks matter more than naming LeetCode level-order. Do not claim: “We used LeetCode BFS in the header renderer.” Follow-ups. ≤20s interview line?: “Tree traversals map to S D U I and view trees — BFS for level-aware passes, DFS for path/subtree decisions.”. What is verified for BookMyShow backend-driven header & search?: Protocol-driven header, search debounce, M V V M state.. Day 25 link?: Brief B S D U I renderer — same fail-soft instinct..

## §1 Q2. What is the Stories SDK tree angle (Stories SDK (Raw / Miami Heat))?

Next. Q2. What is the Stories SDK tree angle (Stories SDK (Raw / Miami Heat))? Answer. Stories S D K has story/page/frame hierarchy — a tree of ownership and isolation boundaries. Traversal thinking helps debug nested presenters, but this is not a D S A flex. ≤20s: “Nested page/frame structure forced clear ownership — same discipline as bounding recursion depth.” Follow-ups. Resume anchor?: Standalone reusable Stories S D K across portfolio apps.. Max-depth guard analogy?: Design: fail-soft placeholder after N nests — crash-free culture, not a shipped claim unless verified.. STAR timing?: Full STAR on Day 26; today ≤20s hooks while coding..

## §2 Q3. How do deeplinks relate to tree walks (Hybrid UI / deeplinks)?

Next. Q3. How do deeplinks relate to tree walks (Hybrid UI / deeplinks)? Answer. Deeplink destinations and nested coordinators form a route tree. Resolving a specific path is DFS-like; listing siblings at a navigation level is BFS-like. Same clarify-first habit as interview tree problems: path vs level concern. Follow-ups. Verified anchor?: Hybrid U I; deeplinks + navigation/lifecycle.. Production iterative walk?: Prefer iterative when CMS/JSON depth is unbounded — reliability over clever recursion.. Invented metric?: Forbidden — no “reduced tree walk latency X%.”.

## §3 Q4. What metrics may I mention on a DSA tree day?

Next. Q4. What metrics may I mention on a DSA tree day? Answer. Allowed if behavioral drift: 30L+ daily active users, 99.95% crash-free, 30%+ nav as company context. Qualitative: reusable S D K, hybrid nav shipped. Not allowed: invented “solved N trees in prod” or fake latency % from traversal choice. Follow-ups. BookMyShow I M O C + crash-free at scale soft touch?: Fail-soft / depth guards tie to crash-free culture — not a Memory Graph war story.. Learning-lab code?: All LeetCode Swift in code/ — interview practice, not shipped product.. When full STAR?: Day 26 architecture/behavioral — not while narrating LC medium #5..

## §4 Q5. What is the 45s bridge if asked “when do you use this at work?”?

Next. Q5. What is the 45s bridge if asked “when do you use this at work?”? Answer. “I don’t force interview patterns into product code for sport. Where trees appear — S D U I documents, view hierarchies, deeplink graphs — I use the same rule: level-aware work leans BFS-shaped; path and subtree decisions lean DFS-shaped. In production I budget depth and prefer iterative walks when input is untrusted CMS depth, because crash-free sessions beat clever recursion.” Follow-ups. Applied max-depth guard?: Design-only unless verified — placeholder after N nests.. Parent map for component path?: O(n) preprocess — design interview, not resume claim.. Anti-pattern?: “Our search is level-order BFS” — cosplay..

## §5 Q6. What production anti-patterns should I avoid?

Next. Q6. What production anti-patterns should I avoid? Answer. Don’t map every LC problem to a resume bullet. Don’t invent fill-rate or latency ms from traversal choice. Don’t claim Instruments proved a “tree optimization.” Don’t blur learning-lab Swift with BookMyShow production. Keep hooks ≤20s while coding; save STAR for behavioral days. Follow-ups. Honest framing for depth guard?: “I’d design fail-soft — tie to 99.95% mindset, not ‘I shipped this guard.’”. STAR pointers?: BookMyShow backend-driven header & search header, Stories S D K (Raw / Miami Heat) S D K, Hybrid U I / deeplinks deeplink, BookMyShow I M O C + crash-free at scale reliability — story-bank IDs.. After sample?: 07-revision-qna.md for timed two-layer Q&A..
