# Surface Mapping

Step 3 of `start atlas`. Build a complete flat list of every ROUTE in the app BEFORE documenting any of them. Dev tiers each by importance. This drives all subsequent work.

Note the granularity: surface mapping is **route-level** (one entry per `<Route>` in the router). The fine-grained feature tree per route is built later in Phase A of `continue atlas` and lives in `screens/<route>/FEATURE-MAP.md` (see `references/feature-mapping.md`).

| Document | Granularity | When built | Tracks |
|---|---|---|---|
| `SURFACE-MAP.md` | Route-level | Step 3 of `start atlas`, once | Route count, route tiers, coarse progress |
| `screens/<route>/FEATURE-MAP.md` | Feature-level (tabs / modals / paywalls / edit views / etc.) | Phase A of `continue atlas`, per route | Feature count, feature tiers, fine progress |
| `STATUS.md` | Both | Updated every session | Combined progress |

Edit/detail routes that fold into a parent feature (per `references/split-criteria.md`) do NOT appear as separate rows in `SURFACE-MAP.md`. They appear inside the parent's FEATURE-MAP.

## Why this matters

Without a surface map, dev doesn't know how many routes need work. Skill might document low-value routes deeply while skipping critical ones. Tiering upfront focuses effort on what matters.

Surface map = coarse plan ("we have 37 routes, 10 are Critical"). Feature map = fine plan ("the /metatags route has 12 top-level features and 65 sub-features inside the row-editor variants").

## When to run

- Step 3 of `start atlas` (after intake, before any feature documentation)
- Manually via `refresh surface-map` if dev adds many routes (rare)

## Output

`product-atlas/SURFACE-MAP.md`. Template at `assets/surface-map-template.md`.

Lives as a top-level file alongside `OVERVIEW.md`. Loaded every session.

## How to build it

### Step 1: Detect all routes

Scan router config / pages folder / route files. Build a flat list including:
- Top-level routes (`/`, `/products`, `/settings`)
- Nested routes (`/projects/[id]`, `/projects/[id]/board`)
- DO NOT include sub-screens accessed via in-page navigation (modals, drawers, wizards). Those are features inside a route, documented in FEATURE-MAP per route.
- Tab views within a route are NOT separate routes. They're features inside the route.

Filter against EXCLUSIONS.md (already-known dead routes removed).
Filter against ATLAS-RULES.md skip patterns.

### Step 2: Apply edit/detail folding

For any route that's an edit/detail view of another route (e.g. `/items/list` and `/items/:id` or `/items/edit`), check the parent-child relationship:

- If the route is an edit/detail of a parent list, DO NOT include it as a separate row. It will fold into the parent's FEATURE-MAP (per `references/split-criteria.md`).
- If the route is a sibling list with its own purpose, include as a separate row.

When in doubt, include as separate row; the folding decision can be reversed during Phase A mapping with no data loss.

### Step 3: Categorize by route group

Group routes into logical categories. Auto-categorization heuristics:

| Pattern | Likely category |
|---|---|
| `/`, `/dashboard`, `/home` | Dashboard |
| `/settings/*`, `/preferences/*` | Settings |
| `/admin/*` | Admin |
| `/billing/*`, `/subscription/*`, `/pricing/*` | Billing |
| `/auth/*`, `/sign-in`, `/sign-up` | Auth |
| `/profile/*`, `/account/*` | Profile |
| `/api/*` | (skip - API endpoints not screens) |
| Domain-specific (`/products`, `/projects`, `/customers`) | Core product |
| `/integrations/*`, `/apps/*` | Integrations |
| `/reports/*`, `/analytics/*` | Reports |
| `/help`, `/docs`, `/support` | Help |

### Step 4: First-pass tier suggestions

Skill proposes initial tier per route. Heuristics:

| Signal | Suggested tier |
|---|---|
| Core product routes (mentioned in OVERVIEW.md top features) | Critical |
| Dashboard / landing route | Critical |
| Primary CRUD list for the main entity | Critical |
| Billing routes | Critical (often) |
| Workspace/team management | Important |
| Reports / analytics | Important |
| Settings (non-billing) | Standard |
| Profile / preferences | Standard |
| Help / docs | Standard |
| Auth routes (sign-in, sign-up) | Standard |
| Internal/admin routes | Important if user-facing, Skip if internal-only |
| Debug / test routes | Skip → suggest EXCLUSIONS.md |
| Edit/detail of a parent list | NOT a separate row - fold per split-criteria |

### Step 5: Present to dev for tier confirmation

Use this format (not a 47-question round, one batched view):

