# Funnel Stages: Lifecycle and Lead Status

**Purpose:** Define what each stage means and what actions are appropriate at each stage.

---

## Lifecycle Stages

The contact's position in the buyer journey.

### Subscriber
**Definition:** Opted into content (newsletter, download) but no sales activity.

**Characteristics:**
- Came through marketing channel
- No direct sales outreach yet
- May not be aware of product/service

**Appropriate Actions:**
- Nurture with content
- Score based on engagement
- Promote to Lead when engagement threshold met

**Move to Lead when:** Opens multiple emails, visits pricing page, or fits ICP criteria.

---

### Lead
**Definition:** Identified as potential buyer, in active outreach.

**Characteristics:**
- Fits basic criteria (industry, company size, role)
- In a sequence or receiving outreach
- Not yet qualified

**Appropriate Actions:**
- Active email sequences
- LinkedIn connection/outreach
- Enrichment to understand fit
- Monitor engagement signals

**Move to MQL when:** Engagement score reaches threshold (define specific number).

---

### Marketing Qualified Lead (MQL)
**Definition:** Engagement threshold met, demonstrating interest.

**Characteristics:**
- High engagement (opens, clicks, content downloads)
- May have visited key pages (pricing, demo)
- Marketing says "worth sales attention"

**Appropriate Actions:**
- Prioritize for personal outreach
- Phone call attempt
- Personalized email (not just sequence)
- LinkedIn direct message

**Move to SQL when:** Fit confirmed AND engagement confirmed (responded, showed buying signals).

**Current MQL Criteria (needs refinement):**
- Property: `mql` (enumeration)
- Threshold: TBD (document as we learn)

---

### Sales Qualified Lead (SQL)
**Definition:** Fit + engagement confirmed, ready for sales conversation.

**Characteristics:**
- Right company (size, industry, tech stack)
- Right person (decision maker or influencer)
- Engaged (responded, asked questions)
- Showed buying intent

**Appropriate Actions:**
- Book meeting/demo
- Discovery call
- Needs analysis
- Create deal if not exists

**Move to Opportunity when:** Meeting booked or deal created.

**Current SQL Criteria (needs refinement):**
- Responded to outreach AND
- Fit score above threshold AND
- Expressed interest in demo/conversation

---

### Opportunity
**Definition:** Active deal in pipeline.

**Characteristics:**
- Has associated deal record
- In active sales conversation
- Evaluating or negotiating

**Appropriate Actions:**
- Deal-stage specific activities
- Proposals, demos, negotiations
- Multi-thread stakeholders
- Overcome objections

**Move to Customer when:** Deal closed won.

---

### Customer
**Definition:** Closed won, paying customer.

**Characteristics:**
- Active subscription/contract
- Onboarding or using product

**Appropriate Actions:**
- Onboarding support
- Success check-ins
- Upsell opportunities
- Referral requests

**Move to Evangelist when:** Satisfied + willing to refer/advocate.

---

### Evangelist
**Definition:** Happy customer who actively promotes.

**Characteristics:**
- Given testimonial or referral
- Speaks positively about product
- Case study candidate

**Appropriate Actions:**
- Referral program enrollment
- Case study creation
- Speaking opportunities
- Maintain relationship

---

## Lead Status

The contact's outreach/sales status (independent of lifecycle).

| Status | Definition | Next Action |
|--------|------------|-------------|
| **New** | Not yet contacted | Begin outreach sequence |
| **Open** | Active outreach in progress | Continue sequence, monitor engagement |
| **Attempted to Contact** | Outreach sent, no response yet | Wait for sequence to complete, try other channels |
| **Connected** | Response received (any response) | Personal follow-up, qualify, book meeting |
| **Bad Timing** | Interested but not now | Set task for future follow-up (3-6 months) |
| **Past Client** | Former customer | Re-engagement campaign, understand why they left |
| **Unqualified** | Not a fit | Document why, remove from active outreach |
| **No More Emails** | Opted out of email | LinkedIn only or remove entirely |

---

## Stage Transition Triggers

### Lead → MQL
- [ ] Engagement score exceeds threshold (TBD)
- [ ] Multiple email opens/clicks
- [ ] Visited pricing or demo page
- [ ] Downloaded high-intent content

### MQL → SQL
- [ ] Responded to outreach
- [ ] Fit score confirmed (right company/role)
- [ ] Expressed interest in conversation
- [ ] Booking intent shown

### SQL → Opportunity
- [ ] Meeting booked OR
- [ ] Deal created in pipeline

---

## Lifecycle vs Lead Status Matrix

| Lifecycle | Typical Lead Status | Notes |
|-----------|--------------------| ------|
| Subscriber | (none) | Not in sales process |
| Lead | New, Open, Attempted | Active outreach |
| MQL | Open, Attempted, Connected | Higher priority outreach |
| SQL | Connected | Qualified, in conversation |
| Opportunity | Connected | Has deal record |
| Customer | Past Client (if churned) | Out of sales process |

---

## When to Change Stages

**Only move lifecycle FORWARD (except churn scenarios).**

**Lead Status can move in any direction** based on current reality:
- Connected → Bad Timing (they said "not now")
- Open → Unqualified (discovered bad fit)
- Attempted → Connected (they replied)

**Document stage changes in Notes:**
```
Stage Change (2026-01-23):
Lead → MQL
Reason: 8 clicks on AI search email, visited pricing page,
engagement score now 45 (threshold: 40)
```
