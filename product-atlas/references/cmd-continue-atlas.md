# Commands: `continue atlas` and `document <screen>`

The workhorse commands. Documents one feature view at a time (or resumes mid-feature). Run repeatedly across sessions until atlas complete.

Each route is documented in two phases:
- **Phase A — Feature mapping.** Walk the route's code, identify every feature view (tabs, modals, paywalls, edit views, filter panels), produce `screens/<route>/FEATURE-MAP.md`, get dev confirmation. Mandatory for Critical and Important routes; light version for Standard.
- **Phase B — Per-feature documentation.** For each feature in the map, run feature-first reasoning (hypothesis → confirm → edge cases → README + metadata).

A feature view = one folder = one README. The unit of progress is the feature, not the route.

## When to use which

| Command | Picks screen by |
|---|---|
| `continue atlas` | Skill picks next pending screen from STATUS.md queue |
| `document <screen>` | Dev specifies screen by name or path |
| `document next critical` | Skill picks next Critical-tier pending screen |
| `document <route> overview` | Document the route-level overview screen only |

## Pre-conditions

- `product-atlas/` exists (`start atlas` was run)
- STATUS.md has pending screens

If no pending screens, suggest `quality review` or `generate <view>` commands instead.

## Time per session

- One Critical screen: 15-30 min
- One Important screen: 10-15 min
- One Standard screen: 3-5 min

Dev decides how many screens per session. After each screen, skill asks: "Continue with next screen, or stop here?"

## Steps

### Step 1: Auto-load context

Read in order:
1. `product-atlas/STATUS.md` - current state, what's pending, in-progress if any
2. `product-atlas/OVERVIEW.md` - product brain
3. `product-atlas/ATLAS-RULES.md` - per-repo rules
4. `product-atlas/EXCLUSIONS.md` - skip list
5. `product-atlas/COMMON-COMPONENTS.md` - black box list
6. `product-atlas/SURFACE-MAP.md` - tier per screen
7. **For any route with an existing FEATURE-MAP.md, also read `screens/<route>/FEATURE-MAP.md`** and reconcile its folder count against STATUS.md (per `references/status-file.md` > Counting rule). If STATUS undercounts or overcounts, fix STATUS before picking work. Treat a per-route "X pending" claim in STATUS.md as suspect until verified against the FEATURE-MAP tree - especially for routes with folded row-editor / edit-detail sub-trees, where it's easy to count only top-level features and miss the sub-tree.

### Step 2: Pick route to work on

For `continue atlas`:
- If STATUS.md has in-progress entry → resume that route's feature (jump to Phase A or B with prior state restored)
- Else → pick next pending route, prioritizing higher tier

For `document <screen>`:
- Find named route in SURFACE-MAP.md
- If not found, ask dev for clarification
- If excluded, reject and tell dev

Announce to dev:
```
Skill: Working on /workspace/billing (Critical tier).
3 Critical routes remaining after this. STATUS shows you last documented /projects/[id]/board on 2026-05-19.

Phase A first: I'll map the feature tree for this route before documenting any features.
```

### Step 3 (Phase A): Build feature map

Per `references/feature-mapping.md`:

1. Read the route component end-to-end.
2. Recurse into sibling components (dive in unconditionally for `<app>/Pages/<screen>/` siblings; apply three-category rule for common components per `references/common-components.md`).
3. Apply atomic stop check (`references/split-criteria.md`) at each node.
4. Apply common-component dive-in rule per category.
5. Apply edit/detail folding rule (edit routes fold into parent feature, not separate FEATURE-MAP).
6. Record navigation as relationships.
7. Sanity-count check (≥3 nodes per CommonTable, ≥2 per paywall variant, ≥1 + tab-count for `<Tabs>`).
8. Save `screens/<route>/FEATURE-MAP.md` using the template at `assets/feature-map-template.md`.

Present the tree summary to dev. Get confirmation. Apply corrections.

