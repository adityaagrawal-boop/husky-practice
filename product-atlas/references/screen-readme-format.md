# Per-Feature README.md Format

Every **feature** folder contains a `README.md` following this format. This applies at any nesting depth - route-level hubs, per-tab features, per-modal features, per-paywall variants, folded edit sub-trees. The 12 required sections are the same regardless of where the feature sits in the tree.

Template available at `assets/screen-readme-template.md`.

Atomic sub-features (per `references/split-criteria.md`) are documented inline in their parent feature's README, not in their own file. The atomic stop check decides which surfaces get their own README.

If this feature has an action with genuinely non-trivial logic (branching, async chains, retries, multi-system effects), that gets a separate, optional `TECHNICAL-FLOW.md` sibling file, developer-only, never part of the 12 sections below. See `references/technical-flow-diagrams.md`.

## Required sections in order

1. **Title** - screen/section title as H1
2. **Parent breadcrumb** - link to parent screen (skip for root screens/README.md only)
3. **What is this?** - 1-2 sentences
4. **How this helps your business** - 3-6 sentences of business value
5. **What you see here** - top-to-bottom UI description
6. **What you can do from here** - every action with full UI trace
7. **Controls on this screen** - every toggle/slider/dropdown/checkbox
8. **States** - empty, loading, error states
9. **Who sees this** - roles, plans, conditions
10. **Where you can go from here** - navigation table
11. **How this connects to other parts of the app** - cross-screen relationships
12. **Common questions about this screen** - Q&A pairs

## Section-by-section content

### What is this?
1-2 sentences. What is this screen/section? What can the user accomplish here?

### How this helps your business
3-6 sentences. Why this screen matters. What business problem does it solve? How does it help the business make more money, save time, or serve customers better? What would they have to do without this?

### What you see here
Describe top-to-bottom as the user sees it:
- Title/heading at top
- Status indicators, badges, summary info
- Cards, sections, content blocks in order
- Buttons visible and where they are
- Tabs if any (list all tab names)
- Tables/lists if any (what columns/data they show)
- What it looks like when empty vs with data

### What you can do from here
For each action, action gets its own subsection with:
- **What this does** (1-2 sentences)
- **Why you'd use this** (business reason)
- **When you click this** (numbered list with every option/field/dropdown value listed)
- **What this changes behind the scenes** (plain language backend behavior)
- **Business value** (specific improvement to the store)
- → link to sub-folder if action opens something complex

Every dropdown's options listed individually. Every checkbox/toggle in the opened flow listed.

### Controls on this screen
Every toggle, slider, switch, checkbox, dropdown that lives directly on this screen. Each control gets:

For **toggles/switches**:
- **What it controls** (plain language)
- **When ON** (what the app does differently)
- **When OFF** (what happens instead)
- **Default** (ON or OFF)
- **Recommendation** (when to turn this on/off and why)

For **sliders**:
- **What it controls**
- **Low end ([min])** (what happens, when you'd want this)
- **High end ([max])** (what happens, when you'd want this)
- **Sweet spot** (recommended range and why)
- **Default** (starting value)
- **Example** (concrete: "If you set this to 70%...")

For **dropdowns**:
- **What it controls**
- **Options** (every option listed with what it does, business impact, when to choose)
- **Default** (initial selection)
- **Recommendation** (which option works best for which store type)

For **checkboxes**:
- **What it controls**
- **When checked** (app behavior, business impact)
- **When unchecked** (app behavior, business impact)
- **Default**

### States
- **Empty state** - what you see when there's no data, the copy, the CTA
- **Loading state** - what you see while data loads
- **Error states** - what can go wrong, what message the user sees, what they should do

### Who sees this
- **Roles** - list of user roles with access
- **Plans** - list of plans that unlock this, or "all plans"
- **Conditions** - any data-state or feature-flag conditions

### Where you can go from here
Markdown table:

| Destination | What's there | Go to |
|---|---|---|
| [Screen name] | [What user will find] | [→](./sub-folder/README.md) |

### How this connects to other parts of the app
Bulleted list of semantic connections (not just navigation):
- **[Other screen]** - how they relate, what data connects them, why using both together is valuable

### Common questions about this screen
2-5 Q&A pairs. Questions a user or support agent would ask about this specific screen.

## Format rules

- Use the H1 for screen title only. H2 for top-level sections. H3 for sub-sections.
- No em dashes anywhere. Use hyphens, colons, or sentence breaks.
- No emojis unless dev explicitly approves.
- No technical terms in body prose. Full list in `references/writing-rules.md`.
- Every dropdown's full option list, no "etc."
- Plain language for all backend effects.

## Pre-write interactive-element checklist (REQUIRED)

Before writing any screen README, open the source code file(s) and produce an enumeration of every interactive UI element. This catches gaps that are otherwise easy to miss (filter chips, segmented buttons, icon-only row actions, pagination controls).

For each item enumerated, write down in scratch:
1. **What is the control?** (button label / icon meaning / field name)
2. **What is the default state?**
3. **What value(s) can it take?** (for selects/segmented: list every option)
4. **What happens on click / check / uncheck / change?** (client-side state, API call, toast, redirect, table refresh)
5. **Is anything disabled when this changes?** (cross-control constraints)
6. **Is anything persisted?** (localStorage, sessionStorage, server, URL params)

Look explicitly for these often-missed categories:

| Category | What to grep for in the source | Often missed because |
|---|---|---|
| Segmented buttons / filter chips | `<ButtonGroup variant="segmented">`, `pressed={…}` | Look like decoration; behavior tied to React state, not a labeled toggle |
| Icon-only row actions | `<Button icon={…}>` inside table row | No text label; described as "the pencil icon" instead of "Edit" |
| Pagination | inherited from `CommonTable` | Skipped because it's "framework" — but it IS a user-facing control |
| Section chips / decorative headers | hand-styled `<span>` blocks | Visual only — still get a one-liner in "What you see here" |
| Conditionally-rendered controls | `{isAdmin && …}`, `{plan === "premium" && …}` | Writer only saw the user view, missed admin/plan variants |
| Drag handles | `cursor: grab`, `react-beautiful-dnd` | Appears only in a specific mode (e.g. Manage Priority) |
| Popover triggers | `<Popover>`, `<ActionList>` | Trigger looks like a normal button until clicked |
| `onClick` on divs/spans | `onClick={…}` outside `<Button>` | Hand-rolled buttons that don't look like buttons |
| Inline edit pencils | small icon near a label | Reads as decoration; actually opens an inline editor |

After enumeration, every item must end up in either:
- A subsection of **"What you can do from here"** (for actions / clicks)
- An entry in **"Controls on this screen"** (for toggles / selectors / inputs / pagination)
- A one-line mention in **"What you see here"** (for decorative elements)

If any enumerated element does not appear in the README, the README is incomplete. Do not stop until every interactive element has full click/check/uncheck/change semantics documented.

For inherited-from-CommonComponents controls (pagination, sort, validation), document them per-screen with a back-link to `COMMON-COMPONENTS.md` for shared defaults. See `references/writing-rules.md` rule 10c.
