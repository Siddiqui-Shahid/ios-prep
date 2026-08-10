# Sample 07 — Revision Q&A (day-22) (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Indirect ≈ 60–90s · Tricky ≈ 90–120s.

---

## Normal questions

### Q1. When do you choose BFS over DFS on a tree? `(30–45s)`
**Answer:**

> I choose BFS when the prompt is level-oriented — level order, zigzag, side view — or when I need shortest path in an unweighted tree. I choose DFS when I care about paths, subtrees, or combining children results like height, diameter, or LCA. Space-wise BFS holds a level of width w, DFS holds height h on the stack. In product terms, a depth-by-depth layout pass feels BFS-shaped; resolving a nested component path feels DFS-shaped.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Extremely wide tree — what changes? | BFS queue space hits O(n) when one level holds almost every node, so I’d call out width risk and prefer DFS if I only need path or subtree results. |
| Unweighted vs weighted shortest path? | BFS is shortest by edge count on unweighted trees/graphs; for weighted edges I’d use Dijkstra (or A*) instead of plain BFS. |
| When would you DFS with an explicit depth parameter instead of BFS? | When I need nodes or paths under a depth cap without materializing whole levels — pass depth in DFS and prune. |

**How can I relate to my case:**
- **Shipped:** BookMyShow backend-driven header & search
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q2. What’s the time and space of tree traversal? `(30–45s)`
**Answer:**

> Any full traversal is O(n) time because each node is processed a constant number of times. Recursive DFS uses O(h) call-stack space; BFS uses O(w) for the widest level. Worst case both can be O(n) — skewed chain for height, bushy level for width. On a balanced BST I’d say O(log n) height. I never call recursive DFS O(1) space unless I’m explicitly excluding the stack, and interviewers usually want the stack counted.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What is h for a linked-list-shaped tree? | Height h equals n, so recursive DFS stack is O(n) — the usual worst case. |
| Output space for level-order arrays — count it? | Yes — storing every node in the result is O(n) output space on top of the O(w) queue. |
| Morris traversal trade-off? | Morris gets O(1) extra space by temporarily threading right pointers, but it mutates the tree mid-walk and is easy to botch under time pressure. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q3. How do you validate a BST correctly? `(30–45s)`
**Answer:**

> Comparing each node only to its parent is insufficient — a value can satisfy the parent and still violate an ancestor. I DFS with exclusive low and high bounds updated as I go left and right, or I do an inorder walk and ensure values are strictly increasing. I clarify whether duplicates are allowed. Time O(n), space O(h).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Show the classic counterexample (4 under 6 under 5). | Root 5 with right child 6 and 4 under 6: parent-only checks pass, but 4 violates the ancestor bound against 5. |
| Duplicate keys — left ≤ or <? | Clarify with the interviewer — if duplicates are allowed on one side, use a non-strict bound there; many prompts require strictly increasing inorder. |
| Recover a BST from a swapped pair? | Inorder-find the one or two inversion points from the swapped pair, then swap those node values back — O(n) time, O(h) space. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q4. Explain level-order traversal implementation? `(30–45s)`
**Answer:**

> I BFS with a queue starting at the root. While the queue isn’t empty, I snapshot the current count as the level size, dequeue that many nodes, enqueue their children, and append that level’s values to the result. That snapshot is what keeps levels from mixing. Empty root returns an empty list. For zigzag I reverse every other level after collecting it.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Right side view from the same skeleton? | Same level-order BFS — record the last node dequeued on each level (or the first if you enqueue right child first). |
| `removeFirst` cost on Array? | `Array.removeFirst` is O(n) because it shifts elements — use index cursors, `Deque`, or two stacks instead of Array-as-queue. |
| N-ary level order? | Same BFS with a level-size snapshot; enqueue every child from the n-ary children list instead of only left/right. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q5. How does recursive LCA work on a binary tree? `(45s)`
**Answer:**

