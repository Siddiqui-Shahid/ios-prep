# 04 — Questions (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Each question ends with **How can I relate to my case** using named work — never S-codes.
> Normal ≈ 30–60s · Design ≈ 90–120s · Tricky ≈ 90–120s.

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

### Q4. Explain level-order traversal implementation. `(30–45s)`

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

## Tricky questions

## Practice set for today

