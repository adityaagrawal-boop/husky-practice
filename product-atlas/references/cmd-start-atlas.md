# Command: `start atlas`

First-time setup of the atlas. Runs ONCE per repo. Sets foundation: product profile, intake, surface map. Does NOT document any screens.

## When to run

- New repo with no `product-atlas/` folder
- Existing atlas being rebuilt from scratch (after deletion)

## When NOT to run

- `product-atlas/` already exists → use `continue atlas` instead
- Dev wants to update specific feature → use `rewrite feature` instead

If user runs `start atlas` on existing atlas:
- Ask: "product-atlas/ already exists. Abort, or delete and rebuild from scratch?"
- Never silently overwrite

## Total time

20-30 minutes typically. ~6-10 question rounds.

## Steps

### Step 1: Verify location

Confirm working directory is the target app's repo root. Check for `product-atlas/` existence.

### Step 2: Pattern detection (silent)

Run full pattern detection per `references/pattern-detection.md`. Build internal product profile.

Detect: framework, auth, multi-tenancy, billing, real-time, jobs, storage, email, AI, analytics, i18n, database, permission model, API surface, routing.

Skill should NOT ask dev anything yet. Just scan and build profile.

### Step 3: Pattern detection summary to dev

State summary using hypothesis-confirm:

```
Skill: Scanning your repo... done.

   Detected:
   - Next.js 14 (App Router)
   - Clerk auth with Organizations (multi-tenant B2B SaaS)
   - Stripe Subscriptions (3 plans: starter, pro, scale)
   - Prisma + Postgres
   - PostHog analytics
   - next-intl with 3 locales (en, de, fr)
   - Inngest for background jobs
   - 34 routes detected, ~40-50 screens estimated
   - No real-time features detected
   - No AI features detected

   Sound right? Anything I'm missing or misreading?
```

Dev confirms or corrects.

### Step 4: Adaptive intake (Mode 0 default — draft-from-code, then dev reviews)

Follow `references/adaptive-intake.md`. **Default flow per section:**

1. Read relevant code/docs/config for the section
2. Write a complete draft with HIGH / MEDIUM / LOW / UNKNOWN confidence labels per field
3. Present draft to dev
4. Ask only targeted follow-ups for UNKNOWNs and LOW-confidence guesses

Per section, mine these sources before drafting:
- Section 1 Identity → `shopify.app.toml`, `package.json`, README, marketing pages
- Section 2 What it does → route + controller folder structure, READMEs, surface area
- Section 3 ICP → plan limits (size bands), feature mix, category
- Section 4 Pricing → pricing mock/config files, billing controller, charge/trial code
- Section 5 Users & Roles → auth provider, schema multi-tenancy keys, permission tables, plan gating
- Section 6 Positioning → README + marketing pages, category-inferred competitors (best-guess draft, dev rewrites)
- Section 7 Technical → pattern detection output (Step 1)
- Section 8 Setup & Onboarding → onboarding routes/components, OAuth handlers, install flow files
- Section 9 Meta → package.json version, today's date, git config

~5-9 rounds total. Dev reviews drafts instead of composing answers from scratch.

### Step 5: Write OVERVIEW.md

Assemble draft from intake answers. Show to dev. Apply corrections. Save to `product-atlas/OVERVIEW.md`.

### Step 6: Collect EXCLUSIONS.md

Ask dev:
```
Skill: Is this app a clone or fork of another product, or does it contain feature code that is not currently active (e.g., disabled features, legacy code)?
```

If yes, dev lists exclusions. Skill writes to `product-atlas/EXCLUSIONS.md` per format in `references/exclusions.md`.

If no, skill writes EXCLUSIONS.md with header and "No exclusions" note. File still exists.

### Step 7: Collect COMMON-COMPONENTS.md

Ask dev:
```
Skill: What shared infrastructure components exist in this codebase that I should treat as documented black boxes? Examples: CommonForm, CommonTable, AdminLayout, custom modal wrapper, etc. I won't dive into their source when documenting screens that use them.
```

Dev provides list. Skill writes to `product-atlas/COMMON-COMPONENTS.md` per format in `references/common-components.md`.

If dev says none / not sure, skill writes COMMON-COMPONENTS.md with header and note "No common components specified yet - dev will add as discovered during build."

### Step 8: Collect ATLAS-RULES.md

Ask dev:
```
Skill: Any custom rules for this repo specifically? Examples:
- Special vocabulary (e.g., we call workspaces "teams")
- Skip patterns (e.g., all /internal-tools/* routes)
- Documentation conventions
- Code pattern shortcuts

If yes, list them. If you don't have any preferences yet, I'll create the file empty and you can add rules as you discover preferences during build.
```

