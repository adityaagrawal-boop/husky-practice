# Maintenance Loop - Keeping the Brain Fresh

<!--
  WHY THIS FILE EXISTS (business logic):
  The #1 reason a product brain dies is silent rot: code ships, docs don't follow,
  and within weeks the brain lies. The existing MAINTENANCE.md (in the atlas
  folder) describes the manual workflow well, but nothing tells the skill how to
  DETECT what drifted. This file adds the detection step: diff git since the last
  atlas update, map changed source files to the screens they back, and queue those
  screens for rewrite. It turns maintenance from "remember to do it" into a
  command the team can run after every merge.
-->

This is the skill-side companion to the atlas folder's `MAINTENANCE.md`. `MAINTENANCE.md` is the human workflow (snapshot → rewrite → changelog). This file adds **automated drift detection** via the `atlas sync` command.

## `atlas sync` command

Detects which documented screens have drifted from the code and queues them for rewrite. Read-only until the user approves rewrites.

### Flow

1. **Find the baseline commit.** Read `STATUS.md` "Atlas version" line for the commit the atlas was last built/synced from. If absent, ask the user for a baseline (or use the oldest documented screen's verified commit).

2. **Diff code since baseline.**
   ```
   git diff --name-only <baseline-commit> HEAD
   ```
   Get the list of changed source files.

3. **Map changed files → affected screens.** For each documented screen, read its `metadata.json` `code_files`. If any changed file appears in a screen's `code_files`, that screen is **drifted**.

4. **Classify each drifted screen** by `MAINTENANCE.md` "what counts as a meaningful product change":
   - Product-visible change (control, state, gating, copy, integration) → queue for rewrite.
   - Pure internal refactor (no behavior change) → note but don't queue, unless it affects dev onboarding/integrations.

5. **Report the drift queue** to the user, most-impactful first (Critical tier > Important > Standard):
   ```
   Drifted screens since <baseline>:
   - /funnels/funnel-editor (Critical) - funnelForm.jsx changed 2026-06-10 → rewrite feature
   - /pricing/plan-picker (Important) - billing.js changed 2026-06-08 → rewrite route
   ...
   New routes detected (no doc yet): /new-route → document
   ```

6. **Wait for the user to pick** which to update. Then run the standard `rewrite feature` / `rewrite route` / `document` flow per `MAINTENANCE.md`, which handles snapshot → rewrite → CHANGELOG → STATUS.

7. **Re-stamp.** After updates, set each touched screen's `verified` stamp (see `references/confidence-and-freshness.md`), refresh its badge/row in `INDEX.md` (see `references/route-index.md`), and update `STATUS.md`'s atlas-version commit to `HEAD`. While the drift queue is still pending, mark drifted rows in `INDEX.md` as ⚠ so answers flag them as potentially stale.

### When to run

- After merging any product-changing PR.
- Periodically (weekly) to catch accumulated drift.
- Before generating a view for an external audience (support/sales/marketing) so the output isn't stale.

## Relationship to other pieces

| Piece | Role |
|---|---|
| `atlas freshness` (`confidence-and-freshness.md`) | Lighter check: per-screen "potentially stale" flag at answer time. |
| `atlas sync` (this file) | Heavier: full git-diff drift scan + rewrite queue. |
| `MAINTENANCE.md` (atlas folder) | The human snapshot→rewrite→changelog workflow that the queue feeds into. |
| `references/snapshot-versioning.md` | How to snapshot before each rewrite. |

## Hard rules

- `atlas sync` is read-only until the user approves the rewrite queue. It never rewrites silently.
- Never overwrite `history/` - snapshots are append-only (per `MAINTENANCE.md`).
- If git is unavailable, `atlas sync` can't run; fall back to manual `MAINTENANCE.md` workflow and say so.
- A refactor that changes no product behavior does NOT need a rewrite - avoid churning docs for noise.
