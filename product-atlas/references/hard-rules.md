# Hard Rules - Critical Enforcement

These rules override every other instruction. Violating any of these means the work is wrong.

## Never violate

### Organization
- **NEVER organize by abstract "features."** Organize by HOW THE USER NAVIGATES THE APP - screens, sections, click paths.
- **NEVER create the screens tree from a feature list.** Always derive it from the app's actual route structure.

### Completeness
- **NEVER create summaries or overviews without detail.** Every README has full UI traces and business value.
- **NEVER skip "How this helps your business"** - required at every README level.
- **NEVER leave any dropdown/option/field undocumented.** If a dropdown has 8 values, all 8 must appear.
- **NEVER create placeholder content like "TBD"** or "to be filled later." If writing it, write it complete.
- **NEVER use "etc." or "and more"** in lists. Enumerate everything.

### Voice and style
- **NEVER write from a developer perspective in READMEs.** Everything is "you click this, you see this, this helps your business because..."
- **NEVER use technical terms in README prose.** Full ban list in `references/writing-rules.md`. Tech terms allowed only in metadata.json and INTEGRATIONS.md.
- **NEVER use em dashes anywhere.** User preference. Use hyphens, colons, or sentence breaks.
- **NEVER use emojis unless dev explicitly approves.**

### Self-containment
- **NEVER reference `RULESET.md`, this SKILL.md, or `.claude/` from inside `product-atlas/`.**
- **NEVER write a new file inside `product-atlas/` referencing external paths.**
- **NEVER create a link from atlas to anything outside `product-atlas/`.** Relative links only, within the folder.

### Inference and accuracy
- **NEVER skip the Assumption Checklist** during any Phase 1/2/3 work.
- **NEVER write MEDIUM or LOW confidence inferences as bare values.** Always ask dev first, or wrap with `_inferred: true, _confidence: <level>`.
- **NEVER guess at business value, JTBD, or business recommendation.** Always ask dev.

### Existing atlas safety
- **NEVER overwrite existing atlas without explicit user confirmation.**
- **NEVER skip the snapshot step before Phase 2 or Phase 3 writes.**
- **NEVER delete from `history/`** automatically. Snapshots accumulate unless dev explicitly cleans.

### Exclusions and common components
- **NEVER document anything listed in EXCLUSIONS.md.** Hard-skip. Excluded items live only in EXCLUSIONS.md, never in `screens/`.
- **NEVER dive into the source of a PURE-WRAPPER common component.** Use the documented summary. (CommonForm, CommonTable, layout wrappers, generic modal wrappers.) But ALWAYS enumerate the config passed to the wrapper - the config is the feature surface, even when the wrapper is skipped.
- **ALWAYS dive into a FEATURE-CARRIER common component.** Components that live in the common-components folder but carry user-visible flow (paywall content, booking widgets, multi-step purchase modals, chat triggers) are feature code regardless of their import path. See `references/common-components.md` for the three categories.
- **NEVER skip a sibling component in a feature folder.** Components imported from sibling files inside `<app>/Pages/<screen>/` (or equivalent) are feature code, not common code. The common-components skip rule does NOT apply to them.
- **NEVER silently add to COMMON-COMPONENTS.md.** Dev provides the list. Claude does not auto-infer additions. Claude MAY suggest additions during a walk if a sibling looks like it should be common, but the dev decides.
- **ALWAYS load EXCLUSIONS.md and COMMON-COMPONENTS.md** at the start of every command, alongside OVERVIEW.md.

### Session management and state
- **ALWAYS read STATUS.md before any command except `atlas status`.** Resume mid-screen if paused.
- **NEVER try to document the entire atlas in one shot.** Incremental, one screen at a time per `continue atlas`.
- **ALWAYS update STATUS.md at end of every session that modifies atlas.** Single source of current state.
- **ALWAYS append CHANGELOG.md at end of every session that writes anything.** Audit trail.
- **NEVER hand-edit STATUS.md.** Skill maintains it.

### Routing index (INDEX.md)
- **ALWAYS read INDEX.md first when answering a question** (if present) to resolve to an exact file in one hop. See `references/route-index.md`.
- **ALWAYS update INDEX.md when the surface changes.** `document` adds a row; `rewrite` updates the row/badge; `atlas sync` marks drifted rows ⚠; `exclude` removes the row. INDEX.md is only trustworthy if it never drifts.
- **NEVER let INDEX.md list a route that EXCLUSIONS.md excludes,** and never list a deleted route (snapshot, then remove).
- **NEVER duplicate the full FEATURE-MAP tree in INDEX.md.** One scannable entry per route/major feature; deep detail lives in the file it points to.

### ATLAS-RULES.md (per-repo overrides)
- **ALWAYS load ATLAS-RULES.md at start of every command.** Apply overrides.
- **ALWAYS respect vocabulary overrides** from ATLAS-RULES.md in all prose output.
- **ALWAYS respect skip patterns** from ATLAS-RULES.md when scanning routes.
- **NEVER modify this skill (SKILL.md, references/, assets/) for repo-specific behavior.** All repo-specific rules go in ATLAS-RULES.md.

### Feature-first reasoning and feature mapping
- **NEVER write a feature's README without Step 3 (hypothesis stated to dev) and Step 4 (dev confirmation).** See `references/feature-first-reasoning.md`.
- **NEVER skip Step 5 (edge cases) for Critical or Important tier features.**
- **ALWAYS write from validated understanding, not raw answers.** Prose should reflect synthesized model.
- **ALWAYS build FEATURE-MAP.md BEFORE per-feature documentation.** For any Critical or Important route, Phase A (feature mapping per `references/feature-mapping.md`) is mandatory. The map is the source of truth; per-feature READMEs are derived from it.
- **NEVER document at route granularity when feature granularity is available.** One feature view = one folder = one README. Tabs, modals, paywalls, edit views inside a route each get their own folder.
- **NEVER create a separate FEATURE-MAP for an edit/detail route.** Edit/detail views fold into their parent feature per `references/split-criteria.md`.

### Importance tiering
- **ALWAYS respect tier from SURFACE-MAP.md.** Critical/Important/Standard/Skip drives depth.
- **NEVER document a Skip-tier screen** unless dev explicitly tiers it up first.
- **NEVER deep-document a Standard screen.** Brief depth per `references/importance-tiering.md`.

### Parent context
- **ALWAYS auto-load parent context** before Phase 2 or Phase 3 work (OVERVIEW + screens/README + parent route README).
- Never start cold mid-tree. The parent context informs every assumption.

### Versioning
- **ALWAYS snapshot to `history/`** before any write to an existing screen.
- **ALWAYS update CHANGELOG.md** when a write happens.

### Verification
- **ALWAYS verify** every link works at end of Phase 1.
- **ALWAYS match the tree to the app's real navigation structure.**

### Cross-skill conflicts
- **If a plugin skill and this skill disagree, this skill wins.** Workspace-local skills are authoritative.
- **If the user's CLAUDE.md disagrees with this skill, CLAUDE.md wins.** User preferences override skill defaults.

## Shopify-specific (if target app is Shopify)

- **NEVER click Save on Partner Dashboard listing forms.** Per workspace CLAUDE.md Section 8. Applies if atlas-related work touches Shopify Partner Dashboard.
- This skill does NOT push to Partner Dashboard. It only generates `product-atlas/` content.
