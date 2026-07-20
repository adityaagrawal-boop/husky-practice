# Confidence Rules

For every item in the Assumption Checklist (`references/assumption-checklist.md`), apply this confidence threshold to decide whether to write the value as fact, write with INFERRED tag, or ask the dev.

## The four levels

### HIGH
- Explicit code pattern matches with no ambiguity
- Example: `t('products.title')` call → `i18n_keys` includes `'products.title'`
- Example: `<Modal>` wrapper → `screen_type = "popup"`
- **Action:** WRITE as bare value (no `_inferred` tag)

### MEDIUM
- Pattern present but interpretation uncertain
- Example: handler exists but effect chain hits 3+ files
- Example: comment near code hints at purpose but not explicit
- **Action:** ASK dev via AskUserQuestion (per locked threshold)

### LOW
- Best guess from naming convention or context only
- Example: variable named `autoSeoEnabled` suggests SEO automation but no logic confirms
- **Action:** ASK dev via AskUserQuestion (per locked threshold)

### UNKNOWN
- No code signal at all
- **Action:** ASK dev via AskUserQuestion
- If skipped → leave field empty + log to `meta.open_questions` (surfaces in OPEN-QUESTIONS.md)

## Locked threshold

**HIGH writes as fact. MEDIUM and LOW always ask dev. UNKNOWN always asks dev.**

This is the conservative setting. Only explicit code patterns become confirmed facts in metadata. Anything less certain gets dev review.

## When dev confirms a MEDIUM/LOW inference

After dev confirms an inferred value:
- If they accept the inferred value as-is → write as bare value (treat as HIGH)
- If they correct the value → write the corrected value as bare value
- If they skip the item → write the inferred value wrapped with `_inferred: true` + log to `meta.open_questions`

## When to write the wrapped INFERRED form

Only when dev explicitly says `skip` or `defer all`. In those cases:

```json
"on_effect": {
  "value": "App scans products nightly",
  "_inferred": true,
  "_confidence": "medium"
}
```

These items get aggregated into `OPEN-QUESTIONS.md` for later dev review.

## When the dev session ends early

If the dev abandons or stops mid-Phase 1/2/3:
- All unanswered items get wrapped INFERRED form with their original confidence level
- All unanswered items are logged to `meta.open_questions`
- Final `OPEN-QUESTIONS.md` aggregation reflects the state
