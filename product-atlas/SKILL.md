---
name: product-atlas
description: Universal B2B SaaS product brain - builds, maintains, AND answers from a complete `product-atlas/` knowledge folder inside any web app's git repo. Serves the whole team through one router that detects who's asking (developer, PM, support, QA, marketing, data analyst, sales, designer) and answers in that role's shape with citations, confidence, and source-code fallback. Use whenever the user wants to document a SaaS web app from its source code, build screen-by-screen user-facing documentation, create developer onboarding docs, generate support/PM/sales/QA/marketing/data/i18n outputs, keep docs fresh as code changes, or answer ANY product question for ANY role over an existing atlas. Trigger on phrases like "start atlas", "continue atlas", "build atlas", "document this app", "document <screen>", "rewrite feature <name>", "rewrite route <slug>", "atlas status", "atlas sync", "atlas freshness", "quality review", "refresh overview", "what does <screen/button/feature> do", "how does <feature> work", "write a help article / release note / test plan / spec for X", "what changed", "if I change X what breaks", or any request to turn a SaaS web codebase into screen-by-screen documentation. Always use this skill when the user mentions product-atlas, app documentation from code, or asks product questions about a repo that already has a `product-atlas/` folder. The skill is incremental and session-aware: it picks up where it left off, never tries to document the entire app in one shot, persists state in STATUS.md, and respects per-repo overrides in ATLAS-RULES.md. Uses feature-first reasoning (state understanding to dev, get confirmation, then write prose from validated understanding), hypothesis-confirm Q&A for 100% accurate output, and a persona-aware router for answering.
---

# product-atlas

Universal B2B SaaS **product brain**. Builds, maintains, AND answers from a `product-atlas/` folder inside the target app's git repo. Two modes share one knowledge base:

- **Build/maintain mode** - incremental, multi-session documentation of the app from its source code (never one-shot a full atlas).
- **Answer mode** - a persona-aware router that lets any teammate (dev, PM, support, QA, marketing, data, sales, design) ask anything and get the best-shaped answer, with citations, confidence labels, and source-code fallback when the atlas is thin.

The router is the front door for every question: see `references/router.md`.

## Core principles

1. **Feature-first granularity.** One feature view = one folder = one README. Not one route = one screen. Tabs, modals, paywalls, edit views inside a route each get their own folder. Edit/detail routes fold INTO their parent feature, not as separate screens. See `references/feature-mapping.md` and `references/split-criteria.md`.
2. **Incremental, session-aware.** Atlas builds over many sessions. `STATUS.md` tracks progress at both route and feature granularity. `pause` and `continue` work mid-feature.
3. **Feature-first reasoning.** Per feature: read code (including sibling components in the feature folder), state understanding to dev, get confirmation, write prose from validated understanding. Not template-filling.
4. **Hypothesis-confirm Q&A.** "I see X. I think Y. Correct?" Faster + more accurate than open-ended questions.
5. **Pattern detection upfront.** Scan repo first, detect auth/billing/multi-tenancy/etc., ask only what code can't answer.
6. **Importance tiering.** Critical / Important / Standard / Skip. Routes are tiered in SURFACE-MAP.md (coarse). Features inherit the route tier in each FEATURE-MAP.md, with per-feature overrides. Depth varies by tier. 80/20 effort allocation.
7. **Edge cases first-class.** Per Critical/Important feature: scale, concurrency, network, error, accessibility, i18n captured structurally.
8. **Conservative inference.** HIGH writes as fact. MEDIUM and LOW always ask dev. UNKNOWN always asks.
9. **Universal vocabulary, domain adoption.** No Shopify-specific words. Atlas uses dev's domain language (workspace, patient, project, merchant, whatever).
10. **Common-component categories.** Pure wrappers skipped; feature carriers dived into; sibling components in `<app>/Pages/` always dived into. See `references/common-components.md`.
11. **Snapshot before rewrite.** History/ keeps every old version.
12. **Self-contained atlas.** Inside `product-atlas/`, never reference files outside the folder.
13. **Enumerate every interactive element before writing.** Before writing any screen README, open the source file and enumerate every `<Button>`, `<ButtonGroup variant="segmented">`, `<Checkbox>`, icon-only row action, pagination control, popover trigger, and `onClick`-bearing div. Every enumerated element must map 1:1 to a "Controls" entry, a "What you can do from here" subsection, or a one-line decorative-element mention. **No exceptions.** Gaps caught in past sessions (filter chips on /funnels/select-design, pagination on /funnels) all came from skipping this step. See `references/writing-rules.md` §10a and `references/screen-readme-format.md` "Pre-write interactive-element checklist".
14. **Persona-aware answering (the brain).** When answering questions over an existing atlas, route every request through `references/router.md`: classify intent x persona x output, load the right knowledge, and answer in the persona's shape (`references/personas.md` + `references/answer-contracts.md`). Infer the persona; ask only when genuinely ambiguous. Never dead-end with "not documented" - fall back to reading source code, then offer to add it to the atlas.
15. **Trust through confidence + freshness.** Every non-trivial answer carries a confidence label and, for high-stakes answers, a staleness check against the code (`references/confidence-and-freshness.md`). Keep the brain current with the maintenance loop (`references/maintenance-loop.md`) so it never silently rots.

