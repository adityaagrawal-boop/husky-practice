# Personas - Canonical Audience Set

<!--
  WHY THIS FILE EXISTS (business logic):
  "Roles" used to be defined in three places that disagreed - use-cases.md (9 use
  cases), views/ (6 folders), and the per-repo ASK-ME-FIRST.md (~8 intents). That
  drift meant the router, view generator, and Q&A could each serve a different
  set. This file is the SINGLE canonical persona list. The router, answer
  contracts, view generation, and use-cases all reference these 8. Change a
  persona here and everything downstream stays aligned.
-->

The product brain serves **8 canonical personas**. Every routing, answer-shaping, and view-generation decision references this list. Each persona entry says: who they are, what they typically ask, which atlas files to load, and the answer shape they need.

> Persona is **inferred** from the request by `references/router.md`. The asker may not name a role - infer it, ask only when ambiguous.

## The 8 personas

### 1. Developer
- **Who:** Engineers building or changing the app.
- **Typically asks:** "Where is the code for X?", "What's the data flow?", "What APIs/webhooks does this call?", "What are the edge cases / side effects?"
- **Load:** screen `metadata.json` (`code_files`), `INTEGRATIONS.md`, `COMMON-COMPONENTS.md`, architecture/data-flow sections, and `TECHNICAL-FLOW.md` if present (`references/technical-flow-diagrams.md`).
- **Answer shape:** data flow + file paths + APIs + side effects + edge cases. Code identifiers welcome.

### 2. PM (Product Manager)
- **Who:** Owns scope, priorities, and tradeoffs.
- **Typically asks:** "What problem does X solve?", "What's the scope?", "What are the risks/tradeoffs?", "Is X done?", "What's open?"
- **Load:** `OVERVIEW.md`, `STATUS.md`, `OPEN-QUESTIONS.md`, `CHANGELOG.md`, per-feature `purpose` + `access`, top-level `PM-*` / `*-ROADMAP` / `*-RISK-*` docs if present.
- **Answer shape:** user problem → behavior → scope → tradeoffs → open questions.

### 3. Support
- **Who:** Front-line team helping users.
- **Typically asks:** "User says X is broken - what do I tell them?", "How do they do Y?", "When does this error happen?"
- **Load:** affected `screens/<route>/README.md`, `COMMON-COMPONENTS.md`, `OPEN-QUESTIONS.md`, `states.errors` in metadata, top-level `SUPPORT-*` playbooks if present.
- **Answer shape:** symptom → likely cause → user-safe steps → escalation note (separate user-facing from internal-only checks).

### 4. QA
- **Who:** Testers validating behavior.
- **Typically asks:** "What are the preconditions?", "What should I test on X?", "What's the expected result?", "Known risks?"
- **Load:** `views/qa/` latest matrix, screen `metadata.controls` (every option) + `states` + `access`.
- **Answer shape:** feature → preconditions → test steps → expected result → known risks.

### 5. Marketing
- **Who:** Positioning, messaging, and demand generation.
- **Typically asks:** "What's the benefit of X?", "How do we position vs competitors?", "Give me landing copy / a feature announcement."
- **Load:** `OVERVIEW.md` positioning, `PLANS.md`, per-feature `purpose.business_value`, `views/marketing/` (reserved), UX/positioning docs if present.
- **Answer shape:** value prop → who it's for → benefit (outcome, not feature) → proof/differentiator → messaging hooks.
- **Note:** `generate marketing view` is available on demand (spec in `references/view-generation.md`); output lands in `views/marketing/`.

### 6. Data analyst
- **Who:** Measures adoption, revenue, behavior.
- **Typically asks:** "What metrics exist?", "How is X computed?", "Where is this data stored?", "What's the revenue/credit impact?"
- **Load:** `screens/analytics/README.md` + analytics sub-feature metadata, `PLANS.md` (credits/billing), the generated data dictionary in `views/data/`.
- **Answer shape:** metric → definition → data source → how computed → caveats.
- **Note:** `generate data-dictionary` is implemented (`references/view-generation.md`; `scripts/generate-views.mjs`). A generated dictionary is present in `views/data/`.

### 7. Sales
- **Who:** Demos and closing.
- **Typically asks:** "How do I demo X?", "What's the ROI?", "How do I handle objection Y?"
- **Load:** `OVERVIEW.md` positioning, `PLANS.md`, per-feature/action `business_value`, `views/sales/`.
- **Answer shape:** hook → demo flow → ROI per feature → objection handling.

### 8. Designer
- **Who:** UX/UI and flows.
- **Typically asks:** "What's the layout of X?", "What's the user flow?", "Why is it designed this way?"
- **Load (text-first):** the screen README's "What you see here" / layout (ASCII) section + "What you can do from here", the route `FEATURE-MAP.md` layout diagram, `FLOWS.md` (journeys), `DECISIONS.md` (UX rationale), and `UI-SNAPSHOTS.md` (textual UI descriptions). Also `analyses/` for any UX audits/redesigns.
- **Answer shape:** screen layout → user flow → controls → UX rationale.
- **Note:** the atlas describes UI in **text** (layout sections, FEATURE-MAP diagrams, UI-SNAPSHOTS.md). The `ui-snapshots/` image folder is **optional and manually populated** — do not assume rendered images exist; answer from the text sources above and say images aren't captured if asked for one.

## Mapping to views and use cases

| Persona | Existing view folder | Use case (`use-cases.md`) |
|---|---|---|
| Developer | `views/onboarding/` | Developer onboarding |
| PM | `views/pm-specs/` | PM artifacts |
| Support | `views/support/` | Support docs |
| QA | `views/qa/` | QA test plans |
| Marketing | `views/marketing/` *(on demand)* | Marketing collateral |
| Data analyst | `views/data/` *(generated)* | Data dictionary |
| Sales | `views/sales/` | Sales scripts |
| Designer | text sources (README layouts, `FEATURE-MAP` diagrams, `UI-SNAPSHOTS.md`, `analyses/`) | Design handoff |

Plus two non-persona use cases that any persona triggers: **AI Q&A** (the router itself) and **Audit trail** (`CHANGELOG.md` + `history/`).

Every persona above also has an **onboarding playlist** available (`generate onboarding playlist for <persona>`, spec in `references/onboarding-playlists.md`), not just Developer, that command is the persona-agnostic counterpart to the Developer-only `generate onboarding doc`.
