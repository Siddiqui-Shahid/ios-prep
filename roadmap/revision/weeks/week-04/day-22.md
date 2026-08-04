# Day 22 — DSA Trees: BFS / DFS Patterns

> Week 4 · Phase: DSA polish + interview communication · Time budget today: ~4–5 hrs

## 1. Outcome

By end of day you can explain aloud (no notes):

- When to reach for **BFS** vs **DFS** (level order / shortest path in unweighted trees vs path/subtree recursion) and state **time/space** in one breath.
- The four DFS shapes: **preorder / inorder / postorder / “any order recurse children”**, plus iterative stack variants.
- How to open every tree problem with a **2–3 min “say this first”** script before typing code.
- Solve 8–12 medium tree problems from the track list, narrating complexity *before* implementation.
- Map tree traversal patterns to production mental models (UIKit view hierarchy walk, SDUI node tree, deeplink route tree) without forcing a fake LeetCode story.

## 2. Concept deep dive

### 2.1 Pattern catalog (memorize the trigger → algorithm)

| Trigger phrase in prompt | Default pattern | Why |
|---|---|---|
| “Level by level”, “leftmost/rightmost at each depth”, “zigzag level order” | **BFS** + queue | Natural FIFO; `O(w)` space for width |
| “Shortest path” in **unweighted** tree/graph | **BFS** | First time you hit target = shortest |
| “Path sum”, “root-to-leaf”, “all paths” | **DFS** (usually preorder with accumulator) | Path state rides the recursion stack |
| “Subtree of another”, “same tree”, “symmetric” | **DFS** compare two pointers / mirrored | Structural recursion |
| “LCA of two nodes” | **DFS** postorder return markers | Bottom-up combine |
| “Serialize / deserialize”, “clone N-ary” | **DFS** or BFS with null markers | Encoding must be reversible |
| “Max depth / diameter / balanced?” | **DFS** return height + side effects | One pass compute multiple facts |
| “Validate BST” | **DFS** with low/high bounds (or inorder) | Inorder must be sorted |
| “k-th smallest in BST” | **Inorder** (stack or Morris) | Sorted order |
| “Connect next pointers / cousins” | **BFS** with level size loop | Sibling awareness |

**Complexity script (say verbatim until automatic):**

> “n = number of nodes. Visit each once → **O(n)** time. Recursion depth or queue holds up to **O(h)** or **O(w)** space; worst case skewed tree **O(n)**, balanced **O(log n)** height.”

Never say “O(1) space” for recursive DFS unless you explicitly discuss the call stack as free (interviewers will push). Prefer: “auxiliary O(1) besides the call stack O(h).”

### 2.2 BFS skeleton (level-order discipline)

Always use the **level-size** idiom so you never confuse “nodes in queue” with “this level”:

```text
queue = [root]
while queue not empty:
  levelCount = queue.count
  for _ in 0..<levelCount:
    node = dequeue
    // process node (or collect into level array)
    enqueue children if non-nil
```

**Interview habits:**

1. Clarify: binary vs N-ary? values unique? need path or just bool? mutable tree OK?
2. Draw 5–7 node example; walk one BFS level out loud.
3. State edge cases: empty root, single node, skewed, duplicate values, negative vals.

### 2.3 DFS skeletons

**Recursive (default for trees):**

```text
func dfs(node):
  if node == nil: return base
  // pre: act before children
  L = dfs(node.left)
  // in: act between (BST / inorder)
  R = dfs(node.right)
  // post: combine L,R with node
  return combined
```

**Iterative preorder (stack):** push root; while stack: pop, visit, push right then left (so left processed first).

**Iterative inorder:** walk left pushing; pop/visit; go right — classic BST k-th / validate helper.

**When iterative wins in interview:** “I need explicit control / avoid deep recursion on skewed input” or follow-up asks for O(1) Morris (mention only if comfortable — don’t derail).

### 2.4 Trade-offs

| Choice | When | Cost |
|---|---|---|
| BFS | Levels, width-aware, unweighted shortest | Queue `O(w)`; poor for deep path reconstruction without parent map |
| DFS recursive | Structure, path, subtree, LCA | Call stack `O(h)`; skewed → stack overflow risk in prod (rare in LC) |
| DFS iterative | Same as DFS, explicit stack | More boilerplate; easier to pause/resume |
| Inorder on BST | Sorted queries, validate, k-th | Wrong on non-BST; don’t force inorder on general binary trees |
| Parent pointer / map | Path to root, cousin distance | Extra `O(n)` space; clarify if tree nodes have parent |
| Two-pass vs one-pass | Diameter (height + max path) | Prefer one DFS returning height and updating global max |