## What gets created

A `product-atlas/` folder at the target app's repo root:

```
product-atlas/
├── README.md                   ← navigation guide
├── INDEX.md                    ← one-hop routing map (read first when answering)
├── ASK-ME-FIRST.md             ← per-repo router front door
├── STATUS.md                   ← current state, auto-maintained
├── OVERVIEW.md                 ← product brief, always loads
├── ATLAS-RULES.md              ← per-repo overrides + custom rules
├── EXCLUSIONS.md               ← dead code / disabled features
├── COMMON-COMPONENTS.md        ← shared infra to treat as black box
├── SURFACE-MAP.md              ← flat list of every screen with importance tiers
├── STYLE.md                    ← writing conventions
├── ROLES.md                    ← auto-aggregated
├── PLANS.md                    ← auto-aggregated
├── INTEGRATIONS.md             ← auto-aggregated
├── GLOSSARY.md                 ← hand-curated terms
├── DECISIONS.md                ← why product choices were made (ADR)
├── FLOWS.md                    ← Mermaid diagrams of key journeys
├── CHANGELOG.md                ← reverse-chrono version log
├── llms.txt / llms-full.txt    ← agent-readable index (npm run atlas:llms)
├── OPEN-QUESTIONS.md           ← auto-aggregated INFERRED
├── screens/                    ← navigation tree
├── history/                    ← snapshots
└── views/                      ← exported use-case docs
```

Architecture details in `references/architecture.md`.

## Commands

| Command | What | Reference |
|---|---|---|
| `start atlas` | First session only. Pattern detection + adaptive intake + surface mapping. ~20-30 min. | `references/cmd-start-atlas.md` |
| `continue atlas` | Next pending screen. Resumes mid-screen if paused. ~10-30 min per session. | `references/cmd-continue-atlas.md` |
| `document <screen>` | Target specific screen by name or path. | `references/cmd-continue-atlas.md` |
| `pause` | Save mid-screen state, resume later. | `references/incremental-build.md` |
| `atlas status` | Read STATUS.md, report current state. | `references/status-file.md` |
| `quality review` | Final cross-cutting validation pass. | `references/quality-review.md` |
| `rewrite feature <name>` | Update single feature's docs. | `references/phase-2-rewrite-feature.md` |
| `rewrite route <slug>` | Update entire route's docs. | `references/phase-3-rewrite-route.md` |
| `refresh overview` | Re-run adaptive intake for OVERVIEW.md only. | `references/overview-intake-spec.md` |
| `ask: <question>` | Persona-aware Q&A over atlas (routed). | `references/router.md` → `references/qa-mode.md` |
| `atlas sync` | Diff code since last atlas update, queue drifted screens for rewrite. | `references/maintenance-loop.md` |
| `atlas freshness` | Report screens whose code changed after they were documented. | `references/confidence-and-freshness.md` |
| `generate <view>` | Export use-case view. | `references/view-generation.md` |
| `generate onboarding playlist for <persona>` | Staged reading path into the product for any persona, not just developers. | `references/onboarding-playlists.md` |
| `generate offboarding playlist for <persona> owning <features>` | Same staged path plus a capture-before-they-leave gap list. | `references/onboarding-playlists.md` |
| `exclude <feature>` / `exclude <route>` | Add to EXCLUSIONS.md, snapshot existing if any. | `references/exclusions.md` |
| `add common-component <name>` | Add to COMMON-COMPONENTS.md. | `references/common-components.md` |
| `tier <screen> as <tier>` | Re-tier a screen (Critical/Important/Standard/Skip) in SURFACE-MAP.md. | `references/importance-tiering.md` |
| `add atlas-rule <text>` | Append a per-repo override/rule to ATLAS-RULES.md. | `references/atlas-rules.md` |
| `atlas coverage` | Regenerate COVERAGE.md (tier-ranked freshness/coverage burndown). | `scripts/atlas-coverage.mjs` |
| `atlas test` | Run the validator self-test harness. | `tests/run-tests.mjs` |

