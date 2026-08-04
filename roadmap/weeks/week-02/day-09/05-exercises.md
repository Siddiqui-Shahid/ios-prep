# 05 — Exercises

> Solutions are in-repo. Prefer speaking aloud before peeking at solutions.

## A. Conceptual

### A1. Pipeline recall
Draw from memory: endpoint → … → decoded model, including the 401 branch.

**Solution:**
```text
APIEndpoint → RequestBuilder (+ whitelist) → Interceptors (auth/log)
→ URLSession → status/decode
→ on 401: SingleFlightRefresh → retry once → decode
→ on refresh fail: fail waiters → logout
```

### A2. ATS vs pinning (two sentences)
Write two sentences that an intern couldn’t confuse.

**Solution:**  
ATS is system policy that prefers HTTPS and blocks cleartext by default. Pinning is an additional app-level check that the server’s identity matches embedded pins (typically SPKI hashes) during trust evaluation.

### A3. SPKI true/false
Mark each statement T/F and fix the false ones.

1. SPKI pinning hashes the Subject Public Key Info DER.  
2. `SecKeyCopyExternalRepresentation` bytes are the same as SPKI DER.  
3. SPKI pins always survive certificate renewal.  
4. Domain whitelist replaces the need for HTTPS.

**Solution:**  
1 T.  
2 F — raw key export ≠ SPKI DER; don’t call that SPKI.  
3 F — survives renewal **only if the same key pair is reused**.  
4 F — whitelist constrains hosts; HTTPS/TLS still required.

### A4. Provenance hygiene
Rewrite this bad interview sentence so it’s honest:

> “I shipped Alamofire to URLSession with pinning, whitelist, shadow traffic, and a production break-glass runbook.”

**Solution:**  
“I migrated Ads networking from Alamofire to URLSession and enforced HTTPS, SSL pinning, and a domain whitelist. Pin rotation, backup pins, and break-glass I’d treat as required design alongside pinning — I’m not claiming I shipped a shadow-traffic rollout or the full ops runbook.”

---

## B. Coding

### B1. Read and critique
Open [code/SingleFlightRefresh.swift](code/SingleFlightRefresh.swift).

1. Explain why the continuation design avoids the racy `Task { self.token = … }` bug.  
2. What goes wrong if you set `isRefreshing = false` **after** resuming waiters?  
3. Optional: implement a unit-test-shaped async function that starts three concurrent `refresh` calls and asserts a single leader execution using an `OSAllocatedUnfairLock`/`actor` counter inside `performRefresh`.

**Solution sketch:**

1. Waiters never mutate actor state from a non-isolated Task; only the actor method writes `accessToken` / waiter lists.  
2. A resumed waiter that immediately calls `refresh` again may see `isRefreshing == true` and append to an already-draining waiter list — hanging or lost wakeups. Clear flag before resume.  
3. Counter inside `performRefresh` should end at 1 across three concurrent callers (leader-only execution).

### B2. Broken refresh — fix it
Fix this (conceptually or in a playground):

```swift
actor Broken {
    var token: String?
    var task: Task<String, Error>?
    func refresh() async throws -> String {
        if let task { return try await task.value }
        let task = Task {
            let t = try await network()
            self.token = t // bug
            return t
        }
        self.task = task
        defer { self.task = nil }
        return try await task.value
    }
    func network() async throws -> String { "ok" }
}
```

**Solution direction:** Move `token = t` to after `await task.value` on the actor, or switch to the continuation-based `SingleFlightRefresh`. Prefer not mutating actor state inside the unstructured Task.

### B3. Callback cancel + stale guard
Write a minimal class that:

- Starts a `URLSessionDataTask` for search  
- Cancels previous task on new query  
- Ignores late completions via a generation `Int`

**Solution pattern:** see Deep Dive §5.2 — `task?.cancel(); generation += 1; capture myGeneration; guard myGeneration == generation`.

### B4. Whitelist gate
Given `allowedHosts = ["api.bms.example"]`, show the guard that throws before `session.data`.

**Solution:**
```swift
guard let host = url.host, allowedHosts.contains(host) else {
    throw NetworkError.hostNotAllowed(url.host ?? "")
}
```

---

## C. Debugging scenarios

### C1. Users see old search results after typing fast
**Likely causes:** no cancel; callback task without stale guard; applying results without `Task.isCancelled` check.  
**Fix:** cancel previous Task / dataTask; generation guard; ignore cancel errors.

### C2. Mass logout at 8am traffic peak
**Likely causes:** refresh storm on expired access tokens; refresh token rotation invalidating siblings.  
**Fix:** single-flight refresh; one retry; verify only one refresh call under load tests.

### C3. “Pinning mismatch” after routine cert renew
**Likely causes:** leaf pin instead of SPKI; SPKI pin but **new key**; pins generated from wrong bytes (`SecKeyCopyExternalRepresentation`).  
**Fix:** confirm pin pipeline hashes SPKI DER; use backup pins; design rotation (S4-A1).

### C4. CI networking tests flake
**Likely causes:** live network; shared mutable `URLProtocol` state across parallel tests.  
**Fix:** inject `NetworkSession` fakes; isolate protocol mocks per test.

---

## D. Speaking drills

### D1. 60s Ads migration
Record once. Must include: Alamofire → URLSession, HTTPS, pinning, whitelist. Must **not** invent shadow traffic or shipped runbook.

### D2. 90s refresh design
Whiteboard three parallel 401s; say “critical section” and “retry once.”

### D3. 45s cancellation distinction
One breath on async participation vs callback explicit cancel + stale guards.

### D4. Full agenda opener
Deliver the README networking HLD opener cold, then expand 3 minutes covering refresh, cache split, S4, S4-A1.

**Opener:**  
> “I’ll scope a first-party URLSession client — endpoints, interceptors, decode/errors — then single-flight refresh, cancellation, cache boundaries, and the Ads security controls: HTTPS, pinning, and host whitelist.”

---

## E. Whiteboard prompts

1. Sequence diagram: three 401s → one refresh → three retries → one failure path to logout.  
2. Table: ATS | TLS defaults | Pinning | Whitelist — layer and failure mode each.  
3. List Ads migration steps (protocol → URLSession → HTTPS → pin → whitelist → **design** rotation).  
4. Mark each step Verified S4 vs S4-A1.

---

## F. Self-score rubric

| Skill | 0 | 1 | 2 |
|---|---|---|---|
| Layer HLD | Missing pieces | Correct happy path | Happy + 401 + cancel + cache boundary |
| Refresh | Per-request refresh | Single-flight named | Actor-safe + retry once + fan-out |
| Cancellation | Vague | Async cancel only | Async + callback stale guards |
| Pinning | ATS confusion | Pinning named | SPKI DER correct + outage mode |
| Provenance | Overclaims | S4 accurate | S4 + explicit S4-A1 design language |

Target: **≥ 8/10** before marking Day 09 complete.

---

## G. After exercises

1. Skim revision twin: [../../../revision/weeks/week-02/day-09.md](../../../revision/weeks/week-02/day-09.md)  
2. Log gotchas: refresh concurrency, SPKI vs raw key bytes, ATS ≠ pinning, no shadow-traffic claim.  
3. Next day builds on persistence / offline — keep cache boundary language ready for Day 10.
