# Feature Mapping

The most important shift in v1.0+ of this skill: **one feature view = one folder = one README.** Not one route = one screen.

A route can contain many feature views (tabs, modals, paywalls, edit-views, filter panels, confirmation flows, wizard steps). Each feature view that's distinct from its parent gets its own documentation node. Conversely, an edit/detail view implemented as a separate route folds INTO its parent feature, because the URL split is an implementation detail.

This file describes HOW to identify and map feature views per route. Output is `screens/<route>/FEATURE-MAP.md`.

## When to run

- **Phase A of `continue atlas` / `document <screen>`.** Before any per-feature documentation, build the feature map for the route. Get dev confirmation. Then proceed to per-feature work.
- **`rewrite route <slug>`.** Re-walk the route to detect added/removed/modified features. Diff old map vs new.
- **Quality review.** Validate that the map matches actual UI.

Feature mapping is mandatory for Critical and Important tier routes. Standard tier routes can use a lighter map (just enumerate, skip recursion past atomic).

## Output

`screens/<route>/FEATURE-MAP.md`. Template at `assets/feature-map-template.md`.

The map is the source of truth. Per-feature READMEs are derived from it.

## The algorithm

### Step 1: Read the route component end-to-end

Read the file referenced by the matching `<Route>` in the app's router. Enumerate every:

- **State slot** (`useState`, `useRef`, `useReducer`) — each state often gates a sub-surface (modal open/close, draft mode, paywall flag, filter open/close).
- **Handler** (each onClick, onSubmit, callback) — each handler is a user action.
- **Conditional render** on user/plan/feature flags — record as a paywall variant or empty-state feature.
- **`<Tabs>` instance** — enumerate the tabs array AND the switch/case body AND any nested `subTabs` / `disclosureText` / `secondaryTab` config.
- **`<Modal>`, drawer, sheet, popup** rendered inside the component (often at the bottom of the JSX tree — easy to miss).
- **Component imported from a sibling file** in the SAME feature folder (e.g. `app/Pages/<X>/`). Sibling components are FEATURE code, not common code. Dive in. See `references/common-components.md` for the boundary.

### Step 2: Recurse into siblings

For each sibling component imported in Step 1, repeat Step 1. The recursion depth is unbounded in principle; in practice it caps at 3-5 levels for most feature-rich screens.

The skill's `COMMON-COMPONENTS.md` skip rule applies ONLY to imports whose path matches the dev-supplied common-components folder (typically `<app>/CommonComponents/` or equivalent). Even then, the COMPONENT's source is skipped but its CONFIG (props passed to it) is part of the feature surface — see Step 4.

### Step 3: Apply the atomic stop check

A feature view is **atomic** (no further recursion needed; documents inline in parent) when ALL of these are true:

1. No tabs inside it.
2. No nested modals with their own forms.
3. Two or fewer distinct user actions.
4. No conditional sub-surfaces (e.g. "if user picks X, show this whole other panel").
5. No paywall variants.
6. No background AI/job flow with its own status surface.

If any one of these is false → split into a separate feature node and recurse.

If the inner content is **pure chrome** (loading skeleton, generic error toast, navigation header) or **purely informational** (static help text, FAQ section content) → roll into parent, no separate node.

### Step 4: Apply the common-component dive-in rule

Common components have three categories (per `references/common-components.md`):

- **Pure wrapper** (CommonForm, CommonTable, layout wrappers) → skip internals. BUT enumerate the CONFIG passed in (`formFields`, `columns`, `rowsData`, `promotedBulkActions`, `customizeComponent`, `headings`, etc.). The config IS the feature surface.
- **Feature carrier** (paywall content components, modal flows, booking widgets, chat-trigger components) → dive in. Document as a feature even though the component lives in the common-components folder.
- **Ambiguous** → dive in to verify, then categorize. Record the decision in `OPEN-QUESTIONS.md` so it isn't re-litigated.

### Step 5: Apply the edit/detail folding rule

When a feature has an **edit, detail, or single-item view implemented as a SEPARATE route**, the edit view folds INTO the parent feature. It is NOT a separate FEATURE-MAP file, and NOT a separate `SURFACE-MAP.md` row.

**Rationale:**
- Developer mental model: "this is the edit screen for the list" — one feature.
- User mental model: "I'm editing an item" — one task, regardless of URL change.
- The URL split is a code-organization choice (route boundary), not a documentation boundary.

**Apply:**
1. At the parent feature's row in the FEATURE-MAP tree, add a sub-node for the edit/detail view (e.g. `<parent>.X row-editor`).
2. Inside that sub-node, enumerate the edit view's own sub-features by recursing Steps 1-4.
3. Note on the sub-node: `(opens as separate route /path/to/edit-view)` so future devs see the URL wiring.
4. Do NOT create a separate FEATURE-MAP.md for the edit route. Do NOT create a separate row in SURFACE-MAP.md.

**Per-parent variation:** if the same edit component is reachable from multiple parents and renders DIFFERENTLY per parent (different tabs available, different gating, different content), fold into EACH parent with the parent-specific variant captured. Acceptable duplication because the per-parent differences are real and dev/user care about them.