### 2.5 “Say this first” master script (2–3 min coding approach)

Use every tree problem today. Aligns with [answer-timing-guide.md](../../timing/answer-timing-guide.md) coding section.

1. **Clarify (20–30s):** “Binary tree or BST? Need the path or a boolean? Can I mutate? n up to?”
2. **Brute (20–30s):** “I could enumerate all paths / compare every subtree — typically O(n²).”
3. **Optimize (45–60s):** Name pattern (BFS level loop / DFS postorder / bounds for BST) + why correct.
4. **Complexity (15s):** O(n) time, O(h) or O(w) space; worst case.
5. **Edges (20s):** null root, one child, skewed, duplicates.
6. **Commit (5s):** “I’ll code the optimized version now.”

**Example opener — Binary Tree Level Order:**

> “I’ll BFS with a queue and process by level size so each array in the result is one depth. Empty root returns []. Time O(n), space O(w) for the widest level. Edges: single node, skewed left chain. Coding now.”

**Example opener — Lowest Common Ancestor (binary tree, not BST):**

> “Postorder DFS: recurse left/right; if both sides find targets, current is LCA; if one side finds, bubble that node up. Assumes both nodes exist in tree — I’ll confirm. O(n)/O(h).”

**Example opener — Validate BST:**

> “Not enough to compare only to parent. I’ll DFS with inclusive/exclusive low-high bounds, or inorder and ensure strictly increasing. O(n)/O(h).”

## 3. Read these

| Priority | Resource | Why |
|---|---|---|
| Must | [coding/dsa-track.md](../../coding/dsa-track.md) — Trees / BFS / DFS section | Canonical problem list + your solve log |
| Must | [timing/answer-timing-guide.md](../../timing/answer-timing-guide.md) § Coding approach | Enforce 2–3 min agenda before code |
| Deepen | LeetCode Explore: Binary Tree (BFS/DFS cards) | Visual reinforcement of level vs recurse |
| Deepen | Swift `Collection` / recursive enums mental model | Trees as value types vs class nodes (interview aside) |
| Repo | Production analogy only — no new SD doc today | Save bandwidth for Day 24 AI + Day 27 mock |

## 4. Map to your work

**Company / feature:** BookMyShow SDUI / header tree; Raw deeplink + navigation graph; view hierarchy debugging.  
**What you did:** Walked nested UI / CMS component trees, routed deeplinks through hierarchical destinations, reasoned about parent-child layout and lifecycle — same *shape* as tree DFS/BFS, different domain.  
**Interview line (≤20s):**  
> “Tree BFS/DFS show up in product as view and SDUI trees — I pick BFS for level-aware layout passes and DFS when I need path or subtree decisions.”

→ Full STAR (architecture, not DSA): [story-bank.md](../../stories/story-bank.md)#S3 · #S10 · #S13

**Do not invent** a LeetCode metric. Keep resume numbers for behavioral days: **30L+ DAU**, **99.95% crash-free**, **30%+ nav reduction** (LE sheet).

## 5. Normal questions

For each: answer out loud within the time. Skeleton only — expand from memory.

### Q1. When do you choose BFS over DFS on a tree? `(30–45s)`
**Skeleton:** Levels / width / unweighted shortest → BFS; path/subtree/structure → DFS. Space: queue width vs recursion height.  
**Follow-up:** “What if the tree is extremely wide?” → BFS memory; maybe DFS + explicit depth param.  
**Story:** SDUI/layout “by section depth” analogy only if natural — don’t force.

### Q2. What’s the time and space of tree traversal? `(30–45s)`
**Skeleton:** Visit each node once → O(n). Space O(h) recursion or O(w) queue; worst O(n) skewed/full wide.  
**Follow-up:** Balanced BST height? → O(log n).  
**Story:** —

### Q3. How do you validate a BST correctly? `(30–45s)`
**Skeleton:** Bounds (low, high) on each node **or** inorder strictly increasing. Parent-only check is wrong.  
**Follow-up:** Duplicates allowed? → clarify strict vs non-strict.  
**Story:** —

### Q4. Explain level-order traversal implementation. `(30–45s)`
**Skeleton:** Queue + `levelCount = queue.count` inner loop; collect or process per level.  
**Follow-up:** Zigzag? → alternate reverse or deque.  
**Story:** —

### Q5. How does recursive LCA work on a binary tree? `(45s)`
**Skeleton:** If node is null or matches p/q return node; recurse L/R; if both non-null return node else return non-null side.  
**Follow-up:** BST LCA? → walk comparing values — O(h).  
**Story:** —

## 6. Tricky questions

