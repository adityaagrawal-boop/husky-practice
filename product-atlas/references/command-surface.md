# Command Surface

Commands the dev/user can trigger that this skill handles.

## Atlas build commands (incremental)

| Command | Aliases | Phase | Reference |
|---|---|---|---|
| `start atlas` | `setup atlas`, `generate atlas`, `initialize atlas`, `build atlas` (first-run only) | Initial setup | `references/cmd-start-atlas.md` |
| `continue atlas` | `next screen`, `next` | Per-screen iteration | `references/cmd-continue-atlas.md` |
| `document <screen>` | `doc <screen>` | Targeted screen | `references/cmd-continue-atlas.md` |
| `pause` | `stop` | Mid-screen pause | `references/incremental-build.md` |
| `quality review` | `review`, `qa pass` | Final cross-check | `references/quality-review.md` |
| `atlas status` | `status` | Read-only state report | `references/status-file.md` |

## Atlas update commands

| Command | Aliases | Reference |
|---|---|---|
| `rewrite feature <name>` | `update feature <name>`, `refresh feature <name>` | `references/phase-2-rewrite-feature.md` |
| `rewrite route <slug>` | `update route <slug>`, `refresh route <slug>` | `references/phase-3-rewrite-route.md` |
| `refresh overview` | `re-intake`, `update overview` | `references/overview-intake-spec.md` |
| `tier <screen> as <tier>` | - | `references/importance-tiering.md` |
| `exclude <feature>` / `exclude <route>` | - | `references/exclusions.md` |
| `add common-component <name>` | - | `references/common-components.md` |
| `add atlas-rule <text>` | - | `references/atlas-rules.md` |

## Q&A commands

| Command | What | Reference |
|---|---|---|
| `ask: <question>` | Q&A over atlas | `references/qa-mode.md` |
| Natural product question | Any free-form question about the app | `references/qa-mode.md` |

## View generation commands

| Command | What | Reference |
|---|---|---|
| `generate support view` | Per-screen help articles export | `references/view-generation.md` |
| `generate pm specs` | Feature one-pagers export | `references/view-generation.md` |
| `generate qa view` | Test matrix export | `references/view-generation.md` |
| `generate i18n keys` | String ID inventory export | `references/view-generation.md` |
| `generate sales script` | Demo flow + ROI export | `references/view-generation.md` |
| `generate onboarding doc` | Dev walkthrough export | `references/view-generation.md` |

## Maintenance commands

| Command | What |
|---|---|
| `refresh overview` | Re-run OVERVIEW.md intake (manual only, never auto) |

## Trigger phrase matching

Recognize variations of the locked commands.

### Examples that should trigger `start atlas`:
- "Build atlas"
- "Set up product documentation"
- "Document this entire app"
- "Initialize product-atlas"
- "Start atlas for this repo"

If `product-atlas/` already exists, route to `continue atlas` or ask dev to confirm rebuild.

### Examples that should trigger `continue atlas`:
- "Continue atlas"
- "Next screen"
- "Pick up where we left off"
- "Document the next thing"

### Examples that should trigger `document <screen>`:
- "Document /workspace/billing"
- "Doc the products screen"
- "Now do the billing screen"

### Examples that should trigger `quality review`:
- "Quality review"
- "Run a review"
- "Check for gaps"
- "Final pass"

### Examples that should trigger `atlas status`:
- "Atlas status"
- "Status"
- "Where are we"
- "What's left"
- "How much is done"

### Examples that should trigger Phase 2 (rewrite feature):
- "Rewrite the auto-SEO feature"
- "Refresh the pricing tier docs"
- "Update the bulk edit feature's documentation"

### Examples that should trigger Phase 3 (rewrite route):
- "Rewrite the products route"
- "Refresh /settings"
- "Update everything under the dashboard route"

When the intent is ambiguous (e.g., "update the docs"), ask the user to clarify scope.

## When to NOT trigger this skill

- User is asking about something unrelated to product documentation
- User wants to edit a single specific file directly (use Edit/Write tools)
- User wants to read existing docs without modifying (just read the files)
- Atlas-related work that's already complete and just needs acknowledgment

## Setup: making these commands actually exist

Every `npm run atlas:*` command in this file requires `start atlas` Step 10a to have merged `assets/package-json-scripts-template.json` into the target repo's `package.json` first (`references/package-json-setup.md`). If a command below fails with "missing script," that step either didn't run or a new command was documented here without adding it to the template, fix the template, not just this doc.

## Health & freshness automation (npm scripts + hooks)

These keep the brain trustworthy without anyone remembering to look. All read-only except where noted.

