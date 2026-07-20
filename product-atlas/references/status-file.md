# STATUS.md - Current State File

A single markdown file at `product-atlas/STATUS.md`. Auto-maintained by the skill. Always reflects the current state of the atlas.

## Why this exists

The atlas builds incrementally over many sessions (see `references/incremental-build.md`). Each new session needs to know:
- What's been documented
- What's pending
- Is there mid-screen paused state to resume
- What open questions exist
- What was the last activity

Without STATUS.md, every session would start cold. With it, sessions resume cleanly.

## Auto-maintenance rule

The skill writes STATUS.md at the end of every session that modifies the atlas. Never hand-edit. If dev wants to override state (e.g., reset a screen's status), edit via skill command, not by editing STATUS.md directly.

## File location

`product-atlas/STATUS.md`. Top-level, sibling to OVERVIEW.md.

## Format

Human-readable markdown. Skill parses sections by header on read. Template at `assets/status-template.md`.

```markdown
# Atlas Status

> Auto-maintained. Do not edit directly. Run skill commands to update state.

**Last updated:** 2026-05-19 14:30 UTC
**Atlas version:** v1 (from commit a1b2c3d at start)
**Schema version:** 1.0

---

## Overall progress

- **Total screens identified:** 47
- **Documented:** 12 / 47 (26%)
- **In progress:** 1
- **Pending:** 34
- **Excluded:** 2 (see EXCLUSIONS.md)

### By tier
- Critical: 4 / 8 documented
- Important: 6 / 18 documented
- Standard: 2 / 17 documented
- Skip: n/a (2 excluded)

### Quality review
- Latest run: not yet run
- Outstanding gaps: 0
- Open questions: 7 (see OPEN-QUESTIONS.md)

---

## Currently in-progress

- **Screen:** `/workspace/billing`
- **Tier:** Critical
- **Started:** 2026-05-19 14:05
- **Step paused at:** Step 5 (edge cases capture)
- **Completed steps in this screen:**
  - Step 1: Code read - done
  - Step 2: Internal understanding built - done
  - Step 3: Hypothesis stated to dev - done
  - Step 4: Dev confirmed understanding - done (corrections applied)
- **Pending steps:**
  - Step 5: Edge cases enumeration
  - Step 6: README + metadata write
  - Step 7: CHANGELOG entry
- **Validated understanding saved:**
  - Screen lets workspace admins manage their subscription
  - Key controls: Plan selector, payment method update, billing email, invoice history
  - Critical actions: Upgrade plan, downgrade plan, update payment method, cancel subscription
  - Business value: Self-service billing reduces support tickets, especially around renewals
- **Pending questions:**
  - Concurrent edits (two admins changing plan simultaneously)?
  - Failed payment flow - what user sees, retry behavior?

---

## Pending queue (next up)

Ordered by tier, then by route order.

### Next: Critical (4 remaining)
1. `/workspace/billing` (in-progress, resume next)
2. `/workspace/members`
3. `/workspace/settings`
4. `/reports`

### Then: Important (12 remaining)
5. `/workspace/integrations`
6. `/reports/time`
7. `/reports/projects`
8. `/notifications`
...

### Then: Standard (15 remaining)
- `/profile`
- `/profile/notifications`
- `/help`
...

---

## Documented (12)

Most recent first.

| Screen | Tier | Documented | Last touched |
|---|---|---|---|
| `/projects/[id]/board` | Critical | 2026-05-19 13:45 | 2026-05-19 13:45 |
| `/projects/[id]` | Critical | 2026-05-19 13:15 | 2026-05-19 13:15 |
| `/projects` | Critical | 2026-05-19 12:30 | 2026-05-19 12:30 |
| `/` (dashboard) | Critical | 2026-05-18 17:00 | 2026-05-18 17:00 |
| `/projects/new` | Important | 2026-05-18 16:30 | 2026-05-18 16:30 |
| ...8 more | | | |

---

## Recent activity

Latest 5 CHANGELOG entries. See CHANGELOG.md for full history.

- **2026-05-19 14:05** - Started documentation of `/workspace/billing` (paused at Step 5)
- **2026-05-19 13:45** - Documented `/projects/[id]/board` (Critical) - all edge cases captured
- **2026-05-19 13:15** - Documented `/projects/[id]` (Critical)
- **2026-05-19 12:30** - Documented `/projects` (Critical)
- **2026-05-18 17:00** - Documented `/` dashboard (Critical) - flagged 2 open questions

---

## Atlas health

- ✓ All Critical screens have `purpose.what`
- ✓ All documented screens have valid metadata.json
- ✓ Navigation tree has no broken links
- ⚠ 7 INFERRED items outstanding (see OPEN-QUESTIONS.md)
- ⚠ /workspace/billing has unconfirmed edge cases
- ✓ ATLAS-RULES.md loaded and applied
- ✓ COMMON-COMPONENTS.md has 5 entries
- ✓ EXCLUSIONS.md has 2 entries

---

## Suggested next action

Run `continue atlas` to resume `/workspace/billing` at Step 5.

Estimated time: 5-10 minutes for this screen.

After completion, 3 Critical screens remain. Recommend finishing all Critical before starting Important tier.
```

## What skill writes vs what skill reads

### At session end - skill WRITES STATUS.md
- Updates "Last updated" timestamp
- Moves completed screens from pending → documented
- Updates in-progress section (or clears if completed mid-screen)
- Recalculates progress counts
- Adds new entry to Recent activity (top of list)
- Updates Atlas health checks
- Suggests next action

### At session start - skill READS STATUS.md
- Last activity / paused state
- Pending queue order
- Atlas health flags
- Open questions context

Note: the recent activity section in STATUS.md is a SUMMARY of CHANGELOG.md (latest 5). CHANGELOG.md is the full audit trail. STATUS.md is the current snapshot.

## `atlas status` command

When dev runs `atlas status`:
1. Skill reads STATUS.md
2. Reports key sections to dev:
   - Overall progress
   - Currently in-progress
   - Suggested next action
   - Open questions count
3. Does NOT modify any files

~30 seconds total. Fast info request.

## STATUS.md vs CHANGELOG.md

| File | Purpose | Format | Mutation pattern |
|---|---|---|---|
| STATUS.md | Current snapshot. "Where are we right now?" | One file, overwritten | Replaced each session |
| CHANGELOG.md | Audit trail. "What happened over time?" | Append-only at top | New entries added, old kept |

Both reference each other. STATUS.md shows latest 5 CHANGELOG entries inline. CHANGELOG.md is the source of truth for history.

## When STATUS.md is missing

Two scenarios:

### Brand new atlas (before `start atlas` runs)
- File doesn't exist yet
- `start atlas` creates it as part of initialization

### Atlas exists but STATUS.md missing (data loss)
- Skill detects on session load
- Tells dev: "STATUS.md missing. The atlas has X documented screens (counted from screens/ folder). Should I reconstruct STATUS.md by scanning, or run `start atlas` fresh?"
- Dev chooses. Reconstruct option scans existing screens/ + CHANGELOG.md to rebuild state.

## Counting rule (CRITICAL)

STATUS.md progress counts MUST be at **feature-folder granularity across the whole FEATURE-MAP tree**, not at route-level and not at top-level-features-only granularity.

For every route with a FEATURE-MAP.md, the "Total" used in STATUS.md is the sum of every feature folder that FEATURE-MAP's "Folder layout to create" section enumerates, including:
- Top-level feature folders (tabs, page-level modals, paywall variants, secondary actions)
- Nested sub-features (modals inside tabs, paywall sub-flows)
- Folded row-editor / edit-detail sub-trees per per-parent variation (e.g., `<list-tab>/row-editor/`, `<list-tab>/row-editor/<editor-tab>/`)
- Orphan modals or flows discovered during Phase A mapping that don't sit under a single tab

Per `references/feature-mapping.md`, every distinct feature view is its own folder. STATUS.md must count them all - otherwise "X pending" reads as bounded when more work is required.

### Cross-reference check (run every session)

Before declaring scope for any session:

1. Open the relevant `screens/<route>/FEATURE-MAP.md`.
2. Count every `screens/<route>/...` folder in its "Folder layout to create" section (or its tree summary, if no explicit folder-layout section).
3. Confirm STATUS.md's per-route counts match that folder count.
4. If they don't match, STATUS.md is stale - reconcile it before starting work. Do NOT proceed on the stale count.

If the user says "Finish the X pending features for route Y", verify X against FEATURE-MAP's folder count. If they don't match, surface the discrepancy before writing.

## Validation

STATUS.md is validated for consistency on every read:
- All "documented" screens should have folders under screens/
- All "in-progress" screens should have valid step number (1-7)
- Progress counts should match: documented + in-progress + pending + excluded = total
- **Per-route totals should match the route's FEATURE-MAP.md folder count** (see Counting rule above)

If validation fails, skill flags warning and asks dev to confirm reconstruction.