## How to use this skill

### Step 1: Identify the request

| Request looks like... | Command to use |
|---|---|
| First-time documentation | `start atlas` |
| Resume previous work | `continue atlas` or `document <screen>` |
| Status check | `atlas status` |
| Specific feature update | `rewrite feature <name>` |
| Whole route update | `rewrite route <slug>` |
| Final validation | `quality review` |
| Product question | `ask: <question>` or natural Q |
| Export | `generate <view>` |

### Step 2: Always auto-load context (before any work)

For every command except `atlas status`, read these files in order:
1. `product-atlas/STATUS.md` - current state
2. `product-atlas/OVERVIEW.md` - product brain
3. `product-atlas/ATLAS-RULES.md` - repo-specific rules
4. `product-atlas/EXCLUSIONS.md` - dead code
5. `product-atlas/COMMON-COMPONENTS.md` - shared infra to skip
6. `product-atlas/SURFACE-MAP.md` - tier assignments

For Phase 2/3 work, also read parent route README.

**Answer mode (any question / Q&A / artifact request):** before answering, also read `references/router.md` (the front door) and `references/personas.md`. The router reads `product-atlas/INDEX.md` first to resolve the question to an exact file in one hop (see `references/route-index.md`), then decides who's asking, what they want, and in what form, and answers via `references/answer-contracts.md`. This is the path for "what does X do", "write a help article", "if I change X what breaks", and any natural-language product question.

### Step 3: Read the matching command reference

Each command has its own file in `references/`. Read it before executing.

### Step 4: Pull sub-rule references as needed

| If you're working on... | Read |
|---|---|
| Answering ANY question / Q&A / artifact (the brain) | `references/router.md` |
| The one-hop routing index (INDEX.md format + sync rules) | `references/route-index.md` |
| Who the answer is for (persona definitions) | `references/personas.md` |
| What shape the answer takes (per-persona + artifacts) | `references/answer-contracts.md` |
| Labeling confidence / checking staleness | `references/confidence-and-freshness.md` |
| Keeping docs fresh after code changes (`atlas sync`) | `references/maintenance-loop.md` |
| Validating atlas structure (script) | `references/validation-script.md` |
| Capturing why a product choice was made (ADR) | `references/decision-log.md` |
| Pattern detection in code | `references/pattern-detection.md` |
| Adaptive intake | `references/adaptive-intake.md` + `assets/b2b-saas-intake-template.md` |
| Building a per-route FEATURE-MAP (Phase A) | `references/feature-mapping.md` + `assets/feature-map-template.md` |
| Per-feature documentation (Phase B) | `references/feature-first-reasoning.md` |
| Deciding feature splits (inline vs own folder vs fold into parent) | `references/split-criteria.md` |
| Hypothesis-confirm questions | `references/hypothesis-driven-qa.md` |
| Capturing edge cases | `references/edge-cases.md` + `assets/edge-cases-template.md` |
| Tiering importance (routes and features) | `references/importance-tiering.md` |
| Filling OVERVIEW.md | `references/overview-intake-spec.md` + `assets/overview-template.md` |
| Filling EXCLUSIONS.md | `references/exclusions.md` + `assets/exclusions-template.md` |
| Filling COMMON-COMPONENTS.md | `references/common-components.md` + `assets/common-components-template.md` |
| Filling ATLAS-RULES.md | `references/atlas-rules.md` + `assets/atlas-rules-template.md` |
| Filling SURFACE-MAP.md | `references/surface-mapping.md` + `assets/surface-map-template.md` |
| Maintaining STATUS.md | `references/status-file.md` + `assets/status-template.md` |
| Writing metadata.json | `references/metadata-schema.md` + `references/metadata-enums.md` |
| Writing screen README | `references/screen-readme-format.md` |
| Diagramming a non-trivial action's code-level logic (developer-only) | `references/technical-flow-diagrams.md` + `assets/technical-flow-template.md` |
| Writing screens/README.md | `references/root-readme-format.md` |
| Multi-pass iteration | `references/multi-pass-refinement.md` |
| Final quality review | `references/quality-review.md` + `assets/quality-review-template.md` |
| Building aggregated files | `references/auto-aggregation.md` |
| Generating an onboarding/offboarding playlist | `references/onboarding-playlists.md` + `assets/onboarding-playlist-template.md` |
| Writing CHANGELOG entry | `references/changelog-format.md` |
| Snapshotting before rewrite | `references/snapshot-versioning.md` |
| Validating output | `references/validation-rules.md` |
| Wiring `npm run atlas:*` commands into the target repo | `references/package-json-setup.md` + `assets/package-json-scripts-template.json` |
| Writing prose | `references/writing-rules.md` + `references/universal-vocabulary.md` |

