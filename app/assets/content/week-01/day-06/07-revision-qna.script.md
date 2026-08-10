# Audio script — Sample 07 — Revision Q&A (day-06) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. Explain two pointers? `(30–45s)`

Next. Q1. Explain two pointers? `(30–45s)` Answer. Two pointers means I maintain two indices into an array or string and move them according to an invariant. Classic opposite-ends: palindrome checks or container-with-most-water, where I move the pointer that can still improve the answer. Same-direction patterns include a write pointer that compacts non-zeroes in place. It’s usually O(n) time and O(1) extra space when the input is already suitable — if I must sort first, I say that cost up front. Follow-ups. Fast/slow vs opposite ends?: Fast/slow detects cycles or midpoints; opposite ends shrink a sorted/range invariant from both sides.. When does sorting + two pointers beat a hash map?: When O(1) extra space matters and you can afford n log n sort, or you need ordered pairs/triplets.. Write pointer vs allocate a new array?: Write pointer compacts in place with O(1) extra space; a new array is clearer but uses O(n) memory..

## §1 Q2. Sliding window vs two pointers? `(45s)`

Next. Q2. Sliding window vs two pointers? `(45s)` Answer. A sliding window is a contiguous subarray or substring where I expand the right edge to include elements and shrink the left when a constraint breaks — like longest substring without repeating characters. Two pointers is the broader family that includes windows, opposite ends, and write pointers. I’d call it a window when the answer is about a contiguous range with a running condition. Follow-ups. Fixed vs variable window?: Fixed keeps constant length; variable expands/shrinks with a constraint like unique chars or sum ≥ target.. Why negatives break some window sum tricks?: Shrinking the left side no longer monotonically improves/violates the sum, so the two-pointer invariant fails.. Off-by-one checklist?: Confirm inclusive bounds, when left advances (lastIndex+1), and length as right-left+1 vs half-open ranges..

## §2 Q3. When prefix sums? `(30–45s)`

Next. Q3. When prefix sums? `(30–45s)` Answer. Prefix sums help when I need many range sums: build a prefix array so a range is a subtraction. Product-of-array-except-self is the same idea with prefix and suffix products without division. If the problem has negatives and asks for subarray sums equaling k, I shift to prefix sums plus a hash map — pure two-pointer windows usually need monotonic positivity. Follow-ups. Space trade-off of storing prefix?: O(n) prefix storage buys O(1) range queries; you can sometimes overwrite the input if mutation is allowed.. Difference from Kadane?: Prefix+hash answers many range/sum-k queries; Kadane finds one best contiguous sum in O(n)/O(1).. Mutable vs immutable prefix?: Building into a new array is safer; mutating in place saves memory but destroys the original values..

## §3 Q4. Why narrate before coding? `(30s)`

Next. Q4. Why narrate before coding? `(30s)` Answer. Narrating the approach first lets the interviewer correct constraints early and shows how I think — brute force, why a pattern fits, complexity, and edges. Silent coding hides mistakes until the end. As a senior signal I’d rather burn sixty seconds aligning than ten minutes implementing the wrong plan. Follow-ups. What if they say ‘just code’?: Still state brute force, chosen approach, and complexity in one breath, then code — keep the alignment tiny.. How do you handle mid-problem constraint change?: Pause, restate the new invariant, scrap the broken assumption, and adjust the plan before typing more.. Time split for 45-minute interview?: Roughly a few minutes clarifying/approach, most of the time coding+tests, leave a buffer to dry-run edges..

## §4 Q5. Two Sum — approach? `(60–90s)`

Next. Q5. Two Sum — approach? `(60–90s)` Answer. Constraints — is there exactly one answer? Duplicates allowed? Brute force tries all pairs in O(n²). Sorting would lose indices unless I store pairs, so I’ll scan once with a dictionary from value to index: for each number I look up target minus that number; if found I return both indices; otherwise I store the current value. Time O(n), space O(n). Edges: empty input, no valid pair, negatives, and not using the same index twice. Coding that now. Follow-ups. Return all pairs?: Scan with a map of value→indices (or sort+two pointers) and emit every valid pair while skipping duplicates if required.. O(1) space if allowed to sort?: Sort then two-pointer for the values; recovering original indices needs stored pairs, so space isn’t truly free.. Streaming numbers?: Keep a hash of seen values online; you can’t sort the whole stream, so map-based lookup is the natural fit..

