# Quality Review

Final pass over the atlas. Catches inconsistencies, gaps, and missed items that per-screen work might miss.

## When to run

- After all Critical screens documented (first checkpoint)
- After all Critical + Important documented (mid checkpoint)
- After all screens documented (final pass)
- Manually any time via `quality review` command

Multiple reviews OK. Each surfaces gaps relative to current state.

## Step 0: Run the structural validator first

Before the prose/consistency review, run the automated structural check (see `references/validation-script.md`):

```
node .claude/skills/product-atlas/scripts/validate-atlas.mjs product-atlas
```

Fix all **errors** (broken links, invalid metadata, INDEX drift, self-containment violations) before doing the manual review below. No point reviewing prose in a structurally broken atlas. Warnings are judgment calls.

## What gets checked

### 1. Gap detection

Scan for screens that should exist but don't:

- OVERVIEW.md mentions a feature in top 5 list - is there a screen for it?
- A route exists in code but no screen folder
- Navigation tree references a screen that has no folder
- INTEGRATIONS.md mentions a service - is there a screen that uses it?
- ROLES.md mentions a role - is there at least one screen with that role in access?
- PLANS.md mentions a plan - is there at least one screen that plan unlocks?

For each gap found, ask dev:
> "OVERVIEW.md mentions 'Inventory Sync' in top features but I didn't document any screen for it. Is it a settings page, a separate route, or part of /products?"

### 2. Consistency checks

Same thing documented differently across screens:

- Same control appears on multiple screens with different defaults → bug or intentional?
- Same role has different access patterns on two screens → bug or intentional?
- Same integration described differently in two screens
- Same feature mentioned in OVERVIEW.md with different name than in screens/

Example surfacing:
> "The auto-SEO toggle appears on /products (default OFF, Pro plan) and /settings/seo (default ON, Free plan). Bug or intentional?"

### 3. Completeness per tier

Check tier promises are met:

- All Critical screens have full edge cases captured (all 6 categories)
- All Critical/Important screens have `purpose.what`, `purpose.jtbd`, `purpose.business_value` filled
- All Standard screens have at least required README sections
- No Critical screen has empty controls/actions arrays (if visible UI exists)

For each fail:
> "Critical screen /reports has empty business_value. Why does a user view reports? What value does this provide?"

### 4. Aggregation sanity

Cross-check aggregated files against source metadata:

- ROLES.md references a role - is it actually in any screen's access.roles?
- PLANS.md references a plan - is it actually in any access.plans or gating.plans?
- INTEGRATIONS.md references a service - is it in any integrations[]?
- OPEN-QUESTIONS.md entries still relevant (not resolved by later work)?

### 5. Link validation

- Every link in any README points to existing path
- Every metadata.navigation.linked_screens target exists
- Every metadata.related_screens target exists
- No broken cross-references

### 6. Missing fields

- Required fields per `references/metadata-schema.md` all present
- No screens with `_inferred: true` for Critical-tier fields that should be HIGH confidence

### 7. OPEN-QUESTIONS.md review

- All items still relevant?
- Items dev has answered earlier in session but not cleared from OPEN-QUESTIONS.md?
- Items that should be promoted from "open" to "known limitation, on roadmap"?

## How to present findings to dev

After running checks, batch all findings into one structured report:

```
Skill: Quality review complete. Found 5 items to review.

=== GAPS ===
1. OVERVIEW.md top feature "Inventory Sync" - no screen documented for this. Where does this live?

=== CONSISTENCY ===
2. auto-SEO toggle has different defaults on /products (OFF) and /settings/seo (ON). Intended?
3. /workspace/billing and /billing both exist in screens/ - duplicate or different screens?

=== COMPLETENESS ===
4. Critical screen /reports has empty purpose.business_value. Why do users view reports?

=== AGGREGATION ===
5. ROLES.md shows "billing_admin" role but no screen has it in access.roles. Should /workspace/billing have it?

Respond to each:
1: <answer>
2: <answer>
3: <answer>
4: <answer>
5: <answer>

OR
"all good - apply auto-fixes" if you trust skill judgment on minor items
OR
"skip <N>" to defer a specific item to OPEN-QUESTIONS.md
```

## Apply fixes

Dev responds. Skill applies fixes:

- New screens → run `document <screen>` for each
- Consistency fixes → run `rewrite feature <name>` to fix metadata + README
- Completeness fixes → ask dev for missing info + write
- Aggregation fixes → re-aggregate after metadata changes
- Defer items → add to OPEN-QUESTIONS.md

## CHANGELOG entry

Quality review always produces a CHANGELOG entry:

```markdown
## 2026-05-20 - Quality review pass #1

**Trigger:** quality review command
**Items reviewed:** 5 issues found
**Items fixed:** 4
**Items deferred to OPEN-QUESTIONS:** 1

### Fixes applied
- Documented new screen /products/inventory-sync (Important tier)
- Corrected auto-SEO default mismatch (both screens now reflect OFF default)
- Removed duplicate /billing folder (was old draft, /workspace/billing is correct)
- Filled purpose.business_value for /reports

### Deferred
- billing_admin role question - dev wants to think about this further
```

## STATUS.md update after quality review

After review:
- Update "Quality review" section in STATUS.md with date + results
- Update open questions count
- If review found gaps, add affected screens back to pending queue with adjusted tier

## Quality levels

Dev can request different depth:

- `quality review` - standard depth (the 7 categories above)
- `quality review --deep` - additional checks (writing style consistency, prose quality, edge case completeness audit)
- `quality review <screen>` - scoped to one screen

## When skill can auto-fix vs needs dev input

Auto-fix without asking:
- Broken links to known files (fix the path)
- Stale aggregations (re-run aggregation)
- Snapshot before re-write (per `references/snapshot-versioning.md`)

Always ask dev:
- Anything involving business value
- Anything with consistency conflicts (which is correct?)
- Anything that changes scope (new screens to add)
- Anything that affects multiple screens

## When dev says "all good - apply auto-fixes"

Skill applies the safe auto-fixes (links, aggregation, snapshots) but stops on anything needing judgment. Reports back: "Fixed 3 auto-fix items. 2 items still need your input: items 1 and 4."

## Final quality review

The last quality review run (typically when all Critical + Important done) is the "atlas complete" milestone. Skill writes:

```markdown
## 2026-05-25 - Atlas v1 milestone: ready for production use

**Trigger:** final quality review
**Coverage:**
- Critical: 8/8 documented with full edge cases
- Important: 18/18 documented with key edge cases
- Standard: 17/17 documented with summary depth
- Excluded: 4 (in EXCLUSIONS.md)

**Quality:**
- 0 gaps remaining
- 0 consistency issues
- 0 broken links
- 2 open questions deferred (in OPEN-QUESTIONS.md)

**Aggregations:** all current
- ROLES.md: 4 roles
- PLANS.md: 3 plans
- INTEGRATIONS.md: 6 services
- GLOSSARY.md: 12 terms

Atlas is production-ready. Use views to export use-case-specific outputs.
```

## What quality review does NOT do

- Does not edit screen content without dev approval (except safe auto-fixes)
- Does not change tier assignments
- Does not modify EXCLUSIONS.md or COMMON-COMPONENTS.md (those are dev-managed)
- Does not run `rewrite feature` automatically (dev must confirm scope)
