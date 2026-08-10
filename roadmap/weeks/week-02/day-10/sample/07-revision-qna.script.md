# Audio script — Sample 07 — Revision Q&A (day-10) (Q&A)
> Listen-only sample Q&A from `07-revision-qna.md`. Spoken answers and follow-ups.

## §0 Q1. What is server-driven UI? `(30–45s)`

Next. Q1. What is server-driven UI? `(30–45s)` Answer. Server-driven U I means the backend sends a structured schema for layout and content, and the client maps each type to a native SwiftUI or UIKit component through a registry. Actions are allowlisted. It’s not evaluating JavaScript from CMS, and it’s not ‘the whole app is a WebView.’ On BookMyShow we used that approach for a backend-driven main header so content could move faster without waiting on every release. Follow-ups. Probe deeper?: BookMyShow’s backend-driven header maps schema nodes to native components via a registry — not a WebView shell..

## §1 Q2. Core client components of an SDUI stack? `(45–60s)`

Next. Q2. Core client components of an SDUI stack? `(45–60s)` Answer. I’d describe a pipeline: parse the payload, run a schema version gate, resolve nodes through a ComponentRegistry, handle allowlisted actions, and keep a FallbackEngine for last-known-good or baked defaults. Analytics hooks validate events. The ViewModel owns fetch and cache state; the registry stays a pure mapping layer. Follow-ups. Probe deeper?: Pipeline is parse → schema version gate → ComponentRegistry → allowlisted actions → FallbackEngine for last-known-good..

## §2 Q3. How do you version the schema? `(60s)`

Next. Q3. How do you version the schema? `(60s)` Answer. I version the schema and have the client declare a max-supported version. Additive fields are ignored by older clients. Breaking changes get a major bump with a dual-publish period. If the payload is too new, I reject to a safe fallback rather than crashing. Capability flags help the server avoid sending unsupported types. On BMS header work I’d insist on that discipline as design even when speaking carefully about what was named in production. Follow-ups. Probe deeper?: Client declares max-supported schema version; too-new payloads reject to fallback instead of crashing on unknown fields..

## §3 Q4. Unknown component arrives in prod — what happens? `(45s)`

Next. Q4. Unknown component arrives in prod — what happens? `(45s)` Answer. The registry skips the unknown node, emits a metric with the type name, and continues rendering siblings. We never crash on CMS strings. If skipping leaves a meaningless root — like a blank splash — we engage a hard fallback layout. Skipping without metrics is how broken contracts hide until users complain. Follow-ups. Probe deeper?: Skip unknown types with a metric and keep siblings; if the root is empty, show a hard fallback layout..

## §4 Q5. Offline / fetch failure strategy? `(45–60s)`

Next. Q5. Offline / fetch failure strategy? `(45–60s)` Answer. On network or parse failure I show last-known-good from disk if present and within TTL; otherwise a baked native default. Optionally show a stale affordance if product needs honesty. Retry with backoff in the background. For splash specifically, cached content is critical so cold start isn’t held hostage by the network — that’s the Aces mindset. Follow-ups. Probe deeper?: On fetch failure prefer last-known-good within TTL, else a baked default — Aces splash must not block cold start on a perfect CMS hit..

## §5 Q6. How did BMS header SDUI help the business? `(45s)`

Next. Q6. How did BMS header SDUI help the business? `(45s)` Answer. It let content and layout on the main header iterate faster without waiting on App Store for many changes, behind a generalised protocol-driven client. That’s real product velocity. The limit is honest: new component types still require an app release to register native renderers. Follow-ups. Probe deeper?: Header content can iterate without App Store for many changes, but new native component types still need a client release..

## §6 Q7. SDUI actions security? `(45–60s)`

Next. Q7. SDUI actions security? `(45–60s)` Answer. Actions are allowlisted — open deeplink, open URL, refresh module — not arbitrary code. URLs go through domain policy; deeplinks go through the app router. Auth-sensitive actions re-check client-side. Never execute CMS scripts. It’s the same threat mindset as host whitelisting on networking day. Follow-ups. Probe deeper?: Allowlist actions like open deeplink or refresh; URLs still pass domain policy and never execute CMS scripts..

## §7 Q8. When is SDUI a bad idea? `(45s)`

Next. Q8. When is SDUI a bad idea? `(45s)` Answer. S D U I is a poor fit for highly interactive one-off U I, heavy custom animation, or surfaces that rarely change — and it’s dangerous if the team won’t invest in schema QA. Prefer hybrid: CMS slots inside native chrome. Revenue ads video often stays native for lifecycle guarantees — configure placement maybe, don’t S D U I the player. Follow-ups. Probe deeper?: Keep ad video players native for lifecycle guarantees — S D U I may configure placement, not own AVPlayer pause/play..

## §8 Q9. How do analytics work in SDUI? `(45s)`

Next. Q9. How do analytics work in SDUI? `(45s)` Answer. The payload can attach analytics event names and params, but the client validates them and injects common context like screen and app version. I don’t treat CMS as an unchecked PII pipe. Bad event names get dropped or mapped safely. Follow-ups. Probe deeper?: Validate CMS analytics names and inject screen/app context; drop bad event names rather than treating CMS as a PII pipe..