Skip Phase A only if a FEATURE-MAP.md already exists for this route AND was generated recently (within last 30 days; bump if stale).

Depth varies by tier (per `references/importance-tiering.md`):
- Critical: full code trace, recursive into all sub-features, full sanity check.
- Important: full code trace, recursive, full sanity check.
- Standard: skim code, only top-level features (no deep recursion), light sanity check.

### Step 4 (Phase B starts): Pick a feature from the map

After Phase A confirms the tree, pick the next pending feature to document. Default order:
1. Highest-traffic feature in the tree (often the meta-seo-tab or main edit form for the route).
2. Top-of-tree features first, then their sub-features.
3. Atomic sub-features documented inline in their parent, not as separate folders.

For each feature picked, run feature-first reasoning per `references/feature-first-reasoning.md`:

### Step 5: Build internal understanding (silent)

Construct your own model BEFORE stating to dev.

What is this feature? Why does it exist? Who uses it? Key controls/actions? Business value hypothesis?

**Mandatory enumeration sub-step**: while building this understanding, **open the source file(s)** listed in `code_files` and enumerate **every** interactive UI element. The reviewer-caught gaps (filter chips on /funnels/select-design, pagination on /funnels) were all elements the writer "didn't see" because they didn't grep the JSX before writing. See `references/writing-rules.md` §10a for the full enumeration list and `references/screen-readme-format.md` "Pre-write interactive-element checklist" for the table of often-missed categories.

Output of this sub-step: a working list in scratch of every `<Button>`, `<ButtonGroup variant="segmented">` member, `<Checkbox>`, icon-only row action, pagination chevron, popover trigger, conditionally-rendered control, and `onClick` handler. Every item must end up in the README — no exceptions.

### Step 6: State understanding to dev

Use hypothesis-confirm format from `references/hypothesis-driven-qa.md`:

```
Skill: Feature: <route>/<feature-slug>
Tier: Critical

Here's what I think this screen does:
Lets workspace admins manage their subscription, payment method, and view invoice history.

Users come here to:
Upgrade or downgrade plans, update payment details, or troubleshoot billing issues.

The main things they can do:
- Change plan (between starter/pro/scale)
- Update payment method
- Update billing email
- Download past invoices
- View next renewal date

Controls I found:
- Plan selector (radio): three options matching pricing tiers
- Payment method update: opens Stripe payment element
- Billing email input: triggers email change confirmation flow
- "Cancel subscription" button: opens 2-step confirmation drawer

Business value (hypothesis):
Self-service billing reduces support tickets, especially around renewal and plan changes. Workspace admins can handle billing changes without contacting support.

Read and correct anywhere I'm wrong. Add missing things.
```

### Step 7: Dev confirms or corrects

Dev replies. Apply corrections to internal model.

If corrections reveal deeper questions, re-state revised hypothesis and ask again. Don't move forward until aligned.

If the corrections reveal sub-features missed during Phase A mapping, update FEATURE-MAP.md and proceed.

### Step 8: Edge case capture (Critical/Important only)

For Critical tier, ask full edge case enumeration (`references/edge-cases.md`).
For Important tier, ask key categories only.
For Standard tier, skip this step.

### Step 9: Write README.md and metadata.json for this feature

Write FROM validated understanding.

- README.md per `references/screen-readme-format.md` and `references/writing-rules.md`
- metadata.json per `references/metadata-schema.md`
- Use vocabulary from ATLAS-RULES.md / OVERVIEW.md (`references/universal-vocabulary.md`)

Place at `product-atlas/screens/<route>/<feature-slug>/README.md` + `metadata.json`.

For atomic sub-features (per `references/split-criteria.md`), document inline in the parent feature's README, NOT as a separate folder.

For new sub-features discovered during Step 7, ADD them to FEATURE-MAP.md and queue in STATUS.md.

### Step 10: Update screens/README.md tree

