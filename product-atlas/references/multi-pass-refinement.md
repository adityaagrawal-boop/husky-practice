# Multi-Pass Refinement

Per-screen and per-atlas refinement happens across multiple passes, not one shot. This drives 100% accuracy.

## Two scales of multi-pass

### Per-screen multi-pass (within one screen's documentation)

The feature-first reasoning flow (`references/feature-first-reasoning.md`) IS multi-pass within a single screen:
- Pass A: Code read + internal understanding (silent)
- Pass B: Hypothesis stated to dev
- Pass C: Dev correction applied to internal model
- Pass D: Edge cases captured (for Critical/Important)
- Pass E: README + metadata written from validated model

Each pass refines the previous. Don't skip.

### Per-atlas multi-pass (across screens, across sessions)

The atlas as a whole goes through these passes over many sessions:

1. **Skeleton pass:** Surface map + tiers established (Step 3 of `start atlas`)
2. **Deep-dive pass:** Critical and Important screens documented incrementally (`continue atlas` sessions)
3. **Coverage pass:** Standard screens documented (lighter sessions)
4. **Quality pass:** Quality review identifies gaps, dev clears (`quality review`)
5. **Polish pass:** Final read-through, fix remaining INFERRED, tune writing

Skill suggests transitioning between passes based on STATUS.md state. Dev decides actual cadence.

## Pass transitions

### Skeleton → Deep-dive
Trigger: `start atlas` complete, SURFACE-MAP.md written, STATUS.md initialized.
Dev runs `continue atlas` to start screen documentation. Skill picks Critical screens first.

### Deep-dive → Coverage
Trigger: All Critical + Important screens documented.
Skill suggests: "All Critical and Important screens documented. Recommend running first quality review now, then proceed to Standard tier."

### Coverage → Quality
Trigger: All non-Skip screens documented.
Skill suggests: "All screens documented. Recommend `quality review` to validate."

### Quality → Polish
Trigger: Quality review run, gaps cleared.
Optional: Dev can do another deep-dive pass on Critical screens to add depth where wanted.

## When skill suggests pass transitions

Skill watches STATUS.md state. After each `continue atlas` session, evaluates:

```python
if all_critical_documented and not first_quality_review_run:
    suggest: "All Critical done. Recommend first `quality review` checkpoint."

if all_critical_and_important_done and not second_quality_review_run:
    suggest: "Critical and Important complete. Recommend second `quality review`."

if all_screens_documented and not final_quality_review:
    suggest: "All screens done. Run final `quality review` to complete atlas."

if final_quality_review_complete and gaps_remaining > 0:
    suggest: "Quality review found N gaps. Resolve them via `rewrite feature` calls."

if final_quality_review_complete and gaps_remaining == 0:
    suggest: "Atlas complete and validated. Ready for production use."
```

Suggestion appears in `atlas status` output and at end of `continue atlas` sessions.

## Multi-pass at the per-screen level (detailed)

### Pass A: Silent code read + understanding

Skill reads code without saying anything. Builds internal model. Skips common components.

**Output:** Internal model (mental, not written).

**Time:** 30s - 5min depending on screen complexity.

### Pass B: Hypothesis stated

Skill writes hypothesis in chat. Specific, structured.

**Output:** Statement to dev in feature-first format.

**Time:** 1-2 minutes for dev to read.

### Pass C: Dev corrects

Dev replies with corrections. Skill applies.

**Output:** Updated internal model.

**Time:** Dev typing time + back-and-forth (3-15 min depending on corrections).

### Pass D: Edge cases (Critical/Important)

For Critical: full enumeration (6 categories). For Important: key categories.

**Output:** Edge case data added to model.

**Time:** 5-10 min for Critical, 2-5 min for Important.

### Pass E: Write

Skill writes README + metadata from validated model. No dev interaction this pass (just confirming write).

**Output:** Files on disk.

**Time:** 2-5 min (skill working, dev waiting).

## Why this multi-pass works

Each pass catches what the previous missed:

- Pass A finds code patterns
- Pass B exposes Claude's interpretation (dev catches errors)
- Pass C aligns understanding
- Pass D catches non-functional edge cases templates miss
- Pass E executes cleanly because state is validated

If skill tried to do all of this in one pass (code read → write), errors would accumulate silently.

## Anti-pattern: skipping passes to save time

Don't skip Pass B (hypothesis statement). Even if Claude is "sure," dev might catch:
- Misinterpreted business value
- Missed actions
- Wrong default values
- Custom logic Claude didn't trace

Don't skip Pass D for Critical screens. Edge cases ARE the value of Critical-tier documentation.

Don't skip Pass C (dev correction window). Dev might want to correct even if their answer is "looks right" - opportunity to add nuance.

## Dev requesting fewer passes

If dev says "just write the docs, I'll review at the end":
- Skill flags this is non-standard
- Asks dev to confirm they understand quality risk
- If dev confirms: skill runs Pass A → Pass E directly (no B, C, D)
- All written content tagged INFERRED with confidence levels
- Big batch quality review at end

Not recommended. Skill warns.

## When the multi-pass might compress

For very simple Standard-tier screens with obvious behavior:
- Pass A: skim code (30s)
- Pass B: brief hypothesis (1-2 sentences)
- Pass C: dev confirms quickly
- Pass D: skipped (Standard tier)
- Pass E: short README

Total: 3-5 min per Standard screen. Reasonable.

## Across-session multi-pass continuity

When a session ends mid-screen with `pause`:
- STATUS.md captures which pass we paused at
- Next session resumes at that pass with prior pass results intact
- No need to re-do Pass A or Pass B if Pass C interrupted

See `references/incremental-build.md` for resume protocol.

## How to know when atlas is "done"

There's no perfect atlas. "Done" is contextual.

Recommended definition:
- All Critical screens documented with full edge cases
- All Important screens documented with key edge cases
- Standard tier optional (can skip if time-constrained)
- Final quality review passes with 0 gaps
- OPEN-QUESTIONS.md has only items dev consciously deferred

When this state is reached, skill writes a milestone CHANGELOG entry: "Atlas v1 milestone: ready for production use."

After milestone, ongoing maintenance via `rewrite feature` and `rewrite route` as product evolves.
