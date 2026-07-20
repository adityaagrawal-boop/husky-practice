# Confidence & Freshness

<!--
  WHY THIS FILE EXISTS (business logic):
  A product brain is only useful if people trust it. Trust comes from two things:
  (1) the brain says how sure it is, and (2) the brain warns when an answer might
  be out of date because the code changed after the doc was written. This file
  defines the confidence labels every answer carries and the staleness check the
  router runs before answering. Without this, a confident-sounding wrong answer
  erodes trust in the whole atlas.
-->

The router (`references/router.md` Step 4-5) uses these rules to label answers and detect stale docs.

## Confidence labels

Attach a label whenever the answer relies on anything below High. Derive from the screen's tier (`SURFACE-MAP.md`) and the source field's confidence.

| Label | When | How to phrase |
|---|---|---|
| **High** | Critical/Important-tier screen, HIGH-confidence field, fresh doc | State as fact, no caveat needed. |
| **Medium** | Standard-tier screen, or MEDIUM-confidence field | "Based on the docs, ... (Standard-tier - confident on main behavior, may lack edge-case depth.)" |
| **Low / Inferred** | Field marked INFERRED, or answer assembled across thin docs | "Note: this is inferred from code and awaiting dev confirmation. See OPEN-QUESTIONS.md." |
| **Unknown** | Atlas doesn't cover it | Trigger the fallback chain (router Step 4) - do not guess. |

Tier → confidence mapping (from existing `qa-mode.md`):
- Critical → High.
- Important → High on core, lower on edge cases.
- Standard → confident on main behavior, flag depth gaps.
- INFERRED items → always flag.

## Freshness / staleness check

Docs rot when code changes after the doc was written. Before giving a high-stakes answer (artifacts, impact analysis, "is X done"), check freshness.

### Inputs
- `STATUS.md` "Atlas version" line records the commit the atlas was built/last-synced from.
- Each screen's `metadata.json` may carry a "last verified" date (see stamping below).
- The screen's `code_files` list says which source files back the doc.

### Check
1. Identify the `code_files` for the screen(s) the answer draws from.
2. Compare against current code: `git log -1 --format=%cd -- <code_file>` for the newest change to those files.
3. If a `code_file` changed AFTER the doc's last-verified date (or after the atlas version commit) → the answer is **potentially stale**.

### What to do when stale
- Still answer (the doc is the best available knowledge), but prepend:
  > ⚠ This may be outdated: `<file>` changed on `<date>`, after this screen was last documented (`<date>`). Run `rewrite feature <name>` to refresh, or I can read the current code now.
- Offer the code-fallback (router Step 4): read the changed file and reconcile.

> Staleness checks need git. If git is unavailable (e.g. headless run), skip the check and note "freshness not verified."

## "Last verified" stamping

When a screen is documented or rewritten, stamp `metadata.json` with the date and commit it was verified against. This is what the freshness check compares to.

Suggested metadata field (additive, optional):
```json
"verified": { "date": "YYYY-MM-DD", "commit": "<hash>" }
```

If a screen has no `verified` stamp, fall back to comparing against `STATUS.md`'s atlas-version commit.

## Commands

- `atlas freshness` → scan documented screens, compare `code_files` mod dates vs each screen's verified date, report a list of "potentially stale" screens (most-changed first). Read-only. Feeds the maintenance loop (`references/maintenance-loop.md`).

## Behavior

- Confidence/freshness labels NEVER block an answer - they qualify it.
- Always prefer answering with a caveat over refusing.
- The only hard refusal is excluded features (`EXCLUSIONS.md`) and unwritten product decisions (log to `OPEN-QUESTIONS.md`).
