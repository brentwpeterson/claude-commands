# Tiered Contact Enrichment SOP

**Purpose:** Define enrichment depth by relationship tier. Every contact gets baseline enrichment. Higher-value relationships get progressively deeper research.

**Related files:**
- `enrichment-workflow.md` - When/why to enrich (unchanged)
- `personalization-rules.md` - Quality rules for client-facing content (unchanged)
- `guardrails.md` - Internal vs external content boundaries (unchanged)

This SOP defines the HOW and HOW DEEP.

---

## Tier-to-Depth Matrix

| Step | Name | T5 (Cold) | T4 (Aware) | T3 (Engaged) | T2 (Warm) | T1 (Inner Circle) |
|------|------|:---------:|:----------:|:-------------:|:---------:|:------------------:|
| 1 | Contact + Company Fetch | Y | Y | Y | Y | Y |
| 2 | Tech Stack Detection (Wappalyzer) | Y | Y | Y | Y | Y |
| 3 | Blog Discovery + Content Audit | Y | Y | Y | Y | Y |
| 4 | Baseline Personalization | Y | Y | Y | Y | Y |
| 5 | Website Content Analysis | - | Y | Y | Y | Y |
| 6 | Competitive Context | - | Y | Y | Y | Y |
| 7 | Engagement History Synthesis | - | - | Y | Y | Y |
| 8 | LinkedIn Research | - | - | Y | Y | Y |
| 9 | Relationship Context Brief | - | - | - | Y | Y |
| 10 | Meeting Prep + Multi-Variant Personalization | - | - | - | - | Y |

**Minimum for all contacts:** Steps 1-4 (the baseline that `/hubspot-enrich` already does).

---

## Step Definitions

### Step 1: Contact + Company Fetch

**What:** Pull the full HubSpot contact and associated company record.

**Data collected:**
- Contact: name, email, title, lifecycle stage, lead status, all scores, last activity timestamps, sequence enrollment, `relationship_tier`, `enrichment_depth`
- Company: industry, employee count, revenue, website, existing tech stack fields, `company_platform`, `marketing_stack`

**Writes to HubSpot:** Nothing yet (read-only step).

**Batch-compatible:** Yes. Use `hubspot-batch-read-objects` for up to 100 contacts at a time.

---

### Step 2: Tech Stack Detection (Wappalyzer)

**What:** Run Wappalyzer against the company website to detect their full technology stack.

**Data collected:**
- E-commerce platform (Shopify, Magento, WooCommerce, BigCommerce, etc.)
- Email/marketing tools (Klaviyo, Mailchimp, HubSpot Marketing, etc.)
- Analytics (GA4, Adobe Analytics, etc.)
- Payment processors
- CMS
- CDN and hosting
- Other marketing tech (chat widgets, review platforms, etc.)

**Writes to HubSpot:**
- Company property: `company_platform` (mapped from Wappalyzer detection)
- Company property: `marketing_stack` (primary email/marketing tool)
- Note: Full Wappalyzer results with detection date

**Batch-compatible:** Yes. Wappalyzer CLI calls can be parallelized via subagents.

---

### Step 3: Blog Discovery + Content Audit

**What:** Check if the company has a blog and assess its state.

**How:**
1. Fetch the company website
2. Look for `/blog`, `/news`, `/resources`, `/articles` paths
3. If found, assess: last publish date, frequency, topic coverage, quality
4. If not found, note the absence (this is a personalization hook)

**Writes to HubSpot:**
- Note section: Blog status (active/inactive/none), last post date, content themes

**Why it matters:** A stale or missing blog is one of the strongest hooks for RequestDesk. An active blog signals content maturity (different messaging angle).

**Batch-compatible:** Yes. WebFetch calls per domain, parallelizable.

---

### Step 4: Baseline Personalization

**What:** Generate the `personalization_paragraph` using data from Steps 1-3.

