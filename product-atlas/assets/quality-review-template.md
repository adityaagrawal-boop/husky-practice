# Quality Review Report Template

Used by `quality review` command to present findings to dev in a single batched view.

---

# Quality Review - [App Name]

**Run date:** YYYY-MM-DD HH:MM
**Trigger:** quality review command
**Atlas state at review:**
- Critical: N / N documented
- Important: N / N documented
- Standard: N / N documented
- Excluded: N

---

## Summary

**Items found:** N
- Gaps: N
- Consistency: N
- Completeness: N
- Aggregation: N
- Links: N
- Open questions: N

---

## === GAPS ===

Issues where something should exist but doesn't.

<!-- For each gap:

### 1. [Short title]
**Type:** Missing screen / Missing field / Missing aggregation entry
**Detail:** <description>
**Where:** <file path or context>
**Suggested action:** <action>

Reply with answer to resolve.
-->

(none found)

---

## === CONSISTENCY ===

Same thing documented differently across screens.

<!-- For each consistency issue:

### N. [Short title]
**Type:** Conflicting defaults / Different descriptions / Naming mismatch
**Locations:**
- `<file 1>`: <observation>
- `<file 2>`: <observation>
**Question:** Which is correct, or is it intentional?

Reply with answer to resolve.
-->

(none found)

---

## === COMPLETENESS ===

Required fields missing or below tier expectation.

<!-- For each completeness issue:

### N. [Screen name] - Missing [field]
**Tier:** <tier>
**Expected:** <what's required for this tier>
**Actual:** <what's missing>
**Question:** <what to fill>

Reply with answer to resolve.
-->

(none found)

---

## === AGGREGATION ===

Cross-file inconsistencies between metadata and aggregated docs.

<!-- For each:

### N. [Short title]
**Detail:** <description>
**Source:** <which metadata fields>
**Aggregated file:** <ROLES.md / PLANS.md / INTEGRATIONS.md>
**Question:** <how to reconcile>

Reply with answer to resolve.
-->

(none found)

---

## === LINKS ===

Broken links or invalid references.

<!-- For each:

### N. [Source file] → [target]
**Issue:** Target doesn't exist
**Action:** Auto-fixable (skill can resolve)

-->

(none found)

---

## === OPEN QUESTIONS ===

Items in OPEN-QUESTIONS.md that may be resolvable now.

<!-- For each:

### N. [Open question]
**Originally logged:** <date>
**Context:** <screen / field>
**Still relevant?** yes / no
**Resolution:** <if dev knows answer now>
-->

(no outstanding items)

---

## How to respond

Per item:
- Provide answer to resolve
- Say "defer" to keep in OPEN-QUESTIONS.md
- Say "skip" to remove from review (mark won't-fix)

OR

- "all good - apply auto-fixes" to apply safe auto-fixes (broken links, stale aggregations) and skip items needing judgment
- "abort review" to end without applying any fixes

---

## What happens after responses

Skill processes each response:

- **Resolved with new info** → applies fix (may run `rewrite feature` for affected screen)
- **Deferred** → keeps/adds to OPEN-QUESTIONS.md
- **Skipped** → removes from active review, marks won't-fix
- **Auto-fix** → applies without asking (links, aggregations only)

Final CHANGELOG entry added at end of review.

---

## Milestone check

If after this review:
- 0 gaps remaining
- 0 consistency issues
- 0 completeness issues
- All Critical + Important screens documented

Skill marks atlas as "v1 milestone reached" and adds CHANGELOG entry indicating production-readiness.