## §5 Q6. Buy/Sell Stock — approach? `(60–90s)`

Next. Q6. Buy/Sell Stock — approach? `(60–90s)` Answer. One transaction — buy once, sell later. Brute force is all buy/sell pairs O(n²). I’ll track the minimum price so far and at each day compute profit as price minus that minimum, keeping the max profit. Time O(n), space O(1). Edges: single price returns zero; strictly decreasing returns zero. Coding the one-pass now. Follow-ups. k transactions?: Move to DP over day and transaction count (or state machine of hold/sold per trade), not the one-pass min tracker.. With cooldown?: Track states like hold / sold-today / cooldown so you can’t buy on the day after a sell.. Fee per transaction?: Subtract the fee when transitioning out of a sell (or into a buy) inside the DP/state updates..

## §6 Q7. Valid Palindrome — approach? `(60–90s)`

Next. Q7. Valid Palindrome — approach? `(60–90s)` Answer. I’ll use two pointers from both ends. Skip non-alphanumeric characters, compare lowercased equals, move inward. In Swift String isn’t O(1) random access, so I’ll convert to an array of characters for clear indexing — O(n) space — unless you prefer String.Index walking. Time O(n). Edges: empty string is true; all punctuation is true; I’ll assume ASCII alnum per typical LeetCode unless you want unicode rules. Follow-ups. Unicode normalization?: Ask whether to normalize (NFC) and define alnum on Characters/scalars; LeetCode-style ASCII is the usual default.. O(1) extra space with indices?: Walk with String.Index from both ends instead of materializing a [Character] array.. Almost-palindrome (one delete)?: On mismatch, try skipping left or right once and check whether either remainder is a palindrome..

## §7 Q8. Container With Most Water — approach? `(60–90s)`

Next. Q8. Container With Most Water — approach? `(60–90s)` Answer. Area is min of the two heights times the distance between indices. Brute checks all pairs O(n²). I’ll start at both ends for maximum width and move the shorter pointer inward, because width always shrinks and only a taller short side can improve the min height. Time O(n), space O(1). Edges: exactly two lines; all heights equal. Coding that. Follow-ups. Prove why move shorter?: Width shrinks either way; only raising the shorter height can increase min(hL,hR), so move that pointer.. Histogram largest rectangle contrast?: Histogram uses a monotonic stack over contiguous bars; container-with-most-water only needs opposite-end two pointers.. 3D variant joke → stay focused?: Acknowledge briefly, then return to the 1D proof and finish the O(n) two-pointer solution they asked for..

## §8 Q9. Longest Substring Without Repeating — approach? `(60–90s)`

Next. Q9. Longest Substring Without Repeating — approach? `(60–90s)` Answer. I need the longest contiguous substring with unique characters. I’ll keep a sliding window and a map of character to last index. Expand right; if the character was seen inside the window, move left to lastIndex + 1 — taking max so left never jumps backward. Track max window length. Each index moves at most once so O(n) time, space O(alphabet). Edges: empty string, all unique, all identical characters. I’ll dry-run ‘abba’ mentally for the left jump. Coding now. Follow-ups. At most k distinct characters?: Variable window with a frequency map; shrink left while distinct count exceeds k and track max length.. Return the substring not length?: Also record the best (start, end) whenever the window length updates, then slice that range.. Byte vs Character in Swift?: Clarify whether uniqueness is on Character/scalars; don’t assume UTF-8 byte indexing equals Character bounds..

## §9 Q10. Maximum Subarray — approach? `(60–90s)`

Next. Q10. Maximum Subarray — approach? `(60–90s)` Answer. Maximum contiguous sum — brute is O(n²). Kadane keeps a running sum: at each value, running becomes max of starting fresh at x versus extending running + x, and I track the global max. That correctly handles all-negative arrays by returning the largest element. Time O(n), space O(1). Edges: single element; all negative; mix of signs. Coding Kadane. Follow-ups. Also return bounds?: When starting a new run or extending, store start/end indices alongside the best sum.. Circular maximum subarray?: Compare standard Kadane max with totalSum − minimum subarray sum (careful with the all-negative case).. 2D kadane?: Fix left/right column bounds, compress rows to a 1D temp, and run Kadane on that temp for each pair..

