# Feature-First Reasoning (CORE INNOVATION)

The most important pattern in this skill. Replaces "fill template fields with answers" with "understand the feature, then write from understanding."

Note: this pattern operates on a **feature view** (a tab, modal, paywall, edit form, filter panel, etc.) - not on a route. The unit of documentation is a feature, not a screen. Build the feature map first (`references/feature-mapping.md`), then run this pattern per feature.

## Why this matters

Template-filling output:
> "The Products screen displays a list of all products. The auto-SEO toggle default is false. When toggle is ON, backend behavior is..."

Reads like assembled fields. Mechanical.

Feature-first reasoning output:
> "Products is where you spend most of your time once you're past 50 items in your catalog. The auto-SEO toggle exists so you don't have to remember to add meta titles to every new product. Most teams leave it off until volume forces the issue."

Reads like a human PM who understands the product wrote it.

The difference matters for ALL downstream use cases (support docs, sales scripts, dev onboarding, Q&A).

## The pattern (apply per feature view)

### Step 1: Read code for this feature

- Component code + handlers + imports for THIS feature view (tab body, modal content, paywall content, etc.)
- For pure-wrapper common components, use the documented summary AND enumerate the config props
- For feature-carrier common components, dive in (see `references/common-components.md`)
- For sibling components in `<app>/Pages/<screen>/`, dive in unconditionally - they are feature code, not common code
- Identify all controls, actions, states, events, integrations, i18n keys
- Note conditional rendering (role/plan/data gating)

### Step 2: Build internal understanding (silently)

Before saying anything to dev, construct your own understanding:

```
- What is this feature for? (1-2 sentences in your head)
- What job is the user doing here? (JTBD)
- What are the 3-5 most important controls/actions?
- What's the business value? (hypothesis)
- What state transitions happen? (empty → populated → error)
- What's the obvious edge case I'd worry about?
- What questions do I have that code can't answer?
```

This is the internal model. Do not skip this step. Bad reasoning = bad output.

### Step 3: State understanding to dev (hypothesis-confirm)

Present your model in plain language. Ask dev to correct.

Format:
```
Feature: <route>/<feature-slug>
Tier: <Critical / Important / Standard>

Here's what I think this feature does:
<2-3 sentences>

Users come here to:
<JTBD in 1 sentence>

The main things they can do:
- <action 1>
- <action 2>
- <action 3>

Controls I found:
- <control 1>: <my interpretation of what it does>
- <control 2>: <my interpretation>

Business value (hypothesis):
<1-2 sentences>

Read and correct anywhere I'm wrong. Point out missing things.
```

### Step 4: Dev confirms or corrects

Dev responds with corrections. Common corrections:
- "Wrong default - it's OFF not ON"
- "You missed action X"
- "Business value is actually more about Y than Z"
- "Control X effect is wrong - it does this instead"

Take corrections at face value. Don't argue. Update internal model.

If dev's correction is unclear, ask one follow-up. Don't make dev repeat themselves.

### Step 5: Capture edge cases (if Critical or Important tier)

Only for Critical and Important features. See `references/edge-cases.md` for the structured capture.

Brief example:
```
For this Critical feature, please confirm edge cases:

Scale: behaves OK at 100 records, 1K, 10K? Any pagination kicks in?
Concurrent: two users editing same record at same time - what happens?
Network: offline behavior, slow connection feedback?
Errors: rate limit, timeout, third-party down - what user sees?
Accessibility: keyboard nav, screen reader announcements?
i18n: any hardcoded strings, RTL support, date format issues?

Reply yes / no / known-issue / not-applicable to each.
```

### Step 6: Write README + metadata FROM validated understanding

Now (and only now) write the documentation. Two parts:

**README.md** - Prose written from your now-validated understanding. Read `references/screen-readme-format.md` for structure. Read `references/writing-rules.md` for style.

The prose should read like you're explaining this feature to a smart friend over coffee. Use the dev's confirmed details. Don't fall back to template-speak.

**metadata.json** - Structured data following `references/metadata-schema.md`. Fill from your validated model, not by re-reading code.

### Step 7: Update CHANGELOG.md + STATUS.md

After write, log to CHANGELOG.md and update STATUS.md. See `references/changelog-format.md` and `references/status-file.md`.

## Tier-adjusted depth

| Tier | Step 1 depth | Step 2 depth | Step 3 detail | Step 5 edge cases | Step 6 prose |
|---|---|---|---|---|---|
| Critical | Full code trace | Detailed model | Full hypothesis | Full enumeration | Long-form, rich |
| Important | Full code trace | Detailed model | Full hypothesis | Key edge cases | Medium prose |
| Standard | Skim code | Brief model | Brief hypothesis | Basic only | Short prose |
| Skip | None | None | None | None | Not documented |

## Anti-patterns to avoid

**Don't skip the internal understanding step.** Writing without an internal model produces template-filling output.

**Don't ask dev to fill fields directly.** Ask them to validate your understanding instead. "Here's what I think" > "What is the business value?"

**Don't argue with dev corrections.** Dev knows the product. Take corrections, update model.

**Don't write prose from raw answers.** Write from the synthesized understanding. The understanding is what the dev approved, the answers were inputs to it.

**Don't repeat questions across screens.** If dev already explained how a pattern works (e.g., role gating), apply the answer to all screens that match. Don't re-ask.

**Don't dive into PURE-WRAPPER common components.** Use the documented summary. BUT: enumerate the CONFIG passed to them (formFields, columns, rowsData, promotedBulkActions) - the config IS the feature surface. See `references/common-components.md`.

**DO dive into FEATURE-CARRIER common components.** Paywall content, booking widgets, multi-step purchase modals, chat triggers - even if they live in a common-components folder, they carry feature surface. Document as features.

**DO dive into sibling components in the feature folder.** Components in `<app>/Pages/<screen>/<sibling>.jsx` are feature code, not common code. The common-component skip rule does NOT apply to them.

## How this pattern fits Phases 1, 2, 3

- **`continue atlas` / `document <screen>`**: Run this pattern per screen, depth per tier
- **`rewrite feature <name>`**: Run this pattern on the changed feature's screen(s). Compare new understanding to old metadata to detect what changed.
- **`rewrite route <slug>`**: Run this pattern per screen in the route. Detect added/removed/modified.

## Why this gives 100% accuracy

- Step 2 forces explicit thinking (catches misunderstandings)
- Step 3 surfaces understanding before writing (dev catches errors early)
- Step 4 is dev-authoritative (their corrections override your inferences)
- Step 5 captures gaps that templates miss (edge cases)
- Step 6 writes from validated state, not raw inputs

Combined with multi-pass refinement (`references/multi-pass-refinement.md`) and final quality review (`references/quality-review.md`), this delivers production-grade documentation.
