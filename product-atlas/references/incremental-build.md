# Incremental Build - Session Management

The atlas is NEVER built in one shot. It builds incrementally over many sessions. This file defines the session-management strategy.

## Why incremental

A real B2B SaaS has 20-100 screens. Documenting all in one session:
- Burns out the dev (50+ rounds of Q&A in 3 hours = bad UX)
- Wastes context (skill carries half-finished state in memory)
- Locks dev into one sitting (no flexibility)
- Quality drops in later screens (fatigue)

Incremental fixes all of this. Dev controls pace. Skill remembers state via STATUS.md.

## Session boundaries

A session = one block of dev-skill interaction. Boundaries:
- Dev opens cowork and types a command
- Dev says `pause` or stops responding
- Skill completes its work and reports done

Sessions can be 5 minutes (one screen) or 60 minutes (multiple screens). Dev's call.

## State persistence

All session state lives in `product-atlas/STATUS.md`. Format spec in `references/status-file.md`.

Key state captured:
- Last session date
- Documented screens (with dates)
- In-progress screen (if paused mid-screen)
- Pending queue (ordered by tier, then by importance)
- Open questions count
- Atlas health (any inconsistencies flagged)

Every session ends by updating STATUS.md.

## The command lifecycle

### `start atlas` - first session only

Runs once. Builds the foundation:
1. Pattern detection (scan repo)
2. Adaptive intake (OVERVIEW.md)
3. EXCLUSIONS.md + COMMON-COMPONENTS.md + ATLAS-RULES.md intake
4. Surface mapping (SURFACE-MAP.md with tier suggestions)
5. Dev confirms tiers
6. Initialize STATUS.md with full pending queue
7. Initialize CHANGELOG.md

Output: foundation ready, all screens in pending queue. NO screens documented yet.

Tell dev: "Foundation ready. Run `continue atlas` when ready to start documenting screens."

Details in `references/cmd-start-atlas.md`.

### `continue atlas` - typical session

Pulls next pending screen and documents it. Resumes mid-screen if paused.

1. Read STATUS.md
2. Pick next screen (or resume in-progress one)
3. Run feature-first reasoning (see `references/feature-first-reasoning.md`)
4. Write README + metadata
5. Update STATUS.md (move screen from pending → documented)
6. CHANGELOG entry
7. Ask dev: "Continue with next screen, or stop here?"

Details in `references/cmd-continue-atlas.md`.

### `document <screen>` - targeted session

Same as `continue atlas` but for a specific screen by name or path. Useful when:
- Dev wants to document a specific screen out of queue order
- Dev knows a particular screen needs attention
- A new screen was just added to code, document it now

Details in `references/cmd-continue-atlas.md`.

### `pause` - mid-screen state save

Stops current work without losing progress. STATUS.md captures:
- Current in-progress screen
- Which step of feature-first reasoning (Step 1-6)
- Any intermediate data collected
- Questions dev hasn't answered yet

Next session: `continue atlas` resumes from exact state.

Pause is graceful, never destructive.

### `quality review` - final pass

Runs after all screens documented (or when dev says ready). Cross-cutting validation:
- Gap detection across screens
- Consistency checks (same feature documented differently?)
- Aggregation sanity (ROLES references screens that lack the role?)
- Open questions review
- Missing critical fields

Details in `references/quality-review.md`.

### `atlas status` - state check

Read-only. Reports STATUS.md content. No changes. ~30 seconds.

Details in `references/status-file.md`.

## Resume protocol (mid-screen pause)

When a session ends with `pause` mid-screen:

STATUS.md captures:
```markdown
## Currently in-progress

- **Screen:** /workspace/billing
- **Tier:** Critical
- **Step paused at:** Step 5 (edge cases capture)
- **Completed steps:** Steps 1-4 done (code read, understanding built, hypothesis stated, dev confirmed)
- **Pending in this screen:**
  - Edge cases enumeration
  - README write
  - metadata.json write
  - CHANGELOG entry
- **Validated understanding (saved):**
  - <bullet summary of what dev confirmed>
- **Pending questions:**
  - Concurrent edit behavior
  - Network failure UX
```

Next `continue atlas` reads this and resumes at Step 5 with all prior state restored.

## Session ordering recommendations

Critical screens first (most impactful), then Important, then Standard. Within tier, order by:
1. Most-used routes (from analytics if available)
2. Routes mentioned in OVERVIEW.md top features
3. Alphabetical / route-tree order

Dev can override by saying `document <screen>` to jump queue.

## When to do `quality review`

Run when:
- All Critical screens documented (early checkpoint)
- All Critical + Important documented (mid checkpoint)
- All screens documented (final pass)

Multiple quality reviews OK. Each surfaces gaps relative to current state.

## What never happens incrementally

Some operations stay single-session:
- `rewrite feature <name>` - one feature, one session (can pause if needed)
- `rewrite route <slug>` - one route, one session (can pause)
- `refresh overview` - OVERVIEW.md only, one session

These are scoped narrow enough to complete in one sitting normally.

## Failure modes

**Dev abandons mid-screen with no `pause`:**
- Next session: skill detects in-progress entry in STATUS.md
- Asks dev: "Last session you were on /workspace/billing at Step 5. Resume or start fresh on this screen?"

**STATUS.md gets corrupted or deleted:**
- Skill detects on next load
- Asks dev: "STATUS.md missing or unreadable. Run `start atlas` to rebuild? (Existing screens/ folder is safe)"
- If existing screens/ has documented screens, skill can reconstruct STATUS.md by scanning

**Schema version mismatch (skill updated mid-build):**
- Skill detects on STATUS.md load
- Migration path defined per version bump (in future)
- v1.0 first release - no migrations yet

## CHANGELOG.md entry per session

Every session that writes anything adds a CHANGELOG entry. Format in `references/changelog-format.md`. Single session can produce multiple entries if it documents multiple screens.

## Dev control over pace

Dev decides:
- How many screens per session (1, 5, 10, all)
- When to pause
- When to run quality review
- When atlas is "done" (typically when all Critical + Important done + quality review passes)

Skill suggests cadence but never forces.
