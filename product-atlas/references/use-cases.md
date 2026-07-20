# Use Cases Supported

The atlas powers distinct use cases from one source of truth, served to the **8 canonical personas** defined in `references/personas.md` (Developer, PM, Support, QA, Marketing, Data analyst, Sales, Designer). Answer mode routes every request through `references/router.md`. Every locked decision in this skill supports these.

> Personas are the single source of truth for audiences. The use cases below map onto them - if they ever drift, `personas.md` wins.

## 1. Support docs

**Audience:** Support team, help center editors
**Source data:** README prose + `metadata.states` + `metadata.controls[].business_recommendation`
**Output:** Per-screen help articles ready to paste into help center
**Generated via:** `generate support view`

## 2. Product roadmap

**Audience:** Product leadership
**Source data:** OVERVIEW features + screens tree + OPEN-QUESTIONS.md + CHANGELOG.md
**Output:** Surface map of what exists + gap list of unresolved items
**Generated via:** Manual reading of OVERVIEW + screens/README + OPEN-QUESTIONS

## 3. PM artifacts

**Audience:** Product managers
**Source data:** `metadata.purpose` + `metadata.controls` + `metadata.actions` + `metadata.access`
**Output:** Per-feature one-pagers
**Generated via:** `generate pm specs`

## 4. Developer onboarding

**Audience:** New developers joining the team
**Source data:** screens tree + INTEGRATIONS.md + `metadata.screen.code_files` + GLOSSARY.md
**Output:** Mental map of the app, route-by-route walkthrough with code refs
**Generated via:** `generate onboarding doc` + browse atlas directly

## 5. Sales scripts

**Audience:** Sales team
**Source data:** OVERVIEW positioning + per-feature business value
**Output:** Demo flow + ROI per feature + objection handling
**Generated via:** `generate sales script`

## 6. AI agent context (Q&A)

**Audience:** Anyone using cowork to query the product
**Source data:** Full atlas as cowork project
**Output:** Conversational Q&A over product knowledge
**Generated via:** `ask: <question>` or natural questions in chat

## 7. QA test plans

**Audience:** QA engineers
**Source data:** `metadata.controls` (every option) + `metadata.states` + `metadata.access`
**Output:** Per-screen test matrix with every option, state, and access combination
**Generated via:** `generate qa view`

## 8. i18n scoping

**Audience:** Localization team
**Source data:** `metadata.i18n_keys` across all screens
**Output:** Deduplicated string ID inventory with screen references
**Generated via:** `generate i18n keys`

## 9. Audit trail

**Audience:** Compliance, leadership, anyone tracking UI history
**Source data:** CHANGELOG.md + `history/` snapshots
**Output:** Reverse-chronological log of every atlas change with snapshot links
**Generated via:** Read CHANGELOG.md directly + browse history/

## 10. Marketing collateral

**Audience:** Marketing team
**Source data:** OVERVIEW positioning + per-feature `purpose.business_value` + `PLANS.md`
**Output:** Value props, feature benefits (outcome-framed), competitor comparison, messaging hooks, feature announcements
**Generated via:** `generate marketing view` *(output slot reserved - next round)*

## 11. Data & analytics dictionary

**Audience:** Data analysts
**Source data:** `screens/analytics/` docs + analytics sub-feature metadata + `PLANS.md` (credits/billing)
**Output:** Catalog of every metric/event - definition, data source, how computed, caveats
**Generated via:** `generate data-dictionary` *(output slot reserved - next round)*

## 12. Onboarding & offboarding playlists (any persona)

**Audience:** Any new hire in any of the 8 personas; departing team members' managers for offboarding
**Source data:** `personas.md` load order + `SURFACE-MAP.md` tier data + `scripts/atlas-persona-bundle.mjs` field projections + `GLOSSARY.md`
**Output:** Staged, ordered reading path with a "you're ready when" checklist per stage; offboarding variant adds a capture-before-they-leave punch list of thin/low-confidence Critical or Important items this person owns
**Generated via:** `generate onboarding playlist for <persona>` / `generate offboarding playlist for <persona> owning <features>` (see `references/onboarding-playlists.md`)

## Why one atlas, many views

Every use case needs the same underlying data: what screens exist, what controls live on them, what each control does, who can access it, what plans unlock it, what services it connects to, what strings are used.

Building one source of truth and deriving views means:
- No drift between support docs and QA plans
- One place to update when product changes
- New use cases can be added without rebuilding source data

## When to invoke each view

- **Daily/weekly:** Q&A mode for ad-hoc questions
- **Before major release:** support view (refresh help center), qa view (test plan)
- **Quarterly:** pm specs (feature audit), sales script (demo refresh)
- **Onboarding event:** onboarding doc for new developers; onboarding playlist for any other new hire
- **Offboarding event:** offboarding playlist for the departing person's role, before their last day
- **Translation rollout:** i18n keys export
- **Always available:** OVERVIEW.md and screens/ tree for browsing
