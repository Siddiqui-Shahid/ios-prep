# Audio script — Sample 03 — Approach & complexity (Q&A)
> Listen-only sample Q&A from `03-approach-complexity.md`. Spoken answers and follow-ups.

## §0 Q1. What is the 2–3 min “say this first” script for trees?

Next. Q1. What is the 2–3 min “say this first” script for trees? Answer. Clarify (20–30s): binary vs BST? path or bool? mutate OK? n up to? Brute (20–30s): enumerate all paths / compare every subtree — often O(n²). Optimize (45–60s): name pattern + why correct. Complexity (15s): O(n) time; O(h) or O(w) space. Edges (20s): null, one child, skewed, duplicates. Commit (5s): “I’ll code the optimized version now.” Follow-ups. Level order example opener?: “BFS with level-size queue; empty root → []; O(n)/O(w); coding now.”. LCA example opener?: “Postorder markers; bubble single-side hit; confirm both exist; O(n)/O(h).”. Skip the script?: Restart — interviews grade process under uncertainty..

## §1 Q2. What should I clarify before picking BFS or DFS?

Next. Q2. What should I clarify before picking BFS or DFS? Answer. Binary vs BST. Return type: levels array, bool, path list, int depth. Mutate tree allowed? Both nodes guaranteed in tree? Definition of depth (nodes vs edges). Duplicate values. n scale for recursion depth. These answers pick BFS level-size vs DFS postorder vs BST walk. Follow-ups. “Can I modify the tree?”: Changes Morris, in-place connect-next, flatten approaches.. Path “downward only”?: Usually root-to-leaf — confirm; any-node paths differ.. n = 10⁵ skewed?: Mention iterative or stack — recursion depth risk..

## §2 Q3. How do I present brute force without sounding weak?

Next. Q3. How do I present brute force without sounding weak? Answer. Brute is the baseline, not failure. “Compare every subtree pair — O(n²)” or “enumerate all root-to-leaf paths — O(n²) worst” shows you understand search space. Then: “One pass DFS/BFS visits each node once — O(n) — because …” Seniors always anchor optimal against brute. Follow-ups. Interviewer says “skip brute”?: One sentence baseline, then pivot.. When is brute the answer?: Tiny n or explicit compare-approaches question.. Same tree check brute?: Compare every node pair — motivates synchronized DFS..

## §3 Q4. What edge cases should I name every time?

Next. Q4. What edge cases should I name every time? Answer. Null root. Single node. Skewed left/right chain (height n, width 1). One missing child. Duplicate values in BST. Very wide level (queue memory). Path problems: leaf definition, negative values, target zero. Follow-ups. Empty tree max depth?: 0 — confirm definition.. LCA both same node?: Return that node — clarify if allowed.. Serialize empty?: "#" or "null" marker policy — match decoder..

## §4 Q5. When must I state time and space complexity?

Next. Q5. When must I state time and space complexity? Answer. In the “say this first” block before coding — not after as an apology. Say O(n) time and O(h) or O(w) space with worst case (skewed → O(n)). If using Morris or iterative, adjust auxiliary space claim. Mention removeFirst if using Swift Array as queue. Follow-ups. Follow-up “can you do O(1) space?”: Usually means Morris or iterative with O(h) stack — clarify which.. BFS “O(1) space”?: Wrong unless tree is a linked list level — queue dominates.. Amortized over all nodes?: Still O(n) total work — each node enqueued/dequeued once..

## §5 Q6. Example spoken scripts for three classics?

Next. Q6. Example spoken scripts for three classics? Answer. Level order: “BFS, level-size loop, empty → []. O(n)/O(w). Skewed + single node edges. Coding now.” LCA: “Postorder; both sides non-nil → current; else bubble. Both exist. O(n)/O(h).” Validate BST: “Bounds DFS, not parent-only; duplicate policy with interviewer. O(n)/O(h).” Follow-ups. Diameter script?: “DFS height; update global best with leftH+rightH at each node; confirm edge vs node count.”. Right side view?: “BFS last per level — or DFS right-first with depth map.”. Same tree?: “Mirror DFS on both roots; nil-nil true, one-nil false.”.

## §6 Q7. What glossary terms should I speak cleanly?

Next. Q7. What glossary terms should I speak cleanly? Answer. Level-size loop — snapshot queue count per wave. Preorder / inorder / postorder — when you visit relative to children. h height, w max width. Morris — threaded inorder O(1) aux if you know restore. Say “visit each node once” not vague “traverse efficiently.” Follow-ups. “Depth of tree” vs “depth of node”?: Tree depth often = max node depth from root — confirm.. Cousins vs siblings?: Same depth, different parents — BFS level helps.. Subtree vs substructure?: Subtree = exact clone; substructure = pattern match — different problems..