## §9 Q10. Cold start + server splash — how do you think about metrics? `(45–60s)`

Next. Q10. Cold start + server splash — how do you think about metrics? `(45–60s)` Answer. I care about time-to-interactive more than a vanity first-frame number. Splash should read cache quickly, attempt a short network refresh, and fall back to a default if slow. Blocking launch on a perfect CMS response is how you create slow launches. On Aces we made splash server-driven for flexibility and freshness — I won’t invent millisecond claims. Follow-ups. Probe deeper?: Optimize time-to-interactive: cache-first splash, short refresh window, then default — don’t invent millisecond claims..

## §10 Q11. How do you test SDUI? `(45–60s)`

Next. Q11. How do you test SDUI? `(45–60s)` Answer. I use fixture schemas per version, registry unit tests, chaos payloads with unknown types, and snapshots for critical chrome. Contract tests with backend catch drift. UITests cover a few golden paths — not every CMS combination, because that matrix explodes. Follow-ups. Probe deeper?: Fixture schemas, chaos unknown-type payloads, and a few golden-path UITests beat trying to UITest every CMS combination..

## §11 Q12. SDUI vs feature flags vs A/B? `(45s)`

Next. Q12. SDUI vs feature flags vs A/B? `(45s)` Answer. Feature flags toggle code paths. A/B assigns users to variants. S D U I changes layout and content through payloads. They’re often combined: a flag enables an S D U I surface, and CMS or experiment config supplies the variant layout. Don’t conflate the three in an interview. Follow-ups. Probe deeper?: Flags toggle code paths, A/B assigns users, S D U I supplies layout payloads — often combined, never conflated in an interview.. Indirect questions These do not name the concept first. Speak from the symptom, scenario, or junior question.

## §12 I1. A junior asks you in standup: “What is server-driven UI?” — how do you answer without jargon? `(60–90s)`

Next. I1. A junior asks you in standup: “What is server-driven UI?” — how do you answer without jargon? `(60–90s)` Answer. “Server-driven U I means the backend sends a structured schema for layout and content, and the client maps each type to a native SwiftUI or UIKit component through a registry. Actions are allowlisted. It’s not evaluating JavaScript from CMS, and it’s not ‘the whole app is a WebView.’ On BookMyShow we used that approach for a backend-driven main header so content could move faster without waiting on every release.” Follow-ups. What concept is this really?: What is server-driven U I. How do you prove it?: Give a tiny example or production boundary..

## §13 I2. Production symptom: something related to “Core client components of an SDUI stack” just broke under load. What do you check first? `(60–90s)`

Next. I2. Production symptom: something related to “Core client components of an SDUI stack” just broke under load. What do you check first? `(60–90s)` Answer. “I’d describe a pipeline: parse the payload, run a schema version gate, resolve nodes through a ComponentRegistry, handle allowlisted actions, and keep a FallbackEngine for last-known-good or baked defaults. Analytics hooks validate events. The ViewModel owns fetch and cache state; the registry stays a pure mapping layer.” Follow-ups. What concept is this really?: Core client components of an S D U I stack. How do you prove it?: Give a tiny example or production boundary..

## §14 I3. Interviewer never names the topic. They describe a mess that maps to “How do you version the schema”. How do you diagnose? `(60–90s)`

Next. I3. Interviewer never names the topic. They describe a mess that maps to “How do you version the schema”. How do you diagnose? `(60–90s)` Answer. “I version the schema and have the client declare a max-supported version. Additive fields are ignored by older clients. Breaking changes get a major bump with a dual-publish period. If the payload is too new, I reject to a safe fallback rather than crashing. Capability flags help the server avoid sending unsupported types. On BMS header work I’d insist on that discipline as design even when speaking carefully about what was named in production.” Follow-ups. What concept is this really?: How do you version the schema. How do you prove it?: Give a tiny example or production boundary..

## §15 I4. Code review: you spot a smell around “Unknown component arrives in prod — what happens”. What do you say and what fix do you propose? `(60–90s)`

Next. I4. Code review: you spot a smell around “Unknown component arrives in prod — what happens”. What do you say and what fix do you propose? `(60–90s)` Answer. “The registry skips the unknown node, emits a metric with the type name, and continues rendering siblings. We never crash on CMS strings. If skipping leaves a meaningless root — like a blank splash — we engage a hard fallback layout. Skipping without metrics is how broken contracts hide until users complain.” Follow-ups. What concept is this really?: Unknown component arrives in prod — what happens. How do you prove it?: Give a tiny example or production boundary..

## §16 I5. What happens if a teammate ignores the rule behind “Offline / fetch failure strategy”? `(60–90s)`

Next. I5. What happens if a teammate ignores the rule behind “Offline / fetch failure strategy”? `(60–90s)` Answer. “On network or parse failure I show last-known-good from disk if present and within TTL; otherwise a baked native default. Optionally show a stale affordance if product needs honesty. Retry with backoff in the background. For splash specifically, cached content is critical so cold start isn’t held hostage by the network — that’s the Aces mindset.” Follow-ups. What concept is this really?: Offline / fetch failure strategy. How do you prove it?: Give a tiny example or production boundary..

