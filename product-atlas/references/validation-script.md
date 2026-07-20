# Atlas Validator Script

<!--
  WHY THIS FILE EXISTS (business logic):
  Structural integrity checks (broken links, missing metadata, INDEX drift) were
  manual and therefore skipped. scripts/validate-atlas.mjs automates them so the
  brain's structure stays trustworthy. This reference says when to run it, what it
  checks, and how it feeds quality review + the maintenance loop.
-->

A read-only Node script that checks the structural health of a `product-atlas/` folder. Lives at `scripts/validate-atlas.mjs` in this skill.

## Run it

```
node .claude/skills/product-atlas/scripts/validate-atlas.mjs [path-to-atlas] [--freshness]
```

- Defaults to `./product-atlas` if no path given.
- Exit code `0` = clean (warnings allowed), `1` = errors found (use in CI / pre-push).
- Read-only: it reports, it never edits the atlas.
- `--freshness` adds the git-based staleness pass (opt-in; needs git). This is what backs the `atlas freshness` command.

Convenience wrappers (also usable in CI): `npm run atlas:validate` and `npm run atlas:freshness`.

## What it checks

| Check | Severity | Why it matters |
|---|---|---|
| Required top-level files present (OVERVIEW, STATUS, SURFACE-MAP, ATLAS-RULES, EXCLUSIONS, COMMON-COMPONENTS, CHANGELOG, README) | error | A missing core file breaks the brain's load order. |
| `INDEX.md` / `ASK-ME-FIRST.md` present | warning | The router's front door; recommended but not fatal. |
| Every `screens/**/README.md` (except the nav root) has a `metadata.json` sibling | warning | Metadata powers QA/i18n/views; a README without it is half-documented. |
| `metadata.json` is valid JSON | error | Invalid JSON silently breaks view generation. |
| No broken relative links inside the atlas | error | Dead links erode trust and break navigation. Also catches **self-containment violations** (links pointing outside `product-atlas/`, which `references/hard-rules.md` forbids). |
| `INDEX.md` drift - referenced `screens/...` paths exist; every route folder appears in INDEX | error / warning | Keeps the one-hop routing map honest (see `references/route-index.md`). |
| **Code-reference existence** (Check 5) - every path-shaped `code_files` entry and path-shaped `code_ref` resolves against the repo root (supports a trailing glob) | error | The brain's #1 dev promise is "open the screen's code." Dead paths point devs at deleted files. Path-shaped = contains `/` and looks like a file/dir/glob; bare-filename shorthand (`Foo.jsx#L10`) is skipped as unverifiable. |
| **Freshness** (Check 6, `--freshness`) - any live `code_files` committed after the screen's `verified.date` (or `meta.generated_at` fallback) | warning | Surfaces docs that drifted from code; feeds the maintenance loop. Never blocks. |
| **FEATURE-MAP presence** (Check 7) - a route folder with feature sub-folders has a `FEATURE-MAP.md` | warning | The route's feature tree should be navigable; single-feature routes are exempt (no false positives). |
| **Orphan metadata** (Check 8) - every `metadata.json` has a `README.md` sibling | warning | The reverse of Check 2: structured data with no human-readable doc beside it. |
| **screen_id resolution** (Check 9) - every `related_screens` / `navigation.linked_screens` `screen_id` matches a real screen | warning | These are IDs, not links, so Check 3 can't see them. Warns (a target may be not-yet-documented). |
| **Required fields** (Check 10) - `schema_version`, `screen.{id,name,route,screen_type,code_files}`, `access.roles`, `purpose.what`, `meta.generated_at` present | error | View generation and answers depend on these; a missing one blocks. |

It skips `history/` and `ui-snapshots/` (frozen snapshots) and ignores placeholder paths containing `<...>`.

## Automated runs (shipped)

- **PostToolUse hook** (in `.claude/settings.json`): whenever Claude edits a file under `product-atlas/`, `scripts/atlas-validate-hook.sh` runs the validator and, on failure, returns the errors so they're fixed in the same turn. No human action required.
- **CI / pre-push**: run `npm run atlas:validate` (exit 1 on errors). Add `npm run atlas:freshness` as an advisory step.

## When to run

- During `quality review` - run it first; fix structural errors before the prose review.
- After `atlas sync` rewrites - confirm no links broke and INDEX is consistent.
- In CI / a pre-push hook - block merges that break atlas structure (optional; configure via the repo's `settings.json` hooks).

## Interpreting results

- **Errors** must be fixed: broken links, invalid metadata, INDEX pointing nowhere, missing core files.
- **Self-containment violations** show up as broken links to `.claude/...` or `client/...` - the fix is to remove the cross-boundary link (move code refs into `metadata.json` `code_files`, which is plain text not a link).
- **Warnings** are advisory: a Standard-tier screen may legitimately lack `metadata.json` if ATLAS-RULES caps its depth - judgment call.

The script reports; a human or the skill decides what to fix. It does not auto-repair.
