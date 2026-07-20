# Adaptive Intake

Dynamic interview shaped by pattern detection output. Replaces the fixed 43-question intake. Asks only what code can't answer.

## Where this runs

Step 2 of `start atlas` (after pattern detection, before surface mapping).

Also runs on `refresh overview` command.

## Intake modes

### Mode 0: Draft-from-code (DEFAULT for every section)

**This is the default flow.** For every section, before asking anything:

1. Skill reads relevant code/docs/config files (package.json, route files, schema files, marketing pages, controller logic, mock/seed data, existing project docs).
2. Skill writes a **complete draft** of the section with everything it could derive. Each field is labeled with confidence:
   - **HIGH** = directly evidenced by code (e.g., plan list from a mock file)
   - **MEDIUM** = strong inference (e.g., persona deduced from pricing limits + feature mix)
   - **LOW** = best guess from weak signal (e.g., competitors inferred from category)
   - **UNKNOWN** = no signal at all (e.g., why users don't pick this)
3. Skill presents the draft to the dev. Dev reviews and corrects in-place.
4. Skill asks **only targeted follow-ups** for UNKNOWN fields and LOW-confidence guesses that need verification.

**Why this is the default:** Reviewing and editing a draft is dramatically faster for the dev than composing answers to open-ended questions from scratch. Open-ended Q&A rounds are slow and exhausting; draft-first reduces a 4-question round to a single "looks good" or "fix X" reply.

**Required draft format:**
```
Section X — <name>

| Field | Draft value | Confidence |
|---|---|---|
| ... | ... | HIGH/MEDIUM/LOW/UNKNOWN |

Follow-ups (only for UNKNOWN + LOW):
1. <specific question about gap>
2. <specific verify-this-guess question>
```

**When Mode 0 isn't enough:** if a section is 100% UNKNOWN (e.g., positioning in a repo with zero marketing pages), fall back to Mode 3 — but even then, draft a best-guess "what I would say if I had to guess" first, then ask dev to rewrite it.

### Mode 1: Auto-filled (no question needed)

Patterns confirmed by Step 1 (pattern detection) fill OVERVIEW.md Section 7 (Technical) directly. Skill writes inferred values with HIGH confidence. Dev sees results, doesn't have to type.

Examples:
- Tech stack (auto from package.json)
- Database (auto from prisma/schema.prisma)
- i18n locales (auto from messages/ folder)
- Third-party services (auto from package.json + .env.example)

### Mode 2: Hypothesis-confirm (one-line confirmations)

Skill states inference, dev confirms or corrects in one reply. Used for things code suggests but doesn't prove.

Examples:
- "Pricing model: subscription, billed monthly via Stripe. Correct?"
- "Multi-tenancy: workspaces via Clerk Orgs. Multiple users per workspace, each user can belong to multiple workspaces. Correct?"
- "Permission model: 3 roles (admin, member, viewer). Correct?"

Dev says yes / no / correction. One round each.

### Mode 3: Open-ended (asked only when needed)

Things code can never answer. Dev tells skill in their own words.

Always-asked open-ended:
- Product one-liner
- Full description
- ICP (persona, pain, JTBD)
- Positioning vs competitors
- Why users pick this vs why they don't

These are product/business context. No code signal can provide them.

## The intake decision tree

**Default flow per section: Mode 0 (Draft-from-code, then review).** The list below describes WHICH sources to mine for each section's draft, and which fields will typically be UNKNOWN and need a follow-up question.

```
START
├── Read pattern detection output
├── Mode 1: Auto-fill technical section (no questions)
│
├── Section 1 - Identity (Mode 0)
│   Draft from: shopify.app.toml (name + handle + app URL), package.json (repo, description),
│                README.md, marketing pages, route prefixes (category hint)
│   Likely UNKNOWN: official one-liner / App Store subtitle (ask)
│   Likely LOW: App Store listing URL if not in toml (ask)
│
├── Section 2 - What it does (Mode 0)
│   Draft from: route folders + controller folders (top features), README + marketing pages
│                (description + value prop), feature folder counts (depth signals headline-ness)
│   Likely UNKNOWN: official value prop wording
│   Likely MEDIUM: top-5 feature ranking (skill suggests by surface area; dev re-orders)
│
├── Section 3 - ICP (Mode 0)
│   Draft from: pricing limits (store size bands), feature mix (persona type), category
│   Likely UNKNOWN: pain points in customer's voice, JTBD wording, target industries
│   Likely MEDIUM: store size range (derive from plan limits)
│
├── Section 4 - Pricing (Mode 0)
│   Draft from: pricing mock files, plan config, billing controller, trial/charge code,
│                discount schema, one-time charge handlers
│   Result: skill should be able to draft the full plan table + gating + trial + one-time + custom
│           tier with HIGH confidence in most repos.
│   Likely UNKNOWN: hidden/legacy plans visible in code but not marketed (verify with dev)
│
├── Section 5 - Users & Roles (Mode 0)
│   Draft from: auth provider, multi-tenancy keys in schema, role/permission tables,
│                middleware gating, plan-based feature checks
│   Result: for Shopify embedded apps, default draft is "1 shop = 1 tenant, no in-app roles,
│           plan-based gating only" with HIGH confidence.
│   Likely UNKNOWN: hidden role distinctions in custom apps (verify with dev)
│
├── Section 6 - Positioning (Mode 0, with Mode 3 fallback)
│   Draft from: README + marketing pages (differentiator language), category + features
│                (competitor inference for that vertical), App Store listing if accessible,
│                code comments / docs that mention competitors
│   Result: skill drafts a plausible competitor list and differentiation guess. Dev rewrites
│           with real positioning.
│   Likely UNKNOWN: actual competitor list, real differentiator wording, common objections
│   This section often has the most UNKNOWNs - still draft best guess so dev edits, not composes.
│
├── Section 7 - Technical (Mode 1 - auto-fill, Mode 0 review)
│   Draft from: pattern detection output (already done in Step 1 of start-atlas)
│   Result: full draft, dev only reviews & corrects
│
├── Section 8 - Setup & Onboarding (Mode 0)
│   Draft from: onboarding routes/components, OAuth flow files, install handlers,
│                first-run screen logic, required-config detection (env vars, profile flags),
│                AI onboarding controllers if present
│   Result: skill drafts install flow + first-run UX + required config.
│   Likely UNKNOWN: time-to-value (this is a positioning claim, not a code fact)
│
├── Section 9 - Meta (Mode 0 + auto)
│   Draft from: package.json (app version), today's date (auto), git config (filled-by hint)
│   Result: nearly fully auto. Dev confirms filled-by name + optional notes.
│
└── COMPLETE → present full OVERVIEW.md draft → dev approves → save
```

## Questions skill does NOT ask

If pattern detection answered them with HIGH confidence:
- "What framework do you use?" - auto from package.json
- "What database?" - auto from schema files
- "Do you use multi-tenancy?" - auto from auth provider + schema
- "What auth provider?" - auto from package.json
- "What analytics tool?" - auto from package.json
- "What email provider?" - auto from package.json
- "What's your tech stack?" - auto from package.json

These appear in OVERVIEW.md Technical section auto-filled with `_inferred: false` (HIGH confidence). Dev reviews the section at the end, corrects if wrong.

## Branching examples

### Example: Free product (no billing detected)

```
Skill: I don't see billing code. Is this product free, monetized via something I can't see (manual invoicing, parent product subsidy), or open source?

Dev: Manual invoicing. We're B2B and bill quarterly via custom contracts.

Skill: Got it. Section 4 will note "Custom contract billing, no in-app pricing." Skipping plan structure questions. Should we still capture Enterprise tier features that differ from Standard?

Dev: Yes - Standard is up to 10 users, Enterprise is unlimited + SSO.

Skill: Captured. Moving to Section 5 Users & Roles.
```

### Example: AI feature detected

```
Skill: I see OpenAI integration in app/lib/ai/. Used in 4 places: /editor (content suggestions), /support (auto-replies), /reports (insights), /search (semantic search). AI is a product feature here, not just internal tooling. Correct?

Dev: Yes, AI features are positioned heavily.

Skill: I'll add an "AI Features" subsection to OVERVIEW.md. For each AI feature, when we get to documenting screens, I'll capture: model used, prompt input range, expected output range, fallback when AI fails. Sound good?

Dev: Yes.
```

### Example: Complex RBAC

```
Skill: I see a Permission and Role table in Prisma schema. Not just role-based (admin/user), but custom permission grants per role. Permissions visible in code: read_billing, write_billing, manage_users, view_audit, ... 14 permissions total. Correct?

Dev: Yes, fully custom RBAC.

Skill: I'll generate a paste-back template listing all 14 permissions. Fill in per-role grants and I'll convert to ROLES.md aggregation format. Ready for the template?

Dev: Send it.
```

## Round structure with Mode 0 default

With Mode 0 as default, each section becomes a single round:

**Per-section round:**
1. Skill reads relevant code & writes draft (5-15 min depending on section depth)
2. Skill presents draft with confidence labels
3. Dev reviews, corrects in one reply, answers follow-up questions for gaps
4. Skill saves section, moves to next

**Typical total intake with Mode 0:** 5-9 rounds (one per section, sometimes combined), ~10-20 min for dev to review (vs 25-40 min composing answers). The skill's research time replaces the dev's composition time.

**When to batch with AskUserQuestion:** if multiple sections have only 1-2 UNKNOWN follow-ups each, batch their follow-ups together (max 4 per call). For UNKNOWNs that need paragraph-length answers, ask in plain text.

## Paste-back templates (when used)

For tabular data (plans, roles, permissions matrix), use paste-back template:

```
Skill: For plans, fill this template and paste back:

[plans template inline]

For roles + permissions, fill this template:

[roles template inline]
```

Dev fills offline, pastes back. Skill parses into structured data.

Templates at:
- `assets/b2b-saas-intake-template.md` (full template if dev wants offline mode)
- Inline paste-back snippets generated by skill for specific sections

## Validation after intake

After OVERVIEW.md draft assembled:

1. Show full draft to dev
2. Highlight any HIGH-confidence inferred fields (Technical section mostly)
3. Ask: "Review and confirm or correct anything"
4. Apply edits
5. Save final OVERVIEW.md
6. Move to Step 3 of start atlas (surface mapping)

## What if dev wants to skip intake

If dev says "skip intake, just document screens":
- Skill creates minimal OVERVIEW.md with auto-detected technical section
- All other sections marked TODO
- Flagged as a blocker for view generation (PM specs / sales scripts need positioning)
- Dev can run `refresh overview` later to fill in

Not recommended. Skill warns.
