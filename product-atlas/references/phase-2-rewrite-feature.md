# Phase 2 - `rewrite feature <name>`

Triggered when a specific feature changed and its existing atlas docs are stale, or when the user wants to update a feature's docs.

## Pre-conditions

- `product-atlas/` exists at repo root
- User has named a specific feature to rewrite

## Step-by-step

### 1. Auto-load context

Before any work, read:
- `product-atlas/STATUS.md` (current state)
- `product-atlas/OVERVIEW.md` (product brain)
- `product-atlas/ATLAS-RULES.md` (per-repo overrides)
- `product-atlas/EXCLUSIONS.md` (skip list)
- `product-atlas/COMMON-COMPONENTS.md` (black box list)
- `product-atlas/SURFACE-MAP.md` (tier of affected screen)
- `product-atlas/screens/README.md` (navigation tree)
- The affected screen's parent route `README.md`
- `ROLES.md`, `PLANS.md`, `INTEGRATIONS.md` if they exist

Never start cold mid-tree. The parent context informs every assumption.

**Check EXCLUSIONS.md first.** If the user-named feature is in EXCLUSIONS.md, reject the rewrite request and tell the user this feature is excluded. Ask if they want to remove from EXCLUSIONS.md and document it.

**Use COMMON-COMPONENTS.md during code reading.** When the affected screen's code imports a listed common component, do NOT dive into its source. Use the documented summary.

**Use feature-first reasoning** (`references/feature-first-reasoning.md`) - read code, build understanding, state to dev, get confirmation, write from validated state. Do not skip the hypothesis pass.

### 2. Identify affected screen(s)

Map the feature name to specific screen folders under `screens/`. If ambiguous, ask the dev to confirm scope (e.g., "Do you mean the auto-SEO toggle on /products, or the global SEO settings page?").

### 3. Read new/changed code block-by-block

Compare the current code to the existing `metadata.json` for the affected screens. Identify:
- New controls / actions added
- Removed controls / actions
- Changed gating or defaults
- New events / integrations
- Changed copy / i18n keys
- Changed states (empty/loading/error)

### 4. Run Assumption Checklist

For each affected screen, run the full checklist. See `references/assumption-checklist.md`. Surface every gap as AskUserQuestion to dev.

### 5. Dev clears questions

Use per-screen rounds. See `references/question-batching.md`.

### 6. Snapshot old version BEFORE writing new

Copy the affected screen folder(s) to:
```
history/<YYYY-MM-DD>-<feature-slug>/
├── README.md         (old version)
└── metadata.json     (old version)
```

Rules in `references/snapshot-versioning.md`.

### 7. Write new README.md and metadata.json

For affected screens. Use:
- `references/screen-readme-format.md` for README structure
- `references/metadata-schema.md` for metadata structure

### 8. Update CHANGELOG.md

New entry at top. Format in `references/changelog-format.md`.

### 9. Cascade updates

- If `access.roles` or `access.plans` changed → re-aggregate `ROLES.md` / `PLANS.md`
- If `integrations` changed → re-aggregate `INTEGRATIONS.md`
- If new INFERRED items → append to `OPEN-QUESTIONS.md`
- If navigation links changed → update parent route's `README.md` "Where you can go from here" table and `screens/README.md` tree
- If new business terms appeared → optionally suggest adding to `GLOSSARY.md` (do not auto-add)

Rules in `references/auto-aggregation.md`.

### 10. Done

Tell user: feature rewrite complete, link to updated files, snapshot path, count of new open questions if any.
