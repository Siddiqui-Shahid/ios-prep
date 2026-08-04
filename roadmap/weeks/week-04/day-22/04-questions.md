# 04 — Questions (two-layer Q&A)

> **How to practice:** Cover **Full spoken answer**. Speak from **Answer points** only. Uncover and compare.  
> Timing: Normal ≈ 30–45s (some 45–60s) · Tricky ≈ 90–120s.  
> Every question uses the same shape.

---

## Normal questions

### Q1. When do you choose BFS over DFS on a tree? `(30–45s)`

**Answer points (frame first):**
- Levels / width / unweighted shortest → BFS
- Path / subtree / LCA / structure combine → DFS
- Space: queue width vs recursion height
- One production shape hook only if natural (SDUI depth vs path resolve)

**Agenda opener:**  
> “Trigger first — levels versus structure — then space.”

**Full spoken answer:**  
> “I choose BFS when the prompt is level-oriented — level order, zigzag, side view — or when I need shortest path in an unweighted tree. I choose DFS when I care about paths, subtrees, or combining children results like height, diameter, or LCA. Space-wise BFS holds a level of width w, DFS holds height h on the stack. In product terms, a depth-by-depth layout pass feels BFS-shaped; resolving a nested component path feels DFS-shaped.”

**Common wrong answer:**  
> “BFS is always better” or “DFS is faster.” (Same O(n) visits; different access order and space profile.)

**Follow-up ladder:**
- **L1:** Extremely wide tree — what changes?
- **L2:** Unweighted vs weighted shortest path?
- **L3:** When would you DFS with an explicit depth parameter instead of BFS?

**Provenance:** Learning-lab · tree patterns; soft Verified · S3 shape

---

### Q2. What’s the time and space of tree traversal? `(30–45s)`

**Answer points:**
- Visit each node once → O(n) time
- Space O(h) recursion or O(w) queue
- Worst O(n) skewed or full-wide
- Balanced BST height ~ O(log n)
- Don’t call recursive DFS O(1)

**Agenda opener:**  
> “O(n) visits — space is height or width.”

**Full spoken answer:**  
> “Any full traversal is O(n) time because each node is processed a constant number of times. Recursive DFS uses O(h) call-stack space; BFS uses O(w) for the widest level. Worst case both can be O(n) — skewed chain for height, bushy level for width. On a balanced BST I’d say O(log n) height. I never call recursive DFS O(1) space unless I’m explicitly excluding the stack, and interviewers usually want the stack counted.”

**Common wrong answer:**  
> “BFS is O(1) space” or “recursion is free.”

**Follow-up ladder:**
- **L1:** What is h for a linked-list-shaped tree?
- **L2:** Output space for level-order arrays — count it?
- **L3:** Morris traversal trade-off?

**Provenance:** Learning-lab

---

### Q3. How do you validate a BST correctly? `(30–45s)`

**Answer points:**
- Bounds (low, high) on each node **or** inorder strictly increasing
- Parent-only check is wrong
- Clarify duplicate policy
- O(n)/O(h)

**Agenda opener:**  
> “Bounds or sorted inorder — not parent-only.”

**Full spoken answer:**  
> “Comparing each node only to its parent is insufficient — a value can satisfy the parent and still violate an ancestor. I DFS with exclusive low and high bounds updated as I go left and right, or I do an inorder walk and ensure values are strictly increasing. I clarify whether duplicates are allowed. Time O(n), space O(h).”

**Common wrong answer:**  
> “Left less than node and right greater is enough locally.” (Misses ancestor constraints.)

**Follow-up ladder:**
- **L1:** Show the classic counterexample (4 under 6 under 5).
- **L2:** Duplicate keys — left ≤ or <?
- **L3:** Recover a BST from a swapped pair?

**Provenance:** Learning-lab

---

### Q4. Explain level-order traversal implementation. `(30–45s)`

**Answer points:**
- Queue + `levelCount = queue.count` inner loop
- Collect or process per level
- Empty root → []
- Zigzag = reverse alternate levels

**Agenda opener:**  
> “Queue waves — snapshot count each level.”

**Full spoken answer:**  
> “I BFS with a queue starting at the root. While the queue isn’t empty, I snapshot the current count as the level size, dequeue that many nodes, enqueue their children, and append that level’s values to the result. That snapshot is what keeps levels from mixing. Empty root returns an empty list. For zigzag I reverse every other level after collecting it.”

**Common wrong answer:**  
> “Just BFS into one flat list” when the API wants `[[Int]]`.

**Follow-up ladder:**
- **L1:** Right side view from the same skeleton?
- **L2:** `removeFirst` cost on Array?
- **L3:** N-ary level order?

**Provenance:** Learning-lab · see `code/TreeBFS.swift`

---

