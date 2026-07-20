# Exclusions

> Features and routes that exist in code but are NOT live in this app.
> Atlas does not document anything listed here.

## Whole-repo scope note

This entire repo is out of product-atlas's primary intended scope (non-SaaS, no UI). See `ATLAS-RULES.md` for the scope override this atlas operates under. Nothing below is a "hidden feature," it's just infrastructure/vendored content that isn't this repo's own product logic.

---

## `.claude/skills/*`

- **Status**: Not this repo's product code
- **Type**: Route (folder)
- **Reason**: Installed Claude Code skill definitions (including product-atlas's own skill files), vendored tooling, not application logic.
- **Code location**: `.claude/skills/`
- **Affected screens**: n/a
- **Added**: 2026-07-20
- **Action**: Skip entirely during any atlas work.

## `coverage/`

- **Status**: Generated artifact
- **Type**: Route (folder)
- **Reason**: Vitest coverage HTML/JSON output, regenerated on every test run, not source.
- **Code location**: `coverage/`
- **Affected screens**: n/a
- **Added**: 2026-07-20
- **Action**: Skip, never document as if it were a feature.

## `node_modules/`, `.husky/_/`

- **Status**: Vendored/generated
- **Type**: Route (folder)
- **Reason**: Dependencies and Husky's internal shim scripts, not authored code.
- **Code location**: `node_modules/`, `.husky/_/`
- **Affected screens**: n/a
- **Added**: 2026-07-20
- **Action**: Skip entirely.