If the same edit component renders IDENTICALLY across parents, fold into the most-trafficked parent only; reference from siblings via `(see <other-parent>.X.Y)`.

### Step 6: Record navigation as relationship

For every `navigate("/...")` / `<Link>` / `<Button onClick={navigate}>` discovered in the walk, record it as a feature-to-feature relationship in the map. If the destination route exists in `SURFACE-MAP.md` separately (not folded by Step 5), the relationship is a link, not a containment.

### Step 7: Sanity-count check

After Step 6, count feature nodes inside this route. Apply these heuristics:

- Routes with a list table (CommonTable / similar) → expect ≥ 3 feature nodes (table, bulk actions, at least one modal or sub-surface)
- Routes with paywall variants → expect ≥ 2 nodes per variant (paywall feature + the gated feature it replaces)
- Routes with `<Tabs>` → expect ≥ 1 + (tab count) feature nodes
- Routes with edit/detail destinations → expect the edit sub-tree to add 5+ nodes per parent variant

If your count falls below these thresholds, you probably missed something. Re-walk Step 1.

### Step 8: Save FEATURE-MAP.md

Write the tree to `screens/<route>/FEATURE-MAP.md`. Required sections:

1. **Header** with route, source commit, generated date
2. **Tree** in monospace with depth-indenting (use the template at `assets/feature-map-template.md`)
3. **Per-node reasons** (one paragraph each explaining why the node is its own feature)
4. **Variation matrix** (if edit/detail folding applied per-parent)
5. **Sanity-count check** (show the counts and verify against thresholds)
6. **Open questions** (anything UNKNOWN/LOW-confidence to verify during per-feature docs)
7. **Folder layout to create** (the directory tree under `screens/<route>/`)

### Step 9: Confirm with dev BEFORE writing per-feature READMEs

Present the tree summary to the dev. Get confirmation that:
- The tree captures everything they'd consider a feature
- Tier suggestions per node are right (or note overrides)
- No edit/detail destinations got missed
- No "common component" was wrongly skipped

Apply corrections. Then proceed to per-feature documentation via `references/feature-first-reasoning.md`.

## Common signals to enumerate (general)

These signals appear in most React + Polaris (or similar UI library) apps. Repo-specific signal lists belong in `ATLAS-RULES.md`.

| Signal | What it usually means |
|---|---|
| `useState` for a modal-open flag | A modal feature node |
| `useState` for a draft / unsaved-changes flag | A save-bar or leave-confirmation interaction |
| `useState` for filter-panel open/close | A filter panel feature (often atomic, depends on filter count) |
| Conditional render based on `featureData.X` or plan check | A paywall variant feature; the unlocked surface AND the locked surface are both features |
| Component imported from sibling folder | Feature code; dive in |
| Component imported from common-components folder | Pure wrapper unless its name suggests carrying a flow (Modal, Wizard, Booking, Chat); dive in if so |
| `useNavigate` / `setNavigate` call | Navigation relationship; may trigger edit/detail folding |
| Polaris `<Tabs tabs={...} />` | Multi-tab feature; enumerate every tab |
| Polaris `<Modal>` / `<Drawer>` / `<Banner>` | Each is its own feature node |
| Form library schema config (e.g. `formFields={...}`) | Field enumeration is the feature surface |
| Table library config (e.g. `rowsData={...}`, `promotedBulkActions={...}`) | Row-cell content AND bulk actions are the feature surface |

## What feature mapping is NOT

- **Not a code review.** Don't comment on code quality, refactor opportunities, or stylistic issues. The feature map describes WHAT the user sees, not HOW the dev wrote it.
- **Not a flat checklist.** It's a TREE. Parent-child structure preserves the navigation reality.
- **Not exhaustive of code paths.** It captures user-facing surfaces. Internal helper functions, formatters, validators — skipped.
- **Not per-tier work.** Even Standard-tier routes get a feature map; the difference is depth of per-feature documentation later, not depth of the map itself.

## Anti-patterns

- **"One README per route."** This is the old worldview. Replace it.
- **"Tabs documented as section headers inside one README."** They should be separate feature nodes. Each has its own README.
- **"Modal mentioned in prose, no folder."** If the modal has its own form/state, it's a feature node.
- **"Common component, so I skipped it."** Skipping pure wrappers is fine. Skipping feature carriers because they happen to live in a common-components folder is the bug.
- **"Edit view is a separate route, so I documented it separately."** No. Fold into the parent.
- **"Per-parent variation seems redundant, so I used one shared map."** When the variations are real (different tabs, different gating, different content), one shared map hides the real differences. Use per-parent.

## Why feature-first

Documentation built per-route produces flat output. A tab-rich screen's README turns into nine paragraphs and the per-tab features get buried. Quality review can't tell whether each tab was actually documented or just mentioned. Sales scripts derived from such docs miss feature-level depth.

Feature-first output produces deep, navigable trees. Each feature has its own dedicated README with the full 12-section structure. Quality review can validate each feature independently. Sales scripts, support docs, dev onboarding, and Q&A all benefit from feature-level granularity.

The cost is more folders. The benefit is documentation that matches the way devs and users actually think about the app.
