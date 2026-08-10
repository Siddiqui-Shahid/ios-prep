# Audio script — Sample 07 — Revision Q&A (day-19) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. What does ATS protect you from? `(30–45s)`

Next. Q1. What does ATS protect you from? `(30–45s)` Answer. App Transport Security is the system baseline that prefers HTTPS and blocks cleartext by default, pushing modern TLS configurations. It reduces accidental insecure transport. It is not pinning and it does not make you immune to every MITM scenario — compromised trust stores or hostile enterprise inspection are separate conversations. Exceptions in Info.plist are debt with an expiry plan. Follow-ups. Is ATS the same as pinning?: No — ATS is the HTTPS/TLS baseline; pinning is an extra MITM defense you implement.. What about Info.plist exceptions?: Treat cleartext exceptions as debt with an expiry plan, not permanent product config..

## §1 Q2. Certificate pinning vs SPKI pinning? `(30–45s)`

Next. Q2. Certificate pinning vs SPKI pinning? `(30–45s)` Answer. Leaf certificate pinning breaks when the cert is reissued even if the key is unchanged. SPKI pinning hashes the Subject Public Key Info DER — so it can survive cert renewal when the same key is reused. Keys still change eventually, so you need a rotation design with backup pins. And SPKI means the DER structure hash — not raw SecKeyCopyExternalRepresentation bytes. Follow-ups. Why does leaf pinning break on renew?: Reissued leaf certs change even when the key is unchanged; SPKI pins the key material instead.. What exactly is SPKI?: The SHA-256 of Subject Public Key Info DER — not raw SecKey bytes..

## §2 Q3. Where do you implement pinning on iOS? `(30–45s)`

Next. Q3. Where do you implement pinning on iOS? `(30–45s)` Answer. In the URLSession delegate authentication challenge for server trust. I evaluate trust, extract the certificate’s SPKI DER, SHA-256 it, and compare against embedded pins for allowlisted hosts. Mismatch cancels the challenge for sensitive Ads or auth traffic. That’s the ownership we wanted when Ads moved onto URLSession. Follow-ups. Which A P I surface?: URLSessionDelegate server-trust authentication challenge with evaluate + SPKI compare.. What on mismatch?: Cancel the challenge for allowlisted sensitive hosts — fail closed for Ads/auth traffic..

## §3 Q4. Pin rotation strategy? `(45–60s)`

Next. Q4. Pin rotation strategy? `(45–60s)` Answer. I’d ship a client build that already contains the new SPKI hash alongside the old one, then rotate the server key, watch pin-failure metrics, and retire the old pin later. I’d design a monitored break-glass path for emergencies. On Ads we shipped pinning and whitelist; this rotation playbook I’m describing as design judgment — Design: pin rotation / break-glass (not shipped runbook) — not as a claim I shipped the full ops runbook. Follow-ups. Ship order for rotation?: Ship client with old+new pins first, rotate server key, watch failures, then retire the old pin.. Break-glass?: Design a monitored emergency path — label pin-rotation runbook as design unless you shipped it..

## §4 Q5. Keychain vs UserDefaults? `(30–45s)`

Next. Q5. Keychain vs UserDefaults? `(30–45s)` Answer. UserDefaults is for non-sensitive preferences. Tokens, refresh credentials, and keys go in Keychain with appropriate accessibility — often AccessibleAfterFirstUnlock if background refresh matters — and I usually disable iCloud keychain sync for auth tokens. Putting a token in UserDefaults is a security bug, not a shortcut. Follow-ups. Where do tokens live?: Keychain with deliberate accessibility; never put auth tokens in UserDefaults.. iCloud keychain sync?: Usually disable sync for auth tokens so they don’t roam unexpectedly..

## §5 Q6. Persist refresh token + theme + image cache — where? `(30–45s)`

Next. Q6. Persist refresh token + theme + image cache — where? `(30–45s)` Answer. Refresh token in Keychain, theme in UserDefaults, image files in Caches via FileManager with an NSCache memory layer for the session. That’s the persistence decision tree in miniature — sensitivity and lifetime drive the store, not convenience. Follow-ups. Map the three stores?: Refresh token → Keychain; theme → UserDefaults; image files → Caches (+ NSCache memory).. What drives the choice?: Sensitivity and lifetime — not which A P I is most convenient..