> For a general binary tree I recurse: if the node is null or equals p or q, I return it. I recurse left and right. If both sides return non-null, the current node is the LCA because the targets split here. If only one side is non-null, I bubble that up. I confirm both nodes exist in the tree. Complexity O(n) time and O(h) space. If it’s a BST, I’d instead walk comparing values in O(h).

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Parent pointers available — alternate approach? | Walk both nodes up to the root (or align depths then climb) and take the first shared parent — often simpler when parent links exist. |
| LCA of more than two nodes? | Reduce pairwise, or one DFS that counts how many targets sit in each subtree and records the deepest node covering all of them. |
| First common ancestor in a deeplink route tree (shape analogy)? | Treat route segments as a tree path; the LCA is the deepest shared prefix of two deeplink paths — same split-point idea as tree LCA on Hybrid UI / deeplinks. |

**How can I relate to my case:**
- **Shipped:** Hybrid UI / deeplinks
- **Design if asked:** Only if they ask for a modern redesign — label it design, not shipped.
- **Lab only:** Learning-lab demos / sketches only — not production source.
- **Don’t claim:** Invented metrics, sole credit for org-wide CFS, or claiming design-only work as shipped.

---

### Q6. Preorder vs inorder vs postorder — when each? `(30–45s)`
**Answer:**

> Preorder processes the node before children — useful for serialization prefixes and building paths downward. Inorder is left-node-right — on a BST that yields sorted order for validate and k-th. Postorder processes children first — natural for height, diameter, and LCA where you combine left and right results. On a general binary tree, inorder is not a sorted sequence.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| Iterative inorder skeleton? | Push the left spine onto a stack, pop to visit the node, then step right — classic O(h) iterative inorder. |
| Why serialize often uses preorder + nulls? | Preorder with explicit null markers uniquely reconstructs shape and values in one pass without needing a second inorder sequence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q7. How do you approach a cold tree Medium in the first two minutes? `(45–60s)`
**Answer:**

> I restate the problem and clarify binary versus BST, whether I need a path or a boolean, and if mutation is allowed. I give a one-line brute force — often enumerating paths or comparing all subtrees in O(n²). Then I name the optimized pattern: BFS with level size, DFS with bounds, postorder LCA, and so on. I state O(n) time and O(h) or O(w) space, list edges like null root and skewed trees, and only then start coding.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What if you misclassified BFS vs DFS? | Say it aloud and switch early — rewriting level-order as DFS-with-depth (or the reverse) is fine if you narrate why. |
| Tie to Day 23 unknown-pattern drill. | Same first-two-minutes script: restate, brute force, name the structure, complexity, edges — then code; Day 23 just swaps trees for hash/heap/window. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if the interviewer asks for production proof.

---

### Q8. What is the one rule to remember for day-22? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-22, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q9. What is the one rule to remember for day-22? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-22, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### Q10. What is the one rule to remember for day-22? `(30–45s)`
**Answer:**

> “Keep a clear boundary, speak simply, and prove with a small example. For day-22, lead with the mental model before APIs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Indirect questions

> These do not name the concept first. Speak from the symptom, scenario, or junior question.

### I1. A junior asks you in standup: “When do you choose BFS over DFS on a tree?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I choose BFS when the prompt is level-oriented — level order, zigzag, side view — or when I need shortest path in an unweighted tree. I choose DFS when I care about paths, subtrees, or combining children results like height, diameter, or LCA. Space-wise BFS holds a level of width w, DFS holds height h on the stack. In product terms, a depth-by-depth layout pass feels BFS-shaped; resolving a nested component path feels DFS-shaped.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | When do you choose BFS over DFS on a tree |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I2. Production symptom: something related to “What’s the time and space of tree traversal” just broke under load. What do you check first? `(60–90s)`
**Answer:**

