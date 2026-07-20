# Edge Cases Capture Template

Use during Step 5 of feature-first reasoning for Critical and Important tier screens.

For each category below, ask dev. Capture in metadata.json under `edge_cases` field and in screen README under "Edge cases" section.

---

## Full enumeration (Critical tier)

### 1. Scale
Ask:
- Behavior at 100 records? 1K? 10K? 1M?
- Pagination kicks in at what threshold?
- Search / filter performance at scale?
- Any feature limits (max items, max sub-records)?

Capture format (metadata):
```json
"scale": {
  "tested_up_to": "<volume>",
  "pagination_threshold": "<threshold>",
  "performance_notes": "<notes>",
  "feature_limits": ["<limit 1>", "<limit 2>"]
}
```

### 2. Concurrency
Ask:
- Two users editing same record - what wins?
- Conflict resolution UI?
- Real-time sync between sessions?
- Optimistic vs pessimistic locking?

Capture format:
```json
"concurrency": {
  "strategy": "<last-write-wins | optimistic-with-conflict-ui | pessimistic-lock | real-time-sync>",
  "conflict_ui": "<description or 'none'>",
  "real_time_sync": "<yes/no>",
  "known_gaps": ["<gap 1>"]
}
```

### 3. Network
Ask:
- Offline behavior?
- Slow connection feedback?
- Intermittent connection (drops mid-action)?
- Retry strategy?
- Optimistic UI updates?

Capture format:
```json
"network": {
  "offline_support": "<yes/no/partial>",
  "slow_connection_ui": "<description>",
  "retry": "<auto/manual/none>",
  "optimistic_ui": "<yes/no/partial>"
}
```

### 4. Errors
Ask for each known error scenario:
- What scenario can trigger it?
- What UI shows?
- What user action?

Capture format:
```json
"errors": [
  {
    "scenario": "<description>",
    "ui_shown": "<what user sees>",
    "user_action": "<what user can do>",
    "code_ref": "<file:line>"
  }
]
```

### 5. Accessibility
Ask:
- Keyboard navigation - all interactive elements reachable?
- Screen reader - elements announced correctly?
- Focus management - returns correctly after actions?
- Color contrast - WCAG AA?
- Touch targets - min 44x44 on mobile?
- Reduced motion preference respected?

Capture format:
```json
"accessibility": {
  "keyboard_nav": "<full | partial | none>",
  "screen_reader": "<full | partial | none>",
  "focus_management": "<yes/no>",
  "contrast": "<WCAG AA | AAA | not verified | fails>",
  "known_gaps": ["<gap 1>"]
}
```

### 6. i18n / Internationalization
Ask:
- Any hardcoded strings (not in i18n files)?
- RTL language support?
- Long translation handling (text overflow)?
- Date/time/currency/number formatting per locale?
- Pluralization rules?

Capture format:
```json
"i18n": {
  "hardcoded_strings": [
    {"file": "<file:line>", "string": "<text>"}
  ],
  "rtl_support": "<yes/no/partial>",
  "long_text_handling": "<tested/not-tested>",
  "date_format": "<locale-aware/hardcoded>",
  "currency_format": "<locale-aware/hardcoded>",
  "plurals": "<library-handled/manual/none>"
}
```

---

## Key categories only (Important tier)

For Important tier, ask only:
- ERRORS - all scenarios + UI
- ACCESSIBILITY - keyboard nav + screen reader status + known gaps
- (Other categories: ask if dev wants to flag known issues)

Skip:
- Scale (assume defaults unless concerning)
- Concurrency (assume defaults)
- Network (assume defaults)
- i18n (capture via auto-extract of i18n_keys only, no deep audit)

---

## Basic only (Standard tier)

For Standard tier, ask only:
- ERRORS - known error scenarios + UI

Skip all other categories.

---

## When dev doesn't know

Acceptable answers and how to capture:

| Dev says | Capture |
|---|---|
| "Not sure" | INFERRED with `_confidence: "unknown"`, log to OPEN-QUESTIONS.md |
| "Not applicable" | `"n/a"` value |
| "Known gap, on roadmap" | Use `known_gaps` field, include "on roadmap" note |
| "Tested but no notes" | `"tested": true, "notes": null` |
| "Default behavior is fine" | Use library/framework defaults documented in OVERVIEW.md tech stack |

---

## In screen README

Edge cases section appears after States section:

```markdown
## Edge cases

### Scale
- <key point>
- <key point>

### Concurrency
- <key point>

### Network
- <key point>

### Errors
- <error scenario>: <UI shown>
- <error scenario>: <UI shown>

### Accessibility
- <coverage status>
- Known gaps: <list>

### Internationalization
- <coverage status>
- Hardcoded strings: <list or "none">
```

Tier-adjusted depth:
- Critical: full prose for all 6
- Important: full prose for errors + accessibility, brief for others
- Standard: errors only, very brief

---

## Special screen types

ATLAS-RULES.md can specify additional edge cases for specific patterns:

### AI feature screens
- Model fallback when AI is down
- Input length limits
- Output format guarantees
- Cost / token usage visible to user
- Latency expectations

### Real-time screens
- Connection loss UI
- Reconnect behavior
- Message ordering
- Stale state detection

### File upload screens
- File size limits
- File type validation
- Upload progress UI
- Failed upload retry

### Wizards / multi-step flows
- Back button behavior
- Mid-flow abandonment recovery
- Step validation order
