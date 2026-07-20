# Dev Question Batching

How to group AskUserQuestion calls when running the Assumption Checklist.

## Core rule - Per-screen rounds

Dev clears all questions for the current screen before Claude moves to the next screen. Linear, predictable, easier to context-switch.

Why: if dev gets a deep field wrong on screen 1 and we've already moved past, the corrections cascade into screens 2+. Per-screen rounds catch errors before they propagate.

## Round structure per screen

Up to 5 rounds max per screen. Skip rounds when no items in that block need asking.

### Round 1 - Purpose (always run if any of items 9-11 not certain)
- Item 9: What is this screen
- Item 10: Job-to-be-done
- Item 11: Business value

### Round 2 - Access gaps (only if items 6, 7, or 8 not clear from code)
- Item 6: Roles with access
- Item 7: Plans required
- Item 8: Conditional visibility

### Round 3+ - Per-control business intent

**For screens with 1-3 controls:** ask items 16, 17, 18 per control individually.

**For screens with 4+ controls:** present a batched control table with INFERRED defaults filled in, ask dev to correct or confirm. One round, not one round per control.

The threshold (1-3 vs 4+) exists because per-control questions on a 15-control settings page would generate 30+ questions for one screen. Batching keeps the screen reviewable in one pass.

### Round 4 - Actions business value (only if 4+ actions on screen)
- Item 22: Business value for each major action

For screens with 1-3 actions, fold this into Round 1.

### Round 5 - Related screens (1 question)
- Item 33: Semantic connections to other screens

## AskUserQuestion call limits

The tool supports 1-4 questions per call. Aim for 3-4 questions per call to minimize round-trips. Group related items.

## Skip behaviors

Dev can short-circuit at any time. Recognize these phrases:

| Dev says | Action |
|---|---|
| `skip` (or "skip this") | Current item only - mark INFERRED with low confidence, log to `meta.open_questions` |
| `skip all` (or "skip the rest") | All remaining items for current screen - mark all as INFERRED |
| `defer all` (or "defer everything") | All remaining items for entire current build/rewrite run - write all as INFERRED, batch dev review at end via OPEN-QUESTIONS.md |

After `defer all`, do not ask any more questions during this session. Aggregate to OPEN-QUESTIONS.md at end.

## Context to include in every AskUserQuestion call

Tell the dev where they are:
- "Working on screen: [screen name]"
- "Parent route: [route slug]"
- Question(s)

This helps the dev context-switch when reviewing many screens in a row.

## When to NOT ask

Skip the question entirely if:
- Item is HIGH confidence from code (just write as fact)
- Same item was already answered for the same screen earlier in session
- Item is auto-extracted (events, i18n, integrations) and doesn't need dev confirmation
