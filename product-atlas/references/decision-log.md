# Decision Log (ADR)

<!--
  WHY THIS FILE EXISTS (business logic):
  The atlas documents WHAT the app does; CHANGELOG logs WHAT changed. Neither
  captures WHY a deliberate product choice was made or what was rejected - the
  single most valuable knowledge for PMs, support (explaining limitations), and
  future devs (not undoing intentional decisions). DECISIONS.md fills that gap.
  This reference defines its format and the no-guessing rule for rationale.
-->

`product-atlas/DECISIONS.md` is the product decision log (lightweight ADR). Template: `assets/decisions-template.md`.

## What belongs here

A deliberate product/UX/architecture choice whose **rationale** isn't obvious from code:
- "Trial cut from 30 → 14 days" / "default flipped to OFF" / "feature X disabled"
- "We dropped the baked currency table to shrink the bundle"
- "Volume Discount removed; only Spending Goal ships"

What does NOT belong: routine bug fixes, refactors with no product impact, or anything already captured as a screen behavior. Those go to CHANGELOG.

## Relationship to other files

| File | Captures |
|---|---|
| `DECISIONS.md` | **Why** a choice was made + alternatives rejected (durable). |
| `CHANGELOG.md` | **What** changed in the atlas, when (audit trail). |
| `OPEN-QUESTIONS.md` | **Unresolved** questions (a decision not yet made). |

A resolved OPEN-QUESTION often becomes a DECISIONS entry.

## The no-guessing rule (HARD)

Per `references/hard-rules.md`, never invent business rationale. For each entry:
- The **what** and **when** can be stated as fact if verifiable from git/CHANGELOG/code.
- The **why** is stated as fact ONLY if the team confirmed it or the atlas already records it. Otherwise mark the entry ⏳ and write the rationale as a hypothesis-question for the team.

## Format

Reverse-chronological, newest at top. Each entry: Decision, Status (✅ confirmed / ⏳ awaiting confirmation / 🔁 superseded), Why, Alternatives not taken, Source, Affected surface. Full template in `assets/decisions-template.md`.

## When to write an entry

- During `atlas sync` / `rewrite`, if a code change reflects a deliberate choice (not just a fix), add or update a decision entry.
- When the dev explains *why* during hypothesis-confirm Q&A, capture it here so it isn't lost.
- When a question in `OPEN-QUESTIONS.md` gets resolved, move the resolution here.

## Keep it linked

Cite `DECISIONS.md` when answering "why does X work this way?" or "can we change X?". Register it in `INDEX.md` Section D so the router routes those questions here.
