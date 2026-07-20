<!--
  TEMPLATE: DECISIONS.md
  WHY: The product decision log (ADR). Captures WHY deliberate choices were made
  and what was rejected - knowledge code and CHANGELOG can't hold. Copy into
  product-atlas/DECISIONS.md. Never invent rationale: mark ⏳ when the why is
  unverified. Format spec: skill references/decision-log.md.
-->
# Decisions - Why the product is the way it is

> Reverse-chronological log of deliberate product decisions. Newest first.
> Captures the **why** and **rejected alternatives** that code and CHANGELOG can't.

**Status legend:** ✅ confirmed · ⏳ awaiting confirmation (what verified, why inferred) · 🔁 superseded

---

## YYYY-MM-DD - [Short decision title]

**Decision:** [what was decided]
**Status:** ✅ confirmed | ⏳ awaiting confirmation | 🔁 superseded by [link]
**Why:** [rationale - only as fact if verified; else "(awaiting confirmation - <hypothesis>)"]
**Alternatives not taken:** [what was rejected and why]
**Source:** [commit / PR / CHANGELOG date / dev conversation]
**Affected surface:** [screens/routes touched]

---

## How to add a decision

Add a new entry at the top whenever the team makes (or you discover) a deliberate product choice. Do not invent rationale - if you only know *what* changed but not *why*, mark it ⏳ and phrase the why as a question for the team.