### Step 5: Always respect hard rules

Before any write, consult `references/hard-rules.md`. These override every other instruction.

### Step 6: Always update STATUS.md and CHANGELOG.md after writes

Any change to a screen, OVERVIEW, or aggregated file → update STATUS.md (current state) and CHANGELOG.md (audit trail) at end of session.

## What this skill is NOT for

- Non-SaaS products (mobile-only, CLI, browser extensions, marketplaces, etc.) - out of v1 scope
- Building marketing sites / landing pages
- Generating UI mockups
- Writing actual code (only documenting existing code)

## Schema version

product-atlas schema v1.0 (locked 2026-05-19). Every metadata.json carries `schema_version: "1.0"`.

## Health & freshness automation

Beyond the build/answer commands, the skill ships self-defending tooling so the brain never silently rots. Full table in `references/command-surface.md`. Quick reference:

- `npm run atlas:validate` - structural hard gate; `npm run atlas:quality` - per-screen 0-100 score + i18n/a11y lint + confidence decay + tiered freshness SLAs (-> `QUALITY.md`, plus a single headline freshness % -> `FRESHNESS-SCORE.json`); `npm run atlas:coverage` - verification burndown (-> `COVERAGE.md`); `npm run atlas:freshness` - drift report; `npm run atlas:test` - validator regression.
- A `SessionStart` hook surfaces drift at the start of every session; a `PreToolUse` git-push guard checks freshness before a push from the Claude terminal (warn, or block with `ATLAS_PUSH_GATE=block`); a native git pre-push hook and `.github/workflows/atlas-freshness.yml` extend the same checks to every terminal and every PR.
- **Freshness SLAs:** Critical 3d / Important 7d / Standard 30d. **Decay:** `verified` stamps older than 120d are flagged for spot-check.

### Impact analysis (Phase 2)

- `npm run atlas:impact -- --since=<ref>` answers "if this code changed, what docs are affected?" - it maps changed files to affected screens, the views to regenerate, the personas who care, and changed code with no screen yet. `npm run atlas:routes` reconciles `client/Routes.jsx` against documented screens. A PR workflow (`.github/workflows/atlas-impact-pr.yml`) posts this as a comment on every pull request. (`atlas verify-api`, an endpoint cross-check, is planned next.)

### Spec -> code scaffolding (Phase 3, human-gated)

- `npm run atlas:scaffold -- <screen-id-or-path>` runs the spec FORWARD: from a screen's metadata it generates an i18n key stub and a vitest test skeleton (`test.todo` per control/action/state/access) into `.atlas-scaffold/` for review. It never writes into app source. This is the concrete answer to "can the atlas generate code?" - yes, from the structured spec it already holds, with a human gate.

### Phase 5: depth, polish & maintainability

- `npm run atlas:journeys` (Mermaid journey maps -> JOURNEYS.md), `atlas:dashboard` (HTML health page), `atlas:personas` (role context packs), `atlas:release-notes` (draft notes), `atlas:migrate` (schema migration runner, dry-run by default), `atlas:eval` (search regression). Screenshots, the 28 open questions, and feature-coverage expansion remain human/runtime tasks by design.

### Closeout commands

- `npm run atlas:verify-api` (documented endpoints vs real Express routes), `npm run atlas:explain-pr -- --since=<ref>` (diff -> product language), `npm run atlas:mttr` (drift-incident tracking + MTTR). The PR impact comment now also reports unverified-affected count + PR-head health (stale count, API mismatches, quality scorecard).
