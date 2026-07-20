<!--
PRE-WRITE STEP (DO NOT SKIP):
Before filling this template, open the source file(s) for this screen and enumerate every interactive UI element:
  - Every <Button>, including icon-only buttons
  - Every <ButtonGroup variant="segmented"> and its child buttons (segmented / filter chips)
  - Every <Checkbox>, <RadioGroup>, <Switch>, <Select>, <TextField>, <RangeSlider>, <ChoiceList>
  - Every <Popover>, <Modal>, <ActionList> trigger
  - Every row-action icon (pencil, copy, trash, eye, drag-handle, etc.)
  - Every clickable chip / badge / tag
  - Every conditionally-rendered control ({isAdmin && ...}, {plan === "premium" && ...})
  - Every pagination control (chevrons + page-size selector — inherited from CommonTable)
  - Every onClick on a <div> or <span>

For each: capture (1) what it is, (2) default state, (3) options/values, (4) what happens on click/check/uncheck/change,
(5) any cross-control disabling, (6) what is persisted. Every item must end up in either "Controls on this screen",
a subsection under "What you can do from here", or a one-line decorative mention in "What you see here".

See references/writing-rules.md §10a-10c and references/screen-readme-format.md "Pre-write interactive-element checklist".
Delete this comment block before saving.
-->

# [Screen/Section Title]

> Part of [Parent Screen](../README.md)

## What is this?

[1-2 sentences. What is this screen/section? What can the user accomplish here?]

## How this helps your business

[3-6 sentences. Why this screen matters. What business problem does it solve? How does it help the business make more money, save time, or serve customers better?]

## What you see here

[Describe top-to-bottom as the user sees it:
- Title/heading at top
- Status indicators, badges, summary info
- Cards, sections, content blocks in order
- Buttons visible and where they are
- Tabs if any (list all tab names)
- Tables/lists if any (what columns/data they show)
- What it looks like when empty vs with data]

## What you can do from here

### [Action Name]

**What this does**: [1-2 sentences]

**Why you'd use this**: [Business reason]

**When you click this**:
1. [What opens - new screen / popup window / dropdown / side panel]
2. [Everything visible in it]:
   - [Field name]: [what it's for, example value]
   - [Dropdown name] - options:
     - "[Option A]" - [what it means, when to pick it, business benefit]
     - "[Option B]" - [what it means, when to pick it, business benefit]
3. [Next step - what user clicks to complete]
4. [Result - what changes, what user has achieved]

**What this changes behind the scenes**: [Plain language. Example: "After turning this on, the app will automatically check your products every night and fix any missing descriptions."]

**Business value**: [How completing this action improves the store]

→ [If this opens something complex, link to sub-folder](./sub-folder/README.md)

---

### [Next Action]

[Same structure as above]

---

## Controls on this screen

### [Toggle Name]
- **What it controls**: [Plain language]
- **When ON**: [What the app does differently]
- **When OFF**: [What happens instead]
- **Default**: [ON or OFF]
- **Recommendation**: [When to turn this on/off and why]

### [Slider Name]
- **What it controls**: [What this slider adjusts]
- **Low end ([min])**: [What happens. When you'd want this.]
- **High end ([max])**: [What happens. When you'd want this.]
- **Sweet spot**: [Recommended range and why]
- **Default**: [Starting value]
- **Example**: ["If you set this to 70%, the app will only suggest products..."]

### [Dropdown Name]
- **What it controls**:
- **Options**:
  - "[Option A]" - [What it does. Business impact. When to choose.]
  - "[Option B]" - [Same depth]
- **Default**:
- **Recommendation**:

### [Checkbox Name]
- **What it controls**:
- **When checked**: [App behavior. Business impact.]
- **When unchecked**: [App behavior. Business impact.]
- **Default**:

## States

### Empty state
[What you see when there's no data. The copy shown. The CTA presented.]

### Loading state
[What you see while data loads.]

### Error states
[What can go wrong. What message the user sees. What they should do.]

## Who sees this

- **Roles**: [List of user roles with access]
- **Plans**: [List of pricing plans that unlock this, or "all plans"]
- **Conditions**: [Any data-state or feature-flag conditions]

## Where you can go from here

| Destination | What's there | Go to |
|---|---|---|
| [Screen name] | [What user will find] | [→](./sub-folder/README.md) |

## How this connects to other parts of the app

- **[Other screen]** - [How they relate, what data connects them, why using both together is valuable]

## Common questions about this screen

**Q: [Question a user/support agent would ask]**
A: [Clear answer]
