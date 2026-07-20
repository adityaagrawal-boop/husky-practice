# Phase 1 - Atlas Build (Now Incremental)

The original "Phase 1 build atlas" has been split into incremental commands. This file is now an overview pointer.

## What replaced Phase 1

Phase 1 (single-session full build) is replaced by these incremental commands:

| Command | Purpose | Reference |
|---|---|---|
| `start atlas` | Foundation: pattern detection + intake + surface map. ~20-30 min. NO screen docs yet. | `references/cmd-start-atlas.md` |
| `continue atlas` | Per-screen documentation. Repeat across sessions. | `references/cmd-continue-atlas.md` |
| `document <screen>` | Targeted screen documentation. | `references/cmd-continue-atlas.md` |
| `quality review` | Final cross-cutting validation. | `references/quality-review.md` |

## Why incremental

A real B2B SaaS has 20-100 screens. Documenting all in one session burns out the dev (50+ Q&A rounds in 3 hours = bad UX). Quality drops in later screens. Skill carries half-finished state. Dev locked into one sitting.

Incremental fixes all of this. State persists in STATUS.md (`references/status-file.md`). Dev controls pace.

Full session-management strategy: `references/incremental-build.md`.

## Original Phase 1 step list (for reference, replaced by above)

## Pre-conditions

- User is working in a target app's repo
- No `product-atlas/` folder exists yet (or user has explicitly approved overwriting)

## Step-by-step

### 1. Verify location and existing atlas

Confirm working directory is the target app's repo root. If `product-atlas/` already exists:
- Ask user whether to abort, overwrite, or run `rewrite route` per-route instead
- Never overwrite existing atlas without explicit confirmation

### 2. Scan repo for auto-inference

Read in this order to gather data for OVERVIEW.md Section 7 and screen code-trace data:

| Source | Inferred data |
|---|---|
| `package.json` | Product name, repo URL, tech stack (deps) |
| `shopify.app.toml` (Shopify apps) | App config, permission scopes |
| `README.md` (repo root) | Description draft, install flow hint |
| `app/routes/`, `pages/`, `src/routes/` | Route list, surface area |
| `locales/`, `i18n/`, `lang/` | Supported locales |
| `prisma/schema.prisma`, `models/` | Database |
| `webhooks/` configs | Webhook subscriptions |
| `cron/`, scheduled job configs | Background jobs |
| `pricing.ts`, billing configs | Plan structure draft |
| Component imports (Polaris/Chakra/etc.) | UI framework |
| `.env.example` | Third-party services from keys |

### 3. Generate Section 7 (Technical) draft

Apply INFERRED tags on every inferred field. Confidence rules in `references/confidence-rules.md`.

### 4. Run intake AskUserQuestion rounds for Sections 1-3, 6, 8, 9

Approximately 6 rounds of 3-4 questions each. Full intake spec in `references/overview-intake-spec.md`. Template in `assets/overview-template.md`.

### 5. Generate paste-back templates for Sections 4-5

Pricing and Roles are tabular. Ask dev to fill the template offline and paste back. Template in `assets/overview-intake-paste-template.md`.

### 6. Assemble draft OVERVIEW.md

Show to dev for approval. Apply edits. Save final to `product-atlas/OVERVIEW.md`.

### 6a. Collect exclusions (dead code / disabled features)

If the target app was cloned from another SaaS or has feature code that is not live, collect exclusions BEFORE scanning routes. Spec in `references/exclusions.md`. Template at `assets/exclusions-template.md`.

Ask dev (AskUserQuestion):
- "Is this app a clone or fork of another SaaS, or does it contain feature code that is not currently active?"
- If yes: "List the routes, features, or sections that exist in code but are NOT live."

Save to `product-atlas/EXCLUSIONS.md`.

If no exclusions exist, create `EXCLUSIONS.md` with the header and a "No exclusions" note. Skill still loads the file every phase.

### 6b. Collect common components (shared infrastructure)

Collect the list of shared infrastructure components Claude should treat as black boxes. Spec in `references/common-components.md`. Template at `assets/common-components-template.md`.

