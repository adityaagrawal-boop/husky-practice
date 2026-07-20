# ATLAS-RULES.md - Per-Repo Overrides

A single file at `product-atlas/ATLAS-RULES.md` that holds rules specific to THIS repo. The skill respects these without ever modifying itself.

## Why this exists

Different repos need different conventions:
- One product calls workspaces "teams," another calls them "organizations"
- One repo has API endpoints worth documenting inline, another doesn't
- One repo has 50 deprecated routes to skip-by-pattern
- One product domain has specific vocabulary that should be used throughout

Without per-repo rules, dev would have to repeat these preferences every session. With ATLAS-RULES.md, write once, skill obeys forever.

## When to load

Auto-load at the start of every command except `atlas status`. Loads alongside OVERVIEW.md.

## What goes in ATLAS-RULES.md

### Vocabulary overrides

Use dev's domain terms instead of universal defaults.

```markdown
## Vocabulary

- Use "workspace" not "account" or "team"
- Use "member" not "user" when referring to people inside a workspace
- Use "project" not "item" or "entity"
- Use "deal" not "record" in CRM contexts
- "AI-free" is our positioning phrase - never use "non-AI" or "without AI"
```

### Skip patterns

Routes or screens to skip by pattern (broader than EXCLUSIONS.md which is item-by-item).

```markdown
## Skip patterns

- All routes under `/internal-tools/*` - employee-only debug tools
- All routes under `/v1/*` - legacy API, being phased out
- Any component named `_*.tsx` (underscore prefix) - internal not user-facing
```

### Documentation rules

Repo-specific docs rules that extend (not replace) the skill defaults.

```markdown
## Documentation rules

- For billing screens, always include link to Stripe customer portal
- Document API endpoint in metadata.json under integrations when a screen uses internal API
- Don't document admin-only screens at full Critical depth - cap at Important
- Include "what happens after this action" in every action's prose (a step often missed)
```

### Pattern shortcuts

Tell skill what code patterns to expect, so it stops asking.

```markdown
## Code patterns

- All forms use react-hook-form. Don't flag this pattern, don't ask about it.
- All buttons use Polaris Button component. Treat as standard.
- All routes under /app/* are authenticated. No need to ask about auth on each.
- Server actions live in app/actions/. Database writes go through these.
```

### Custom checklist items

Add screen-checklist items specific to this product.

```markdown
## Custom checklist items

For every Critical screen:
- Does this screen send a notification? If yes, document trigger + content.
- Does this screen produce an audit log entry? If yes, document what's logged.
- Is this screen accessible to support reps via impersonation? If yes, document scope.
```

### Aggregation overrides

Customize how aggregated files are built.

```markdown
## Aggregation overrides

- ROLES.md should also include each role's "what they cannot do" section
- INTEGRATIONS.md should group services by category (analytics, billing, comms, infrastructure)
- PLANS.md should include trial-to-paid conversion notes per plan
```

### Other custom directives

```markdown
## Other

- Always use ISO date format (YYYY-MM-DD) in prose, never US format
- Currency display is always USD with $ prefix and 2 decimals
- All screen names in titles match the actual UI label exactly (no rephrasing)
- For any screen that integrates with Slack, link to the slack-integration screen documentation
```

## Format

Free-form markdown organized by section. Examples above. No rigid schema - rules are diverse.

Template at `assets/atlas-rules-template.md`.

## How skill applies rules

At the start of every command (Step 2 of SKILL.md flow), skill reads ATLAS-RULES.md and treats its contents as additive instructions on top of skill defaults. Specifically:

- **Vocabulary overrides** apply to all prose written this session
- **Skip patterns** filter route scan and screen identification
- **Documentation rules** extend or replace skill's writing rules for this repo
- **Pattern shortcuts** suppress questions about confirmed patterns
- **Custom checklist items** add to per-screen Assumption Checklist
- **Aggregation overrides** modify how ROLES/PLANS/INTEGRATIONS are built

If a rule conflicts with a hard rule (see `references/hard-rules.md`), the hard rule wins. Otherwise, ATLAS-RULES.md wins over skill defaults.

## Adding rules over time

ATLAS-RULES.md grows as dev discovers preferences. Common pattern:
- First session: dev fills initial rules during `start atlas`
- Mid-build: dev says "from now on always do X" → Claude adds to ATLAS-RULES.md and applies going forward
- After quality review: dev says "I noticed Y missing across screens" → Claude adds rule + retroactively fixes (via `rewrite route` or batch update)

## What does NOT go in ATLAS-RULES.md

- **Dead code / disabled features** → EXCLUSIONS.md
- **Shared infrastructure components** → COMMON-COMPONENTS.md
- **Product positioning, ICP, plans, roles** → OVERVIEW.md
- **Business term definitions** → GLOSSARY.md
- **Open dev-pending questions** → OPEN-QUESTIONS.md
- **Audit trail of changes** → CHANGELOG.md
- **Current build state** → STATUS.md

ATLAS-RULES.md is specifically for behavioral overrides: how the skill should behave when building/maintaining this atlas.

## When ATLAS-RULES.md is missing or empty

Skill uses defaults from this skill's reference files. No error. Just runs without overrides.

If file exists but empty (only header), skill treats as no overrides.

## Migration of rules between repos

If dev runs the skill on a new repo and has rules from a previous repo they want to reuse:
- Manually copy `ATLAS-RULES.md` from old repo's atlas
- Adjust vocabulary section for new product domain
- Adjust skip patterns for new repo structure
- Other sections often reusable

This is manual. Skill does not auto-import rules.
