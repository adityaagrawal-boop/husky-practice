# Atlas Maintenance

<!--
  TEMPLATE: copied into product-atlas/MAINTENANCE.md by `start atlas`.
  This is the human + agent playbook the maintenance loop and router defer to.
  Replace <app-specific> examples with this app's real routes/surfaces.
-->

Use this playbook to keep the product atlas current as the app changes.

Every meaningful product change should leave three things behind:

1. Updated current docs in `screens/`, top-level atlas files, or `views/`
2. A snapshot of the previous docs in `history/`
3. A `CHANGELOG.md` entry explaining what changed and why

## What counts as a meaningful product change

Update the atlas when a commit or PR changes any of these:

- New route, screen, modal, wizard step, banner, table, or other surface
- Removed or disabled route, screen, modal, wizard step, or feature
- New or changed button, toggle, dropdown, filter, table action, or submit/publish flow
- Changed default value, validation rule, error state, empty state, or loading state
- Changed role or plan/permission gating
- Changed billing, credits, discount, or revenue/usage behavior
- Changed webhook, extension, API endpoint, or third-party integration
- Changed user-facing copy that affects support, sales, QA, or i18n
- Known bug fixed or newly discovered

Skip purely internal refactors that don't change product behavior — unless they affect developer onboarding, integrations, or code ownership (e.g. a file rename: update `code_files`, no prose rewrite).

## Which command to use

| Change type | Use |
|---|---|
| One feature changed | `rewrite feature <feature-name>` |
| Whole route changed | `rewrite route <route-slug>` |
| New route added | `document <route>` or `rewrite route <route-slug>` |
| Stale but scope unclear | `quality review` first, then rewrite affected areas |
| Overview/ICP/pricing/positioning changed | `refresh overview` |
| Role-specific output after docs are current | `generate <view>` |

## Required workflow for every atlas update

1. **Identify the affected product surface** from the commit/PR (route, storefront/embedded surface, internal admin, or a cross-cutting file).
2. **Read current atlas context:** `STATUS.md`, `OVERVIEW.md`, `ATLAS-RULES.md`, `EXCLUSIONS.md`, `COMMON-COMPONENTS.md`, `SURFACE-MAP.md`, and the relevant `screens/<route>/README.md` + feature README + `metadata.json`.
3. **Compare docs against code/PR notes:** added/removed controls or actions, changed states, access/plan/billing impact, changed APIs/integrations, changed copy/i18n, new/resolved bugs.
4. **Snapshot before rewriting:** copy current docs to `history/YYYY-MM-DD-<feature-slug>/` (or `history/YYYY-MM-DD-route-<route-slug>/`). Include old `README.md`, `metadata.json`, affected subfolders.
5. **Rewrite the active docs:** the README(s), `metadata.json`, `SURFACE-MAP.md`/`screens/README.md` if navigation changed, `OPEN-QUESTIONS.md` if items open/close. **Re-stamp `metadata.json` `verified: {date, commit}`** so the freshness check knows this screen is current.
6. **Rebuild cross-cutting files when needed:** `ROLES.md` (access), `PLANS.md` (plans/credits), `INTEGRATIONS.md` (services/APIs), `GLOSSARY.md` (new terms), `views/` exports.
7. **Update `CHANGELOG.md`:** trigger, affected screens/routes, what changed, why, snapshot location, aggregated files rebuilt, open questions opened/closed.
8. **Update `STATUS.md`:** current state, recent activity, coverage, open-question counts, suggested next action.

## Validation (do not skip)

Run the validator after any change:

```
node .claude/skills/product-atlas/scripts/validate-atlas.mjs            # structure + code-ref existence
node .claude/skills/product-atlas/scripts/validate-atlas.mjs --freshness  # git drift vs verified date
node .claude/skills/product-atlas/scripts/atlas-coverage.mjs <atlas> <date>  # regenerate COVERAGE.md
```

A PostToolUse hook (`.claude/settings.json`) runs the validator automatically whenever the atlas is edited — fix any errors it reports before continuing.

## PR checklist

- Does this PR change any user-visible behavior?
- Updated the related `screens/` docs + re-stamped `verified`?
- Snapshotted old docs to `history/`?
- Explained why in `CHANGELOG.md`?
- Updated `OPEN-QUESTIONS.md` for known bugs/unresolved decisions?
- Re-aggregated `ROLES.md` / `PLANS.md` / `INTEGRATIONS.md` if needed?
- Regenerated any affected `views/`?
- Validator clean (`atlas:validate`)?

## Important rule

Do not overwrite `history/`. It is the audit trail — keep old snapshots even if imperfect.
