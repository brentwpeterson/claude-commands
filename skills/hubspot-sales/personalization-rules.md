# Personalization Rules

**Purpose:** How to write client-facing personalization content that sounds human and converts.

---

## Golden Rule

**ALWAYS run `/brand-brent` before writing any client-facing content.**

This loads Brent's voice, tone, and style rules.

---

## What Makes Good Personalization

### DO:
- Reference something SPECIFIC to their business
- Connect their situation to your value prop
- Sound like a human who did research
- Keep it conversational
- Use their language (from their website)

### DON'T:
- Be generic ("I noticed you're in e-commerce...")
- Sound like a template with [COMPANY] swapped in
- Over-research creepily ("I saw you posted on LinkedIn 3 days ago...")
- Use corporate jargon
- Write paragraphs (keep it tight)

---

## Personalization Formula

```
[Specific observation about THEM]
+ [Connection to problem you solve]
+ [Why it matters for THEIR situation]
```

**Example:**
```
Since Love&Cookies ships nationally and competes against
local bakeries, showing up in AI-powered searches could
be a real edge. Your cause-driven mission is exactly the
kind of story that AI search surfaces well.
```

**Breakdown:**
- Specific: "ships nationally", "competes against local bakeries"
- Connection: "AI-powered searches"
- Their situation: "cause-driven mission" as differentiator

---

## Personalization by Funnel Stage

### Cold Outreach (Lead)
**Goal:** Get attention, show you understand them.

**Length:** 2-3 sentences max.

**Focus on:**
- Their business model/differentiator
- A specific challenge they likely have
- Quick value prop connection

**Example:**
```
I found your blog at cookiesilove.com - looks like it could
use some fresh content. Love&Cookies ships nationally against
local bakeries. The cause-driven mission is the differentiator.
```

### Warm Follow-up (MQL/SQL)
**Goal:** Build on previous interaction, move forward.

**Length:** 2-4 sentences.

**Focus on:**
- What they engaged with
- Next logical step
- Specific offer

**Example:**
```
I noticed you were checking out the AI search content.
Since you're running Shopify, the integration takes about
5 minutes. Want to see how it works for Love&Cookies
specifically?
```

### Re-engagement (Gone Cold)
**Goal:** Restart conversation without being pushy.

**Length:** 1-2 sentences.

**Focus on:**
- New angle or value
- No pressure
- Easy out

**Example:**
```
Quick thought - we just launched a feature that auto-generates
product descriptions. Might be useful given your catalog size.
If timing's better now, happy to show you.
```

---

## Personalization Sources

| Source | What to Use |
|--------|-------------|
| Company website | Mission, differentiators, products |
| Tech stack | Platform-specific benefits |
| Engagement | What they clicked on (carefully) |
| Industry | Common challenges |
| Role | Decision-maker vs influencer framing |
| Company size | Scale-appropriate messaging |

---

## Referencing Engagement (Carefully)

### Good - Vague Reference:
```
"I noticed you were exploring the demo..."
"Since you seemed interested in the AI search topic..."
"You were checking out some of our content..."
```

### Bad - Creepy Specificity:
```
"I saw you clicked 8 times on my email..."
"You opened my email 3 times yesterday..."
"I noticed you spent 4 minutes on the pricing page..."
```

**Rule:** Acknowledge interest, don't reveal surveillance.

---

## Personalization Token Fields

### Primary: `personalization_paragraph`
**Usage:** Main personalization block for emails/sequences.
**Length:** 2-4 sentences.

### Secondary: Other custom fields (if they exist)
- Check for `personalization_token`, `custom_opener`, etc.
- Ask before writing to unfamiliar fields

---

## Quality Checklist

Before saving personalization:

- [ ] Would I say this to them in person? (Natural)
- [ ] Is there something SPECIFIC to them? (Not generic)
- [ ] Does it connect to value prop? (Relevant)
- [ ] Is it 2-4 sentences max? (Concise)
- [ ] Does it sound like Brent? (Voice)
- [ ] Would I be embarrassed if they knew my source? (Not creepy)
- [ ] Does it avoid internal insights? (See guardrails.md)

---

## Examples by Industry

### E-commerce (Shopify)
```
Since you're on Shopify, the RequestDesk app installs in
about 5 minutes. Your [product category] pages could have
fresh AI-generated content same day - no developer needed.
```

### E-commerce (Magento)
```
Magento stores usually have complex catalogs - that's exactly
where AI-generated content scales well. One integration, content
for hundreds of products.
```

### Agency Serving E-commerce
```
Your clients are probably asking about AI for content.
RequestDesk gives you a white-label solution - your branding,
our AI. Might be a new revenue stream.
```

---

## What NOT to Include

Never put these in personalization:

- Engagement metrics (clicks, opens, scores)
- Internal assessments ("high fit", "warm lead")
- Sales strategy ("trying breakup email approach")
- Competitive intel ("they're also talking to X")
- Budget/timeline speculation
- Anything you wouldn't say to their face

**These go in NOTES only. See guardrails.md.**

---

## Personalization Refresh

Update personalization token when:

- Significant new engagement (they clicked something new)
- New enrichment data (discovered something)
- Previous personalization is stale (>30 days)
- Changing outreach angle

Don't update if:
- Still in active sequence using current personalization
- No new information
- Contact is disqualified/paused
