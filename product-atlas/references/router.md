# Router - The Brain's Front Door

<!--
  WHY THIS FILE EXISTS (business logic):
  The atlas is not just a doc folder - it is the product brain for the whole team.
  Marketing, PM, support, QA, devs, data, sales, and design all ask different
  questions in different words and need answers in different shapes. Without a
  router, every question would get the same screen-dump answer. This file is the
  single front door: it classifies the request, loads the right knowledge, and
  picks the right output shape BEFORE answering. Read this first for ANY question
  asked over an existing atlas.
-->

This file is loaded first for every question, Q&A, or artifact request over an existing `product-atlas/`. It decides **who is asking, what they want, and in what form**, then routes.

## When the router runs

- The user runs `ask: <question>`.
- The user asks any natural-language product question while a `product-atlas/` exists.
- The user asks for an artifact ("write a help article for X", "draft a release note", "give me a test plan for Y").
- The user asks a cross-cutting question ("what changed last week", "if I change X what breaks", "Free vs Premium").

Do NOT run the router for build/maintenance commands (`start atlas`, `continue atlas`, `rewrite ...`, `quality review`) - those have their own command references.

## Step 0: Classify on three axes

Classify the request on all three axes. This is cheap and happens before any file load beyond the always-on context.

### Axis 1 - INTENT (what they're trying to do)

| Intent | Signal words |
|---|---|
| Understand | "what is", "explain", "how does ... work", "walk me through" |
| Test | "test", "QA", "edge case", "preconditions", "expected result" |
| Debug | "broken", "not working", "error", "user says", "why did" |
| Build / change code | "implement", "where is the code", "data flow", "API", "refactor" |
| Plan | "roadmap", "scope", "priority", "is X done", "risk", "tradeoff" |
| Sell | "pitch", "demo", "ROI", "objection", "why choose us" |
| Market | "positioning", "benefit", "messaging", "landing copy", "vs competitor" |
| Analyze | "metric", "KPI", "revenue", "adoption", "how is X computed", "data source" |
| Maintain | "update docs", "after this PR", "what changed", "sync atlas" |
| Create artifact | "write", "draft", "generate", "give me a <doc>", "turn this into" |

### Axis 2 - PERSONA (who is asking)

Use `references/personas.md` for the canonical 8: **Developer, PM, Support, QA, Marketing, Data analyst, Sales, Designer**.

**Inference rule (default mode):** infer the persona from the intent and wording. Ask a persona question ONLY when the request is genuinely ambiguous AND the answer shape would differ materially by persona. When you do ask, ask once and combine it with desired output format ("Quick answer, deep dive, or a paste-ready doc?").

- Named role ("as QA", "for support", "I'm a new dev") → use it, but as a clue not a hard wall.
- Strong intent signal with no role → infer (e.g. "what's the revenue impact" → Data/PM; "user says checkout is blank" → Support).
- Truly ambiguous → answer in plain English first, then offer the role-specific deep dive.

**Inference-confidence gate.** Before committing to a persona, gauge how strong the signal is:
- **Strong** (named role, or one intent that maps cleanly to one persona) → proceed in that persona's contract.
- **Weak** (no role, and the intent maps to 2+ personas equally) → do NOT silently pick one. Either (a) lead with a plain-English answer and offer "want the <persona-A> or <persona-B> take?", or (b) if the question is short and cheap, ask the one disambiguating question.

**Multi-persona questions.** Some questions legitimately serve two roles at once — e.g. "what's the revenue impact *and* how do I demo it" (Data + Sales), or "is X done and what would it break" (PM + Developer). Do NOT collapse these to one shape. Answer in **two clearly-labelled sub-sections**, one per persona's contract (e.g. `**Revenue (data view)**` then `**Demo (sales view)**`). Keep each concise; cite per section. If three or more personas are implicated, lead with the primary and offer the rest.

### Axis 3 - OUTPUT (what form)

| Output form | When |
|---|---|
| Quick answer | Default. 1-5 sentences + citation. |
| Deep dive | "explain fully", "walk me through", onboarding, complex feature. |
| Artifact | Any "write / draft / generate / give me a <doc>" - use `references/answer-contracts.md` artifact formats. |

## Step 1: Always-on context

Read these every time before routing (same set as `qa-mode.md` Step 1-2):
- `product-atlas/INDEX.md` if present - **the one-hop routing map; read this FIRST** (see `references/route-index.md`)
- `product-atlas/OVERVIEW.md` - product brain
- `product-atlas/STATUS.md` - current state + confidence gauge
- `product-atlas/ATLAS-RULES.md` - per-repo vocabulary and rules
- `product-atlas/SURFACE-MAP.md` - tier map (drives confidence)
- `product-atlas/screens/README.md` - navigation tree
- `product-atlas/ASK-ME-FIRST.md` if present - per-repo routing overrides

### One-hop resolution (do this before fanning out)
If `INDEX.md` exists, resolve the question against it before reading anything else:
1. Match against Section B (aliases) → Section A (routes) → Section C (flows).
2. Open ONLY the matched file(s) in Step 2 - skip the multi-file walk.
3. Use the staleness badge (✅/⚠/🔹) as an early confidence signal.
4. If no match: fall back to the `SURFACE-MAP.md` + `screens/README.md` walk, answer, then **add the missing entry to INDEX.md** so next time is one hop.

