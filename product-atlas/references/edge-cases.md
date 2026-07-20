# Edge Cases - Structured Capture

Per-screen edge case capture. Triggered as Step 5 of feature-first reasoning, but only for Critical and Important tiers.

## Why this matters

Edge cases are where docs typically fail. Template-filling doesn't catch them. Structured capture makes sure scale/concurrency/network/error/accessibility/i18n are all asked.

These cases drive:
- QA test plans
- Support troubleshooting docs
- Accessibility audits
- i18n / localization audits

## When to capture

| Tier | Edge case capture |
|---|---|
| Critical | Full enumeration - all 6 categories |
| Important | Key edge cases - errors + accessibility minimum, others if relevant |
| Standard | Basic check - errors only |
| Skip | None |

## The 6 edge case categories

### 1. Scale

What happens as data volume grows?

Questions:
- Behavior at 100 records? 1K? 10K? 1M?
- Pagination kicks in at what threshold?
- Search/filter performance at scale?
- Any feature limits (max items, max sub-records, etc.)?

Example capture in metadata:
```json
"edge_cases": {
  "scale": {
    "tested_up_to": "10K records",
    "pagination_threshold": "100 records per page",
    "performance_notes": "Search uses Postgres GIN index, sub-100ms up to 1M rows",
    "feature_limits": ["max 500 tasks per project", "max 50 columns on kanban board"]
  }
}
```

### 2. Concurrency

What happens when multiple users act simultaneously?

Questions:
- Two users editing same record - what wins?
- Conflict resolution UI (warning, merge, force-overwrite)?
- Real-time sync between sessions?
- Optimistic vs pessimistic locking?

Example capture:
```json
"concurrency": {
  "strategy": "last-write-wins",
  "conflict_ui": "none - silent overwrite",
  "real_time_sync": "no",
  "known_gap": "concurrent edits can cause data loss, on roadmap"
}
```

### 3. Network

How does the screen behave under poor network?

Questions:
- Offline behavior?
- Slow connection feedback?
- Intermittent connection (drops mid-action)?
- Retry strategy on failure?
- Optimistic UI updates?

Example capture:
```json
"network": {
  "offline_support": "no",
  "slow_connection_ui": "skeleton loaders for 500ms+, then progress indicator",
  "retry": "automatic retry on 5xx errors, max 3 attempts",
  "optimistic_ui": "yes for status changes, no for creates"
}
```

### 4. Error

What can go wrong and what does user see?

Questions:
- Validation errors (form field, business rule)?
- Server errors (500, timeout)?
- Third-party service down (Stripe, OAuth provider, etc.)?
- Rate limiting / quota exceeded?
- Permission denied scenarios?

Example capture:
```json
"errors": [
  {
    "scenario": "Stripe payment failure",
    "ui_shown": "Inline error on payment form: 'Card declined. Try another card.'",
    "user_action": "User updates card details, retries",
    "code_ref": "app/routes/billing/_index.tsx:120"
  },
  {
    "scenario": "Concurrent rate limit (Stripe API)",
    "ui_shown": "Toast: 'Service busy, try again in 30s'",
    "user_action": "Wait, retry",
    "code_ref": "app/lib/stripe.ts:45"
  }
]
```

### 5. Accessibility

Is the screen usable with assistive technology?

Questions:
- Keyboard navigation - all interactive elements reachable?
- Screen reader - elements announced correctly, ARIA labels present?
- Focus management - focus moves correctly after actions?
- Color contrast - text passes WCAG AA?
- Touch targets - min 44x44 on mobile?
- Reduced motion preference respected?

Example capture:
```json
"accessibility": {
  "keyboard_nav": "full - all actions accessible via tab/enter",
  "screen_reader": "partial - main actions have labels, drag-drop on kanban not screen-reader friendly",
  "focus_management": "yes - focus returns to trigger after modal close",
  "contrast": "WCAG AA verified",
  "known_gaps": ["kanban drag-drop not keyboard-accessible", "on roadmap"]
}
```

### 6. i18n / Internationalization

Are all user-facing strings localizable?

Questions:
- Any hardcoded strings (untranslated)?
- RTL language support (Arabic, Hebrew)?
- Long translation handling (text overflow)?
- Date/time/currency/number formatting per locale?
- Pluralization rules?

