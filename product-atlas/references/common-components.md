# Common Components - Three Categories

Most apps have shared infrastructure components used across many screens. `COMMON-COMPONENTS.md` in the atlas folder lists them. This file is about HOW the skill treats those components when walking a route's code.

The previous version of this file had a blanket "never dive into a common component" rule. That was too rigid. Some "common" components are pure wrappers (skip internals); others carry real features (must dive in). This file replaces the blanket rule with three categories.

## The three categories

### Pure wrapper

Components that exist purely to enforce consistent UI plumbing. They have configuration, but no user-visible behavior of their own.

**Examples:** `CommonForm`, `CommonTable`, `AdminLayout`, `CommonSkeletonPage`, `NavigationMenu`, `CommonFilter`, generic modal wrappers (`BannerModal`, `CommonModal`).

**Rule:** Do NOT read the component's source. Do NOT document the wrapper. Use the documented summary from `COMMON-COMPONENTS.md`.

**BUT — and this is critical — the CONFIG passed to the wrapper IS the feature surface.**

When `<CommonForm formFields={...}>` is used, the `formFields` content (every field, label, default, options, validation) is part of the feature being documented. Not the form library; the form's content.

When `<CommonTable columns={...} rowsData={...} promotedBulkActions={...}>` is used, the columns config, the `rowsData` cell rendering (every link, button, badge inside row cells), and the bulk actions are part of the feature. Not the table mechanics; the table's content and actions.

When documenting a screen that uses a pure-wrapper common component:
- Skip the wrapper's source.
- Enumerate the config (per `references/feature-mapping.md` Step 4).
- Document the fields / columns / rows / actions as the screen's behavior.

### Feature carrier

Components that LIVE in the common-components folder but contain a coherent user-visible feature flow. They look like infrastructure but carry semantic feature surface.

**Examples (general patterns, not repo-specific):**

- Paywall content components that surface upgrade copy, plan comparisons, and CTAs.
- Booking widgets (Cal.com, Calendly embeds) that run a complete scheduling flow.
- Chat-trigger components that fire support automations.
- Multi-step purchase modals that handle the entire flow (form → validation → confirmation → callback).
- Onboarding step components that have their own forms and state.
- Notification/banner systems that present user-facing prompts with their own actions.

**Rule:** Dive in. Treat the component as a feature node in the FEATURE-MAP. Enumerate its own sub-features (forms, modals, paywalls, etc.).

The fact that the component lives in `<app>/CommonComponents/` (or equivalent) is a code-organization choice, not a documentation choice. Feature surface is feature surface.

### Ambiguous

Components where the category isn't clear from the import path or name. Could be either category.

**Rule:** Dive in to verify. Read enough of the component to decide:
- Is its job to enforce UI plumbing with no user-visible behavior? → Pure wrapper.
- Does it surface a user-visible flow with its own state / actions / decisions? → Feature carrier.

After deciding, record the decision in `OPEN-QUESTIONS.md` (or `ATLAS-RULES.md` for repo-specific categorizations) so it isn't re-litigated next session.

## What's NOT a common component

**Sibling components in feature folders are NOT common components.** Components imported from a sibling file in the SAME feature folder (e.g. `<app>/Pages/<X>/<sibling>.jsx`) are FEATURE code, not common code. The common-components rule does NOT apply to them.

Dive into siblings unconditionally. The COMMON-COMPONENTS.md skip rule applies ONLY to imports whose path matches the dev-supplied common-components folder (typically `<app>/CommonComponents/` or `<app>/components/common/` or equivalent).

If you're unsure whether a component is "common" or "sibling," check the import path:

| Import path | Category |
|---|---|
| `@/CommonComponents/X/Y.jsx` | Common (apply categories above) |
| `@/Pages/<screen>/sibling.jsx` | Sibling — dive in unconditionally |
| `./sibling.jsx` (relative, same folder) | Sibling — dive in unconditionally |
| `@/Utils/X.js` | Utility, not a component — skip unless it carries logic worth documenting |

## How to use COMMON-COMPONENTS.md during route walk

When reading a screen's code:

1. Identify all component imports.
2. For each import, check `COMMON-COMPONENTS.md`.
3. If listed AND categorized as **pure wrapper** → use the documented summary; do NOT read the component's source; DO enumerate the config props.
4. If listed AND categorized as **feature carrier** → dive in; document as a feature node.
5. If listed but the category is ambiguous → dive in to verify; update the category in `COMMON-COMPONENTS.md` (or `ATLAS-RULES.md`) after deciding.
6. If NOT listed AND path is in the feature folder → sibling component; dive in unconditionally.
7. If NOT listed AND path looks like a common-component folder → ask dev whether to add it to `COMMON-COMPONENTS.md`. Until then, dive in to be safe.

## Documenting a screen that uses common components

Document the SCREEN behavior, not the common component plumbing. Two examples:

**Bad (treating CommonForm internals as the feature):**

> "This screen uses CommonForm with a schema containing fields name, email, phone. CommonForm provides validation via the form library, submission via the fetch wrapper, error display via Toast..."

**Good (treating CommonForm as a black box, fields as the feature):**

> "You see a form with three fields: name, email, phone. After clicking Save, the values are stored and you return to the previous list."

**Bad (skipping a feature carrier because it lives in common-components):**

> "Click the Upgrade button. It opens a PremiumButton component (skipped per COMMON-COMPONENTS.md)."

**Good (diving in because PremiumButton with custom priceConfig is a feature carrier):**

> "Click the Upgrade button. A paywall appears with three plan options: Free, Tier-1-Yearly, Tier-1-Monthly. The plans show pricing, feature comparison, and a primary CTA that opens the pricing page."

## COMMON-COMPONENTS.md location and format

Lives at `product-atlas/COMMON-COMPONENTS.md`. Top-level, sibling to `OVERVIEW.md` and `EXCLUSIONS.md`.

Auto-load at the start of every Phase 1, Phase 2, and Phase 3 run, alongside `OVERVIEW.md` and `EXCLUSIONS.md`.

Per the dev-provided-only rule (preserved from previous version), Claude does NOT silently add components. Dev provides the list. Each entry should include category: `pure-wrapper`, `feature-carrier`, or note the category if ambiguous and to be verified.

See `assets/common-components-template.md` for the format.

## Adding new common components mid-build

User adds entries manually OR says "treat X as a common component" → Claude appends to `COMMON-COMPONENTS.md` with the dev-stated category.

When a new common component is added DURING Phase 1 or after:
1. Update `COMMON-COMPONENTS.md`.
2. Run validation: walk existing screens, check if any documented those internals. If yes, suggest Phase 2 rewrite of affected screens.

## When a "pure wrapper" turns out to be a feature carrier mid-walk

If during a walk you find a component you treated as a pure wrapper actually has user-visible flow (e.g. unexpected modal flow, unexpected paywall, unexpected state machine), STOP the walk. Re-categorize the component in `COMMON-COMPONENTS.md` (or note in `ATLAS-RULES.md`). Re-walk the affected routes that previously skipped it.

This costs time but produces correct documentation. The alternative (treating a feature carrier as a wrapper) silently loses user-visible features in the atlas.