**Inputs:**
- Contact name, title, role
- Company differentiators (from website/description)
- Detected platform (for platform-specific CTA)
- Blog status (for content-gap hook)
- Marketing stack (for integration angle)

**Voice:** Follow `personalization-rules.md` and Brent's brand voice (no em dashes, no emojis, conversational, specific).

**Formula:**
```
[Specific observation about their business]
+ [Connection to a problem RequestDesk solves]
+ [Why it matters for their situation specifically]
```

**Writes to HubSpot:**
- Contact property: `personalization_paragraph`
- Update `enrichment_depth` to `4`

**Batch-compatible:** Yes. Personalization generation is parallelizable.

---

### Step 5: Website Content Analysis

**Starts at:** Tier 4 (Aware) and above.

**What:** Deep read of the company website beyond the homepage. Understand their business, customers, and positioning.

**How:**
1. Read About page, key product/service pages, case studies
2. Identify: target customer, value proposition, differentiators, company story
3. Look for: recent news, press mentions, awards, partnerships
4. Note anything that creates a conversation hook

**Writes to HubSpot:**
- Note section: Company research summary (key findings, differentiators, hooks)
- Refine `personalization_paragraph` with deeper specificity

**Update `enrichment_depth` to `5` or `6` (whichever step completes last in this tier).**

**Partially batch-compatible:** WebFetch is sequential per domain but multiple domains can run in parallel.

---

### Step 6: Competitive Context

**Starts at:** Tier 4 (Aware) and above.

**What:** Understand who they compete with and where they sit in their market.

**How:**
1. From website analysis (Step 5), identify their market segment
2. Note if they mention competitors or comparison positioning
3. Check if any of their competitors are RequestDesk clients (check HubSpot)
4. Identify competitive angles for outreach (without mentioning competitor names in client-facing content)

**Writes to HubSpot:**
- Note section: Competitive context (INTERNAL only, never in personalization)

**Update `enrichment_depth` to `6`.**

**Partially batch-compatible:** Depends on Step 5 completing first.

---

### Step 7: Engagement History Synthesis

**Starts at:** Tier 3 (Engaged) and above.

**What:** Review all HubSpot activity to understand the relationship timeline.

**How:**
1. Pull all engagements: emails sent/received, meetings, calls, notes
2. Pull email engagement: opens, clicks, replies
3. Pull sequence enrollment history
4. Synthesize into a relationship narrative: when did we first connect, what have they engaged with, what went cold, what warmed up

**Writes to HubSpot:**
- Note: Engagement history synthesis with timeline
- Refine `personalization_paragraph` to reference engagement context (vaguely, per guardrails.md)

**Update `enrichment_depth` to `7` or `8`.**

**Not batch-compatible:** Requires per-contact API calls and synthesis. Run one contact at a time.

---

### Step 8: LinkedIn Research

**Starts at:** Tier 3 (Engaged) and above.

**What:** Research the contact's LinkedIn profile for conversation hooks and credibility signals.

