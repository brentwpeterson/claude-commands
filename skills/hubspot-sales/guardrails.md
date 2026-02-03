# Guardrails: Internal vs External Content

**This is the most critical file in the skill. Read before writing ANYTHING to HubSpot.**

---

## The Golden Rule

**INTERNAL insights go in NOTES. EXTERNAL content goes in tokens/emails.**

If the client could see it, it must sound like you're talking TO them, not ABOUT them.

---

## INTERNAL (HubSpot Notes)

**Purpose:** Your private insights, behavioral analysis, recommendations.

**Where it goes:** `hubspot-create-engagement` with type `NOTE`

**What belongs here:**
- Engagement metrics ("8 clicks on Jan 12 email")
- Behavioral signals ("high interest, responded within 2 hours")
- Tech stack discoveries ("running Shopify + Mailchimp")
- Recommendations ("follow up this week, warm lead")
- Objections/concerns noted
- Meeting notes
- Research findings
- Competitor intel
- Pricing discussions
- Internal flags ("decision maker", "budget holder", "champion")

**Example - CORRECT note:**
```
Behavioral Signal (2026-01-23):
- Email "AI search visibility" sent Jan 12
- 2 opens, 8 clicks (high engagement)
- Clicked demo link multiple times but didn't book
- Tech: Shopify, Mailchimp, Facebook Pixel

Recommendation: Follow up with specific value prop.
She's interested but needs a nudge. Reference the
cause-driven mission angle.
```

---

## EXTERNAL (Client-Facing)

**Purpose:** Content the client will see directly.

**Where it goes:**
- `personalization_paragraph` property
- `personalization_token` property
- Any email copy fields
- LinkedIn message drafts
- Any `*_paragraph` or `*_message` properties

**What belongs here:**
- Personalized opening lines
- Relevant observations about THEIR business
- Value propositions tied to their situation
- Questions for them
- Calls to action

**Voice:** Always use `/brand-brent` for tone and style.

**Example - CORRECT personalization:**
```
I noticed you explored the AI search visibility content
I sent a couple weeks ago. Since Love&Cookies ships
nationally and competes against local bakeries, showing
up in AI-powered searches like ChatGPT or Perplexity
could be a real edge.
```

---

## NEVER Do This

### Wrong: Internal insight in personalization field
```
// WRONG - This would be sent to the client!
personalization_paragraph: "Ashley clicked 8 times on my
email. She's a warm lead. Follow up immediately."
```

### Wrong: Talking ABOUT them instead of TO them
```
// WRONG - Sounds like internal notes
personalization_paragraph: "This contact runs Shopify and
has 50K monthly visitors. Good fit for RequestDesk."
```

### Wrong: Exposing your sales strategy
```
// WRONG - Never reveal your playbook
personalization_paragraph: "Since you didn't respond to
the last 3 emails, I'm trying a different approach."
```

---

## Pre-Write Checklist

Before writing to ANY HubSpot field, ask:

| Question | If YES → |
|----------|----------|
| Does it mention engagement metrics (clicks, opens, scores)? | NOTES only |
| Does it contain recommendations for me (Brent)? | NOTES only |
| Does it talk ABOUT the contact in third person? | NOTES only |
| Does it reveal sales strategy or intent? | NOTES only |
| Would I be embarrassed if the client saw this? | NOTES only |
| Is it written as if speaking TO the client? | Safe for external |
| Does it sound like the start of an email? | Safe for external |

---

## Field Reference

### INTERNAL (Notes Only)
- HubSpot Notes (via engagement API)
- Any custom field ending in `_notes` or `_internal`

### EXTERNAL (Client-Facing)
- `personalization_paragraph`
- `personalization_token`
- `email_*` fields (except internal tracking)
- `linkedin_message`
- Any `*_paragraph` or `*_message` field

### AMBIGUOUS - Ask First
- Custom fields you haven't seen before
- Fields without clear naming conventions

---

## Recovery: What To Do If You Make a Mistake

If you accidentally write internal content to an external field:

1. **Immediately update the field** with appropriate client-facing content
2. **Tell Brent** what happened
3. **Check if it was used** - was there an email sent? A sequence triggered?
4. **Log it** - add a note about the correction

---

## Examples by Scenario

### Scenario: Contact clicked email multiple times

**INTERNAL (Note):**
```
High engagement on "AI Search Visibility" email (Jan 12):
- 8 clicks in 45 minutes
- Explored demo link 3x but didn't book
- Signal: Strong interest, may need social proof or urgency
```

**EXTERNAL (Personalization):**
```
I noticed you were checking out the AI search demo. Happy to
walk through how it works specifically for [Company] - takes
about 15 minutes and you'll see exactly what your customers
would find when they ask ChatGPT about [product category].
```

### Scenario: Discovered their tech stack

**INTERNAL (Note):**
```
Tech Stack (Wappalyzer 2026-01-23):
- E-commerce: Shopify
- Email: Mailchimp
- Analytics: GA4
- Fit score: High (Shopify = our sweet spot)
```

**EXTERNAL (Personalization):**
```
Since you're running Shopify, the RequestDesk integration
is plug-and-play - about 5 minutes to install and your
first AI-generated posts go live same day.
```

### Scenario: Contact went quiet after demo

**INTERNAL (Note):**
```
Status: Demo completed Jan 10, no response to follow-ups.
Possible blockers: Budget timing? Needs stakeholder buy-in?
Next action: Try LinkedIn touch, reference specific demo moment.
```

**EXTERNAL (Personalization):**
```
Quick question - after our demo last week, was there anything
specific you wanted to dig deeper on? Happy to do a focused
15-min call on just [topic they asked about in demo].
```