## §10 Q11. Product Except Self — approach? `(60–90s)`

Next. Q11. Product Except Self — approach? `(60–90s)` Answer. Each output index is the product of all other elements without division. I’ll put prefix products into the output array on a left-to-right pass, then multiply by a running right product on the way back. Time O(n). Extra space O(1) if the output array doesn’t count. Edges: one zero, two zeros, negatives. I won’t use division because zeros break it and the prompt forbids it. Follow-ups. Follow-up O(1) extra?: The left-pass into output plus right running product already uses O(1) extra if the output array doesn’t count.. Modular product?: Apply modular multiplies on the prefix/suffix passes; still avoid division, and define behavior with zeros carefully.. Streaming?: You generally need two passes or stored prefixes — a single online pass can’t know future factors without extra state..

## §11 Q12. Move Zeroes / write pointer — approach? `(60s)`

Next. Q12. Move Zeroes / write pointer — approach? `(60s)` Answer. I’ll keep a write index. Scan left to right, and whenever I see a non-zero I write it at the write index and advance. Then fill the tail with zeroes. That keeps relative order and uses O(1) extra space. Edges: no zeroes, all zeroes, already compacted. Follow-ups. Move zeroes to front?: Write non-zeroes from the end backward (or collect zeroes first), preserving relative order of non-zeroes as required.. removeElement general pattern?: Same write pointer: copy keepers forward and return the new logical length.. Why not removeAll repeatedly?: Repeated removals shift the array and become quadratic; one write-pointer pass stays linear..

## §12 Q13. 3Sum — approach? `(90s)`

Next. Q13. 3Sum — approach? `(90s)` Answer. I’ll sort, then for each index i run two pointers on the remainder looking for sum zero, skipping duplicate values so we don’t emit the same triplet. Sorting costs n log n; the nested scan is O(n²). Edges: fewer than three numbers, all zeros, heavy duplicates. Coding sort plus two-sum now. Follow-ups. Probe deeper?: For [-1,0,1,2,-1,-4], after sorting skip duplicate -1 anchors so you emit [-1,0,1] once instead of three identical triplets..

## §13 Q14. Min Size Subarray Sum — approach? `(90s)`

Next. Q14. Min Size Subarray Sum — approach? `(90s)` Answer. Assuming positive numbers, I’ll expand a right pointer adding to a running sum; while the sum is at least target I’ll shrink from the left and track the minimum window length. If I never reach the target, return zero. Each pointer moves at most n times so O(n). If negatives were allowed, this shrink logic would break and I’d switch strategies. Follow-ups. Probe deeper?: For target 7 and [2,3,1,2,4,3], expand until sum ≥ 7 then shrink to window [4,3] of length 2 — each pointer moves at most n times..

## §14 Q15. Group Anagrams — approach? `(60–90s)`

Next. Q15. Group Anagrams — approach? `(60–90s)` Answer. Anagrams share a sorted character key or a 26-length count signature. I’ll map key to a list of strings and return the buckets. Sorted keys are O(n·k log k); count signatures are O(n·k). Edges: empty strings, single characters, already identical inputs. Follow-ups. Probe deeper?: Key "aet" (sorted) or a 26-count signature buckets eat/tea/ate into one list without comparing every pair.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §15 I1. A junior asks you in standup: “Explain two pointers?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “Explain two pointers?” — how do you answer without jargon? `(60–90s)` Answer. “Two pointers means I maintain two indices into an array or string and move them according to an invariant. Classic opposite-ends: palindrome checks or container-with-most-water, where I move the pointer that can still improve the answer. Same-direction patterns include a write pointer that compacts non-zeroes in place. It’s usually O(n) time and O(1) extra space when the input is already suitable — if I must sort first, I say that cost up front.” Follow-ups. What concept is this really?: Explain two pointers. How do you prove it?: Give a tiny example or production boundary..

## §16 I2. Production symptom: something related to “Sliding window vs two pointers” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Sliding window vs two pointers” just broke under load. What do you check first? `(60–90s)` Answer. “A sliding window is a contiguous subarray or substring where I expand the right edge to include elements and shrink the left when a constraint breaks — like longest substring without repeating characters. Two pointers is the broader family that includes windows, opposite ends, and write pointers. I’d call it a window when the answer is about a contiguous range with a running condition.” Follow-ups. What concept is this really?: Sliding window vs two pointers. How do you prove it?: Give a tiny example or production boundary..