## Step 2: Route to knowledge (intent x persona)

Load the files that match the classified intent. Persona refines WHICH extra docs to pull.

| Intent | Load first | Then pull (persona-specific) |
|---|---|---|
| Understand | matched `screens/<route>/README.md` | feature READMEs; `GLOSSARY.md` for new users |
| Test | `views/qa/` latest matrix; screen `metadata.json` | top-level `QA-*` docs if present |
| Debug | `screens/storefront/README.md`, `COMMON-COMPONENTS.md`, `OPEN-QUESTIONS.md` | top-level `SUPPORT-*` playbooks if present |
| Build | `INTEGRATIONS.md`, `COMMON-COMPONENTS.md`, screen `metadata.json` (`code_files`) | architecture / data-flow sections; `TECHNICAL-FLOW.md` if present |
| Plan | `STATUS.md`, `OPEN-QUESTIONS.md`, `CHANGELOG.md` | top-level `PM-*`, `*-ROADMAP`, `*-RISK-*` docs if present |
| Sell | `OVERVIEW.md`, `PLANS.md`, per-feature business value | `views/sales/` |
| Market | `OVERVIEW.md` positioning, `PLANS.md`, per-feature business value | `views/marketing/` (reserved); UX/positioning docs if present |
| Analyze | `screens/analytics/README.md`, `PLANS.md` | data-dictionary docs (reserved); analytics sub-feature metadata |
| Maintain | `references/maintenance-loop.md`, `MAINTENANCE.md`, `STATUS.md`, `CHANGELOG.md` | affected screen README + metadata |
| Create artifact | whatever the underlying intent needs (above) | `references/answer-contracts.md` for the format |

Cross-reference indexes as needed: `ROLES.md` (access), `PLANS.md` (pricing/credits), `INTEGRATIONS.md` (services), `GLOSSARY.md` (terms).

## Step 3: Cross-cutting query handlers

Some questions span the whole atlas. Detect and handle these specially:

| Query type | How to answer |
|---|---|
| **Impact analysis** ("if I change X, what's affected?") | Walk the target screen's `related_screens`, then `INTEGRATIONS.md`, `PLANS.md`, `ROLES.md` to enumerate affected screens, plans, roles, and integrations. List who cares (which personas). |
| **Comparison** ("Free vs Premium", "before vs after") | Plans → `PLANS.md`. Time-based → `CHANGELOG.md` + `history/` snapshots. Present as a side-by-side table. |
| **Timeline** ("what changed in X last month?") | `CHANGELOG.md` filtered by date/area + `history/` snapshot links. |
| **Onboarding path** ("I'm new to <role>, what do I read?") | Use the persona's load order from `personas.md` as an ordered reading list. |
| **Readiness** ("is X done / tested / shipped?") | `STATUS.md` (doc state) + `OPEN-QUESTIONS.md` (gaps) + `views/qa/` (test coverage). State doc-confidence, not a guarantee of shipped code. |

## Step 4: Confidence gate + fallback chain

Before answering, decide if the atlas can answer. See `references/confidence-and-freshness.md` for labels and staleness rules.

```
Can the atlas answer this?
 ├─ YES, fresh          → answer + citations + confidence label
 ├─ YES, but stale      → answer + "may be outdated, last verified <date>" + offer `rewrite`
 ├─ PARTIAL             → answer what's known + flag the gap + offer to document it
 └─ NO
     ├─ screen pending in STATUS.md  → "not documented yet, run `document <screen>`"
     ├─ feature in EXCLUSIONS.md     → "excluded - see EXCLUSIONS.md for reason"
     └─ not covered at all           → FALLBACK (see guardrail below): read the
                                       source code directly, answer from code, flag
                                       it as code-derived (not yet in atlas), and
                                       offer to add it via `document`/`rewrite`. If
                                       it's a product DECISION code can't answer, log
                                       it to OPEN-QUESTIONS.md and say a human decides.
```

The code-fallback step is what makes the brain always useful: it never dead-ends with "not documented."

**Fallback guardrail (do this BEFORE reading source).** The code-fallback must respect the same two boundaries the router respects everywhere else — otherwise it can resurrect excluded behavior or expose black-box internals as product fact:
- If the source you're about to read backs a feature in **`EXCLUSIONS.md`** → do NOT answer from it as a live feature. Say it's excluded (with the reason), and stop.
- If the file is a pure wrapper listed in **`COMMON-COMPONENTS.md`** → use that file's summary, don't dive into the wrapper's internals.
- Otherwise → read the source, answer, and **label the answer "derived from current code, not yet in the atlas"** with the file path. Offer to `document`/`rewrite` so it becomes a one-hop answer next time.

## Step 5: Answer in the persona's contract

Shape the answer per `references/answer-contracts.md` for the classified persona and output form. Always:
- Cite source files inside `product-atlas/` (relative paths) so the asker can verify.
- Attach a confidence label when the answer relies on INFERRED or Standard-tier data.
- For non-technical personas (support, marketing, sales, new users), avoid code identifiers unless asked.

## What the router does NOT do

- Does not modify atlas files (Q&A/answers are read-only; switch to `rewrite` flows to change docs).
- Does not invent features listed in `EXCLUSIONS.md`.
- Does not dive into source for components listed in `COMMON-COMPONENTS.md` - use that file's summary.