**How:**
1. Search LinkedIn for the contact (may need Brent's help for profile access)
2. Note: current role and tenure, previous experience, mutual connections
3. Check recent posts/activity for conversation starters
4. Look for shared interests, groups, content themes

**Writes to HubSpot:**
- Note section: LinkedIn research findings
- Refine `personalization_paragraph` if a strong hook is found

**Update `enrichment_depth` to `8`.**

**Not batch-compatible:** LinkedIn access is manual. Flag contacts that need LinkedIn research and let Brent batch-review.

**Important:** If LinkedIn data isn't accessible, note it and move on. Don't block enrichment on this step.

---

### Step 9: Relationship Context Brief

**Starts at:** Tier 2 (Warm) and above.

**What:** Brent provides context that only he knows. Mutual connections, shared history, how they met, what matters to them personally.

**How:**
1. Present Brent with everything collected in Steps 1-8
2. Ask specific questions:
   - "How do you know this person?"
   - "What's the relationship history?"
   - "What matters to them beyond business?"
   - "Any mutual connections or shared experiences?"
3. Record Brent's answers

**Writes to HubSpot:**
- Note: Relationship context brief (INTERNAL)
- Heavily refine `personalization_paragraph` with Brent's personal context

**Update `enrichment_depth` to `9`.**

**Not batch-compatible:** Requires Brent's direct input per contact.

---

### Step 10: Meeting Prep + Multi-Variant Personalization

**Starts at:** Tier 1 (Inner Circle) only.

**What:** Full research dossier and multiple personalization variants for different outreach channels.

**How:**
1. Compile all data from Steps 1-9 into a structured brief
2. Generate personalization variants:
   - Email opener (2-3 sentences)
   - LinkedIn message (1-2 sentences, more casual)
   - Meeting talking points (3-5 bullets)
   - Follow-up angle (different from opener)
3. Include recent news or changes about their company
4. Prepare objection responses based on their likely concerns

**Writes to HubSpot:**
- Note: Full research dossier
- `personalization_paragraph`: Best email variant
- Additional note: All variants and meeting prep

**Update `enrichment_depth` to `10`.**

**Not batch-compatible:** High-touch, one contact at a time.

---

## The `enrichment_depth` Property

**Type:** Number (1-10)
**Location:** Contact property in HubSpot

**Purpose:** Track how far each contact has been enriched so you never re-do work and can quickly see who needs more.

| Value | Meaning |
|-------|---------|
| 0 or empty | Not enriched |
| 1 | Contact + company fetched |
| 2 | Tech stack detected |
| 3 | Blog audit done |
| 4 | Baseline personalization written |
| 5 | Website content analyzed |
| 6 | Competitive context mapped |
| 7 | Engagement history synthesized |
| 8 | LinkedIn researched |
| 9 | Relationship context from Brent |
| 10 | Full dossier + multi-variant personalization |

**Rule:** Only increment when the step actually completes. If Wappalyzer fails (no website), still set to `2` but note the gap.

---

## Batch Enrichment Guide

### Tier 5 Batch (Steps 1-4): Up to 100 contacts

This is what `/hubspot-enrich` does today. Fully parallelizable.

**Workflow:**
1. Fetch all contacts via `hubspot-batch-read-objects` (single API call per 100)
2. Run Wappalyzer in parallel (one subagent per domain, deduplicate by company)
3. Fetch blogs in parallel (WebFetch per domain)
4. Generate personalization in parallel (one per contact)
5. Batch-update contacts with personalization and enrichment_depth

**Time estimate:** ~2-5 minutes for 50 contacts (mostly Wappalyzer wait time).

### Tier 4 Batch (Steps 5-6): 10-25 contacts at a time

**Workflow:**
1. Complete Steps 1-4 first (or verify `enrichment_depth >= 4`)
2. Deep-read each company website (sequential WebFetch per domain)
3. Map competitive context
4. Refine personalization with deeper hooks
5. Update enrichment_depth to 6

**Time estimate:** ~10-15 minutes for 25 contacts.

### Tier 3 (Steps 7-8): 5-10 contacts at a time

**Workflow:**
1. Verify `enrichment_depth >= 6`
2. Pull engagement history per contact (sequential API calls)
3. Flag contacts needing LinkedIn research for Brent
4. Synthesize and refine personalization
5. Update enrichment_depth to 8

**Time estimate:** ~15-20 minutes for 10 contacts (plus Brent's LinkedIn time).

### Tier 2 (Step 9): 1-5 contacts at a time

**Workflow:**
1. Verify `enrichment_depth >= 8`
2. Present research summary to Brent
3. Record relationship context
4. Refine personalization with personal context
5. Update enrichment_depth to 9

**Time estimate:** ~5-10 minutes per contact (depends on Brent's availability).

### Tier 1 (Step 10): One contact at a time

**Workflow:**
1. Verify `enrichment_depth >= 9`
2. Compile full dossier
3. Generate multi-variant personalization
4. Prepare meeting materials
5. Update enrichment_depth to 10

**Time estimate:** ~15-20 minutes per contact.

---

## Deciding Which Tier to Enrich To

**Use `relationship_tier` on the contact record:**

| relationship_tier | Enrich to Step | When |
|-------------------|----------------|------|
| 5 (Cold) | 4 (Baseline) | Batch enrichment, sequence prep |
| 4 (Aware) | 6 (Website + Competitive) | Pre-outreach for targeted contacts |
| 3 (Engaged) | 8 (History + LinkedIn) | Active conversation, deal qualification |
| 2 (Warm) | 9 (Relationship Brief) | Pre-meeting, deal advancement |
| 1 (Inner Circle) | 10 (Full Dossier) | Key relationship, partnership, strategic |

**If `relationship_tier` is empty:** Default to Tier 5 (Steps 1-4 only).

**Upgrading:** When a contact's tier changes (e.g., Cold to Engaged), run the additional steps. The `enrichment_depth` property tells you where to resume.

---

## Integration with `/hubspot-enrich`

The existing `/hubspot-enrich` command maps to Steps 1-4 (baseline enrichment). No changes needed to that command.

**Future enhancement:** `/hubspot-enrich` could accept a `--depth` flag:
- `/hubspot-enrich contact-name` - Default: enrich to tier's target depth
- `/hubspot-enrich contact-name --depth 6` - Enrich to Step 6 regardless of tier
- `/hubspot-enrich contact-name --depth max` - Full dossier (Step 10)

This is not built yet. For now, run additional steps manually by referencing this SOP.

---

## Quality Gates

Each step must pass before incrementing `enrichment_depth`:

| Step | Gate |
|------|------|
| 1 | Contact and company records retrieved successfully |
| 2 | Wappalyzer ran (even if no results), platform mapped |
| 3 | Blog checked (found or confirmed absent) |
| 4 | `personalization_paragraph` written and passes quality checklist from personalization-rules.md |
| 5 | At least 2 meaningful findings about the company |
| 6 | Market segment identified, competitive landscape noted |
| 7 | Engagement timeline documented with at least 3 data points |
| 8 | LinkedIn profile reviewed OR flagged for Brent |
| 9 | Brent has provided relationship context |
| 10 | Multi-variant personalization generated, dossier compiled |

---

## Personalization Evolution by Depth

The `personalization_paragraph` gets better at each step:

**Depth 4 (Baseline):**
```
Since Love&Cookies ships nationally and competes against
local bakeries, showing up in AI-powered searches could
be a real edge. Your blog at cookiesilove.com hasn't been
updated since October. Fresh content there could help.
```

**Depth 6 (+ Website + Competitive):**
```
Love&Cookies ships nationally but your homepage leads with
the cause-driven mission, not the product. That story is
exactly what AI search surfaces well. Your competitors are
leading with price. You should be leading with purpose.
We can help with that.
```

**Depth 8 (+ Engagement + LinkedIn):**
```
Ashley, you opened the AI search piece a few weeks back.
Makes sense given your background in digital marketing
before Love&Cookies. The cause-driven angle is your
differentiator and it's exactly the kind of content that
performs in AI search. 15 minutes and I can show you
what your customers are finding when they ask ChatGPT
about gift baskets.
```

**Depth 10 (Full Dossier):**
```
Ashley, since we connected at the DTC event last fall
you've been scaling the wholesale side hard. The blog
went quiet around the same time (October was your last
post). I think there's a quick win: get the blog running
again with AI-assisted content that tells the cause story
to each new wholesale buyer searching for you. Happy to
walk through it over coffee next week.
```

*Note: These are illustrative examples showing how depth adds specificity. Actual personalization uses real data from each step.*
