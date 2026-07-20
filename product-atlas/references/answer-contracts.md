# Answer Contracts - Output Shapes per Persona

<!--
  WHY THIS FILE EXISTS (business logic):
  "Give all types of answers" only works if each persona gets a PREDICTABLE shape.
  A support agent and a PM asking the same question need different structures, not
  the same wall of prose. This file defines the exact output contract per persona
  AND the paste-ready artifact formats (help article, ticket, release note, etc.)
  so the brain produces deliverables, not just answers. The router (router.md
  Step 5) picks the contract; this file says what it looks like.
-->

Two layers:
1. **Conversational contracts** - the default shape of a spoken answer per persona.
2. **Artifact contracts** - paste-ready document formats when the asker wants "a doc".

All answers cite source files inside `product-atlas/` (relative paths). Confidence labels per `references/confidence-and-freshness.md`.

## Layer 1 - Conversational contracts (per persona)

Personas defined in `references/personas.md`.

| Persona | Answer shape (in order) |
|---|---|
| **Developer** | What it does → data flow → key files (paths) → APIs/side effects → edge cases |
| **PM** | User problem → current behavior → scope/boundaries → tradeoffs → open questions |
| **Support** | Symptom → likely cause → user-safe steps → internal-only checks → escalation |
| **QA** | Feature → preconditions (role/plan/state) → test steps → expected result → known risks |
| **Marketing** | Value prop → who it's for → benefit (outcome) → differentiator → messaging hooks |
| **Data analyst** | Metric/answer → definition → data source → how computed → caveats |
| **Sales** | Hook → what to show (demo) → ROI/outcome → objection handling |
| **Designer** | Layout → user flow → controls → UX rationale / why this way |

**Depth rule (all personas):** start broad (orientation), then go exactly as deep as the question needs. Don't dump a whole screen when one control was asked about.

**Plain-language rule:** for Support, Marketing, Sales, and new-user questions, avoid class names, component names, and code-only identifiers unless explicitly asked.

## Layer 2 - Artifact contracts (paste-ready docs)

Triggered when the asker says "write / draft / generate / give me a <doc> / turn this into X". Produce the document in the exact shape below. Save to `views/<persona>/<YYYY-MM-DD>-<slug>.md` only if the user asks to save; otherwise return inline.

### Help-center article (Support / Marketing)
```markdown
# How to [task] / Why [thing happens]
**Who this is for:** [user segment]
## Steps
1. ...
## If it doesn't work
[symptom → fix, from states.errors]
## Related
[links to other articles/screens]
```

### Feature one-pager / PRD slice (PM)
```markdown
# [Feature]
**Problem:** [purpose.what + jtbd]
**Behavior:** [what it does today]
**Scope / not in scope:** ...
**Gating:** roles [..] / plans [..]
**Tradeoffs & risks:** ...
**Open questions:** [from OPEN-QUESTIONS.md]
```

### Jira / issue ticket (PM / Dev)
```markdown
**Title:** [verb-first]
**Context:** [why]
**Acceptance criteria:** - [ ] ...
**Affected surface:** [screens/routes]
**Notes:** [code files, integrations, edge cases]
```

### Release note / changelog blurb (PM / Marketing)
```markdown
**[Feature] - [one-line benefit]**
[2-3 sentences: what changed, why it helps the user.]
[Plan availability if gated.]
```

### Comparison table (Marketing / Sales / PM)
```markdown
| Capability | [Option A] | [Option B] |
|---|---|---|
```
Use for plan-vs-plan (from `PLANS.md`) or before-vs-after (from `history/` + `CHANGELOG.md`).

### Metric definition (Data analyst)
```markdown
**Metric:** [name]
**Definition:** [plain English]
**Source:** [where the data comes from]
**Computation:** [how it's derived]
**Caveats:** [edge cases, attribution rules]
```

### Demo script (Sales)
```markdown
## Positioning (30s)
## Demo flow (5-10 min) - numbered, screen by screen
## ROI per feature
## Objection handling
```

### Test plan (QA)
Per `references/view-generation.md` `generate qa view` structure: preconditions → control tests → state tests → action tests.

### Slack / email summary (any persona)
```markdown
**TL;DR:** [1 line]
- [bullet]
- [bullet]
[link to atlas source]
```

## Cross-cutting query outputs

For the router's Step-3 query types (`router.md`):
- **Impact analysis** → bullet list grouped by affected screens / plans / roles / integrations, plus "who cares" (which personas).
- **Comparison** → side-by-side table (above).
- **Timeline** → reverse-chrono list with `CHANGELOG.md` + `history/` links.
- **Onboarding path** → numbered reading list using the persona's load order from `personas.md`.
- **Readiness** → status line (documented? tested? open questions?) + confidence label.

## Hard rules for every contract

- Cite atlas source paths.
- Flag INFERRED / stale data (see `confidence-and-freshness.md`).
- Never invent excluded features (`EXCLUSIONS.md`).
- Match the asker's vocabulary (`ATLAS-RULES.md` domain terms; `GLOSSARY.md`).