### Q5. How does recursive LCA work on a binary tree? `(45s)`

**Answer points:**
- Null or match p/q → return node
- Recurse L/R
- Both non-null → current is LCA
- Else bubble non-null side
- Contrast BST walk O(h)

**Agenda opener:**  
> “Postorder markers — split means current.”

**Full spoken answer:**  
> “For a general binary tree I recurse: if the node is null or equals p or q, I return it. I recurse left and right. If both sides return non-null, the current node is the LCA because the targets split here. If only one side is non-null, I bubble that up. I confirm both nodes exist in the tree. Complexity O(n) time and O(h) space. If it’s a BST, I’d instead walk comparing values in O(h).”

**Common wrong answer:**  
> Using BST comparison walk on a non-BST.

**Follow-up ladder:**
- **L1:** Parent pointers available — alternate approach?
- **L2:** LCA of more than two nodes?
- **L3:** First common ancestor in a deeplink route tree (shape analogy)?

**Provenance:** Learning-lab; soft Verified · S13 route-tree analogy

---

### Q6. Preorder vs inorder vs postorder — when each? `(30–45s)`

**Answer points:**
- Pre: copy/serialize prefix, path push before children
- In: BST sorted ops
- Post: height/diameter/LCA combine after children
- Don’t force inorder on non-BST for “sorted”

**Agenda opener:**  
> “When I process relative to children decides the order.”

**Full spoken answer:**  
> “Preorder processes the node before children — useful for serialization prefixes and building paths downward. Inorder is left-node-right — on a BST that yields sorted order for validate and k-th. Postorder processes children first — natural for height, diameter, and LCA where you combine left and right results. On a general binary tree, inorder is not a sorted sequence.”

**Common wrong answer:**  
> “Inorder always sorts any binary tree.”

**Follow-up ladder:**
- **L1:** Iterative inorder skeleton?
- **L2:** Why serialize often uses preorder + nulls?

**Provenance:** Learning-lab

---

### Q7. How do you approach a cold tree Medium in the first two minutes? `(45–60s)`

**Answer points:**
- Clarify constraints
- Brute one-liner
- Name BFS vs DFS pattern
- Complexity + edges
- Then code

**Agenda opener:**  
> “Clarify, brute, pattern, complexity, edges, code.”

**Full spoken answer:**  
> “I restate the problem and clarify binary versus BST, whether I need a path or a boolean, and if mutation is allowed. I give a one-line brute force — often enumerating paths or comparing all subtrees in O(n²). Then I name the optimized pattern: BFS with level size, DFS with bounds, postorder LCA, and so on. I state O(n) time and O(h) or O(w) space, list edges like null root and skewed trees, and only then start coding.”

**Common wrong answer:**  
> Silent coding for three minutes.

**Follow-up ladder:**
- **L1:** What if you misclassified BFS vs DFS?
- **L2:** Tie to Day 23 unknown-pattern drill.

**Provenance:** Learning-lab · timing guide

---

## Tricky questions

### T1. “Can you do this in O(1) extra space?” `(90–120s)`

**Answer points:**
- Distinguish auxiliary heap vs call stack
- Morris exists for inorder but mutates links
- BFS inherently O(w) unless output-only tricks
- Prefer honest O(h) recursive unless asked Morris and you’re solid

**Agenda opener:**  
> “Clarify what counts as extra — stack versus heap.”

**Full spoken answer:**  
> “I’d clarify whether the call stack counts. Recursive DFS is O(h) stack space even if I allocate no containers. For inorder, Morris threading can get O(1) auxiliary space by temporarily mutating child links and restoring them — I’d only code that if I’m fluent, because it’s easy to corrupt the tree under time pressure. For BFS, O(w) queue space is inherent to processing levels unless we’re playing output-accounting games. My default senior answer is honest O(h) recursive or explicit O(h) iterative stack, and I’ll outline Morris only as an option with mutation trade-offs.”

**Common wrong answer:**  
> “BFS is O(1)” or claiming Morris without knowing restore.

**Follow-up ladder:**
- **L1:** Walk Morris link/restore at a high level.
- **L2:** Production: would you mutate a shared tree?

**Provenance:** Learning-lab

---

### T2. “Diameter of binary tree — why isn’t it just max depth left + right at root?” `(90–120s)`

**Answer points:**
- Diameter may lie entirely in a subtree
- At every node: leftH + rightH candidate
- DFS returns height; updates global best
- Confirm edges vs nodes definition
- One O(n) pass

**Agenda opener:**  
> “Not only through the root — update at every node.”

**Full spoken answer:**  
> “If I only add left and right depths at the root, I miss diameters that never pass through the root — a long path entirely in the left subtree, for example. The correct approach is a postorder DFS that returns height from each node and, at every node, updates a global maximum with leftHeight plus rightHeight. That one pass is O(n) time and O(h) space. I also confirm whether diameter is counted in edges or nodes so I don’t ship an off-by-one.”

