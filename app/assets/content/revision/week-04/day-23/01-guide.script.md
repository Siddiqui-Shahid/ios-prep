# Audio script — Revision guide — DSA HashMap / Heap + Mixed Unknown-Pattern
> Listen-only revision day guide from `day-23.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Deploy HashMap patterns: frequency, complement, prefix+K, sliding-window counts — and when hashing beats sorting Deploy Heap patterns: Top-K, merge K, Kth in stream — min-heap size K for Kth largest Run the 90s classify-before-code protocol on unlabeled problems.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 HashMap triggers

Next. 2.1 HashMap triggers. Expected O(1) lookup; pathological collisions → worst O(n). Say expected O(n) for one-pass solutions.

## §3 2.2 Heap triggers

Next. 2.2 Heap triggers. 2.2 Heap triggers.

## §4 2.3 Unknown-pattern protocol

Next. 2.3 Unknown-pattern protocol. 90s before coding: restate → brute force → constrain input → name structure → commit. Stuck → brute → constrain → pivot — not DP worship.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. BookMyShow synchronised dictionaries: Synchronised dictionaries — maps as shared mutable state needing a concurrency boundary, not “I optimized Dictionary hash.” BookMyShow backend-driven header & search: Search debounce — coalesce in-flight keys; cancel stale responses. GymFlow on-device AI: GymFlow cosine top-K — heap/select mental model for “best K neighbors,” not a claim you shipped CFBinaryHeap. Interview line (≤20s): “In product code I treat maps as keyed aggregation with concurrency respect; recommender top-K is the product cousin of heap patterns with a lexical fallback.”.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Two-sum complement — what is the key? 2. Subarray sum K — prefix+hash, not window 3. Top-K largest — min-heap size K, root is answer 4. Merge K lists — heap of heads, complexity.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
