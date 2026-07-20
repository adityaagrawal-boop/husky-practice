# Hypothesis-Driven Q&A Pattern

The default way the skill asks the dev questions. Replaces open-ended "tell me about X" with "I think X works like Y, confirm?"

## Why this matters

**Open-ended (slow, error-prone):**
```
Skill: What's your pricing model?
Dev: We have monthly subscriptions with three tiers. Free starter, paid pro, paid scale. Annual option available with discount.
Skill: How are plans gated? Which features are locked?
Dev: Free has basic features only, no team members. Pro adds team members and integrations. Scale adds SSO and custom branding.
... 5 more rounds of follow-ups
```

**Hypothesis-confirm (fast, accurate):**
```
Skill: I see Stripe subscription code + 3 plans in your billing config (starter $0, pro $29, scale $99). Monthly billing with annual option at 20% off. Plan gating: starter has X feature flags off, pro+ enables team and integrations, scale+ enables SSO and branding. Correct?
Dev: Mostly right. Annual discount is 25% not 20%.
Skill: Updated. Anything else?
Dev: No, that's accurate.
```

3 rounds → 1 round. Less ambiguity. Dev sees skill's understanding directly.

## When to use this pattern

Use hypothesis-confirm for:
- Anything code can suggest (auth, billing, multi-tenancy, integrations, etc.)
- Anything pattern detection inferred
- Sequential follow-ups when dev's previous answer constrains options
- Confirming inferred values after dev gave high-level input

Use open-ended for:
- Things code can NEVER answer (business value, positioning, JTBD)
- First-time context where skill has zero signal (product description)
- Subjective judgment (recommendations, edge cases)

Use AskUserQuestion structured choice for:
- Tier assignments (Critical/Important/Standard/Skip)
- Yes/no with consequences
- Picking from a known short list

## Hypothesis format

### Standard format

```
Skill: I see <evidence from code/repo>. I think <hypothesis>. Correct?
```

Example:
```
I see useStripe() hook and a SubscriptionPlan model with three rows (starter, pro, scale). I think pricing is monthly subscription via Stripe with 3 tiers. Correct?
```

### Multi-part hypothesis

```
Skill: Based on <evidence>, I think:
- <claim 1>
- <claim 2>
- <claim 3>

Read and correct anywhere I'm wrong.
```

Example:
```
Based on Clerk Organizations code + permission table:
- Multi-tenant via workspaces (Clerk Orgs)
- 3 roles: admin, member, viewer
- Admin can invite/remove members
- Member can do everything except billing and member management
- Viewer is read-only across the workspace

Read and correct anywhere I'm wrong.
```

### Filling-in hypothesis (for partial info)

When code suggests structure but not details:

```
Skill: I see <evidence> suggesting <structure>. Fill in the parts I can't infer:

<inferred field 1>: <my guess or [unclear]>
<inferred field 2>: <my guess or [unclear]>
<inferred field 3>: <my guess or [unclear]>

Correct or fill the [unclear] items.
```

Example:
```
I see your pricing config has 3 plans but no metadata on positioning. Fill in:

starter: my guess "for individuals trying the product" — correct?
pro: my guess "for growing teams" — correct?
scale: my guess "for established companies" — correct?

Also, what triggers a customer to move from starter to pro vs pro to scale? (open-ended)
```

## Per-screen hypothesis (the BIG one)

This is where feature-first reasoning lives. Per screen during `continue atlas`:

```
Skill: Screen: <name>
Tier: <tier>

Here's what I think this screen does:
<2-3 sentence narrative>

Users come here to:
<JTBD>

The main things they can do:
- <action 1 with my interpretation>
- <action 2 with my interpretation>
- <action 3 with my interpretation>

Controls I found:
- <control 1>: <my interpretation of effect>
- <control 2>: <my interpretation>

Business value (hypothesis):
<1-2 sentences>

Read and correct anywhere I'm wrong. Add missing things.
```

This is the core pattern for `continue atlas`. See `references/feature-first-reasoning.md` for full flow.

## When dev's correction reveals deeper questions

Sometimes a correction shows skill's understanding was wrong at a deeper level. When this happens:

1. Acknowledge correction
2. Re-state revised understanding (new hypothesis based on correction)
3. Ask dev to confirm revised hypothesis
4. Don't move forward until aligned

Example:
```
Skill: I see auto-SEO toggle. Default ON. When ON, scans products nightly and fills meta titles. Correct?

Dev: Default is OFF. And it's not nightly - it scans on product save.

Skill: Got it. Revised:
- Default: OFF
- Trigger: runs on each product save (not nightly batch)
- Effect: fills missing meta title for the saved product only

Confirm or correct again?

Dev: Yes that's right.
```

## When to ask follow-ups vs accept dev's input

Ask follow-up if:
- Dev's answer raises a new question that affects multiple screens
- Dev's answer contradicts pattern detection (need to reconcile)
- Dev's answer is ambiguous (single word reply with unclear referent)

Don't ask follow-up if:
- Dev's answer is clear and specific
- Skill could have inferred the follow-up from the answer
- Dev seems short on patience (use judgment)

## Anti-patterns

**Don't open-end things code answered:**
> Bad: "What database do you use?"
> Good: "Postgres via Prisma confirmed?" (when prisma/schema.prisma exists)

**Don't ask questions whose answers don't affect anything:**
> Bad: "When was this app first created?" (unless dev mentioned wanting CHANGELOG context)
> Good: skip the question

**Don't ask vague hypotheses:**
> Bad: "Some kind of billing exists. Correct?"
> Good: "Stripe Subscriptions, monthly, 3 plans. Correct?"

**Don't restate dev's exact words as hypothesis:**
> Bad: 
> Dev: "We have multi-tenant workspaces"
> Skill: "So you have multi-tenant workspaces. Correct?"
> 
> Good: just say "Confirmed" and move forward

**Don't ask the same hypothesis twice if dev confirmed:**
> Bad: re-confirming roles 3 screens later when they already confirmed at intake
> Good: trust prior confirmation, apply across all screens

## Hypothesis from ATLAS-RULES.md

When ATLAS-RULES.md has pattern shortcuts (e.g., "all auth is via Clerk, don't ask"), skill skips even the confirmation step. Treats the rule as already-confirmed hypothesis.

## When skill has NO hypothesis

If pattern detection found nothing relevant and code is silent on a topic, use open-ended Mode 3 from `references/adaptive-intake.md`. Don't fake a hypothesis.

Example: "What's the business value of this screen?" - code can't suggest this. Open-ended only.

## Tone

Hypothesis-confirm questions should sound like a colleague checking their understanding, not a form interview. Be specific, show your work, invite correction.

Good: "Pricing looks like monthly Stripe with 3 tiers (starter $0, pro $29, scale $99). 20% annual discount. Correct or off?"

Bad robotic: "Please confirm or correct the following: pricing_type=subscription, billing_provider=stripe, plan_count=3."
