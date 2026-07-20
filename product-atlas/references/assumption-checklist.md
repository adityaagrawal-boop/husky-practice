# Assumption Checklist v1.0

Run this checklist per screen during `continue atlas`, `rewrite feature`, and `rewrite route`. 12 blocks, 33 items.

Wraps inside the broader feature-first reasoning flow (`references/feature-first-reasoning.md`). Specifically, the checklist runs DURING Step 2 (internal understanding build) and Step 3 (hypothesis to dev).

For each item: attempt inference from code → apply confidence rule (`references/confidence-rules.md`) → write as fact OR write with INFERRED tag OR ask dev.

## Pre-checklist filters

Before running the checklist on any screen:

1. **Check EXCLUSIONS.md.** If the screen's route or feature is excluded, skip the entire screen. Do NOT run the checklist. Do NOT create a folder. See `references/exclusions.md`.

2. **When reading code, respect COMMON-COMPONENTS.md.** Component imports matching listed common components are treated as black boxes. Use their summaries instead of diving into source. See `references/common-components.md`.

3. **Check ATLAS-RULES.md for pattern shortcuts.** Apply confirmed-pattern rules to skip relevant questions. See `references/atlas-rules.md`.

4. **Check tier from SURFACE-MAP.md.** Adjust depth of checklist per tier:
   - Critical: all 33 items, full depth
   - Important: all items but lighter on edge cases beyond errors + accessibility
   - Standard: skip Block 6 (edge cases) entirely except errors, skip Block 12 (related screens)
   - Skip: do not run checklist - screen goes to EXCLUSIONS

## Block 1 - Identity (5 items)

| # | Item | Source | Fills |
|---|---|---|---|
| 1 | Screen display name | page title, h1, route name, locale | `screen.name` |
| 2 | Route path | router config | `screen.route` |
| 3 | Screen type | component pattern (Modal/Drawer/route) | `screen.screen_type` |
| 4 | Parent screen ID | navigation structure, import graph | `screen.parent_screen_id` |
| 5 | Code files | component imports tree | `screen.code_files` |

## Block 2 - Access (3 items)

| # | Item | Source | Fills |
|---|---|---|---|
| 6 | Roles with access | role guards, withAuth, conditional renders | `access.roles` |
| 7 | Plans required | plan gating components, billing checks | `access.plans` |
| 8 | Conditional visibility | feature flags, data-state guards | `access.conditions` |

## Block 3 - Purpose (3 items, ALWAYS asks dev)

| # | Item | Source | Fills |
|---|---|---|---|
| 9 | What this screen is | always ask dev | `purpose.what` |
| 10 | Job-to-be-done | always ask dev | `purpose.jtbd` |
| 11 | Business value | always ask dev | `purpose.business_value` |

## Block 4 - Controls (per control, 7 sub-items each)

| # | Item | Source | Fills |
|---|---|---|---|
| 12 | Identity (id, label, type) | JSX component | `controls[].id/label/type` |
| 13 | Default value | state init, default prop, DB default | `controls[].default` |
| 14 | Per-control gating | conditional render around control | `controls[].gating` |
| 15 | Options (dropdown/radio) | options array, enum | `controls[].options` |
| 16 | On effect (plain language) | onChange handler trace | `controls[].on_effect`, `off_effect` |
| 17 | Backend behavior | API calls, jobs, DB writes triggered | `controls[].backend_behavior` |
| 18 | Business recommendation | always ask dev | `controls[].business_recommendation` |

## Block 5 - Actions (per action, 4 sub-items each)

| # | Item | Source | Fills |
|---|---|---|---|
| 19 | Identity (id, label, type) | JSX | `actions[].id/label/type` |
| 20 | What opens | navigation calls, modal triggers | `actions[].opens.type` |
| 21 | Target screen ID | linked component / route | `actions[].opens.target_screen_id` |
| 22 | Business value | always ask dev | `actions[].business_value` |

## Block 6 - States (3 items + edge cases for Critical/Important)

| # | Item | Source | Fills |
|---|---|---|---|
| 23 | Empty state UX | empty-data conditional renders | `states.empty` |
| 24 | Loading state UX | skeleton, spinner, suspense | `states.loading` |
| 25 | Error scenarios | try/catch, error boundaries, toast.error | `states.errors[]` |

For Critical/Important tier, ALSO capture full edge case enumeration after Block 6 - see `references/edge-cases.md`. Six categories: scale, concurrency, network, errors (full detail beyond just scenarios), accessibility, i18n.

## Block 7 - Events (auto-extract, 1 item)

| # | Item | Source | Fills |
|---|---|---|---|
| 26 | Analytics events | `analytics.track()`, `posthog.capture()`, etc. | `events_fired[]` |

## Block 8 - Integrations (auto-extract, 1 item)

| # | Item | Source | Fills |
|---|---|---|---|
| 27 | Third-party services | API client calls, fetch URLs, SDK calls | `integrations[]` |

## Block 9 - Data (2 items)

| # | Item | Source | Fills |
|---|---|---|---|
| 28 | Data reads | graphql queries, REST GETs, DB reads | `data.reads` |
| 29 | Data writes | mutations, POSTs, DB writes | `data.writes` |

## Block 10 - i18n (auto-extract, 1 item)

| # | Item | Source | Fills |
|---|---|---|---|
| 30 | String keys | `t()`, `i18n.t()`, `<Trans>` | `i18n_keys` |

## Block 11 - Navigation (2 items)

| # | Item | Source | Fills |
|---|---|---|---|
| 31 | Outbound links | `<Link>`, `router.push`, opens targets | `navigation.linked_screens` |
| 32 | Inbound links | import graph reverse lookup | `navigation.linked_from` |

## Block 12 - Related (1 item, often asks dev)

| # | Item | Source | Fills |
|---|---|---|---|
| 33 | Semantic connections | usually ask dev | `related_screens` |

## Auto-fill vs always-ask summary

**Almost always auto-fills from code (high confidence):**
- Items 1-5 (Identity), 12, 14, 15, 19-21 (Controls/Actions identity), 23-24 (States), 26 (Events), 27 (Integrations), 28-29 (Data), 30 (i18n), 31-32 (Navigation)

**Often auto-fills, sometimes asks:**
- Items 6-8 (Access), 13 (Defaults), 16-17 (Control effects), 25 (Errors)

**Always asks dev (cannot infer reliably):**
- Items 9-11 (Purpose), 18 (Control business recommendation), 22 (Action business value), 33 (Related screens)