## §6 Q7. Why domain whitelisting with pinning? `(30–45s)`

Next. Q7. Why domain whitelisting with pinning? `(30–45s)` Answer. Allowlisting limits which hosts the client will talk to and which identities we pin. Pinning random third-party hosts you don’t operate is how you inherit their cert rotation pain. On Ads we combined pinning with a domain whitelist so the revenue module only spoke to approved hosts. Follow-ups. Why not pin every host?: You inherit third-party cert rotation pain; allowlist hosts you operate and pin those.. Ads module practice?: BookMyShow Ads combined pinning with a domain whitelist for approved hosts only..

## §7 Q8. Biometric auth — what is stored? `(30–45s)`

Next. Q8. Biometric auth — what is stored? `(30–45s)` Answer. The app doesn’t store the user’s face or fingerprint templates. LocalAuthentication confirms presence and can gate Keychain items via access control. Biometrics are a device-owner step-up, not the primary account identity. Fallback to passcode or fail-closed is an explicit product policy for high-risk actions. Follow-ups. Do you store face templates?: No — LocalAuthentication confirms presence and can gate Keychain items via access control.. Passcode fallback?: Explicit product policy: passcode fallback or fail-closed for high-risk actions..

## §8 Q9. SQLite vs Core Data for offline feed? `(30–45s)`

Next. Q9. SQLite vs Core Data for offline feed? `(30–45s)` Answer. For an offline feed with explicit queries I’d lean SQLite in WAL mode — concurrent readers, one writer, predictable SQL. Core Data wins when I want an object graph and Apple tooling. Either way, writes stay off the main thread. I wouldn’t drag Core Data in for a handful of preference booleans. Follow-ups. When prefer SQLite?: Simple offline feed / keyed blobs with light querying and clear ownership of the schema.. When Core Data?: Richer object graph, relationships, and change tracking — not as a default for every cache..

## §9 Q10. Jailbreak detection — worth it? `(30–45s)`

Next. Q10. Jailbreak detection — worth it? `(30–45s)` Answer. Client jailbreak signals are bypassable, so I treat them as defense-in-depth for high-risk apps, never as the only control. For payments-grade trust I’d rather combine server-side attestation and least privilege than invent a false sense of security from path checks alone — and I’d watch false positives that punish legitimate users. Follow-ups. Worth shipping jailbreak checks?: At best a soft signal; determined attackers bypass it — don’t treat it as real security.. What actually protects data?: Keychain, pinning, ATS, and least-privilege storage — not client-side jailbreak flags..

## §10 Q11. Why leave Alamofire for Ads? `(30–45s)`

Next. Q11. Why leave Alamofire for Ads? `(30–45s)` Answer. Alamofire is fine for rapid CRUD, but Ads needed first-party ownership of the trust evaluation path — HTTPS, pinning, host allowlist — with a smaller dependency surface. URLSession gave us that control on a high-traffic revenue module. It’s threat-model driven, not ideology against libraries. Follow-ups. Why URLSession for Ads?: Own the stack for pinning, whitelist, and interceptors instead of fighting a third-party client.. Was Alamofire always wrong?: No — leave it when you need session ownership for security controls you must implement..

## §11 Q12. Encrypt local DB — when? `(30–45s)`