Ask dev (AskUserQuestion or paste-back template):
- "What shared components (form wrappers, table wrappers, layouts, modal wrappers, etc.) exist in this codebase that should be treated as documented black boxes? I won't dive into their source."

For each, capture:
- Component name + code location
- What it does (one line)
- What to document vs skip when a screen uses it

Save to `product-atlas/COMMON-COMPONENTS.md`.

If dev provides no common components, create `COMMON-COMPONENTS.md` with the header and a "No common components specified" note. Skill still loads the file every phase.

### 7. Build flat route list

Scan router config. Categorize routes: dashboard, settings, content, billing, auth, etc.

**Filter against EXCLUSIONS.md.** Remove any route that matches an exclusion entry. Do not include excluded routes in the walk.

### 8. Per route, depth-first walk

For each route (in dependency order, dashboard/home first):

a. **Read route component code block-by-block.** Identify route render plus all popups, drawers, wizards, tabs, inline-sections rendered from this route. **When you see a component import that appears in COMMON-COMPONENTS.md, do NOT read its source.** Use the documented summary instead. See `references/common-components.md`.

b. **Identify all screens.** Each becomes either:
   - A field inside the parent route's metadata.json (inline simple action), or
   - A sub-folder with its own README + metadata.json (complex screen)
   Use `references/split-criteria.md` to decide.

c. **Run Assumption Checklist** for each screen. See `references/assumption-checklist.md`. 33 items across 12 blocks.

d. **Apply confidence rules.** See `references/confidence-rules.md`. HIGH writes as fact. MEDIUM and LOW always ask dev. UNKNOWN always asks dev.

e. **Batch dev questions per screen.** See `references/question-batching.md`. Per-screen rounds, clear before moving to next screen.

f. **Auto-extract from code into metadata.json:**
   - `events_fired` from `analytics.track()`, `posthog.capture()`, `mixpanel.track()`, etc.
   - `i18n_keys` from `t()`, `i18n.t()`, `<Trans>` calls
   - `integrations` from API client calls, fetch URLs, SDK invocations
   - `data.reads` and `data.writes` from graphql, REST, ORM calls
   - `states.errors` from try/catch blocks, error boundaries, toast.error calls

g. **Write `README.md` + `metadata.json`** for the screen. Use:
   - `references/screen-readme-format.md` + `assets/screen-readme-template.md` for README
   - `references/metadata-schema.md` + `references/metadata-enums.md` + `assets/metadata-template.json` for metadata

### 9. Update screens/README.md

After each route completes, update `screens/README.md` so the navigation tree always reflects what's been built. Format in `references/root-readme-format.md`.

### 10. Auto-generate aggregated docs

Once all screens are written:
- `ROLES.md` from `metadata.access.roles` aggregation
- `PLANS.md` from `metadata.access.plans` and `controls[].gating.plans` aggregation
- `INTEGRATIONS.md` from `metadata.integrations[]` grouped by service
- `OPEN-QUESTIONS.md` from all `_inferred: true` fields and `meta.open_questions` arrays

Rules in `references/auto-aggregation.md`.

### 11. Initialize GLOSSARY.md and STYLE.md

- `GLOSSARY.md`: minimal stub, grows hand-curated over time
- `STYLE.md`: copy from `assets/style-template.md`

### 12. Write top-level README.md for atlas folder

Use `assets/product-atlas-readme-template.md`. Tells users how to navigate the atlas.

### 13. Verify pass

Walk from `screens/README.md`. Confirm:
- Every link works (no 404s within atlas)
- Every screen folder has both `README.md` and `metadata.json`
- Every metadata.json has required fields per `references/metadata-schema.md`
- All inferred items are in `OPEN-QUESTIONS.md`
- No references outside `product-atlas/`

### 14. Write initial CHANGELOG entry

Use `assets/changelog-entry-template.md`. Initial entry includes:
- Date
- Trigger: Phase 1 build atlas
- Generated from commit hash (if git available)
- Routes documented count
- Screens documented count
- Open questions count

### 15. Done

Tell user: atlas ready, open questions count, link to OPEN-QUESTIONS.md for review.
