# Importance Tiering

Four-level tiering system. Drives documentation depth per **feature** (not per route).

**Tier inheritance:** by default, every feature in a route's FEATURE-MAP inherits the route's tier from SURFACE-MAP.md. Dev can override per feature during Phase A mapping (downgrade trivial leaves like FAQs or paywall variants; upgrade unexpectedly important sub-features).

Routes are tiered in `SURFACE-MAP.md` (coarse). Features are tiered in each `FEATURE-MAP.md` (fine). When the two disagree, the per-feature override wins.

## The four tiers

| Tier | Coverage | Time | When to use |
|---|---|---|---|
| **Critical** | Maximum depth, all edge cases | 15-30 min/screen | Core product, used daily, business-critical |
| **Important** | Full depth, key edge cases | 10-15 min/screen | Regular use, valuable to document |
| **Standard** | Summary depth, basic edge cases | 3-5 min/screen | Occasional, ancillary |
| **Skip** | Not documented | 0 | Dead code, internal-only, deprecated |

## How tiers affect documentation

### Code reading depth

- Critical: read every related file, trace all handlers, understand all conditional logic
- Important: read main component + handlers, skim ancillary files
- Standard: read main component only, skip handler tracing
- Skip: no read

### Internal understanding depth (Feature-First Step 2)

- Critical: detailed mental model with all controls, all actions, all states, business value hypothesis
- Important: detailed model focused on user-facing surface
- Standard: brief model - what is it, key actions, who uses it
- Skip: none

### Hypothesis stated to dev (Feature-First Step 3)

- Critical: full hypothesis with all controls and actions and business value (~200 words)
- Important: full hypothesis with controls and actions (~100-150 words)
- Standard: brief hypothesis (~50 words)
- Skip: skipped

### Edge cases captured (Feature-First Step 5)

- Critical: full edge case enumeration (scale, concurrency, network, errors, accessibility, i18n)
- Important: key edge cases only (errors and accessibility, skip others if low-risk)
- Standard: basic check (errors only)
- Skip: none

### README depth

- Critical: 500-1500 words, all sections present, rich detail
- Important: 300-700 words, all sections present, normal detail
- Standard: 100-300 words, minimal sections (What/Business value/Actions/Controls only)
- Skip: no README

### metadata.json depth

- Critical: all fields populated, no INFERRED tags (dev cleared everything)
- Important: all required + most optional, minimal INFERRED
- Standard: required fields only, INFERRED allowed for non-required
- Skip: no metadata

## Tier assignment criteria

### Tier as Critical if

- Mentioned in OVERVIEW.md top 5 features
- Used by 80%+ of users (estimated)
- Failure here = revenue/retention impact
- Core CRUD for the main entity
- Billing / pricing-related
- Workspace administration
- Primary onboarding screen

### Tier as Important if

- Used by most users but not daily
- Has its own controls/actions worth documenting
- Settings pages dev would point a user to
- Integration management
- Reports / dashboards (secondary to main UI)
- Workspace member management
- Notification preferences

### Tier as Standard if

- Used occasionally
- Mostly read-only or simple actions
- Profile / personal settings
- Help / support entry point
- Auth screens (sign-in, sign-up - usually obvious)
- Generic CRUD for less-used entities

### Tier as Skip if

- Internal/employee-only
- Debug or test routes
- Legacy / being deprecated (not active for users)
- Code exists but route is gated/feature-flagged off

Skip → EXCLUSIONS.md, not documented.

## Suggested tier vs locked tier

Skill suggests **route tiers** during Step 3 of `start atlas`. Dev locks route tiers by confirming or adjusting.

Skill suggests **feature tiers** during Phase A of `continue atlas` (inheriting from parent route by default). Dev locks feature tiers by confirming or overriding.

Once locked, tier drives all subsequent work. Re-tier mid-build via `tier <route|feature> as <new-tier>`.

## Per-feature tier inheritance and overrides

When a route is tiered Critical, every feature in its FEATURE-MAP starts as Critical. The dev can downgrade trivial leaves during Phase A mapping:

- FAQ tabs / help content → Standard
- Paywall variants with single-CTA upgrade copy → Standard
- Read-only audit/history surfaces with no user actions → Important
- Confirmation flows with single action → atomic, inline in parent (no separate folder, so no tier needed)

Common downgrade patterns:

| Feature type | Inherited tier | Common override |
|---|---|---|
| Hub/list main feature | Critical (matches route) | Stay Critical |
| Edit/detail folded sub-tree | Critical (matches route) | Stay Critical (highest-value feature for most apps) |
| Settings tab inside main feature | Important | Stay Important |
| FAQ / help tab | Critical (inherited) | Downgrade to Standard |
| Empty state visualizer | Critical (inherited) | Inline in parent (no own folder) |
| Paywall variant (replaces feature when locked) | Critical (inherited) | Downgrade to Standard if the unlocked feature is the real surface |

Common upgrade patterns:

| Feature | Inherited tier | Common override |
|---|---|---|
| Sub-feature in Standard route that's actually heavily used | Standard | Upgrade to Important |
| Modal with complex multi-step flow on an Important route | Important | Upgrade to Critical if it's the primary action |

## When tier should change after initial assignment

- New evidence of usage (e.g., dev says "this is more used than I thought") → upgrade
- Feature deprecated mid-build → downgrade or move to Skip
- Quality review reveals undocumented importance → upgrade
- Initial coverage was too thin and dev wants depth → upgrade

Re-tiering doesn't auto-rewrite existing docs. Dev runs `rewrite feature` or `rewrite route` to apply new depth.

## Trade-off the dev should understand

Critical depth is 5-10x slower than Standard. For a 50-screen app:
- All Critical: ~25 hours of dev interaction
- All Standard: ~4 hours
- Mixed (8 Critical, 18 Important, 18 Standard, 6 Skip): ~12 hours

Skill recommends the mixed approach unless dev specifies otherwise.

## How tiering interacts with other rules

### EXCLUSIONS.md
- Skip tier → must be in EXCLUSIONS.md too (dev explicitly excludes)
- Items in EXCLUSIONS.md are auto-tagged Skip in SURFACE-MAP.md

### COMMON-COMPONENTS.md
- A screen using common components doesn't change its tier
- Tier reflects the SCREEN'S importance, not its implementation

### ATLAS-RULES.md
- Can override default tier suggestions per pattern (e.g., "all /admin/* screens are Important, not Critical")
- Can specify default depth for a tier (e.g., "Standard screens still get full error states")

## Surface map view (route-level) vs feature map view (feature-level)

Two tier breakdowns coexist:
- **Route-level** in SURFACE-MAP.md - coarse count of routes per tier.
- **Feature-level** in each route's FEATURE-MAP.md - fine count of features per tier within that route.

STATUS.md tracks both. Dev can see at any time:
- "Routes: 12 of 47 documented (Critical 4/8, Important 6/18, Standard 2/17)"
- "Features: 38 of 150 documented (Critical 18/40, Important 14/60, Standard 6/50)"
- "Next Critical feature: /workspace/billing/payment-method"

## Quality review tier checks

Quality review (`references/quality-review.md`) validates tier coverage:
- All Critical screens have full edge cases
- All Important screens have key edge cases
- Standard screens have at least required README sections
- No Skip screens accidentally documented

## When dev wants single-depth treatment

If dev says "treat everything as Important" or "everything Critical":
- Skill warns about time estimate
- Sets all non-skip screens to that tier in SURFACE-MAP.md
- Proceeds

Not recommended for large apps. Tiering exists for a reason.
