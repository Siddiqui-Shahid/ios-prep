# 01 — Foundations: Tree BFS / DFS (Q&A)

> Cover the answer, speak aloud, then check follow-ups. Simple language. Named work only — never S-codes in speech.

---

### Q1. What is the one rule to remember for this topic? `(45–60s)`
**Answer:**

> “BFS walks by distance (levels / width); DFS walks by structure (paths / subtrees / combine-after-children). Pick from the prompt trigger, then state O(n) time and O(h) or O(w) space before you type. Everything below unpacks that sentence.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q2. Two boxes in your head? `(45–60s)`
**Answer:**

> “text BFS: root → [level 0] → [level 1] → [level 2] … (queue / FIFO) DFS: root → deep left … backtrack → siblings … (stack / recursion).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q3. The intern demo (say aloud once)? `(45–60s)`
**Answer:**

> “BFS answers width questions. DFS answers structure and path questions. Inorder is special for BSTs.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q4. Binary tree vs BST (do not blur)? `(45–60s)`
**Answer:**

> “Trap: Using “BST walk” LCA on a plain binary tree — wrong.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q5. Glossary (interview vocabulary)? `(45–60s)`
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

### Q6. Complexity script (memorize verbatim)? `(45–60s)`
**Answer:**

> “n = number of nodes. Visit each once → O(n) time. Recursion depth or queue holds up to O(h) or O(w) space; worst case skewed tree O(n), balanced O(log n) height.” Never say “O(1) space” for recursive DFS unless you explicitly discuss the call stack. Prefer: “auxiliary O(1) besides the call stack O(h).”.

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q7. BFS foundation — level-size idiom? `(45–60s)`
**Answer:**

> “Always separate “nodes currently in the queue” from “this level”: text queue = [root] while queue not empty: levelCount = queue.count for _ in 0..<levelCount: node = dequeue // process / collect enqueue children if non-nil.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q8. Void / side-effect DFS? `(45–60s)`
**Answer:**

> “Build a path array, push before recurse, pop after (backtracking). Classic Path Sum II.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q9. Return a value DFS? `(45–60s)`
**Answer:**

> “Height, boolean “found”, optional node pointer. Classic max depth, same tree, LCA.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q10. Return + global update? `(45–60s)`
**Answer:**

> “I decide up front: am I accumulating down, combining up, or both?”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q11. Maximum depth — DFS? `(45–60s)`
**Answer:**

> “text depth(null) = 0 depth(node) = 1 + max(depth(left), depth(right)) BFS alternative: count waves. Same O(n); space trade-off h vs w.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q12. Level order — BFS? `(45–60s)`
**Answer:**

> “Collect one array per wave. This is the template for zigzag (reverse odd levels) and right side view (last node of each wave).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q13. Validate BST — bounds (preview)? `(45–60s)`
**Answer:**

> “Parent-only check fails on: text 5 / \ 1 6 / \ 4 7 ← 4 is wrong: still in right subtree of 5.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q14. “Say this first” — 2–3 min coding approach? `(45–60s)`
**Answer:**

> “Aligns with answer-timing-guide.md. 1. Clarify (20–30s): Binary vs BST? Path or bool? Mutate OK? n up to? 2. Brute (20–30s): Enumerate all paths / compare every subtree — often O(n²). 3. Optimize (45–60s): Name pattern + why correct. 4. Complexity (15s): O(n) time; O(h) or O(w) space; worst case. 5. Edges (20s): null, one child, skewed, duplicates. 6. Commit (5s): “I’ll code the optimized version now.”.”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q15. Swift node shape (interview default)? `(45–60s)`
**Answer:**

> “swift final class TreeNode { var val: Int var left: TreeNode? var right: TreeNode? init(_ val: Int, _ left: TreeNode? = nil, _ right: TreeNode? = nil) { self.val = val; self.left = left; self.right = right } } Interview aside (10s max): Production SDUI trees are often value/Codable enums; LeetCode uses reference nodes. Same traversal ideas; different ownership model. Don’t derail into ARC unless asked (Day 03 territory).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---

### Q16. Checklist before you open Deep Dive? `(45–60s)`
**Answer:**

> “- [ ] I can draw BFS vs DFS on a 5-node tree - [ ] I can recite the complexity script without “O(1) recursive” - [ ] I know BST ≠ binary tree for LCA / validate - [ ] I can speak the 6-step “say this first” agenda - [ ] I know level-size = for _ in 0..<queue.count → Continue: 02-deep-dive.md ''' ).”

**Follow-ups:**

| Follow-up | Answer |
|---|---|
| One-sentence opener? | Lead with the core rule in one sentence. |
| Common trap? | Name the usual mistake and how you avoid it. |

**How can I relate to my case:**
- **Concept-only — no shipped story.** Hook BookMyShow / District / Raw only if the interviewer asks for production proof.

---