Next. Q12. Encrypt local DB — when? `(30–45s)` Answer. When the threat model says PII or financial data at rest matters — SQLCipher or strong file protection, with keys in Keychain or Secure Enclave–backed protection. I don’t encrypt everything by cargo cult; I match the store to sensitivity using the persistence decision tree. Follow-ups. When encrypt the DB?: When the store holds PII or tokens at rest and device theft / backup exposure matters.. What still isn’t enough?: Encryption without Keychain-backed keys and clear threat model is theater.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “What does ATS protect you from?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “What does ATS protect you from?” — how do you answer without jargon? `(60–90s)` Answer. “App Transport Security is the system baseline that prefers HTTPS and blocks cleartext by default, pushing modern TLS configurations. It reduces accidental insecure transport. It is not pinning and it does not make you immune to every MITM scenario — compromised trust stores or hostile enterprise inspection are separate conversations. Exceptions in Info.plist are debt with an expiry plan.” Follow-ups. What concept is this really?: What does ATS protect you from. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Certificate pinning vs SPKI pinning” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Certificate pinning vs SPKI pinning” just broke under load. What do you check first? `(60–90s)` Answer. “Leaf certificate pinning breaks when the cert is reissued even if the key is unchanged. SPKI pinning hashes the Subject Public Key Info DER — so it can survive cert renewal when the same key is reused. Keys still change eventually, so you need a rotation design with backup pins. And SPKI means the DER structure hash — not raw SecKeyCopyExternalRepresentation bytes.” Follow-ups. What concept is this really?: Certificate pinning vs SPKI pinning. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “Where do you implement pinning on iOS”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “Where do you implement pinning on iOS”. How do you diagnose? `(60–90s)` Answer. “In the URLSession delegate authentication challenge for server trust. I evaluate trust, extract the certificate’s SPKI DER, SHA-256 it, and compare against embedded pins for allowlisted hosts. Mismatch cancels the challenge for sensitive Ads or auth traffic. That’s the ownership we wanted when Ads moved onto URLSession.” Follow-ups. What concept is this really?: Where do you implement pinning on i O S. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Pin rotation strategy”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Pin rotation strategy”. What do you say and what fix do you propose? `(60–90s)` Answer. “I’d ship a client build that already contains the new SPKI hash alongside the old one, then rotate the server key, watch pin-failure metrics, and retire the old pin later. I’d design a monitored break-glass path for emergencies. On Ads we shipped pinning and whitelist; this rotation playbook I’m describing as design judgment — Design: pin rotation / break-glass (not shipped runbook) — not as a claim I shipped the full ops runbook.” Follow-ups. What concept is this really?: Pin rotation strategy. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Keychain vs UserDefaults”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Keychain vs UserDefaults”? `(60–90s)` Answer. “UserDefaults is for non-sensitive preferences. Tokens, refresh credentials, and keys go in Keychain with appropriate accessibility — often AccessibleAfterFirstUnlock if background refresh matters — and I usually disable iCloud keychain sync for auth tokens. Putting a token in UserDefaults is a security bug, not a shortcut.” Follow-ups. What concept is this really?: Keychain vs UserDefaults. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “Persist refresh token + theme + image cache — where” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “Persist refresh token + theme + image cache — where” and how you’d correct it? `(60–90s)` Answer. “Refresh token in Keychain, theme in UserDefaults, image files in Caches via FileManager with an NSCache memory layer for the session. That’s the persistence decision tree in miniature — sensitivity and lifetime drive the store, not convenience.” Follow-ups. What concept is this really?: Persist refresh token + theme + image cache — where. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “Why domain whitelisting with pinning?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “Why domain whitelisting with pinning?” — how do you answer without jargon? `(60–90s)` Answer. “Allowlisting limits which hosts the client will talk to and which identities we pin. Pinning random third-party hosts you don’t operate is how you inherit their cert rotation pain. On Ads we combined pinning with a domain whitelist so the revenue module only spoke to approved hosts.” Follow-ups. What concept is this really?: Why domain whitelisting with pinning. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “Biometric auth — what is stored” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “Biometric auth — what is stored” just broke under load. What do you check first? `(60–90s)` Answer. “The app doesn’t store the user’s face or fingerprint templates. LocalAuthentication confirms presence and can gate Keychain items via access control. Biometrics are a device-owner step-up, not the primary account identity. Fallback to passcode or fail-closed is an explicit product policy for high-risk actions.” Follow-ups. What concept is this really?: Biometric auth — what is stored. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. SDUI unknown component in prod? `(90–120s)`

Next. T1. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. DI vs singletons under test? `(90–120s)`

Next. T2. DI vs singletons under test? `(90–120s)` Answer. “I inject boundaries at the feature edge so tests replace networking and clocks. Global singletons make flaky tests and hidden order dependence.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. Prefetch that hurts scrolling? `(90–120s)`

Next. T3. Prefetch that hurts scrolling? `(90–120s)` Answer. “Prefetch without budget causes jank and battery drain. I bound concurrency, cancel off-screen work, and measure with Instruments before calling it a win.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. Actor reentrancy surprise? `(90–120s)`

Next. T4. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. They push you to invent a metric you don’t have? `(90–120s)`

Next. T5. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T6. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. They want a one-tool forever answer? `(90–120s)`

Next. T7. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T8. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Main-thread rule under pressure? `(90–120s)`

Next. T9. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. Cancellation honesty? `(90–120s)`

Next. T10. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