Add link to the new feature folder in the navigation tree. Format per `references/root-readme-format.md`.

### Step 11: Update STATUS.md

- Move feature from "pending" to "documented"
- If sub-features created during this session, add to pending queue
- Update progress counts (per-feature granularity, not per-route)
- Add to "Recent activity" section (top of list)
- Update "Atlas health" checks
- Update suggested next action (next feature in queue)

### Step 12: Append CHANGELOG entry

Per `references/changelog-format.md`. Brief entry:

```markdown
## 2026-05-19 - Documented /workspace/billing

**Trigger:** continue atlas
**Tier:** Critical
**Time spent:** 22 min
**Edge cases captured:** all 6 categories
**Open questions:** 1 (concurrent edits behavior)

### Notes
- Self-service billing screen for workspace admins
- 4 actions, 3 controls, 2 sub-screens (cancel-flow, payment-method)
- Sub-screens cancel-flow and payment-method queued in STATUS.md
```

### Step 13: Aggregations check

If this screen introduced:
- New roles in `access.roles` → re-aggregate ROLES.md
- New plans in `access.plans` or control gating → re-aggregate PLANS.md
- New integrations → re-aggregate INTEGRATIONS.md
- New INFERRED items → append to OPEN-QUESTIONS.md

### Step 14: Ask dev to continue or stop

```
Skill: Done with /workspace/billing.

3 Critical, 13 Important, 15 Standard remaining.
Next up: /workspace/members (Critical).

Continue or stop here?
```

If dev says continue → repeat from Step 2 for next screen.
If dev says stop → final STATUS.md write, end session.
If dev says `pause` → handle pause (Step 14).

### Step 15: Pause handling

If dev says `pause` mid-screen:
- Save current state to STATUS.md (which step paused at, validated understanding, pending questions)
- Update Recent activity with "paused at Step <N>"
- End session

Resume on next `continue atlas` from saved step. Don't re-do completed passes.

## Tier-adjusted flow

Each step adjusts by tier:

| Step | Critical | Important | Standard |
|---|---|---|---|
| 3 Code read | Full trace | Full trace | Skim |
| 4 Internal model | Detailed | Detailed | Brief |
| 5 Hypothesis | ~200 words | ~150 words | ~50 words |
| 6 Dev correction | Multiple rounds OK | Usually 1 round | Usually 1 round |
| 7 Edge cases | All 6 categories | Key categories | Skip (or errors only) |
| 8 README write | 500-1500 words | 300-700 words | 100-300 words |
| 8 metadata | All fields | Most fields | Required only |

## Sub-screen handling

Some screens have nested screens (popups, drawers, wizards). When detected:

- Apply split criteria (`references/split-criteria.md`)
- If complex enough for own folder, queue in STATUS.md
- Document parent screen first
- Sub-screens documented in later sessions (typically same tier as parent)

Example flow:
- Document /workspace/billing (parent) - mention "Cancel subscription" button opens confirmation drawer
- Queue /workspace/billing/cancel-flow as Critical sub-screen
- Next session: document cancel-flow with its own feature-first reasoning

## When dev wants to skip a screen

If dev says "skip this screen" mid-Step 5:
- Add to OPEN-QUESTIONS.md with note
- Move to next screen
- Don't mark as documented, stays pending

If dev says "exclude this screen" mid-Step 5:
- Add to EXCLUSIONS.md
- Remove from pending queue
- Document the exclusion in CHANGELOG entry

## When dev wants to change tier mid-screen

If dev says "this should be Standard not Critical":
- Update SURFACE-MAP.md tier
- Adjust subsequent steps to new tier depth
- If tier downgrades AFTER edge cases captured, keep edge cases (don't discard work)
- If tier upgrades, add steps that weren't planned (edge cases, deeper code read)

## After session ends

Final STATUS.md write happens automatically at session end. CHANGELOG.md has new entry. Dev can run `atlas status` next time to see state.