Dev provides initial rules or says "empty for now." Skill writes `product-atlas/ATLAS-RULES.md` per format in `references/atlas-rules.md`.

### Step 9: Surface mapping

Scan routes (filtered against EXCLUSIONS.md and ATLAS-RULES.md skip patterns). Build flat list with first-pass tier suggestions.

Present to dev per `references/surface-mapping.md` flow. Dev confirms/adjusts tiers.

Write `product-atlas/SURFACE-MAP.md`.

### Step 10: Initialize remaining files

Create these top-level files with starter content:
- `product-atlas/README.md` from `assets/product-atlas-readme-template.md`
- `product-atlas/STYLE.md` from `assets/style-template.md`
- `product-atlas/GLOSSARY.md` (minimal stub, grows over time)
- `product-atlas/CHANGELOG.md` (with initial entry)
- `product-atlas/OPEN-QUESTIONS.md` (empty initially)
- `product-atlas/screens/README.md` (placeholder tree, will be filled as screens documented)
- Empty `product-atlas/history/` folder

### Step 10a: Wire the `npm run atlas:*` commands

Every `npm run atlas:*` command documented throughout this skill (`references/command-surface.md`) only works once it's actually registered in the target repo's own root `package.json`, this step is what makes that true. Follow `references/package-json-setup.md` exactly: merge `assets/package-json-scripts-template.json`'s `scripts` object into the target's `package.json`, union not overwrite, and tell the dev which scripts were added. Do not skip this because it feels like plumbing, every quality/freshness/coverage command downstream silently fails without it.

### Step 11: Initialize STATUS.md

Write `product-atlas/STATUS.md` per `references/status-file.md` format. Populate:
- Total screens identified (from surface map)
- Documented: 0
- Pending: all non-excluded screens, ordered by tier
- Excluded: count from EXCLUSIONS.md
- Last updated: now
- Suggested next action: "Run `continue atlas` to start documenting screens"

### Step 12: Write initial CHANGELOG entry

```markdown
## YYYY-MM-DD - Atlas foundation built

**Trigger:** start atlas
**Generated from commit:** <hash>
**Routes detected:** <N>
**Screens identified:** <N>
**Excluded:** <N>

### Tiers locked
- Critical: <N>
- Important: <N>
- Standard: <N>
- Skip: <N>

### Files initialized
- OVERVIEW.md, EXCLUSIONS.md, COMMON-COMPONENTS.md, ATLAS-RULES.md, SURFACE-MAP.md, STATUS.md, README.md, STYLE.md, GLOSSARY.md, OPEN-QUESTIONS.md, CHANGELOG.md, screens/README.md
- INDEX.md (from `assets/index-template.md`), ASK-ME-FIRST.md (from `assets/ask-me-first-template.md`), MAINTENANCE.md (from `assets/maintenance-template.md`) — the router front door + maintenance playbook
- 0 screens documented yet

### Next steps
- Run `continue atlas` to document screens (start with Critical tier)
- Run `atlas status` anytime to check state
```

### Step 13: Done

Tell dev:
```
Skill: Foundation built. Atlas folder created at <path>.

Files initialized:
- OVERVIEW.md - product brief
- EXCLUSIONS.md - <N> excluded items
- COMMON-COMPONENTS.md - <N> shared components
- ATLAS-RULES.md - <N> custom rules
- SURFACE-MAP.md - 47 screens tiered (8 Critical, 13 Important, 15 Standard, 11 Skip)
- STATUS.md - tracking state
- CHANGELOG.md - audit trail started

Run `continue atlas` to start documenting screens. Start with Critical tier, expect 15-30 min per screen. Can pause anytime.
```

## Time budget per step

| Step | Time | Dev interaction |
|---|---|---|
| 1-3 (verify + scan + summary) | 2-5 min | Quick confirm |
| 4 (adaptive intake) | 15-20 min | 6-10 rounds |
| 5 (write OVERVIEW) | 2-3 min | Review draft |
| 6-8 (EXCLUSIONS + COMMON + RULES) | 5-10 min | Could be just confirmations |
| 9 (surface mapping) | 5-10 min | Confirm tiers |
| 10-13 (initialize + done) | 2-3 min | None |

Total: 30-50 min typically.

## Pause handling

If dev says `pause` mid-`start atlas`:
- Save state in STATUS.md (which step interrupted at)
- Resume on next `start atlas` from that step
- Note: this is rare since `start atlas` is typically completed in one session

## What does NOT happen in start atlas

- NO screen documentation. Foundation only.
- NO aggregations (ROLES.md / PLANS.md / INTEGRATIONS.md not built yet - need screens first)
- NO writes to `screens/<route>/` folders

This is deliberate. Surface map first, then incremental screen work.
