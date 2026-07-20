# View Generation

Use-case-specific exports derived from the atlas. Each `generate <view-name>` command transforms the same atlas data into a different output shape.

## Output location

All view outputs go to `product-atlas/views/<view-name>/` with timestamped filenames:
```
product-atlas/views/
├── support/<YYYY-MM-DD>-help-articles.md
├── pm-specs/<YYYY-MM-DD>-feature-specs.md
├── qa/<YYYY-MM-DD>-test-matrix.md
├── i18n/<YYYY-MM-DD>-string-keys.md
├── sales/<YYYY-MM-DD>-demo-script.md
├── onboarding/<YYYY-MM-DD>-dev-walkthrough.md
├── marketing/<YYYY-MM-DD>-collateral.md
├── data/<YYYY-MM-DD>-data-dictionary.md
└── playlists/<persona>/<YYYY-MM-DD>-onboarding.md (or -offboarding.md)
```

The `views/` folder is added inside `product-atlas/` since views are derived from the atlas and belong with it.

## Pre-conditions

- Atlas must exist (Phase 1 completed)
- Required fields must be present (view-gen-time validation is hard - see `references/validation-rules.md`)

## Per-view specs

### `generate support view`

**Source:** README prose from every screen + `metadata.states` (empty/loading/errors) + `metadata.controls[].business_recommendation`

**Output structure (per screen):**
```markdown
# [Screen Name]

## When users get stuck here
[From states.errors - each error scenario as a troubleshooting entry]

## Common questions
[From README.md Common Questions section]

## How to use [each control]
[From metadata.controls - business recommendation framed as user advice]
```

**Validation:** Fails if any screen missing `purpose.what` or has unhandled error scenarios without UI.

### `generate pm specs`

**Source:** `metadata.purpose` + `metadata.controls` + `metadata.actions` + `metadata.access`

**Output structure (per feature):**
```markdown
# [Feature Name]

## Problem solved
[From purpose.what + purpose.jtbd]

## Business value
[From purpose.business_value]

## Surface
- Screens: [list]
- Controls: [list with on/off effects]
- Actions: [list with business value]

## Gating
- Roles: [list]
- Plans: [list]

## Connected to
[related_screens with relationships]
```

**Validation:** Fails if any screen missing `purpose.what`.

### `generate qa view`

**Source:** `metadata.controls` (every option) + `metadata.states.errors` + `metadata.access`

**Output structure (per screen):**
```markdown
# [Screen Name] - Test Matrix

## Pre-conditions
- Required role: [list]
- Required plan: [list]
- Required state: [conditions]

## Control tests
For each control:
- [Control name] - test setting each value, verify effect

## State tests
- Empty state: visible when [condition]
- Loading state: visible when [condition]
- Error tests: trigger each error scenario, verify UI

## Action tests
For each action:
- Click [action] → verify [opens target]
```

**Validation:** Fails if any control missing `default` or any required state missing.

### `generate i18n keys`

**Source:** `metadata.i18n_keys` across all screens

**Output structure:**
```markdown
# String Key Inventory

## Total keys: [count]
## Total screens: [count]

## Keys by screen
### [Screen Name]
- [key]
- [key]

## Deduplicated key list
[Single flat sorted list of unique keys for translation export]

## Keys missing translations
[If translation files were scanned, list keys not present in non-default locale files]
```

**Validation:** Never fails. Aggregates whatever exists.

### `generate sales script`

**Source:** OVERVIEW.md positioning + per-feature `purpose.business_value` + `metadata.actions[].business_value`

**Output structure:**
```markdown
# [App Name] - Sales Demo Script

## Positioning (30 sec)
[OVERVIEW one-liner + core value prop]

## Demo flow (5-10 min)
1. Show [primary screen] - "This is where [primary JTBD]"
2. Demonstrate [key feature] - "Here's how it solves [pain point]"
...

## ROI per feature
[Each feature's business_value framed as user outcome]

## Objection handling
[From OVERVIEW.md Why users don't pick this section]
```

**Validation:** Fails if OVERVIEW missing positioning section.

