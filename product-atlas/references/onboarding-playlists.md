# Onboarding & Offboarding Playlists

<!--
  WHY THIS FILE EXISTS (business logic):
  `generate onboarding doc` (references/view-generation.md) already covers one case: a single,
  developer-only, technical walkthrough of the codebase. That leaves seven of the eight personas
  with no guided path into the product, and leaves no structured way to capture what a departing
  team member knows before they leave. Playlists close both gaps: an ordered, staged reading path
  through the atlas for any persona, and its mirror image for offboarding. This is the direct
  answer to feature parity with competitor "documentation playlists" - the difference is these are
  generated from the same code-derived atlas instead of hand-assembled and left to rot.
-->

A playlist is a staged, ordered reading path through the atlas, built for one persona at a time. Unlike `generate onboarding doc`, which stays exactly as it is today (a single deep technical walkthrough for developers), a playlist works for any of the 8 canonical personas, is broken into stages a new hire can actually complete in order, and tells them why each stop matters, not just what to click next.

## When this runs

- `generate onboarding playlist for <persona>` - full playlist for a new hire in that role.
- `generate onboarding playlist for <persona> focused on <area>` - narrowed to one feature area, for a hire who only owns part of the product (e.g. a support hire who only handles billing).
- `generate offboarding playlist for <persona> owning <features/screens>` - the mirror case, see "Offboarding mode" below.

## Source data

Reuse what already exists, don't re-derive it:
- `references/personas.md` - which files that persona's answers already load first (the "Load" line per persona) is the seed for stage ordering.
- `SURFACE-MAP.md` - tier data drives sequencing: Critical-tier screens the persona touches come before Standard-tier ones, so a new hire learns what matters most first, not whatever happens to be alphabetically first.
- The per-persona field projection already defined in `scripts/atlas-persona-bundle.mjs` (`PERSONAS` map) - reuse the same "what this role actually needs from a screen" logic rather than inventing a second definition that can drift from it.
- `GLOSSARY.md` for any persona whose stage 1 should include vocabulary (most of them).

## Output structure

Stages, not a flat list. Each stage names what it's for, lists 3-6 stops in read order, and gives one line on why each stop matters plus a rough time estimate. End each stage with a short "you're ready to move on when" checklist, this is what makes it a playlist instead of a table of contents.

Default stage shape (adjust stage count/labels to fit the persona, this is a pattern not a rigid template):

1. **Orient** - OVERVIEW.md, GLOSSARY.md, and the persona's own entry in personas.md restated in plain terms. Goal: know what the product is and the vocabulary before touching a single screen.
2. **Core surface** - the Critical-tier screens this persona's role actually touches, in tier order, each with its README's "what you can do from here" section as the stop. Goal: functional competence on the things that matter most.
3. **Depth & edge cases** - Important-tier screens, plus each screen's edge-cases section relevant to this persona (e.g. QA gets error states, Support gets user-facing failure modes, Developer gets concurrency/data-flow).
4. **Where things connect** - `INTEGRATIONS.md`, `PLANS.md`, or `ROLES.md`, whichever the persona's own "Load" line in personas.md points to, framed as "how this connects to the rest of the product."

Use `assets/onboarding-playlist-template.md` for the literal Markdown shape.

## Offboarding mode

Same stage structure, opposite direction. Given a persona and the features/screens they own, walk each one and flag:
- Anything Critical or Important tier where the atlas's confidence label (per `references/confidence-and-freshness.md`) is MEDIUM, LOW, or UNKNOWN, that's knowledge that exists only in this person's head and needs to be captured before they leave, not something to silently lose.
- Anything in `OPEN-QUESTIONS.md` attributed to or clearly owned by this person.
- Screens this person is the only documented owner of, if `ROLES.md` or metadata tracks ownership.

Output a short punch list at the top ("capture these 4 things before their last day") ahead of the full playlist, that's the part someone will actually act on.

## Output location

`product-atlas/views/playlists/<persona>/<YYYY-MM-DD>-onboarding.md` (or `-offboarding.md`). Same timestamped, never-auto-pruned convention as every other view in `references/view-generation.md`, this is a view like the others, not a new subsystem.

## Validation

- Fails if the target persona's screens include any Critical-tier screen with no README yet, surface that gap instead of silently skipping it, a playlist that quietly omits an unfinished screen is worse than one that flags it.
- Never fails on missing Standard/Skip-tier content, playlists are allowed to be thin at the edges, that's the point of tiering.

## Relationship to `generate onboarding doc`

That command is unchanged and still the right tool for "a developer wants the full technical mental model in one document." Playlists are for "any new hire needs a guided, staged path in, or a departing team member's undocumented knowledge needs to be caught before it walks out the door." Both read from the same atlas, neither duplicates the other's output.