| Command / hook | What |
|---|---|
| `npm run atlas:validate` | Structural integrity (hard gate; non-zero exit on errors). |
| `npm run atlas:freshness` | Git-diff drift report (which screens' code changed after their verified/generated date). |
| `npm run atlas:coverage` | Verification burndown -> `COVERAGE.md` (writes the file). |
| `npm run atlas:quality` | Per-screen 0-100 score + i18n/a11y lint + confidence decay + orphan + tiered freshness SLAs -> `QUALITY.md` (writes the file), plus a single headline freshness percentage (Critical+Important screens within SLA) -> `FRESHNESS-SCORE.json` for dashboards/marketing to read directly. |
| `npm run atlas:test` | Regression harness for the validator itself. |
| SessionStart hook (`scripts/atlas-session-start.sh`) | Every Claude session opens knowing how many screens drifted. |
| PreToolUse git-push guard (`scripts/atlas-pre-push-guard.sh`) | A `git push` from the Claude terminal runs a freshness check first. Warn by default; `ATLAS_PUSH_GATE=block` to block. |
| Native git pre-push (`scripts/atlas-git-pre-push.sh`) | Same check for pushes from ANY terminal (install instructions in the script header). |
| CI (`.github/workflows/atlas-freshness.yml`) | Runs on every push/PR: structural validation hard-gates; freshness/coverage/quality run warn-now (one-line switch to hard-gate). |

**Freshness SLAs (used by `atlas:quality`):** Critical 3 days, Important 7 days, Standard 30 days. A drifted screen past its window is an SLA breach. **Confidence decay:** a `verified` stamp older than 120 days is flagged for spot-check even if the code never changed.

## Impact analysis & router reconcile (Phase 2)

| Command / hook | What |
|---|---|
| `npm run atlas:impact -- --since=<ref>` | Map changed files (a git range, explicit files, or uncommitted changes) to affected documented screens + downstream views/personas, and flag changed code that has no screen yet. `--json` for machine output; `--fail-on-impact` to gate. |
| `npm run atlas:routes` | Reconcile `client/Routes.jsx` against documented screens: routes in code with no doc, and documented routes missing from the router. Admin/storefront/legal surfaces are ignored (they live outside the SPA router). |
| CI (`.github/workflows/atlas-impact-pr.yml`) | On every PR, posts/updates one comment listing the docs the PR affects. Advisory - never blocks the PR. |

**Not yet shipped (next):** `atlas verify-api` (cross-check documented action endpoints against real server routes) - deferred until mount-prefix resolution is added so it doesn't produce false positives.

## Spec -> code scaffolding (Phase 3, human-gated)

| Command | What |
|---|---|
| `npm run atlas:scaffold -- <screen-id-or-path>` | Generate review-ready scaffolding from a screen's metadata into `.atlas-scaffold/<id>/`: an i18n key stub (all `i18n_keys`, empty values) and a vitest test skeleton (`test.todo` per control / action / state / access rule). DRAFT only - never writes into app source; a dev reviews and moves the files. |

This is the forward direction of the atlas (spec -> code). `test.todo` placeholders assert nothing, so a wrong spec cannot generate a wrong-but-green test. Next code-gen targets: new-screen component scaffolds (CommonForm/CommonTable), API/type stubs, and the MCP advisor read tools.

## Phase 3 (complete): full spec -> code

| Command | What |
|---|---|
| `npm run atlas:scaffold -- <screen>` | Now also emits a React component draft (CommonForm/CommonTable conventions: controls -> form state, actions -> useCallback handlers) and an endpoint/type stub (`.ts`) from documented action effects, alongside the i18n stub + vitest skeleton. All into `.atlas-scaffold/<id>/`. |
| `npm run atlas:gen-mcp` | Generate **advisor read-tools** from the atlas (`list_screens`, `get_screen_doc`, `search_atlas`) into `.atlas-scaffold/mcp/productAtlasAdvisorTools.draft.mjs`, matching the target repo's existing MCP tools style (e.g. `server/mcp/tools/*.js`) if it has one. Review, then register with the repo's own MCP server. |

All Phase 3 output is a reviewed DRAFT - the generators never write into app source or the live MCP server.

## Phase 4: one queryable brain + distribution

| Command / artifact | What |
|---|---|
| `npm run atlas:compile` | Compile all 94 metadata files into one `product-atlas/atlas.json` (every screen's spec in one hop). Re-run after doc changes. |
| `npm run atlas:llms` | Emit `product-atlas/llms.txt` + `llms-full.txt` from atlas.json, the llmstxt.org convention, so a plain AI/web crawler with no MCP wiring can still index the atlas. Complements, doesn't replace, atlas.json and the MCP advisor tools below. Re-run after `atlas:compile`. |
| `npm run atlas:search -- "<query>"` | Lexical/concept search over atlas.json ("free shipping", "discount") - ranks screens even when wording differs from route names. `--json`/`--limit`. |
| `npm run atlas:backlinks` | Emit `.atlas-backlinks.json` (repo root): code file -> screen doc map for editor jump-to-doc. |
| MCP resource `atlas://<app>/atlas-index` | `server/mcp/resources/productAtlas.js` (or the target repo's equivalent) now also serves atlas.json as a structured resource (additive; the prose `product-knowledge` resource is unchanged). Namespace the URI to the target app, not hardcoded to any one product. |
| `scripts/slack-ask-the-atlas.draft.mjs` | DRAFT Slack handler: `answerQuestion()` is real/testable over atlas.json; Slack Bolt transport is commented wiring (needs SLACK_* tokens + a running process to deploy). |

## Phase 5: depth, polish & maintainability

| Command | What |
|---|---|
| `npm run atlas:journeys` | Generate `product-atlas/JOURNEYS.md` - per-route Mermaid journey diagrams derived from the screen hierarchy + related-screen links. |
| `npm run atlas:dashboard` | Render `.atlas-scaffold/atlas-health.html` - self-contained glanceable health page (verified vs unverified vs known-stale, by tier). |
| `npm run atlas:personas` | Compile per-persona context packs (support/sales/qa/data/pm) into `.atlas-scaffold/personas/` for cheaper role-shaped Q&A. |
| `npm run atlas:release-notes` | Draft customer-facing release notes from CHANGELOG + business values into `.atlas-scaffold/release-notes.md` (human polishes). |
| `npm run atlas:migrate [-- --apply]` | Schema migration runner across all metadata (dry-run by default; idempotent transforms). Currently a no-op - atlas already conforms to schema 1.0; ready for future bumps. |
| `npm run atlas:eval` | Golden-case regression for `atlas:search` (asserts concept queries still resolve to the right screens). |

**Phase 5 items that need a runtime or human input (not buildable as a script):**
- Screenshots / visual-drift (needs the running Shopify app + a browser) - approach is documented; wire Playwright in CI when ready.
- Resolving the 28 OPEN-QUESTIONS (they are questions FOR the dev/PM - need answers, then `rewrite`).
- Lifting feature coverage past ~49% (each new screen needs code reading + dev confirmation per the hard rules; never auto-generate screen prose).

## Closeout: verify-api, explain-pr, MTTR, enriched PR comment

| Command | What |
|---|---|
| `npm run atlas:verify-api` | Cross-check documented action endpoints against the real Express routes under `server/backend/routes` (param-normalized). Flags documented endpoints with no matching route (stale docs) + counts undocumented routes. `--json`/`--strict`. |
| `npm run atlas:explain-pr -- --since=<ref>` | Translate a diff into product language: groups changed files by the screen they back and states that screen's purpose + business value (-> `.atlas-scaffold/pr-explain.md`). |
| `npm run atlas:mttr` | Track documentation-drift incidents over time in `.atlas-drift-log.json` (opens an incident when a screen drifts, closes it when re-verified) and report MTTR + open incidents vs tier SLA. `--dry` to preview. |
| PR comment (`atlas-impact-pr.yml`) | Now also shows how many affected screens are unverified, plus PR-head atlas health: potentially-stale count, API contract mismatches, and the quality scorecard. |

## Exclusions (excluded:true)

A screen whose feature was removed from the app but whose folder can't be deleted (or is kept as a tombstone) is marked `"excluded": true` in its metadata.json, listed in EXCLUSIONS.md, and given a tombstone README. The report scripts (`atlas:compile`, `atlas:coverage`, `atlas:quality`, `atlas:mttr`) skip `excluded:true` screens so removed features don't count as drift/unverified or appear in atlas.json.

## Runtime-dependent tools (built; run with your infra)

| Command | What | Needs |
|---|---|---|
| `npm run atlas:screenshots -- --base=<admin-app-url> [--auth=.atlas-auth.json]` | Playwright capture of every route into `ui-snapshots/` + visual-drift diff vs previous run | running app + dev store + `npm i -D playwright pixelmatch pngjs` |
| `npm run atlas:embed` then `npm run atlas:search -- "<q>" --semantic` | Build embedding index (`atlas-embeddings.json`) + meaning-based search (auto-falls back to lexical if absent) | `OPENAI_API_KEY` |
| `npm run atlas:slack -- "<q>"` (CLI test) or `node …/slack-ask-the-atlas.mjs` (server) | Slack `/ask-atlas` handler; CLI mode answers from atlas.json without Slack | `npm i @slack/bolt` + `SLACK_BOT_TOKEN` + `SLACK_SIGNING_SECRET` + a host (supersedes the earlier `.draft.mjs`) |