## §17 I3. Interviewer never names the topic. They describe a mess that maps to “When prefix sums”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “When prefix sums”. How do you diagnose? `(60–90s)` Answer. “Prefix sums help when I need many range sums: build a prefix array so a range is a subtraction. Product-of-array-except-self is the same idea with prefix and suffix products without division. If the problem has negatives and asks for subarray sums equaling k, I shift to prefix sums plus a hash map — pure two-pointer windows usually need monotonic positivity.” Follow-ups. What concept is this really?: When prefix sums. How do you prove it?: Give a tiny example or production boundary..

## §18 I4. Code review: you spot a smell around “Why narrate before coding”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Why narrate before coding”. What do you say and what fix do you propose? `(60–90s)` Answer. “Narrating the approach first lets the interviewer correct constraints early and shows how I think — brute force, why a pattern fits, complexity, and edges. Silent coding hides mistakes until the end. As a senior signal I’d rather burn sixty seconds aligning than ten minutes implementing the wrong plan.” Follow-ups. What concept is this really?: Why narrate before coding. How do you prove it?: Give a tiny example or production boundary..

## §19 I5. What happens if a teammate ignores the rule behind “Two Sum — approach”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Two Sum — approach”? `(60–90s)` Answer. “Constraints — is there exactly one answer? Duplicates allowed? Brute force tries all pairs in O(n²). Sorting would lose indices unless I store pairs, so I’ll scan once with a dictionary from value to index: for each number I look up target minus that number; if found I return both indices; otherwise I store the current value. Time O(n), space O(n). Edges: empty input, no valid pair, negatives, and not using the same index twice. Coding that now.” Follow-ups. What concept is this really?: Two Sum — approach. How do you prove it?: Give a tiny example or production boundary..

## §20 I6. Walk me through a failed interview answer on “Buy/Sell Stock — approach” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Buy/Sell Stock — approach” and how you’d correct it? `(60–90s)` Answer. “One transaction — buy once, sell later. Brute force is all buy/sell pairs O(n²). I’ll track the minimum price so far and at each day compute profit as price minus that minimum, keeping the max profit. Time O(n), space O(1). Edges: single price returns zero; strictly decreasing returns zero. Coding the one-pass now.” Follow-ups. What concept is this really?: Buy/Sell Stock — approach. How do you prove it?: Give a tiny example or production boundary..

## §21 I7. A junior asks you in standup: “Valid Palindrome — approach?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Valid Palindrome — approach?” — how do you answer without jargon? `(60–90s)` Answer. “I’ll use two pointers from both ends. Skip non-alphanumeric characters, compare lowercased equals, move inward. In Swift String isn’t O(1) random access, so I’ll convert to an array of characters for clear indexing — O(n) space — unless you prefer String.Index walking. Time O(n). Edges: empty string is true; all punctuation is true; I’ll assume ASCII alnum per typical LeetCode unless you want unicode rules.” Follow-ups. What concept is this really?: Valid Palindrome — approach. How do you prove it?: Give a tiny example or production boundary..

## §22 I8. Production symptom: something related to “Container With Most Water — approach” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Container With Most Water — approach” just broke under load. What do you check first? `(60–90s)` Answer. “Area is min of the two heights times the distance between indices. Brute checks all pairs O(n²). I’ll start at both ends for maximum width and move the shorter pointer inward, because width always shrinks and only a taller short side can improve the min height. Time O(n), space O(1). Edges: exactly two lines; all heights equal. Coding that.” Follow-ups. What concept is this really?: Container With Most Water — approach. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §23 T1. Security theater vs real pinning? `(90–120s)`

Next. T1. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T2. SDUI unknown component in prod? `(90–120s)`

Next. T2. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T3. DI vs singletons under test? `(90–120s)`

Next. T3. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T4. Prefetch that hurts scrolling? `(90–120s)`

Next. T4. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T5. Actor reentrancy surprise? `(90–120s)`

Next. T5. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T6. They push you to invent a metric you don’t have? `(90–120s)`

Next. T6. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T7. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T7. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §30 T8. They want a one-tool forever answer? `(90–120s)`

Next. T8. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §31 T9. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T9. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §32 T10. Main-thread rule under pressure? `(90–120s)`

Next. T10. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
