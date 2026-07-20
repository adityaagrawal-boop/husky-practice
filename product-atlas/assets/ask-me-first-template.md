<!--
  TEMPLATE: ASK-ME-FIRST.md
  WHY: This file is the product brain's front door inside a generated atlas. Every
  atlas should ship with it so any teammate (any role) knows how the brain routes
  their question. It is the per-repo, human-readable mirror of the skill's
  references/router.md. Copy this into product-atlas/ASK-ME-FIRST.md at build time
  and fill the [bracketed] bits with repo-specific paths/areas.
-->
# Ask Me First

This is the front door of the **product brain**. The atlas is not only a documentation folder - treat it as the single source of truth a whole team can query: developers, PMs, support, QA, marketing, data analysts, sales, and designers.

Answer through the router: **figure out who's asking, what they want, and in what form - then route.** Do not answer only from top-level files unless the question is truly high-level.

## Step 1 - Identify intent (what they're trying to do)

| Intent | Load first | Then load |
|---|---|---|
| Understand the product | `OVERVIEW.md`, `SURFACE-MAP.md`, `screens/README.md` | Relevant route README files |
| Test the product | `views/qa/` latest matrix | Relevant screen README + `metadata.json` |
| Debug a user issue | `screens/[storefront-or-runtime]/README.md`, `COMMON-COMPONENTS.md`, `OPEN-QUESTIONS.md` | Affected screen docs |
| Build or change code | `OVERVIEW.md`, `INTEGRATIONS.md`, `COMMON-COMPONENTS.md` | Screen README + `metadata.json` (`code_files`) |
| Plan product work | `STATUS.md`, `CHANGELOG.md`, `OPEN-QUESTIONS.md`, `SURFACE-MAP.md` | Relevant route docs, any `PM-*` docs |
| Sell / pitch | `OVERVIEW.md`, `PLANS.md` | Per-feature business value, `views/sales/` |
| Market / position | `OVERVIEW.md`, `PLANS.md` | Per-feature business value, `views/marketing/` |
| Analyze data / revenue | `screens/[analytics]/README.md`, `PLANS.md` | Analytics sub-feature docs, data-dictionary |
| Maintain docs after a PR | `MAINTENANCE.md`, `STATUS.md`, `CHANGELOG.md` | Affected screen README + `metadata.json` |
| Create an artifact (article, ticket, release note) | whatever the underlying intent needs | shape it per the persona |
| Check access / permissions | `ROLES.md`, `PLANS.md` | Relevant screen docs |
| Check integrations / data flow | `INTEGRATIONS.md` | Related feature docs |

## Step 2 - Match the persona's answer shape

Infer the persona; ask only if genuinely unclear.

| Persona | Answer shape |
|---|---|
| New to project | Plain English, explain terms, avoid code identifiers |
| Developer | Data flow, files, APIs, side effects, edge cases |
| PM | User problem, behavior, scope, tradeoffs, open questions |
| Support | Symptom, likely cause, end-user-safe steps, escalation |
| QA | Feature, preconditions, test steps, expected result, risks |
| Marketing | Value prop, who it's for, benefit, differentiator, hooks |
| Data analyst | Metric, definition, data source, computation, caveats |
| Sales | Hook, demo flow, ROI, objection handling |
| Designer | Layout, user flow, controls, UX rationale |

## Step 3 - Cross-cutting questions

- **Impact** ("if I change X?") → walk related screens + `INTEGRATIONS.md` + `PLANS.md` + `ROLES.md`.
- **Comparison** ("Free vs Premium", "before vs after") → `PLANS.md` or `CHANGELOG.md` + `history/`, as a table.
- **Timeline** ("what changed?") → `CHANGELOG.md` + `history/`.
- **Onboarding** ("what do I read as <role>?") → ordered reading list for that persona.
- **Readiness** ("is X done/tested?") → `STATUS.md` + `OPEN-QUESTIONS.md` + `views/qa/`.

## Step 4 - Depth & fallback

1. Orient with top-level files. 2. `screens/<route>/README.md` for route behavior. 3. Feature README for controls/states/actions. 4. `metadata.json` for exact controls, QA cases, access, APIs, data fields. 5. `OPEN-QUESTIONS.md` for known gaps/bugs.

If the atlas doesn't cover it: say so, then **read the source code directly** and answer from code (flagging it as not-yet-in-atlas), or - if it's an unmade product decision - log it to `OPEN-QUESTIONS.md`. Never dead-end with "not documented."

## Answering rules

- Stay inside `product-atlas/` as the source of truth; cite file paths.
- Say when the atlas has no answer or only an open question.
- For new users / support / marketing / sales, avoid code-only identifiers.
- For QA, convert docs into testable flows, not a generic feature list.
- For support, separate end-user-facing steps from internal-only checks.
- Flag inferred or potentially stale answers.
- Do not invent features listed in `EXCLUSIONS.md`.