Example capture:
```json
"i18n": {
  "hardcoded_strings": [
    {"file": "components/Toast.tsx:34", "string": "Saved successfully"}
  ],
  "rtl_support": "partial - layout works but some icons don't flip",
  "long_text_handling": "tested with German (longest typical), no overflow",
  "date_format": "uses Intl.DateTimeFormat with locale, correct",
  "currency_format": "always USD, no per-locale formatting (gap)",
  "plurals": "uses i18n library pluralization rules"
}
```

## How to ask the dev

For Critical screens, present the full edge case checklist in one batched view:

```
Skill: For this Critical screen, please confirm edge cases. Reply yes / no / known-gap / not-applicable to each, with notes.

SCALE:
- Behavior at 1K records? 10K? 1M? Pagination kicks in at what threshold? Any feature limits (max tasks per project, max columns, etc.)?

CONCURRENCY:
- Two users editing same record at same time - what happens? Conflict UI? Real-time sync between sessions?

NETWORK:
- Offline support? Slow connection feedback? Retry strategy? Optimistic UI?

ERROR:
- Validation errors UX? Server errors UX? Third-party down? Rate limit?

ACCESSIBILITY:
- Keyboard nav full coverage? Screen reader compatible? Focus management? Known gaps?

I18N:
- Any hardcoded strings? RTL works? Long-text handling tested? Date/currency formats correct?

Reply with notes per category.
```

For Important tier, ask only the critical 2-3 categories:
```
For this Important screen:
- ERROR: validation errors? server errors? known failure modes?
- ACCESSIBILITY: keyboard navigation work? Any known a11y gaps?
- (Other categories: respond if you know of issues)
```

For Standard tier:
```
For this Standard screen:
- Any known issues or edge cases worth documenting?
```

## Where edge cases live in atlas

### In screen's README.md

Add an "Edge cases" section after "States":

```markdown
## Edge cases

### Scale
- Pagination at 100 records per page
- Tested up to 10K records, sub-second response

### Concurrency
- Two users editing: last-write-wins, no conflict UI (known gap, roadmap)

### Network
- No offline support - actions fail silently with toast

### Errors
- Stripe rate limit: toast "Try again in 30s"
- Validation: inline field errors

### Accessibility
- Full keyboard nav
- Drag-drop on kanban not screen-reader-friendly (known gap)

### Internationalization
- One hardcoded string: "Saved successfully" in Toast component (fix needed)
- RTL works for layout, some icons don't flip
```

### In metadata.json

Add an `edge_cases` object (extends schema):

```json
"edge_cases": {
  "scale": { ... },
  "concurrency": { ... },
  "network": { ... },
  "errors": [ ... ],
  "accessibility": { ... },
  "i18n": { ... }
}
```

Skill schema v1.0 includes this optional field. Validation soft on write, hard on QA view-gen.

## When dev doesn't know an edge case

Acceptable answers and how to capture:

- "Not sure" → mark as INFERRED with `"_confidence": "unknown"`, log to OPEN-QUESTIONS.md
- "Not applicable" → mark with `"n/a"` value
- "Known gap, on roadmap" → capture with `"known_gap"` field
- "Tested but no notes" → mark with `"tested": true, "notes": null`

Skill never assumes "if dev doesn't know, assume it works." Always flags to OPEN-QUESTIONS.md.

## Edge cases for special screen types

### AI feature screens
Additional edge cases:
- Model fallback when AI is down
- Input length limits
- Output format guarantees (will it always return valid JSON, or sometimes prose?)
- Cost / token usage visible to user
- Latency (AI can be 2-30s)

### Real-time screens
Additional edge cases:
- Connection loss UI
- Reconnect behavior
- Message ordering guarantees
- Stale state detection

### File upload screens
Additional edge cases:
- File size limits
- File type validation
- Upload progress UI
- Failed upload retry
- Concurrent uploads

### Wizards / multi-step flows
Additional edge cases:
- Back button behavior
- Mid-flow abandonment recovery
- Step validation order

ATLAS-RULES.md can specify custom edge case checklists per screen pattern.
