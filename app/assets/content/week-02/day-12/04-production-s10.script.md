# Audio script — Sample 04 — Production S10 Stories SDK (Q&A)
> Listen-only sample Q&A from `04-production-s10.md`. Spoken answers and follow-ups.

## §0 Q1. What can you claim under Verified · S10?

Next. Q1. What can you claim under Verified · S10? Answer. You designed a standalone reusable Stories S D K with a clear public A P I and isolation from app-specific networking where possible via injectable boundaries. Drove adoption across portfolio apps (Raw / Miami Heat). Result: one implementation leveraged by multiple apps → faster feature parity. Lesson: S D K quality = A P I surface + versioning + independence from host shortcuts. Follow-ups. ≤20s pitch?: “I built a reusable Stories S D K — clear public A P I and host isolation — so multiple NBA/WNBA portfolio apps shared one stories implementation.”. Invent install counts?: Forbidden — “portfolio” only, no fake N apps.. @Observable as S 10 claim?: Teaching for modern hosts — not verified resume A P I name..

## §1 Q2. What must you never invent for S10?

Next. Q2. What must you never invent for S10? Answer. Do not invent exact install counts or latency percentages. Do not claim the S D K hardcodes Kingfisher/Alamofire as verified requirement. Do not conflate S 10 with S9 District AI tooling story. Do not claim Observation macros as a resume bullet for S 10. Stable page IDs and pause policy are senior design beats — label Learning-lab shape if illustrating A P I sketches. Follow-ups. Public A P I shape OK to sketch?: Learning-lab if labeled — entry player, data source, events.. Injectable loaders?: Design judgment aligned with “isolation from app networking” — honest.. Pause on background?: Lifecycle discipline — cousin to S 1; no invented Aces metrics..

## §2 Q3. How should the Stories SDK public API be shaped?

Next. Q3. How should the Stories SDK public API be shaped? Answer. Entry player, DataSource protocol (host supplies groups/pages), ImageLoading / VideoLoading protocols (injectable), event callbacks (onOpen, onClose, onCTA, onPage), theming hooks, versioned module boundary. Host gets callbacks for analytics and navigation — S D K does not hardcode host networking or push tickets view controller internally. Follow-ups. Why not S D K own network?: Hosts differ; testability; verified isolation claim.. State machine?: idle → loading → playing ⇄ paused → finished (+ failed/retry).. UIKit-only host?: SwiftUI-first + UIHostingController façade for legacy..

## §3 Q4. How do identity and pause policy prove SDK quality?

Next. Q4. How do identity and pause policy prove SDK quality? Answer. Stable page IDs across progress updates — no UUID in body. Progress driven from model timeline, not scattered view timers. Pause on disappear, scene background, user hold — same lifecycle discipline as HeroWidget (S 1 cousin). These are S D K correctness requirements, not optional polish. Follow-ups. Progress desync pushback?: Model timeline + stable identity — not more timers.. UUID ids pushback?: Never in body; stable model keys.. S13 hybrid host?: Identity/lifecycle sibling — hosting without design fails..

## §4 Q5. How do interviewer pushes map to strong replies?

Next. Q5. How do interviewer pushes map to strong replies? Answer. Copy-paste U I? Parity + bugfix cost; one S D K. S D K own network? Hosts differ; testability; isolation. SwiftUI-only? SwiftUI-first + UIKit hosting façade. Progress desync? Model timeline + stable identity. UUID ids? Never in body; stable model keys. Follow-ups. Cross-app reuse challenges?: Theming, analytics hooks, media formats, nav/CTA exits, dependency versions — protocols + defaults.. 60s practice?: Portfolio need → S D K A P I + isolation → reuse → A P I quality lesson.. 3 min practice?: Add state machine, pause, identity, injectable loaders, hybrid note..

## §5 Q6. How does S10 relate to other Week 2 stories?

Next. Q6. How does S10 relate to other Week 2 stories? Answer. S13: hybrid hosts may embed S D K via UIHostingController — identity/lifecycle sibling. S 1: pause/play lifecycle cousin for media. S 10 is the product proof for modular reusable U I — Day 15 SPM deepens packaging, but S 10 is the interview story. Do not merge S 10 into S9 AI or invent portfolio metrics. Follow-ups. Environment DI in S D K?: Prefer explicit injectable protocols over host AppModel in Environment.. Testing?: XCTest player model primary; UITests golden path open/close.. Full questions?:../04-questions.md for timed practice.. Back to: README.md.
