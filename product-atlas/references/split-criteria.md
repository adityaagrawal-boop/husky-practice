# Split Criteria - Single File vs Sub-folder vs Folded-into-Parent

When walking a route's code, you'll encounter many UI surfaces (tabs, modals, buttons, edit views, paywalls, filter panels). This file decides whether each one becomes a separate documentation folder, gets folded inline into its parent, or gets folded INTO another route's parent feature.

See `references/feature-mapping.md` for the full mapping algorithm. This file is the decision rules used inside that algorithm.

## The three outcomes

| Outcome | What happens | When to apply |
|---|---|---|
| **Inline in parent** | Mentioned in parent's `What you can do from here` section. No own folder. | Atomic surface (rule below). |
| **Own folder** | Becomes `screens/<route>/<feature-slug>/README.md` + `metadata.json`. | Non-atomic surface inside this route. |
| **Folded into parent feature** | Documented as a sub-node inside a feature of a DIFFERENT route. No own FEATURE-MAP. No SURFACE-MAP row. | Edit/detail views accessed from a parent feature (see rule below). |

## Atomic stop check (when to inline)

A feature view is **atomic** (inline in parent only; no separate folder) when ALL of these are true:

1. No tabs inside it.
2. No nested modals with their own forms.
3. Two or fewer distinct user actions.
4. No conditional sub-surfaces (e.g. "if user picks X, show this whole other panel").
5. No paywall variants.
6. No background AI/job flow with its own status surface.

Examples that ARE atomic (inline):
- A "Save" button that just persists state
- A "Delete" button with a single confirmation dialog and one destructive action
- A single dropdown that filters the current view
- A "Refresh" button
- A static help link in the footer

Examples that are NOT atomic (own folder):
- A "Bulk Edit" button that opens a drawer with multiple fields and a multi-step flow
- A "Settings" link that opens a sub-page
- A modal with its own form, validation, and state machine
- A paywall variant that replaces the main UI when locked
- A wizard with multiple steps

## Folder slug rules

When creating a folder for a non-atomic feature:

- Use the actual UI label, lowercase, hyphenated.
- Examples: `product-editor`, `bulk-seo-scan`, `pricing-plans`, `ai-content-generator`, `csv-import-modal`, `home-page-paywall`.
- Slug should make sense when reading the tree alone.
- Avoid generic slugs like `popup-1` or `drawer-a`.
- For paywall variants, suffix with `-paywall` (e.g. `home-page-paywall`) so the sibling unlocked feature is visually distinct.
- For modals, suffix with `-modal` when the surface is unambiguously a popup.
- For confirmation flows, suffix with `-confirm`.

## Edit/detail routes belong with their parent feature

When a feature has an **edit, detail, or single-item view implemented as a SEPARATE route**, the edit view folds INTO the parent feature. No separate FEATURE-MAP. No separate SURFACE-MAP row.

### Rationale

- **Developer mental model:** "this is the edit screen for the products list" — one feature with multiple steps.
- **User mental model:** "I'm editing an item" — one task, regardless of URL change.
- **The URL split is an implementation detail** (route boundary), not a documentation boundary.
- **Single source of truth:** one FEATURE-MAP per logical feature, not per route.

### How to apply

1. At the parent feature's row in the FEATURE-MAP tree, add a sub-node for the edit/detail view (e.g. `<parent>.X row-editor`).
2. Inside that sub-node, enumerate the edit view's own sub-features by recursing the feature-mapping algorithm.
3. Add a note on the sub-node: `(opens as separate route /<path>)` so future devs see the URL wiring.
4. Do NOT create a separate FEATURE-MAP.md for the edit route.
5. Do NOT create a separate row in SURFACE-MAP.md for the edit route.

### Per-parent variation rule

If the same edit component is reachable from multiple parents and renders DIFFERENTLY per parent (different tabs available, different gating, different content), fold into EACH parent with the parent-specific variant captured. Acceptable duplication because the per-parent differences are real and dev/user care about them.

If the same edit component renders IDENTICALLY across parents, fold into the most-trafficked parent only; reference from siblings via `(see <other-parent>.X.Y)`.

### Folder layout under this rule

```
screens/<list-route>/
├── README.md, FEATURE-MAP.md, metadata.json
└── <parent-feature-slug>/
    ├── README.md, metadata.json
    └── row-editor/                    ← edit view folded in
        ├── README.md
        ├── <editor-sub-feature-1>/
        ├── <editor-sub-feature-2>/
        └── ...
```

If per-parent variation applies:

```
screens/<list-route>/
├── parent-feature-A/
│   └── row-editor/                    ← variant A
│       ├── tab-X/
│       ├── tab-Y/
│       └── ...
└── parent-feature-B/
    └── row-editor/                    ← variant B (different tabs)
        ├── tab-X/
        ├── tab-Z/
        └── ...
```

### When NOT to fold

A separate route does NOT fold into a parent when:

- The destination is reached from MANY unrelated parents (it's a shared utility, not an edit of any single feature). Example: a global settings page reached from a sidebar nav.
- The destination has its own independent purpose, not "editing the parent's data." Example: a sibling list route, even if linked from another list.
- The destination represents a different domain entity. Example: from products list, a link to a customer list — these are siblings, not parent-child.

Use judgment. The fold rule is for cases where the destination is unambiguously "the edit/detail/single view of this list/feature."

## How tabs split

A `<Tabs>` instance always creates one feature node per tab AT MINIMUM. Each tab is a distinct working surface unless it's pure chrome (e.g. a single help-text tab with no inputs — rare).

Sub-tabs (`secondaryTab`, `subTabs`) follow the same rule: each sub-tab is a feature node nested under its parent tab.

## How modals split

A modal with its own form, validation, and state machine → its own feature folder.

A modal that is JUST a confirmation dialog with one destructive button and one cancel button → atomic, inline in parent.

A modal that opens further modals (modal-inside-modal) → each level is a feature node.

## How paywall variants split

When a feature has a `<PremiumButton>` (or equivalent) that REPLACES the main UI when locked, the locked surface is its own feature node (suffix `-paywall`). The unlocked feature and the paywall are siblings, often switched by a single `featureData.X` flag.

When a `<PremiumButton>` is just a small CTA inside a feature (e.g. "Unlock for $X" badge on a button), it's inline in the parent. No separate folder.

## When in doubt

Default to **own folder** rather than **inline**. Over-documentation is recoverable (consolidate later); under-documentation requires re-walking the route and is more expensive.

When the dev disagrees with a split decision, take the correction. The dev's mental model of "what's a feature" is authoritative.
