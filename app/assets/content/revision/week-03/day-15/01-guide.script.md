# Audio script — Revision guide — App Modularization, SPM & DI Graphs
> Listen-only revision day guide from `day-15.md`.

## §0 1. Outcome

Next. 1. Outcome. Explain aloud, in plain sentences: Why features depend on interfaces, never other feature implementations How S P M targets map to Interface / Impl / Core and what that buys for build parallelism How the composition root (App target) wires a D I graph without feature-level singletons.

## §1 2. Concept refresh (simple)

Next. 2. Concept refresh (simple). 2. Concept refresh (simple).

## §2 2.1 Module hierarchy

Next. 2.1 Module hierarchy. 2.1 Module hierarchy.

## §3 2.2 SPM packaging

Next. 2.2 SPM packaging. Interface targets build fast and change rarely; Impl targets compile in parallel. Circular deps fail at resolve time — not as mysterious runtime loops.

## §4 2.3 DI without hidden globals

Next. 2.3 DI without hidden globals. Prefer constructor injection or a tree of components over service locators. The App target fulfills dependency protocols; features receive protocols, not .shared singletons.

## §5 2.4 Critical truths (pin)

Next. 2.4 Critical truths (pin). 2.4 Critical truths (pin).

## §6 3. Read these

Next. 3. Read these. 3. Read these.

## §7 4. Map to your work

Next. 4. Map to your work. Stories S D K (Raw / Miami Heat): Raw Engineering — standalone reusable Stories S D K with public A P I and injected host dependencies; adopted across NBA/WNBA portfolio apps. Soft hooks: BookMyShow Ads pipeline + HeroWidget lifecycle Ads as a module boundary (P O P + Generics); District Free Parking + Clean/M V V M + AI tooling Clean/M V V M test discipline; BookMyShow SSL pinning + URLSession migration packaging ≠ architecture (Ads pod path). Interview line (≤20s): “I shipped Stories as a standalone S D K with a clear public A P I and injected host dependencies — one module, multiple apps, no copy-paste forks.” → Stories S D K (Raw / Miami Heat) Stories S D K.

## §8 5. Flash prompts

Next. 5. Flash prompts. 1. Why modularize — three reasons in one breath 2. Interface vs Impl — what lives where? 3. Composition root — who wires what? 4. Feature A navigates to Feature B without importing B’s Impl.

## §9 6. Timed drills

Next. 6. Timed drills. Expand from sample cards and 04-questions answer points.
