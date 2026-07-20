# Q&A Mode Behavior

When user asks a product question over an existing atlas, follow this flow.

> **Router first.** This file is the read-side detail. The entry point for ANY
> question is `references/router.md`, which classifies intent x persona x output
> and decides what to load. Run the router's Step 0 (classify) and Step 1
> (always-on context) first, then use the steps below to find and read the
> relevant screen docs, and `references/answer-contracts.md` to shape the answer
> for the detected persona (`references/personas.md`).

## Trigger conditions

- User runs `ask: <question>`
- User asks any natural-language product question while a `product-atlas/` exists in the current repo
- User asks "what does X do" or "how does Y work" with reference to the app
- User asks for an artifact ("write a help article / release note / spec / test plan for X")
- User asks a cross-cutting question ("what changed", "if I change X what breaks", "Free vs Premium")

## Cross-cutting query types

Some questions span the whole atlas - handle these per `references/router.md` Step 3:
- **Impact analysis** - walk `related_screens` + `INTEGRATIONS.md` + `PLANS.md` + `ROLES.md`.
- **Comparison** - `PLANS.md` (plans) or `CHANGELOG.md` + `history/` (before/after), as a table.
- **Timeline** - `CHANGELOG.md` + `history/`.
- **Onboarding path** - ordered reading list from the persona's load order.
- **Readiness** - `STATUS.md` + `OPEN-QUESTIONS.md` + `views/qa/`.

## Flow

### Step 1: Load OVERVIEW.md + STATUS.md + ATLAS-RULES.md (always)
Read in order:
- `product-atlas/OVERVIEW.md` - product brain
- `product-atlas/STATUS.md` - current atlas state (helps gauge confidence)
- `product-atlas/ATLAS-RULES.md` - per-repo vocabulary and rules to respect in answers

### Step 2: Load screens/README.md and SURFACE-MAP.md (always)
Read `product-atlas/screens/README.md` for the full navigation tree.
Read `product-atlas/SURFACE-MAP.md` to know tier-based confidence (Critical screens have higher-quality docs than Standard).

### Step 3: Identify relevant route(s)

Use the question keywords to find relevant screen folder(s):
- If question mentions a specific screen name → that screen folder
- If question mentions a feature → use INTEGRATIONS.md or PLANS.md or ROLES.md as index to find relevant screens
- If question mentions a user role → ROLES.md to find screens that role accesses
- If question mentions a pricing plan → PLANS.md to find screens unlocked by that plan
- If question mentions a third-party service → INTEGRATIONS.md

### Step 4: Load relevant screen READMEs

Read the matched screen's `README.md` and `metadata.json`. If the question spans multiple screens, load multiple.

### Step 5: Cross-reference aggregated docs as needed

Pull from:
- `ROLES.md` for role-based questions
- `PLANS.md` for pricing/plan-based questions
- `INTEGRATIONS.md` for service-based questions
- `GLOSSARY.md` for term definitions
- `OPEN-QUESTIONS.md` if the question touches an unresolved area (flag uncertainty)

### Step 6: Answer in the persona's shape, with citations

Shape the answer per `references/answer-contracts.md` for the persona the router detected (`references/personas.md`) and the requested output form (quick answer / deep dive / artifact). Attach a confidence label and, for high-stakes answers, a staleness check per `references/confidence-and-freshness.md`.

Format: cite the source file path within `product-atlas/` so the user can verify.

Example:
> "The auto-SEO toggle runs every night at midnight. When turned on, it scans products and fills missing meta titles. (See [Products screen](product-atlas/screens/products/README.md), Controls section.)"

## Citation format

Always include relative path citations:
- Single source: `(See [Screen Name](product-atlas/screens/<route>/<screen>/README.md))`
- Multiple sources: list each at the end of the answer

## When data is missing or inferred

- If the answer relies on INFERRED data → flag it: "Note: this is inferred from code, awaiting dev confirmation. See OPEN-QUESTIONS.md."
- If the answer is in OPEN-QUESTIONS.md → say so explicitly: "This is currently unresolved. Logged in [OPEN-QUESTIONS.md](product-atlas/OPEN-QUESTIONS.md)."
- If the atlas doesn't cover the question because the screen is still pending in STATUS.md → say "This screen hasn't been documented yet. Currently <state>. Run `document <screen>` to add it."
- If the atlas doesn't cover the question because the feature is in EXCLUSIONS.md → say "This feature is excluded from atlas (see EXCLUSIONS.md for reason)."
- If the atlas doesn't cover the question and screen isn't pending/excluded → **use the code-fallback (router Step 4):** read the relevant source code directly, answer from code, flag it as code-derived (not yet in atlas), and offer to add it via `document <screen>` / `rewrite route <slug>`. If it's a product DECISION code can't answer, log it to `OPEN-QUESTIONS.md` and say a human must decide. Never dead-end with "not documented."

## Tier-aware confidence

Q&A answers should acknowledge documentation depth:
- If answer comes from a Critical-tier screen → high confidence
- If from Important → high confidence on core info, lower on edge cases
- If from Standard → confident on main behavior, may lack depth on rare scenarios
- If from INFERRED items → flag uncertainty

## What Q&A mode does NOT do

- Does NOT modify atlas files (Q&A is read-only; switch to `rewrite` flows to change docs)
- Prefers the atlas, but MAY read source code as a fallback when the atlas doesn't cover the question (router Step 4). When it does, it flags the answer as code-derived and offers to add it to the atlas - it does not silently write docs.
- Does NOT answer questions about excluded features. Respond: "This feature is excluded from the atlas. See EXCLUSIONS.md for reason."
- Does NOT dive into common components. If user asks about a component listed in COMMON-COMPONENTS.md, respond with the summary from that file, not source code analysis.

If user asks a question that requires modifying atlas (e.g., "this is wrong, update the docs"), switch to Phase 2 or Phase 3 flow.