**Common wrong answer:**  
> Root-only sum; or two full depth passes without explaining per-node updates.

**Follow-up ladder:**
- **L1:** Balanced tree vs line tree examples.
- **L2:** Return a pair (height, diameter) instead of global?

**Provenance:** Learning-lab · `code/TreeDFS.swift`

---

### T3. “Serialize binary tree — how do you handle nulls and ambiguity?” `(90–120s)`

**Answer points:**
- Preorder without nulls is ambiguous
- Explicit null tokens or BFS-with-nulls
- Deserialize with index or queue
- O(n)
- Light SDUI versioning nod

**Agenda opener:**  
> “Encoding must be reversible — nulls or counts.”

**Full spoken answer:**  
> “If I serialize only values in preorder, different shapes can produce the same sequence. I include explicit null markers, or I BFS and record null children the way the classic codec does. Deserialization consumes the stream with an index pointer or a queue to rebuild pointers. Complexity is O(n). In product SDUI we face a related problem — schemas need versioning and unknown-type fallbacks so documents stay interpretable across app versions — but that’s versioning judgment, not the same as LeetCode null tokens.”

**Common wrong answer:**  
> Values-only preorder “because structure is obvious.”

**Follow-up ladder:**
- **L1:** N-ary encode?
- **L2:** Compress runs of nulls?

**Provenance:** Learning-lab; soft Verified · S3 schema instinct

---

### T4. “DFS recursion blows the stack on skewed trees — what do you do in production?” `(90–120s)`

**Answer points:**
- Prefer iterative
- Validate / cap input depth
- Chunk processing
- UI/CMS trees: max depth + fail-soft UI
- Tie to crash-free culture — defensive limits

**Agenda opener:**  
> “Iterative plus depth budget — don’t hero-recurse.”

**Full spoken answer:**  
> “In production I’d prefer an iterative traversal with an explicit stack when depth may be unbounded. I’d also validate or cap depth on untrusted CMS or SDUI input and fail soft with a placeholder rather than crash. UI trees are often shallow, but nested documents can surprise you. That matches a crash-free mindset at consumer scale — defensive limits beat relying on a larger stack. Same judgment I’ll use later for on-device AI fail-soft: degrade usefully instead of hard-failing.”

**Common wrong answer:**  
> “Never happens on iOS” or only “increase stack size.”

**Follow-up ladder:**
- **L1:** What max depth would you pick for SDUI?
- **L2:** Metrics if depth cap hits often?

**Provenance:** Soft Verified · S8 crash-free culture; S3 SDUI shape; preview Day 24 fail-soft

---

### T5. “Symmetric tree — is checking root.left.val == root.right.val enough?” `(90–120s)`

**Answer points:**
- Need mirror structure recursively
- Compare outer/inner pairs
- BFS pair queue alternative
- Null symmetry matters

**Agenda opener:**  
> “Mirror recursively — not one root check.”

**Full spoken answer:**  
> “A single comparison of the root’s children is nowhere near enough. I need a mirror predicate: two nodes match if values are equal and the left of one matches the right of the other recursively, including nulls. Alternatively I BFS with a queue of pairs. Time O(n), space O(h) or O(w).”

**Common wrong answer:**  
> Only compare immediate children or only values inorder.

**Follow-up ladder:**
- **L1:** Asymmetric nulls on one side?
- **L2:** Perfect binary tree vs symmetric?

**Provenance:** Learning-lab

---

### T6. “Kth smallest in a BST — why not sort all values?” `(90s)`

**Answer points:**
- Inorder yields sorted order
- Stop at k — O(h + k)
- Full sort O(n log n) unnecessary
- Clarify 1-indexed k

**Agenda opener:**  
> “Inorder is already sorted — stop early.”

**Full spoken answer:**  
> “In a BST, inorder traversal visits values in sorted order, so I can decrement k as I visit and return when k hits zero — typically O(h + k) with a stack, better than collecting everything and sorting. Sorting all node values would be unnecessary work. I clarify whether k is 1-based and that the tree is a valid BST.”

**Common wrong answer:**  
> Dump to array and `sort()` without using BST property.

**Follow-up ladder:**
- **L1:** Follow-up: many kth queries — augment tree with sizes?
- **L2:** Morris for O(1) aux?

**Provenance:** Learning-lab

---

## Practice set for today

Record **3 Normal + 2 Tricky**. Target ≥4 Normal, ≥3 Tricky on [answer-timing-guide.md](../../../timing/answer-timing-guide.md).

Suggested set: Q1, Q3, Q5 + T2, T3.
'''