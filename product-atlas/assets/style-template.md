# STYLE.md - Atlas Writing Conventions

> Reminder for anyone editing files inside `product-atlas/`.

## Voice and perspective

- Write in second person: "You click...", "You see..."
- Natural human language. No corporate-speak.
- Smart-friend-over-coffee tone.

## Banned in README prose

These technical terms NEVER appear in any README.md inside this atlas:
- API (describe what it does: "connects to Stripe to charge the card on file")
- Component, controller, hook, props, state, render
- Schema, GraphQL, endpoint, route (say "page")
- Modal (say "popup window")
- JSON (describe the data shape in words)

Tech terms ARE allowed in:
- `metadata.json` (it's data, terms expected)
- `INTEGRATIONS.md` (service descriptions can use API/endpoint/auth)

## Banned punctuation/style

- Em dashes anywhere - use hyphens, colons, or sentence breaks instead
- Emojis (unless explicitly approved)
- "Etc." or "and more" in lists - enumerate everything
- "TBD" or placeholder content - if writing it, write it complete
- Marketing fluff: "powerful", "robust", "seamless", "simply", "just"

## Required structure per screen README

Every screen's README.md must include in this order:
1. Title (H1)
2. Parent breadcrumb (skip for root)
3. What is this?
4. How this helps your business
5. What you see here
6. What you can do from here
7. Controls on this screen
8. States (empty, loading, error)
9. Who sees this
10. Where you can go from here
11. How this connects to other parts of the app
12. Common questions about this screen

## Required completeness

- Every dropdown lists ALL options, never "etc."
- Every action gets a UI trace (click → opens → options → result → business value)
- Every control gets ON/OFF/value effects + default + recommendation
- Every screen has empty + loading + error states documented

## Business framing

Every screen, action, and option explains how it helps the business using it. "How this helps your business" is required at every README. Recommendations included for controls.

## Links

- Only relative links within `product-atlas/`
- Never reference files outside the atlas
- Every link in any README must work (no 404s)

## When in doubt

Read `references/writing-rules.md` in the product-atlas skill for the full ruleset.
