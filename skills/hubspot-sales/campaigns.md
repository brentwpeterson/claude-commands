# Campaigns: Contact Segmentation & Drip Tracks

**Purpose:** Define campaign types, enrollment criteria, and cadence for different contact segments.

---

## Campaign Philosophy

Not all contacts should get the same treatment. Different relationships require different approaches:

- **Direct prospects** → Active sales pursuit
- **Agency partners** → Long-term relationship building
- **Past clients** → Re-engagement and upsell
- **Not ready now** → Nurture until timing is right

---

## Campaign Types

### 1. Direct Sales Campaign
**File:** See `recommended-actions.md` for detailed playbooks

**Target:** E-commerce brands who could directly use RequestDesk

**Goal:** Book demo → Close deal

**Cadence:**
- Sequence: 5-7 emails over 3-4 weeks
- LinkedIn: Parallel touches
- Phone: If high-value

**Lifecycle Stage:** Lead → MQL → SQL → Opportunity

**Lead Status Flow:** New → Open → Attempted → Connected → (Deal or Bad Timing)

**Exit Criteria:**
- Became customer
- Unqualified
- Explicit "not interested"
- Sequence exhausted + no engagement

---

### 2. Partner/Agency Campaign
**File:** See `partner-track.md` for detailed playbook

**Target:** Agencies, consultants, tech partners who serve e-commerce brands

**Goal:** Build relationship → Get referrals OR become reseller

**Cadence:**
- Monthly value-add touch (not sales pitch)
- Quarterly check-in call
- Event invites (webinars, conferences)

**Lifecycle Stage:** Lead (Partner) - consider custom stage

**Lead Status:** Custom - "Partner Prospect" → "Active Partner" → "Referring Partner"

**Key Difference:** These contacts don't BUY, they REFER. Different value prop.

**Exit Criteria:**
- Became active partner
- No fit (wrong type of agency)
- Explicitly not interested in partnership

---

### 3. Case Study Expansion Campaign
**Target:** Existing case study clients who could do more

**Goal:** Get additional case studies from same client OR their referrals

**Cadence:**
- After case study delivered: Thank you + ask for referral
- 30 days: Check on results, soft ask for another
- Quarterly: "Any new projects we could document?"

**Lifecycle Stage:** Customer → Evangelist

**Example (Jason Young / Shopware):**
- Did case studies for Shopware via Jason's agency
- Goal: Get Jason to bring us more Shopware clients
- Long-term relationship, not hard sell

**Exit Criteria:**
- No more case study opportunities
- Relationship went cold
- Client churned

---

### 4. Long-Term Nurture Campaign
**Target:** Contacts who are:
- Good fit but bad timing
- Engaged but not ready to buy
- Past conversations that stalled

**Goal:** Stay top of mind until timing is right

**Cadence:**
- Monthly newsletter/content
- Quarterly personal check-in
- Re-engage when trigger event occurs

**Lifecycle Stage:** Lead (Nurture)

**Lead Status:** Bad Timing

**Trigger Events to Watch:**
- Job change (new role = new budget)
- Company funding announcement
- Expansion/hiring signals
- Replatforming signals (if they're moving to Shopify)

**Exit Criteria:**
- Timing becomes right → Move to Direct Sales
- Company no longer fits criteria
- 12+ months no engagement

---

### 5. Re-Engagement Campaign
**Target:** Past clients who churned or went quiet

**Goal:** Win back or understand why they left

**Cadence:**
- Initial re-engagement email (new feature, new offer)
- 30 days: Different angle
- Quarterly: "Still here if you need us"

**Lifecycle Stage:** Customer (Churned) or Past Client

**Lead Status:** Past Client

**Exit Criteria:**
- Became customer again
- Explicit "moved on"
- Company closed/acquired

---

## Campaign Assignment Logic

When evaluating a contact, determine campaign by asking:

```
Is this an agency/consultant who serves e-commerce?
  YES → Partner/Agency Campaign
  NO ↓

Is this an existing customer or past case study?
  YES → Case Study Expansion OR Re-Engagement
  NO ↓

Did they say "not now" or "bad timing"?
  YES → Long-Term Nurture Campaign
  NO ↓

Are they a direct e-commerce brand prospect?
  YES → Direct Sales Campaign
  NO → Evaluate fit, may not be a target
```

---

## Tracking Campaign Membership

### Option 1: HubSpot Property (Recommended)
Create/use property: `campaign_track` or `drip_campaign`

**Values:**
- `direct_sales`
- `partner_agency`
- `case_study_expansion`
- `long_term_nurture`
- `re_engagement`
- `none` (not in a campaign)

### Option 2: Lead Status
Use Lead Status values to indicate track:
- Standard statuses for direct sales
- Custom status "Partner Prospect" for agencies
- "Bad Timing" for nurture

### Option 3: Notes (Manual)
If no property exists, document in Notes:

```
Campaign Assignment (YYYY-MM-DD):
Track: Partner/Agency Campaign
Reason: Agency owner, potential referral source
Cadence: Monthly touch
Next action: [date] - Send value-add content
```

---

## Campaign Cadence Calendar

| Campaign | Week 1 | Week 2 | Week 3 | Week 4 | Monthly | Quarterly |
|----------|--------|--------|--------|--------|---------|-----------|
| Direct Sales | Email 1 | Email 2 | Email 3+LI | Email 4 | - | - |
| Partner/Agency | - | - | - | Value touch | Value touch | Check-in call |
| Case Study | - | - | - | - | Soft touch | "Any projects?" |
| Long-Term Nurture | - | - | - | - | Newsletter | Personal note |
| Re-Engagement | Email 1 | - | Email 2 | - | - | "Still here" |

---

## Moving Between Campaigns

Contacts can move between campaigns based on signals:

| From | To | Trigger |
|------|----|---------|
| Direct Sales | Long-Term Nurture | "Bad timing" response |
| Long-Term Nurture | Direct Sales | Trigger event or re-engagement |
| Partner/Agency | Case Study Expansion | They become a client too |
| Any | Re-Engagement | Went cold for 6+ months |

**Document all campaign changes in Notes.**

---

## Campaign Content Library

Each campaign needs content ready to go:

### Direct Sales
- [ ] Email sequence (5-7 emails)
- [ ] LinkedIn connection templates
- [ ] LinkedIn message templates
- [ ] Personalization framework

### Partner/Agency
- [ ] Monthly value-add content ideas
- [ ] Partner program one-pager
- [ ] Case study examples to share
- [ ] Referral incentive details (if any)

### Long-Term Nurture
- [ ] Newsletter subscription
- [ ] Quarterly personal check-in template
- [ ] Trigger event response templates

---

## Adding New Campaigns

When a new campaign type is needed:

1. Define target audience
2. Define goal
3. Define cadence
4. Define content needed
5. Define entry criteria
6. Define exit criteria
7. Add to this file
8. Create detailed playbook file if complex (like `partner-track.md`)