> “Any full traversal is O(n) time because each node is processed a constant number of times. Recursive DFS uses O(h) call-stack space; BFS uses O(w) for the widest level. Worst case both can be O(n) — skewed chain for height, bushy level for width. On a balanced BST I’d say O(log n) height. I never call recursive DFS O(1) space unless I’m explicitly excluding the stack, and interviewers usually want the stack counted.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | What’s the time and space of tree traversal |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I3. Interviewer never names the topic. They describe a mess that maps to “How do you validate a BST correctly”. How do you diagnose? `(60–90s)`
**Answer:**

> “Comparing each node only to its parent is insufficient — a value can satisfy the parent and still violate an ancestor. I DFS with exclusive low and high bounds updated as I go left and right, or I do an inorder walk and ensure values are strictly increasing. I clarify whether duplicates are allowed. Time O(n), space O(h).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you validate a BST correctly |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I4. Code review: you spot a smell around “Explain level-order traversal implementation.”. What do you say and what fix do you propose? `(60–90s)`
**Answer:**

> “I BFS with a queue starting at the root. While the queue isn’t empty, I snapshot the current count as the level size, dequeue that many nodes, enqueue their children, and append that level’s values to the result. That snapshot is what keeps levels from mixing. Empty root returns an empty list. For zigzag I reverse every other level after collecting it.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Explain level-order traversal implementation. |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I5. What happens if a teammate ignores the rule behind “How does recursive LCA work on a binary tree”? `(60–90s)`
**Answer:**

> “For a general binary tree I recurse: if the node is null or equals p or q, I return it. I recurse left and right. If both sides return non-null, the current node is the LCA because the targets split here. If only one side is non-null, I bubble that up. I confirm both nodes exist in the tree. Complexity O(n) time and O(h) space. If it’s a BST, I’d instead walk comparing values in O(h).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How does recursive LCA work on a binary tree |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I6. Walk me through a failed interview answer on “Preorder vs inorder vs postorder — when each” and how you’d correct it? `(60–90s)`
**Answer:**

> “Preorder processes the node before children — useful for serialization prefixes and building paths downward. Inorder is left-node-right — on a BST that yields sorted order for validate and k-th. Postorder processes children first — natural for height, diameter, and LCA where you combine left and right results. On a general binary tree, inorder is not a sorted sequence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | Preorder vs inorder vs postorder — when each |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### I7. A junior asks you in standup: “How do you approach a cold tree Medium in the first two minutes?” — how do you answer without jargon? `(60–90s)`
**Answer:**

> “I restate the problem and clarify binary versus BST, whether I need a path or a boolean, and if mutation is allowed. I give a one-line brute force — often enumerating paths or comparing all subtrees in O(n²). Then I name the optimized pattern: BFS with level size, DFS with bounds, postorder LCA, and so on. I state O(n) time and O(h) or O(w) space, list edges like null root and skewed trees, and only then start coding.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| What concept is this really? | How do you approach a cold tree Medium in the first two minutes |
| How do you prove it? | Give a tiny example or production boundary. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---


## Tricky questions / brain puzzles

> Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”

### T1. Actor reentrancy surprise? `(90–120s)`
**Answer:**

> “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T2. They push you to invent a metric you don’t have? `(90–120s)`
**Answer:**

> “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T3. They ask if your lab demo was the shipped file? `(90–120s)`
**Answer:**

> “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T4. They want a one-tool forever answer? `(90–120s)`
**Answer:**

> “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T5. Race vs deadlock — they mix the terms? `(90–120s)`
**Answer:**

> “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T6. Main-thread rule under pressure? `(90–120s)`
**Answer:**

> “UI work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T7. Cancellation honesty? `(90–120s)`
**Answer:**

> “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T8. Cache invalidation trap? `(90–120s)`
**Answer:**

> “I define TTL, version keys, and a clear bust path. Stale UI with a spinner is often better than corrupt merge. I say what is source of truth.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T9. Security theater vs real pinning? `(90–120s)`
**Answer:**

> “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---

### T10. SDUI unknown component in prod? `(90–120s)`
**Answer:**

> “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Say the core idea in one clear sentence. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Use this as vocabulary; hook a named case only if asked.

---
