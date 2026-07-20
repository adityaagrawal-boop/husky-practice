# Writing Rules (Non-Negotiable)

These rules apply to all prose in `product-atlas/`. Different rules for `metadata.json` (technical terms allowed) and `INTEGRATIONS.md` (technical terms allowed when describing services).

## Voice and perspective

1. **Natural human language.** Write like explaining to a smart friend over coffee.
2. **User perspective always.** "You click..." "You see..." "This shows you..." NOT "The user clicks" or "It renders."
3. **No length limit.** Write as much as needed. Completeness wins.

## Vocabulary

4. **Zero technical terms in README prose.** Specifically banned in README.md files:
   - "API" → say what the API does ("connects to Shopify")
   - "component" → describe the thing on screen ("this card", "this button")
   - "controller", "schema", "GraphQL", "props", "state", "hook", "endpoint", "render" - all banned
   - "modal" → say "popup window"
   - "route" → say "page"
   - "JSON" → describe the data shape in words

   Technical terms ALLOWED in:
   - `metadata.json` (it's structured data, terms expected)
   - `INTEGRATIONS.md` (service descriptions can use API/endpoint/auth)

5. **No em dashes anywhere.** Use hyphens, colons, or sentence breaks. User preference.

6. **No emojis unless dev explicitly approves.** Default is no emojis.

## Content completeness

7. **Every option documented.** If a dropdown has 8 values, list all 8. If a form has 5 fields, list all 5. No "etc." No "and more."

8. **Every interactive element documented.** Every toggle, slider, checkbox, dropdown, segmented button, filter chip, pagination control, header action, row-action icon (pencil / copy / trash / eye / drag handle), inline edit pencil, popover trigger, and `onClick`-bearing div gets its own entry in "Controls on this screen" or its own subsection under "What you can do from here" explaining what it controls, what each state does, what happens on click/check/uncheck/change, and how it affects the business.

9. **UI traces for every action.** Click path documented completely: button → what opens → every option listed → API call (if any) → toast/error/redirect → table refresh behavior. No gaps. State the **default value**, the **value after the change**, **what the user sees** (toast text, badge change, panel slide-in), and **what changes server-side** if anything.

10. **Behind-the-scenes logic in plain language.** For every control, explain what it actually changes in business terms.

    Bad: "Enables auto-scan."

    Good: "When you turn this on, the app will automatically scan all your products every night at midnight and fix any SEO issues it finds. You don't need to do anything manually."

### 10a. MANDATORY pre-write enumeration step

**Before writing the README for any screen**, open the source file(s) listed in `screen.code_files` and produce a working list of every interactive UI element by grepping the JSX. **Do not skip this step**: gaps have been caught by reviewers when the writer described only the "obvious" controls and missed segmented buttons, filter chips, pagination, or icon-only row actions that had no plain-text labels.

The component names below (`<ButtonGroup variant="segmented">`, Polaris `<Page>`, etc.) are examples from a Shopify Polaris + React codebase, this skill's original target app. Grep for the equivalent patterns in whatever UI framework the target repo actually uses (Material UI, Ant Design, a custom design system, plain HTML), the categories (segmented controls, icon-only actions, popover triggers, `onClick` divs) apply universally even when the exact component names don't.

The enumeration list must include, at minimum:

- Every `<Button>`, `<Button variant="…">`, `<Button icon={…}>`, including icon-only buttons with no visible text label
- Every `<ButtonGroup variant="segmented">` AND each child button inside (these are filter chips / segmented controls)
- Every `pressed={…}` button (segmented control members)
- Every `<Checkbox>`, `<RadioButton>`, `<RadioGroup>`, `<Switch>`, `<Select>`, `<TextField>`, `<TextField multiline>`, `<RangeSlider>`, `<ChoiceList>`
- Every popover / modal trigger (`<Popover>`, `<Modal>`, custom trigger props)
- Every pagination control (chevrons + page-size selector) — inherited from CommonTable but still documented per-screen with a back-reference to COMMON-COMPONENTS.md
- Every row-action icon (pencil = edit, copy = duplicate, trash = delete, eye = preview, drag-handle = reorder, etc.) — list each by what it does, not by its icon glyph
- Every clickable chip / badge / tag / pill (even if it looks decorative — confirm by checking for `onClick`)
- Every header `primaryAction` / `secondaryActions[]` on Polaris `<Page>` wrappers
- Every `onClick` handler on a `<div>` or `<span>` (these are often missed because they do not look like buttons)
- Every visible text link that triggers navigation

If a control is inside a conditionally-rendered branch (e.g. `{isAdmin && <Button>…</Button>}`), document the condition in the entry.

After enumeration, every item must map 1:1 to either:
- An entry in "Controls on this screen", **OR**
- A subsection in "What you can do from here", **OR**
- An explicit "Atomics inlined" note in the FEATURE-MAP per `references/split-criteria.md`

If any enumerated element is not documented, the README is incomplete. Do not move on. The same enumeration step applies when documenting a refactor — diff the old and new source files to catch removed controls and added controls.

### 10b. Decorative-vs-interactive disambiguation

A chip / badge / pill that is purely visual (e.g. a "🎁 Product Bundle Discounts" section header) still gets one line in "What you see here" so the reader knows it is there and is decorative. The rule is: **if it is visible on screen, it is documented.** Interactive elements get full treatment; decorative elements get a one-liner.

### 10c. Inherited-from-CommonComponents controls

Tables, forms, and other surfaces that compose `CommonTable` / `CommonForm` inherit pagination, sort, and validation controls. Per-screen rule:

- **Always mention these inherited controls exist** in "What you see here" (e.g. "Below the table there is a pagination row showing X-Y of Z results...")
- **Always list them in "Controls on this screen"** with a back-reference to `COMMON-COMPONENTS.md` for the shared defaults
- **Do not re-explain the full mechanics** in every screen — the per-table mechanics belong in `COMMON-COMPONENTS.md` once

Saying "pagination is handled by CommonTable, see common components" without a per-screen mention is **not acceptable** — the user interacts with these controls on every list page, so they must appear in the per-screen docs even when behavior is shared.

### 10d. Technical flow diagrams stay out of the README

For actions with genuinely non-trivial logic (branching, async chains, retries, multi-system effects), the code-level walkthrough belongs in a separate `TECHNICAL-FLOW.md` sibling file, never in the README body, per `references/technical-flow-diagrams.md`. The README's "What this changes behind the scenes" stays plain-language for every reader, rule 6 still applies there without exception. Do not add Mermaid diagrams, code identifiers, or sequence-diagram-style prose to the README to compensate for a missing TECHNICAL-FLOW.md, write the companion file instead.

## Business framing

11. **Business value at every level.** Every screen, every action, every option explains how it helps the user's business. "How this helps your business" is required at every README.

12. **Real examples.** Concrete ("editing your 'Blue Summer Dress' product title" for an e-commerce app, or "moving the 'Q4 Planning' project to Archive" for a project management app) not abstract ("editing a field").

13. **Recommendations matter.** When documenting a control, include when a user should set it which way and why.

14. **Use dev's domain vocabulary.** Read ATLAS-RULES.md for vocabulary overrides. Use those terms throughout. Don't fall back to skill's universal defaults if dev specified domain terms. See `references/universal-vocabulary.md`.

## Structure

14. **Consistent format.** Every screen README follows `references/screen-readme-format.md`. Same sections, same order.

15. **Self-contained.** Inside `product-atlas/`, never reference files outside the folder. Only relative links within.

16. **States are mandatory.** Empty, loading, error states all documented per screen (when applicable).

## What to NOT document

- Generic starter-kit infrastructure that exists in every app (common form components, generic auth, generic billing redirect)
- Developer tools, build process, deployment
- Background processes the user never sees
- Code-level errors that don't surface to the user

Test: "Would every app built on this starter kit have this exact same feature?" YES → skip. NO → document.

**Exception:** If a shared feature has custom UI or logic specific to THIS app, document only what's unique to THIS app.

## Forbidden phrasings

- "Click here" → name the actual button: "Click 'Bulk Edit'"
- "Etc." or "and more" → list everything
- "TBD" or placeholder content → if writing it, write it complete
- "The user" or "Users will" → use "you"
- "Simply" or "just" → cut these words, they're filler
- "Powerful", "robust", "seamless" - marketing fluff, cut
