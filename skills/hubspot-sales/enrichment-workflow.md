# Enrichment Workflow

**Purpose:** When and how to enrich contact records before outreach or personalization.

---

## When to Enrich

### Always Enrich Before:
- Writing personalization content
- Personal (non-sequence) outreach
- Demo/meeting prep
- Deal creation
- MQL/SQL qualification

### Skip Enrichment If:
- Contact was enriched in last 30 days
- Just running through sequence (batch outreach)
- Contact is unqualified/rejected
- Time-sensitive response needed (do after)

---

## Enrichment Command

**Use:** `/hubspot-enrich [contact identifier]`

This command handles the full enrichment workflow.

---

## Data Sources & What They Provide

### 1. HubSpot Contact Record
**What to pull:**
- Basic info (name, email, title, company)
- Lifecycle stage, lead status
- All scores (custom + predictive)
- Last activity timestamps
- Sequence enrollment status
- Associated company

### 2. HubSpot Company Record
**What to pull:**
- Industry
- Employee count
- Revenue (if available)
- Website
- Existing tech stack fields (if populated)

### 3. Wappalyzer (Tech Stack Detection)
**When to use:** Company website exists, tech stack unknown

**What it provides:**
- E-commerce platform (Shopify, Magento, WooCommerce, etc.)
- Email marketing (Mailchimp, Klaviyo, etc.)
- Analytics (GA4, etc.)
- Payment processors
- CMS
- Other marketing tech

**Why it matters:**
- Shopify = best fit for RequestDesk
- Existing email tool = integration consideration
- Analytics maturity = sophistication signal

### 4. Company Website
**What to look for:**
- Products/services offered
- Company story/mission
- Blog presence and quality
- Target customers
- Differentiators
- Recent news/press

**Why it matters:** Personalization hooks, understanding their business.

### 5. LinkedIn Profile
**What to look for:**
- Current role and tenure
- Previous experience
- Shared connections
- Recent posts/engagement
- Content they engage with

**Why it matters:** Conversation starters, credibility signals.

### 6. HubSpot Activity History (NEW - requires sales-email-read scope)
**What to pull:**
- Email engagement (opens, clicks)
- Meeting history
- Call logs
- Notes from previous interactions

---

## Enrichment Output

### Write to HubSpot Company (if applicable):
- `marketing_stack` - Primary email/marketing tool
- Tech stack fields (if custom properties exist)

### Write to HubSpot Notes (INTERNAL):
```
Enrichment (YYYY-MM-DD):

**Tech Stack (Wappalyzer):**
- E-commerce: [platform]
- Email: [tool]
- Analytics: [tool]
- Other: [relevant tools]

**Company Research:**
- [Key finding 1]
- [Key finding 2]
- [Differentiator/hook]

**LinkedIn:**
- Role: [title] at [company] for [tenure]
- [Relevant observation]

**Fit Assessment:**
[High/Medium/Low] - [reason]

**Personalization Hooks:**
- [Hook 1 - specific to their business]
- [Hook 2 - specific to their situation]
```

### Update Personalization Token (EXTERNAL):
Only after enrichment provides hooks. Use `/brand-brent` for voice.

---

## Enrichment Checklist

Before marking enrichment complete:

- [ ] Tech stack identified (or noted as unknown)
- [ ] Company business understood
- [ ] Personalization hooks documented in Notes
- [ ] Fit assessment made
- [ ] Scores reviewed
- [ ] Personalization token updated (if needed)

---

## Enrichment Freshness

| Data Type | Refresh After |
|-----------|---------------|
| Tech stack | 6 months |
| Company info | 3 months |
| Contact role/title | 3 months (people change jobs) |
| Scores | Real-time (auto-updated) |
| Activity history | Always current |

**Check `notes_last_updated` to see when last enriched.**

---

## Partial Enrichment

If time-constrained, prioritize:

1. **Tech stack** - Critical for fit (Shopify vs other)
2. **Company differentiator** - For personalization
3. **Role confirmation** - Are they decision maker?

Skip:
- Deep LinkedIn research (do before meeting)
- Extensive website analysis (do if high priority)

---

## Enrichment for Different Scenarios

### Cold Outreach Prep
- Tech stack (fit check)
- Company hook (personalization)
- Basic role verification
- **Time: 5-10 minutes**

### Post-Engagement Follow-up
- Review activity history
- Update personalization based on what they clicked
- Check if anything changed
- **Time: 5 minutes**

### Pre-Meeting/Demo Prep
- Full enrichment (all sources)
- LinkedIn deep dive
- Recent news/press
- Mutual connections
- **Time: 15-20 minutes**

### Deal Creation
- Full enrichment
- Buying committee identification
- Budget signals
- Timeline indicators
- **Time: 20-30 minutes**
