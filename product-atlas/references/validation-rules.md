# Validation Rules

Two validation modes: soft on write, hard on view-gen.

## Write-time validation (soft)

Runs when Claude writes a screen's `README.md` or `metadata.json`.

| Issue | Action |
|---|---|
| Missing required field per `references/metadata-schema.md` | Warn in chat, log to `OPEN-QUESTIONS.md`, write anyway |
| Invalid enum value (e.g., `screen_type: "blob"`) | BLOCK, force fix |
| `schema_version` mismatch | BLOCK, force migration |
| INFERRED value with no `_confidence` level | BLOCK, force valid confidence |
| Link in README pointing outside `product-atlas/` | BLOCK, force relative link |
| Em dash in README prose | BLOCK, force hyphen/colon/break |

Soft validation means first-gen runs even with gaps. Gaps surface in `OPEN-QUESTIONS.md` for dev review later.

## View-gen-time validation (hard)

Runs when Claude generates a use-case view (`generate support view`, `generate qa view`, etc.).

### ROLES.md regen
| Issue | Action |
|---|---|
| Any metadata missing `access.roles` | FAIL, list affected screens |

### PLANS.md regen
| Issue | Action |
|---|---|
| Any metadata missing `access.plans` | SKIP that screen, don't fail |

### INTEGRATIONS.md regen
| Issue | Action |
|---|---|
| Any `integrations[].service` missing | FAIL, list affected entries |

### Support view
| Issue | Action |
|---|---|
| Any screen missing `purpose.what` | FAIL |
| Any error in `states.errors` missing `ui_shown` | FAIL |

### PM specs view
| Issue | Action |
|---|---|
| Any screen missing `purpose.what` | FAIL |

### QA view
| Issue | Action |
|---|---|
| Any control missing `default` | FAIL |
| Any required state missing | FAIL |

### i18n view
Never fails. Aggregates whatever exists.

### Sales script view
| Issue | Action |
|---|---|
| OVERVIEW missing Positioning section | FAIL |

### Onboarding view
| Issue | Action |
|---|---|
| Any screen missing `code_files` | FAIL |

## What "FAIL" means

When view-gen fails:
- Output is NOT written
- Claude reports the list of missing fields and which screens have them
- Suggests next action: run `rewrite feature` or `rewrite route` on affected screens to fix metadata
- After fix, user re-runs the view-gen command

## What "BLOCK" means at write time

When write is blocked:
- File is NOT written
- Claude reports the specific validation failure
- Claude attempts to fix the issue and re-validate
- If fix requires dev input, asks via AskUserQuestion

## What "SKIP" means

When a screen is skipped during aggregation:
- That screen does not appear in the aggregated file
- A note is added at the bottom of the aggregated file listing skipped screens with the reason
- No failure

## Schema migration

If `schema_version` in any metadata.json doesn't match v1.0:
- BLOCK the write
- Tell user a migration is needed
- Future versions of this skill will include migration scripts in `scripts/`
- For v1.0 first release, no migration paths exist yet
