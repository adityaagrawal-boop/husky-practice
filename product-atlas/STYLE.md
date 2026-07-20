# STYLE.md - Atlas Writing Conventions

> Reminder for anyone editing files inside `product-atlas/`.

## Voice and perspective

- Write in second person: "You click...", "You see..."
- Natural human language. No corporate-speak.
- Smart-friend-over-coffee tone.

## Banned in README prose

These technical terms NEVER appear in any README.md inside this atlas:
- API (describe what it does)
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

## Links

- Only relative links within `product-atlas/`
- Never reference files outside the atlas
- Every link in any README must work (no 404s)