## §17 I6. Walk me through a failed interview answer on “How did BMS header SDUI help the business” and how you’d correct it? `(60–90s)`

Next. I6. Walk me through a failed interview answer on “How did BMS header SDUI help the business” and how you’d correct it? `(60–90s)` Answer. “It let content and layout on the main header iterate faster without waiting on App Store for many changes, behind a generalised protocol-driven client. That’s real product velocity. The limit is honest: new component types still require an app release to register native renderers.” Follow-ups. What concept is this really?: How did BMS header S D U I help the business. How do you prove it?: Give a tiny example or production boundary..

## §18 I7. A junior asks you in standup: “SDUI actions security?” — how do you answer without jargon? `(60–90s)`

Next. I7. A junior asks you in standup: “SDUI actions security?” — how do you answer without jargon? `(60–90s)` Answer. “Actions are allowlisted — open deeplink, open URL, refresh module — not arbitrary code. URLs go through domain policy; deeplinks go through the app router. Auth-sensitive actions re-check client-side. Never execute CMS scripts. It’s the same threat mindset as host whitelisting on networking day.” Follow-ups. What concept is this really?: S D U I actions security. How do you prove it?: Give a tiny example or production boundary..

## §19 I8. Production symptom: something related to “When is SDUI a bad idea” just broke under load. What do you check first? `(60–90s)`

Next. I8. Production symptom: something related to “When is SDUI a bad idea” just broke under load. What do you check first? `(60–90s)` Answer. “S D U I is a poor fit for highly interactive one-off U I, heavy custom animation, or surfaces that rarely change — and it’s dangerous if the team won’t invest in schema QA. Prefer hybrid: CMS slots inside native chrome. Revenue ads video often stays native for lifecycle guarantees — configure placement maybe, don’t S D U I the player.” Follow-ups. What concept is this really?: When is S D U I a bad idea. How do you prove it?: Give a tiny example or production boundary.. Tricky questions / brain puzzles Cover the answer. Speak for ~90–120s. These separate “I read a blog” from “I’ve been burned.”.

## §20 T1. Actor reentrancy surprise? `(90–120s)`

Next. T1. Actor reentrancy surprise? `(90–120s)` Answer. “Await inside an actor can interleave other work on that actor. I don’t assume exclusive state across an await without re-checking invariants.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §21 T2. They push you to invent a metric you don’t have? `(90–120s)`

Next. T2. They push you to invent a metric you don’t have? `(90–120s)` Answer. “I refuse fake precision. I say what I measured, what I didn’t, and what I’d instrument next. Honesty beats a made-up crash percentage.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §22 T3. They ask if your lab demo was the shipped file? `(90–120s)`

Next. T3. They ask if your lab demo was the shipped file? `(90–120s)` Answer. “I separate Learning-lab sketches from Verified production. Lab code teaches the idea; shipped systems may differ. I never claim the demo file was production.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §23 T4. They want a one-tool forever answer? `(90–120s)`

Next. T4. They want a one-tool forever answer? `(90–120s)` Answer. “I pick a default for the constraint, then name the trade-off and when I’d switch. Senior answers are context-bound, not slogan-bound.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §24 T5. Race vs deadlock — they mix the terms? `(90–120s)`

Next. T5. Race vs deadlock — they mix the terms? `(90–120s)` Answer. “Race is unsynchronized shared mutation — corruption and Heisenbugs. Deadlock is waiting forever on an order you can’t break. Fix races with a clear exclusion boundary; fix deadlocks by never syncing onto the queue you’re already on.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §25 T6. Main-thread rule under pressure? `(90–120s)`

Next. T6. Main-thread rule under pressure? `(90–120s)` Answer. “U I work on main. Heavy parse/decode off main. Hop back with async, not sync from main. If the app freezes, I look for sync-to-self or main-queue overload first.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §26 T7. Cancellation honesty? `(90–120s)`

Next. T7. Cancellation honesty? `(90–120s)` Answer. “Cancel in-flight work when the screen goes away. Weak self in completions. Structured tasks cancel children. I don’t claim cancellation if I only nil’d a delegate.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §27 T8. Cache invalidation trap? `(90–120s)`

Next. T8. Cache invalidation trap? `(90–120s)` Answer. “I define TTL, version keys, and a clear bust path. Stale U I with a spinner is often better than corrupt merge. I say what is source of truth.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §28 T9. Security theater vs real pinning? `(90–120s)`

Next. T9. Security theater vs real pinning? `(90–120s)` Answer. “Pinning without rotation and a kill-switch is how you brick clients. I describe SPKI pins, backup pins, and remote config escape hatches.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..

## §29 T10. SDUI unknown component in prod? `(90–120s)`

Next. T10. SDUI unknown component in prod? `(90–120s)` Answer. “Unknown type must degrade — skip, placeholder, or safe fallback — never crash the screen. Schema version and registry discipline matter more than fancy rendering.” Follow-ups. One-sentence opener?: Say the core idea in one clear sentence..
