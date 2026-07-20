# Importance Tiering Decision Rubric

Quick reference for assigning tiers during Step 3 of `start atlas` (surface mapping) or via `tier <screen> as <tier>` later.

---

## The 4 tiers - one-line definitions

| Tier | One-liner | Time / screen |
|---|---|---|
| **Critical** | Core daily-use screens where failure = revenue impact. Maximum docs depth. | 15-30 min |
| **Important** | Regular-use screens valuable to document. Full depth. | 10-15 min |
| **Standard** | Occasional screens. Summary acceptable. | 3-5 min |
| **Skip** | Don't document. Add to EXCLUSIONS.md. | 0 |

---

## Decision rubric

For each screen, walk through these questions in order. First "yes" determines tier.

### Critical if any of:
- Is this mentioned in OVERVIEW.md top 5 features?
- Is this the primary CRUD screen for the main entity?
- Is this the dashboard / landing screen users see first?
- Does failure here = revenue impact (billing, checkout, primary actions)?
- Do 80%+ of users touch this screen daily?
- Is this a workspace administration screen (members, settings, billing)?
- Is this the primary onboarding screen?

### Important if any of (and not Critical):
- Is this used by most users but not daily?
- Does this have its own controls/actions worth documenting?
- Is this a settings page dev would point a user to?
- Is this an integration management screen?
- Is this reports / analytics?
- Is this notification preferences?
- Is this a workspace member management screen?

### Standard if any of (and not Critical/Important):
- Is this used occasionally?
- Is this mostly read-only?
- Is this profile / personal settings?
- Is this help / support entry?
- Is this auth screens (sign-in, sign-up)?
- Is this generic CRUD for less-used entities?

### Skip if any of:
- Is this internal/employee-only (debug, admin diagnostics)?
- Is this a test or debug route?
- Is this legacy / being deprecated?
- Is this code-only (no active route or hidden by feature flag)?

If "yes" to skip questions → goes to EXCLUSIONS.md, not documented.

---

## When unclear

| Unclear between... | Default to |
|---|---|
| Critical vs Important | Critical (better to over-document) |
| Important vs Standard | Important |
| Standard vs Skip | Standard (Skip is a strong claim) |

---

## Examples by domain

### Project management SaaS
- Critical: /, /projects, /projects/[id], /projects/[id]/board, /workspace/members, /workspace/billing
- Important: /reports, /workspace/integrations, /notifications, /projects/new
- Standard: /profile, /help, /workspace/settings (cosmetic only)
- Skip: /admin/debug, /api-test

### CRM SaaS
- Critical: /, /deals, /deals/[id], /contacts, /contacts/[id], /accounts, /workspace/billing
- Important: /reports, /reports/funnel, /workspace/members, /workspace/integrations, /campaigns
- Standard: /profile, /preferences, /help
- Skip: /admin/migration-tools

### Healthcare SaaS
- Critical: /, /patients, /patients/[id], /encounters, /encounters/new, /scheduling, /workspace/billing
- Important: /reports, /claims, /reports/financial, /workspace/users
- Standard: /profile, /preferences, /help
- Skip: /admin/data-import

### Marketing automation
- Critical: /, /campaigns, /campaigns/[id], /campaigns/new, /audiences, /workspace/billing
- Important: /reports, /automations, /integrations, /workspace/users
- Standard: /profile, /preferences, /help
- Skip: /admin/segments-debug

---

## Tier-driven depth (summary)

Detailed in `references/importance-tiering.md`. Quick reference:

### Critical
- Code: full trace including all handlers
- Internal model: detailed (all controls, actions, states, business value hypothesis)
- Hypothesis to dev: ~200 words
- Edge cases: all 6 categories enumerated
- README: 500-1500 words, all sections
- metadata: all fields, no INFERRED tags

### Important
- Code: full trace of main components
- Internal model: detailed focused on user-facing surface
- Hypothesis to dev: ~100-150 words
- Edge cases: key categories (errors + accessibility)
- README: 300-700 words, all sections
- metadata: all required + most optional

### Standard
- Code: skim main component
- Internal model: brief
- Hypothesis to dev: ~50 words
- Edge cases: errors only (basic)
- README: 100-300 words, minimal sections
- metadata: required fields only

### Skip
- No documentation. Goes to EXCLUSIONS.md.

---

## When tier should change mid-build

| Reason | Action |
|---|---|
| New evidence of usage frequency | Upgrade tier, suggest re-document for more depth |
| Feature deprecated | Downgrade or move to Skip |
| Quality review surfaced unexpected importance | Upgrade |
| Initial coverage too thin | Upgrade and re-document |
| Initial tier too high (over-documented) | Downgrade (existing depth preserved) |

Command: `tier <screen> as <new-tier>`

Re-tiering updates SURFACE-MAP.md + STATUS.md. Does NOT auto-rewrite existing docs. Dev must run `rewrite feature` to apply new depth.

---

## When dev wants single-tier treatment

If dev says "everything Critical" or "everything Important":
- Skill warns about time cost (Critical depth × N screens)
- Sets all non-Skip screens to that tier
- Proceeds

Not recommended for apps with 30+ screens. Tiering exists for a reason.

---

## When dev wants to defer tiering

If dev says "I'll tier later":
- Skill tags all screens as "untiered"
- Defaults treatment to Important (mid-tier)
- Tracks "untiered" count in STATUS.md atlas health
- Suggests tiering before quality review