### `generate onboarding doc`

**Source:** screens tree + `metadata.screen.code_files` + INTEGRATIONS.md + GLOSSARY.md

**Output structure:**
```markdown
# [App Name] - Developer Walkthrough

## Where to start
- OVERVIEW.md - product context
- screens/ - navigation map

## How the app is organized
[Routes summary with code file references]

## Key services
[From INTEGRATIONS.md]

## Glossary
[Embedded GLOSSARY.md]

## Per-route deep dive
For each route:
- Purpose
- Key code files
- Key controls
- Connected screens
```

**Validation:** Fails if any screen missing `code_files`.

### `generate marketing view`

**Source:** OVERVIEW.md positioning + per-feature `purpose.business_value` + `PLANS.md` + (if present) competitor/UX docs.

**Output structure:**
```markdown
# [App Name] - Marketing Collateral

## Positioning
[One-liner + who it's for (ICP) + core value prop]

## Feature benefits (outcome-framed)
For each Critical/Important feature:
- [Feature] → [user outcome, not a feature description]

## Differentiators
[What this does that alternatives don't - from OVERVIEW positioning]

## Plan-based messaging
[From PLANS.md - what each plan unlocks, framed as a buyer benefit]

## Messaging hooks
[Short punchy lines per feature for ads / emails / landing copy]
```

**Validation:** Fails if OVERVIEW missing positioning section. Benefits must be outcome-framed (no raw feature dumps).

### `generate data-dictionary`

**Source:** `screens/analytics/` docs + analytics sub-feature metadata + `PLANS.md` (credits/billing) + INTEGRATIONS.md (where data originates).

**Output structure:**
```markdown
# [App Name] - Data & Metrics Dictionary

## Metrics
For each metric (AOV, attributed/app-generated revenue, credit burn, top products, product affinity, placement performance, ...):
- **Metric:** [name]
- **Definition:** [plain English]
- **Source:** [where the data comes from]
- **Computation:** [how it's derived]
- **Caveats:** [attribution window, edge cases]

## Events / data points captured
[List of tracked events or data fields, from metadata.data + INTEGRATIONS.md]

## Glossary cross-refs
[Link credit / attributed-revenue / serviceActive terms to GLOSSARY.md]
```

**Validation:** Never hard-fails; aggregates whatever analytics docs exist. Flags metrics whose computation is INFERRED.

### `generate onboarding playlist for <persona>`

**Source:** `references/personas.md` (per-persona load order), `SURFACE-MAP.md` (tier data), `scripts/atlas-persona-bundle.mjs`'s per-persona field projection, `GLOSSARY.md`. Full spec: `references/onboarding-playlists.md`.

**Output structure:** staged, not flat, see `assets/onboarding-playlist-template.md`. Stage 1 orients (product + vocabulary), Stage 2 covers the persona's Critical-tier surface, Stage 3 covers Important-tier depth and edge cases, Stage 4 covers integrations/plans/roles. Each stage ends with a "you're ready when" checklist.

**Variant:** `generate offboarding playlist for <persona> owning <features>` produces the same staged structure plus a "capture before their last day" punch list of any Critical/Important-tier item this person owns with MEDIUM/LOW/UNKNOWN confidence.

**Validation:** Fails if a Critical-tier screen this persona would need has no README yet, surface the gap rather than silently skip it. Never fails on thin Standard/Skip-tier content.

**Relationship to `generate onboarding doc`:** that command is unchanged, it stays the single deep technical walkthrough for developers. Playlists are the persona-agnostic, staged counterpart for every other role, and for offboarding.

## Behavior

- View generation NEVER modifies atlas content
- Output always timestamped
- Old view exports are kept (no auto-prune)
- If atlas changes after a view was generated, the view becomes stale - re-run to refresh

## Failure handling

Per `references/validation-rules.md`:
- View-gen-time validation is hard
- If required fields missing in any consumed screen, view generation fails loudly with the list of missing fields and which screens have them
- User fixes atlas (Phase 2 or Phase 3), then re-runs view generation
