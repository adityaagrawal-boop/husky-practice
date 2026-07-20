# Phase 3 - `rewrite route <slug>`

Triggered when a whole route changed (new screens added, removed, restructured) or when the user wants to fully refresh one route.

## Pre-conditions

- `product-atlas/` exists at repo root
- User has named a specific route slug to rewrite

## Step-by-step

Same shape as Phase 2 but scoped to all screens under one route folder.

### 1. Auto-load context

Same as Phase 2:
- `product-atlas/STATUS.md` (current state)
- `product-atlas/OVERVIEW.md` (product brain)
- `product-atlas/ATLAS-RULES.md` (per-repo overrides)
- `product-atlas/EXCLUSIONS.md` (skip list)
- `product-atlas/COMMON-COMPONENTS.md` (black box list)
- `product-atlas/SURFACE-MAP.md` (tiers across this route's screens)
- `product-atlas/screens/README.md` (navigation tree)
- `ROLES.md`, `PLANS.md`, `INTEGRATIONS.md` if they exist

For Phase 3, also load the existing route README so you know what's there before reading new code.

**Check EXCLUSIONS.md first.** If the user-named route is in EXCLUSIONS.md:
- If route was previously documented but is now excluded → snapshot existing folder to `history/` and remove from `screens/`. Add CHANGELOG entry.
- If route was never documented → reject the rewrite request. Tell user this route is excluded.

**Use COMMON-COMPONENTS.md during code reading.** When screens under this route import listed common components, use the documented summaries instead of reading source.

**Use feature-first reasoning per screen** (`references/feature-first-reasoning.md`) - one pass per affected screen with hypothesis-confirm pattern.

### 2. Snapshot the entire route folder

Copy to:
```
history/<YYYY-MM-DD>-route-<route-slug>/
├── <screen-1>/
│   ├── README.md
│   └── metadata.json
└── <screen-2>/
    └── ...
```

Rules in `references/snapshot-versioning.md`.

### 3. Re-read all code under that route

Block-by-block. Identify:
- **Added screens** - new screens that didn't exist before
- **Removed screens** - screens that existed but are gone from the code
- **Modified screens** - same screens with different surface

### 4. For each screen, handle by type

**Added:**
- Full Assumption Checklist run
- Write new README + metadata
- Add to parent route's "Where you can go from here" table

**Removed:**
- Leave snapshot in `history/`
- Delete folder from `screens/<route>/`
- Remove from parent route's navigation table
- Remove from `screens/README.md` tree
- Remove inbound links from other screens' READMEs

**Modified:**
- Run checklist
- Per-screen rounds for dev clarifications
- Write new README + metadata

### 5. Per-screen rounds for dev questions

See `references/question-batching.md`.

### 6. Write new structure

After all per-screen work is done, update:
- The route's parent `README.md` (if surface changed)
- `screens/README.md` tree (navigation links)

### 7. Update CHANGELOG.md

New entry at top. Format in `references/changelog-format.md`. For route-level rewrite, include the list of added/removed/modified screens.

### 8. Cascade aggregations

Same as Phase 2:
- Re-aggregate ROLES.md / PLANS.md / INTEGRATIONS.md if any access or integration changed
- Append new INFERRED items to OPEN-QUESTIONS.md

Rules in `references/auto-aggregation.md`.

### 9. Done

Tell user: route rewrite complete, link to updated route folder, snapshot path, count of screens added/removed/modified, count of new open questions.