```
Skill: I found 47 routes in your repo. Here are my proposed tiers. Confirm or adjust.

CRITICAL (8) - Full per-feature documentation, all edge cases per Critical feature:
- / (dashboard)
- /projects
- /projects/[id]
- /projects/[id]/board (kanban view)
- /workspace/members
- /workspace/billing
- /workspace/settings

IMPORTANT (13) - Full per-feature documentation, key edge cases:
- /projects/new
- /reports
- /reports/time
- /workspace/integrations
- /notifications
- ...

STANDARD (15) - Summary depth per feature:
- /profile
- /profile/notifications
- /help
- /sign-in
- /sign-up
- ...

FOLDED (no separate row - documented inside parent):
- /projects/[id]/edit (edit view of /projects/[id])
- /items/:id (detail view of /items)

EXCLUDED (suggest add to EXCLUSIONS.md):
- /admin/_debug (internal only)
- /old-onboarding (legacy)
- /v1/* (4 legacy routes)

Total: 8 + 13 + 15 = 36 routes to document, ~150-200 features expected across them.

Confirm or adjust each. Use shortcuts like:
- "Move X to Critical"
- "Standard for X, Y, Z"
- "Skip /reports/custom (move to EXCLUSIONS)"
- "Don't fold /items/:id - it's a sibling, not an edit"
- "All good"
```

### Step 6: Dev confirms / adjusts

Dev replies with adjustments. Common patterns:
- "Move /integrations to Critical, it's our differentiator"
- "Skip /admin/_debug add to EXCLUSIONS yes"
- "All good as is"

Apply adjustments.

### Step 7: Write SURFACE-MAP.md

After tier confirmation, write the file. Format:

```markdown
# Surface Map

> Complete list of every ROUTE in this product, with importance tier.
> Drives documentation depth and effort allocation at the route level.
> Per-route feature trees live in screens/<route>/FEATURE-MAP.md.

**Generated:** 2026-05-19
**Source commit:** a1b2c3d
**Total routes:** 47 (36 to document, 5 folded into parents, 6 excluded)

## By tier

### Critical (8) - Full per-feature depth, all edge cases per Critical feature

| Route | Path | FEATURE-MAP? | Last touched |
|---|---|---|---|
| Dashboard | `/` | ⏳ pending | - |
| Projects list | `/projects` | ⏳ pending | - |
| Project detail (includes edit folded in) | `/projects/[id]` | ⏳ pending | - |
| ...

### Important (13) - Full per-feature depth, key edge cases
...

### Standard (15) - Summary depth per feature
...

### Folded (no separate row - documented inside parent)
| Route | Parent | Why folded |
|---|---|---|
| `/projects/[id]/edit` | `/projects/[id]` | Edit view of project detail |

### Excluded (6) - See EXCLUSIONS.md
| Route | Reason |
|---|---|
| `/admin/_debug` | Internal only |
| ...

## By route group

### Core product (15 routes)
- /projects, /projects/[id], /projects/[id]/board, /projects/[id]/tasks/[id], ...

### Settings (8 routes)
...

## Documentation order

Suggested order: Critical first, then Important, then Standard. Within tier:
1. Core entity routes (drive most use cases)
2. Onboarding-related routes
3. Billing / settings (legal / compliance)
4. Everything else

This order recommended in STATUS.md pending queue.
```

### Step 8: Update STATUS.md with full queue

After SURFACE-MAP.md written, populate STATUS.md pending queue with all non-excluded routes in suggested order.

## Tier definitions (locked)

See `references/importance-tiering.md` for the full Critical/Important/Standard/Skip definitions and how they affect per-feature documentation depth.

## When tier is unclear

If dev can't decide between two tiers for a route, default to higher tier. Better to over-document than miss something important.

If unclear between Standard and Skip, default to Standard. Skip is a strong claim ("not worth documenting at all").

## Re-tiering after build starts

Dev can re-tier any route at any time:
- `tier <route> as Critical` → upgrades, suggests re-running Phase A feature mapping with deeper recursion
- `tier <route> as Standard` → downgrades, doesn't auto-delete existing FEATURE-MAP or READMEs

Re-tiering updates SURFACE-MAP.md + STATUS.md.

## SURFACE-MAP.md updates

Re-generated when:
- New routes added to code (detected by route scan during `start atlas` or `rewrite route`)
- Routes removed (deleted from screens/, marked here)
- Tiers changed
- Folding decisions changed (route was previously separate, now folded into parent, or vice versa)

Skill auto-updates after every `continue atlas` session.

## Use of SURFACE-MAP.md

- **Dev:** quick reference for "how many routes are left at each tier."
- **Skill:** drives `continue atlas` queue order at the route level.
- **Quality review:** checks every non-excluded route has a FEATURE-MAP and at least one documented feature.
- **Roadmap use case:** SURFACE-MAP.md + OVERVIEW.md.top_features show coverage of product surface vs marketing claims.

## How SURFACE-MAP.md and FEATURE-MAP.md fit together

```
Surface map (1 file)              Feature maps (N files, one per route)
├─ /home                          screens/home/FEATURE-MAP.md
├─ /products                      screens/products/FEATURE-MAP.md
│                                   ├─ products-list
│                                   │  ├─ row-editor (folded edit route)
│                                   │  └─ bulk-actions
│                                   └─ ...
├─ /products/[id] (folded)        (no separate file - inside /products)
├─ /settings                      screens/settings/FEATURE-MAP.md
└─ ...
```

The surface map is the table of contents. Each feature map is a chapter. Per-feature READMEs are the chapter sections.
