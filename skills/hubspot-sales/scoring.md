# Lead Scoring: Custom + HubSpot Predictive

**Purpose:** Understand and use all available scoring to prioritize contacts.

---

## Scoring Philosophy

**Two dimensions matter:**
1. **Fit** - Are they the right type of customer?
2. **Engagement** - Are they showing interest?

**High Fit + High Engagement = Priority**
**High Fit + Low Engagement = Nurture**
**Low Fit + High Engagement = Qualify further or disqualify**
**Low Fit + Low Engagement = Deprioritize**

---

## Custom Scores (Your HubSpot)

### Primary Contact Lead Score v1
**Property:** `primary_contact_lead_score_v1`
**Type:** Number (combined score)

**Components:**
- `primary_contact_lead_score_v1_fit` - Company/role fit
- `primary_contact_lead_score_v1_engagement` - Activity-based

**Threshold Property:** `primary_contact_lead_score_v1_threshold`

**Usage:**
```
Total Score = Fit Score + Engagement Score
If Total >= Threshold → MQL candidate
```

### HubSpot Score
**Property:** `hubspotscore`
**Type:** Number

**Notes:** Manual or workflow-driven score. Check how it's being set.

### MQL Flag
**Property:** `mql`
**Type:** Enumeration

**Usage:** Binary indicator that MQL threshold was met.

---

## HubSpot Predictive Scores (AI-Powered)

HubSpot's AI analyzes your historical data to predict outcomes.

### Likelihood to Close
**Property:** `hs_predictivecontactscore_v2`
**Type:** Number (0-100)

**What it measures:** Probability this contact becomes a customer based on:
- Similar contacts who converted
- Engagement patterns
- Company characteristics

**How to use:**
| Score | Meaning | Action |
|-------|---------|--------|
| 80-100 | Very likely to close | High priority, personal attention |
| 60-79 | Good chance | Active pursuit |
| 40-59 | Moderate chance | Standard sequence |
| 20-39 | Lower chance | Nurture, don't over-invest |
| 0-19 | Unlikely | Minimal effort or disqualify |

### Contact Priority
**Property:** `hs_predictivescoringtier`
**Type:** Enumeration

**Tiers:**
- Tier 1 - Highest priority
- Tier 2 - High priority
- Tier 3 - Medium priority
- Tier 4 - Lower priority

**How to use:** Quick filter for daily task prioritization.

### Lead Rating
**Property:** `hs_predictivecontactscorebucket`
**Type:** Enumeration

**Buckets:** Likely categorical (Hot, Warm, Cold, etc.)

---

## Score Comparison Matrix

When evaluating a contact, check ALL scores:

| Custom Fit | Custom Engagement | HubSpot Predictive | Priority |
|------------|-------------------|-------------------|----------|
| High | High | High | **TOP PRIORITY** |
| High | High | Low | Investigate discrepancy |
| High | Low | High | Engage more, HubSpot sees potential |
| High | Low | Low | Long-term nurture |
| Low | High | High | Recheck fit criteria |
| Low | High | Low | Curiosity seeker, low value |
| Low | Low | Any | Deprioritize |

---

## Score-Based Actions

### Daily Prioritization
1. Pull contacts with tasks due today
2. Sort by: `hs_predictivescoringtier` (Tier 1 first)
3. Secondary sort: `primary_contact_lead_score_v1` (highest first)
4. Work in that order

### Weekly Review
1. Find contacts where custom score != predictive score
2. Investigate: Why does HubSpot AI see them differently?
3. Adjust criteria or investigate data quality

### MQL Threshold Calibration
1. Review contacts who became customers
2. What was their score before converting?
3. Set MQL threshold at 80th percentile of converted contacts

---

## Fit Scoring Criteria (To Document)

**What should increase fit score:**

| Factor | Points | Notes |
|--------|--------|-------|
| Company size: 10-500 employees | +X | Sweet spot |
| Industry: E-commerce/Retail | +X | Primary target |
| Tech stack: Shopify | +X | Best fit |
| Tech stack: Magento | +X | Good fit |
| Role: Marketing/E-commerce leader | +X | Decision maker |
| Role: Founder/CEO (small co) | +X | Decision maker |

**What should decrease fit score:**

| Factor | Points | Notes |
|--------|--------|-------|
| Company size: <5 employees | -X | Too small |
| Company size: >5000 employees | -X | Enterprise (different sale) |
| Tech stack: Custom/headless | -X | Integration complexity |
| Role: Individual contributor | -X | Not decision maker |

**Action:** Document actual criteria as we discover what predicts success.

---

## Engagement Scoring Criteria (To Document)

**What should increase engagement score:**

| Action | Points | Notes |
|--------|--------|-------|
| Email open | +X | Basic interest |
| Email click | +X | Active interest |
| Multiple clicks same email | +X | High interest |
| Demo page visit | +X | Buying intent |
| Pricing page visit | +X | Evaluating |
| Form submission | +X | Hand raised |
| Meeting booked | +X | Very high intent |
| Reply to email | +X | Conversation started |

**Engagement decay:**
- Points should decay over time if no new activity
- 30 days no activity → reduce engagement score by X%

---

## Querying Scores

When working a contact, pull these properties:

```
properties: [
  "primary_contact_lead_score_v1",
  "primary_contact_lead_score_v1_fit",
  "primary_contact_lead_score_v1_engagement",
  "hubspotscore",
  "hs_predictivecontactscore_v2",
  "hs_predictivescoringtier",
  "hs_predictivecontactscorebucket",
  "mql"
]
```

---

## Score Insights for Notes

When documenting score analysis:

```
Score Analysis (2026-01-23):

Custom Scores:
- Total: [X] (Fit: [X], Engagement: [X])
- MQL Threshold: [X]
- Status: [Above/Below threshold]

HubSpot Predictive:
- Likelihood to Close: [X]%
- Priority Tier: [X]
- Lead Rating: [X]

Assessment: [High priority / Standard / Nurture / Deprioritize]
Discrepancies: [Any mismatch between custom and predictive?]
```
