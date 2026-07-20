# CHANGELOG.md Format

Reverse-chronological log of every atlas write event. New entries at the top.

Template: `assets/changelog-entry-template.md`.

## File structure

```markdown
# CHANGELOG

## YYYY-MM-DD - [Event Title]

**Trigger:** [phase name]
**Generated from commit:** [hash if available, else "n/a"]
**Affected screens:** [list]

### Changes
| Screen | Field | Before | After |
|---|---|---|---|

### Snapshot location
- `history/YYYY-MM-DD-<feature-slug>/`

### Notes
- Why the change was made
- Any anomalies, char-fit warnings, policy concerns
- Next-step expectations

---

## (older entries below)
```

## Entry by phase

### Phase 1 (initial build)

```markdown
## 2026-05-18 - Atlas v1 generated

**Trigger:** Phase 1 build atlas
**Generated from commit:** abc123
**Routes documented:** 12
**Screens documented:** 47
**Open questions:** 8

### Notes
- First-time generation
- 8 inferred items logged to OPEN-QUESTIONS.md for review
- All HIGH-confidence fields written as facts
```

### Phase 2 (feature rewrite)

```markdown
## 2026-05-22 - Rewrote auto-SEO toggle feature

**Trigger:** Phase 2 rewrite feature auto-seo-toggle
**Generated from commit:** def456
**Affected screens:** products-list

### Changes
| Screen | Field | Before | After |
|---|---|---|---|
| products-list | controls[auto-seo-toggle].default | true | false |
| products-list | controls[auto-seo-toggle].gating.plans | ["pro", "scale"] | ["scale"] |

### Snapshot location
- `history/2026-05-22-auto-seo-toggle/`

### Notes
- Default flipped to OFF per new product policy
- Now gated to scale plan only (was pro+)
- ROLES.md / PLANS.md re-aggregated
```

### Phase 3 (route rewrite)

```markdown
## 2026-05-30 - Rewrote products route

**Trigger:** Phase 3 rewrite route products
**Generated from commit:** ghi789
**Affected screens:** products-list, products-detail, products-bulk-edit (modified), products-import (added), products-archive (removed)

### Changes
| Action | Screens |
|---|---|
| Added | products-import |
| Removed | products-archive |
| Modified | products-list, products-detail, products-bulk-edit |

### Snapshot location
- `history/2026-05-30-route-products/`

### Notes
- Bulk import wizard added (new sub-screen with 4 steps)
- Archive functionality removed, replaced by tag-based filtering
- ROLES.md / PLANS.md / INTEGRATIONS.md re-aggregated
- 3 new open questions logged
```

## Rules

- New entries always at top, immediately after the `# CHANGELOG` header
- Use H2 for each entry, format: `## YYYY-MM-DD - [Event Title]`
- Include `---` separator between entries
- Date format: ISO 8601 date only (YYYY-MM-DD), no time
- Event title: short, action-oriented (verb-first)
- Always include the snapshot location if any files were rewritten
- Always note which aggregated files were rebuilt (if any)
