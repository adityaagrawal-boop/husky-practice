# Exclusions - Dead Code and Disabled Features

When the target app was cloned from another SaaS or contains feature code that is NOT active in the current product, those features must NOT appear in the atlas.

## Why this matters

Atlas exists to document what users actually see and use. Dead code from a parent SaaS clone confuses every downstream use case:
- Support team documents features that don't work
- PM sees roadmap surface that doesn't exist
- QA writes tests for screens that never render
- Sales pitches features that aren't available

Hard-skip is the locked behavior: excluded features are NOT documented anywhere in `screens/`. They appear ONLY in `EXCLUSIONS.md` with the reason and code location.

## EXCLUSIONS.md location

Lives at `product-atlas/EXCLUSIONS.md`. Top-level, sibling to OVERVIEW.md.

## When to load EXCLUSIONS.md

Auto-load at the start of every Phase 1, Phase 2, and Phase 3 run, alongside OVERVIEW.md.

## How to use during route walk

Before processing any route in Phase 1 step 8:

1. Check if the route path appears in EXCLUSIONS.md
2. Check if the route's code files are listed as excluded
3. If either matches → skip this route entirely. Do NOT create a screen folder. Do NOT add to navigation tree.
4. If no match → proceed with normal Assumption Checklist

When a sub-screen (popup/drawer/wizard) inside a documented route is excluded:
- Still document the parent route
- Skip the excluded sub-screen
- In parent route's "What you can do from here" section, do NOT mention the excluded action

## How to use during Phase 2/3

Phase 2 (`rewrite feature <name>`):
- If user names a feature that is in EXCLUSIONS.md → reject the request. Tell user this feature is excluded. Ask if they want to remove it from EXCLUSIONS.md and document it.

Phase 3 (`rewrite route <slug>`):
- Same as Phase 2.
- If the route was previously documented and is NOW in EXCLUSIONS.md → snapshot existing folder to `history/` and remove from `screens/`.

## EXCLUSIONS.md format

Markdown file. One section per excluded item. Template at `assets/exclusions-template.md`.

```markdown
# Exclusions

> Features and routes that exist in code but are NOT live in this app.
> Atlas does not document anything listed here.

## /admin/legacy-billing
- **Status**: Disabled
- **Type**: Route
- **Reason**: Cloned from parent SaaS, billing handled differently here
- **Code location**: app/routes/admin.legacy-billing.tsx
- **Added**: 2026-05-19
- **Action**: Skip during atlas generation

## Wholesale pricing tier
- **Status**: Disabled
- **Type**: Feature
- **Reason**: Feature not active in new SaaS, code retained for potential re-enable
- **Code location**: app/components/WholesalePricing.tsx + app/routes/products.wholesale.tsx
- **Affected screens**: /products (the wholesale tab section)
- **Added**: 2026-05-19
- **Action**: Skip the wholesale tab on /products screen. Do not document it.
```

## Required fields per exclusion

- **Status**: `Disabled` (only value for now; future: `Deprecated`, `Hidden`)
- **Type**: `Route` (whole route) or `Feature` (sub-section of a live route)
- **Reason**: Why excluded, in plain language
- **Code location**: file paths (helps verify)
- **Affected screens** (Type=Feature only): which live screens this used to appear on
- **Added**: ISO date when added to exclusions
- **Action**: What the skill should do (skip route / skip section / etc.)

## Adding new exclusions

When user discovers a feature is dead:
1. User updates EXCLUSIONS.md manually OR
2. User says "exclude feature X" or "this route is dead" → Claude adds entry to EXCLUSIONS.md
3. If the feature was previously documented in `screens/` → snapshot to `history/` first, then remove from `screens/`, then add to EXCLUSIONS.md
4. Add CHANGELOG.md entry noting the exclusion

## Removing exclusions (re-enabling)

When a previously excluded feature becomes live:
1. Remove entry from EXCLUSIONS.md
2. Run `rewrite route <slug>` or `rewrite feature <name>` to add it back
3. Add CHANGELOG.md entry noting the re-enable

## Never document inside an excluded item

This is enforced at every phase:
- Phase 1 skips the route during scan
- Phase 2 rejects feature rewrites for excluded items
- Phase 3 removes route from screens/ if it became excluded
- Q&A mode answers questions about excluded features with: "This feature is excluded from the atlas. See EXCLUSIONS.md for reason."