### T1. “Can you do this in O(1) extra space?” `(90–120s)`
**Trap:** Forgetting call stack; proposing Morris without knowing it; claiming BFS is O(1).  
**Senior answer:** Distinguish auxiliary heap space vs call stack. Morris threading for inorder exists but mutates links temporarily — say trade-offs. For BFS, O(w) is inherent unless output-only tricks. Prefer honest O(h) recursive.  
**Follow-up:** Interviewer wants Morris — outline link/restore; if shaky, stay with stack iterative.

### T2. “Diameter of binary tree — why isn’t it just max depth left + right at root?” `(90–120s)`
**Trap:** Computing only at root; missing diameter entirely in a subtree.  
**Senior answer:** Diameter = max over all nodes of leftHeight + rightHeight; DFS returns height, updates global max edges/nodes-1 as you go. One O(n) pass.  
**Follow-up:** Define diameter as edges vs nodes — confirm with interviewer.

### T3. “Serialize binary tree — how do you handle nulls and ambiguity?” `(90–120s)`
**Trap:** Preorder without null markers → ambiguous structure.  
**Senior answer:** Preorder with explicit null tokens, or BFS with nulls (LeetCode codec style); deserialize with queue or index pointer. Complexity O(n). Mention JSON/SDUI schemas need versioning too (light production nod).  
**Follow-up:** N-ary? → child count header or delimiter scheme.

### T4. “DFS recursion blows the stack on skewed trees — what do you do in production?” `(90–120s)`
**Trap:** “Never happens” or only “increase stack size.”  
**Senior answer:** Prefer iterative; validate input depth; chunk processing; for UI trees depths are usually small but CMS/SDUI can nest — guard with max depth + fail-soft UI. Same judgment as on-device AI fail-soft (preview Day 24).  
**Follow-up:** Tie to crash-free culture at BMS (99.95%) — defensive depth limits, not hero recursion.

## 7. Flashcards for today

| Front | Back |
|---|---|
| BFS vs DFS trigger | Levels/shortest unweighted → BFS; path/subtree/LCA/structure → DFS · Trap: using DFS for “level averages” · Prod: layout pass vs path resolve |
| Level-size BFS idiom | `for i in 0..<queue.count` each wave · Trap: mixing levels · Prod: batch UI updates by depth |
| BST validate | Bounds or inorder sorted · Trap: only compare parent · Prod: schema validation analogy |
| LCA binary tree | Postorder both-sides found → node · Trap: assuming BST walk · Prod: nearest shared nav ancestor |
| Tree complexity script | O(n) time; O(h)/O(w) space; worst O(n) · Trap: saying O(1) recursive · Prod: skewed CMS tree |
| Diameter one-pass | DFS height + global left+right max · Trap: root-only sum · Prod: longest dependency chain metaphor |
| Serialize need | Explicit nulls or count headers · Trap: values-only preorder · Prod: SDUI versioning |
| Inorder use | BST sorted ops, k-th · Trap: inorder on non-BST for “sorted” · Prod: — |
| Say this first | Clarify → brute → optimize → complex → edges → code · Trap: silent coding · Prod: senior signal |
| Symmetric tree | Mirror DFS or BFS pair queue · Trap: only check root children · Prod: mirrored layout QA |

## 8. Practice

- **Coding / SD:** Work the **Trees · BFS/DFS** list in [dsa-track.md](../../coding/dsa-track.md). Target **8–12** problems today (prefer Medium). Suggested set (adjust to track IDs if numbered differently):

  1. Binary Tree Level Order Traversal  
  2. Binary Tree Zigzag Level Order Traversal  
  3. Maximum Depth of Binary Tree  
  4. Diameter of Binary Tree  
  5. Path Sum II (or Path Sum)  
  6. Lowest Common Ancestor of a Binary Tree  
  7. Validate Binary Search Tree  
  8. Kth Smallest Element in a BST  
  9. Symmetric Tree  
  10. Binary Tree Right Side View  
  11. Serialize and Deserialize Binary Tree *(stretch)*  
  12. Construct Binary Tree from Preorder and Inorder *(stretch)*

  Log each: pattern tag · complexity said aloud? (Y/N) · time to first correct · one miss note.

- **Complexity / agenda to say first:** Before *every* solve, record 60–90s voice memo of the master script. No memo → doesn’t count as done.

## 9. Timed drill

1. Pick **3 Normal + 2 Tricky** from §§5–6. Record.
2. Score against [answer-timing-guide.md](../../timing/answer-timing-guide.md) (target ≥4 Normal, ≥3 Tricky).
3. Log misses in gotchas (especially: BST validate trap, diameter root-only, O(1) space confusion).
4. Bonus 10 min: cold-open **Right Side View** — only BFS agenda + code outline, no full polish.
