# 02 — Deep Dive: Tree Pattern Catalog & Skeletons (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. Pattern catalog (trigger → algorithm)? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. BFS skeleton (production-quality interview form)? `(45–60s)`
**Answer:**

> “swift func levelOrder(_ root: TreeNode?) -> [[Int]] { guard let root else { return [] } var result: [[Int]] = [] var queue: [TreeNode] = [root] while !queue.isEmpty { let levelCount = queue.count var level: [Int] = [] level.reserveCapacity(levelCount) for _ in 0..<levelCount { let node = queue.removeFirst // interview OK; note O(n) shift — mention ArrayDeque if pushed level.append(node.val) if let l = node.left { queue.append(l) } if let r = node.right { queue.append(r) } } result.append(level) } return result } Senior note: removeFirst on Array is O(n). In interviews, clarity usually wins; if interviewer cares, say “I’d use a true deque / index head.” See code/TreeBFS.swift.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. Zigzag variant? `(45–60s)`
**Answer:**

> “Same BFS; on odd levels level.reverse (or insert at front / use deque). Prefer reverse of a level array — fewer bugs than index gymnastics.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Right side view? `(45–60s)`
**Answer:**

> “Per level, append level.last (or track last dequeued). DFS alternative: recurse right before left, record first visit per depth. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Recursive template? `(45–60s)`
**Answer:**

> “text func dfs(node): if node == nil: return base // pre: act before children L = dfs(node.left) // in: act between (BST / inorder) R = dfs(node.right) // post: combine L,R with node return combined.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q6. Iterative preorder? `(45–60s)`
**Answer:**

> “Push root; while stack: pop, visit, push right then left (so left processed first).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. Iterative inorder? `(45–60s)`
**Answer:**

> “Walk left pushing; pop/visit; go right — BST k-th / validate helper. When iterative wins: “I need explicit control / avoid deep recursion on skewed input” or follow-up asks for stack form. Morris only if you can finish link/restore cleanly.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Diameter — why root-only fails? `(45–60s)`
**Answer:**

> “Diameter = max over all nodes of leftHeight + rightHeight (edges) or that sum + 1 (nodes) — confirm definition. text At each node: leftH = height(left); rightH = height(right) best = max(best, leftH + rightH) return 1 + max(leftH, rightH) // height in nodes.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. LCA binary tree — postorder markers? `(45–60s)`
**Answer:**

> “text if node == nil or node == p or node == q: return node L = lca(left); R = lca(right) if L != nil and R != nil: return node // split here return L ?? R Assumptions to clarify: Both nodes exist in tree? Nodes are unique? Parent pointers available?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Validate BST — bounds? `(45–60s)`
**Answer:**

> “text func ok(node, low, high): // low/high exclusive bounds as Optionals if node == nil: return true if node.val <= low or node.val >= high: return false // adjust for duplicate policy return ok(left, low, node.val) and ok(right, node.val, high) Or inorder: previous value must be strictly less than current.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Path Sum II — backtracking? `(45–60s)`
**Answer:**

> “Push node.val; if leaf and remaining == val, copy path to answer; recurse left/right with remaining - val; pop.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Serialize — null markers required? `(45–60s)`
**Answer:**

> “Preorder values alone are ambiguous. Encode nulls ("#" / "null") or use BFS with null children like LeetCode Codec. Deserialize with queue or index pointer. O(n). Production nod (10s): SDUI JSON needs schemaVersion + unknown-type fallback — same reversibility / versioning instinct, different format ( / Day 25 Brief B).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Symmetric tree? `(45–60s)`
**Answer:**

> “Mirror DFS: same(a.left, b.right) && same(a.right, b.left), or BFS pairing queue.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. Construct from preorder + inorder? `(45–60s)`
**Answer:**

> “Preorder[0] is root; find root in inorder to split left/right sizes; recurse. Use hashmap value→index for O(n) if values unique. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Trade-offs? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Failure modes seniors mention? `(45–60s)`
**Answer:**

> “1. Claiming recursive DFS is O(1) space. 2. BST validate via parent-only comparison. 3. Diameter computed only at root once without per-node updates. 4. Serialize without nulls → ambiguous trees. 5. Using BST LCA walk on a general binary tree. 6. Mixing levels because you forgot levelCount. 7. removeFirst performance rabbit hole mid-interview — acknowledge, don’t rewrite half the solution. 8. Silent coding — no agenda → looks junior even if code is fine. ---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q17. Production mental models (shape only)? `(45–60s)`
**Answer:**

> “Honesty: These are isomorphisms for teaching, not “I ran LeetCode BFS in BookMyShow.” Provenance in 03-production-bridge.md.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Shipped / Verified when honest:** Use named work only if this section cites it.
- **Don’t claim:** Metrics or files you didn’t ship.

---

### Q18. Complexity quick reference? `(45–60s)`
**Answer:**

> “---.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q19. Optional citations (not required to study)? `(45–60s)`
**Answer:**

> “- LeetCode Explore: Binary Tree cards (visual BFS/DFS) - Apple docs: value types vs classes (aside only) - Repo timing: answer-timing-guide.md § Coding → Code: code/ · Bridge: 03-production-bridge.md '''.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
