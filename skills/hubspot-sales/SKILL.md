# HubSpot Sales Skill

**Skill Description:** Complete sales workflow management in HubSpot, from cold outreach through close. Covers behavioral analysis, lead scoring, enrichment, personalization, and multi-channel outreach (email + LinkedIn).

---

## When Claude Should Apply This Skill

Apply automatically when:
- Working on HubSpot tasks or contacts
- User asks about lead status, follow-ups, or outreach
- Enriching contact records (`/hubspot-enrich`)
- Writing personalization content for prospects
- Analyzing engagement signals (opens, clicks, replies)
- Discussing pipeline, deals, or sales activity
- LinkedIn outreach planning

---

## Critical Files (Read Order)

1. **guardrails.md** - MUST READ FIRST. Internal vs external content rules.
2. **funnel-stages.md** - Lifecycle stages and lead status definitions
3. **scoring.md** - Lead scores (custom + HubSpot predictive)
4. **behavioral-signals.md** - How to interpret engagement data
5. **enrichment-workflow.md** - When/how to enrich records
6. **personalization-rules.md** - Writing client-facing content
7. **linkedin-outreach.md** - LinkedIn-specific workflow
8. **recommended-actions.md** - Signal → Action mapping

---

## Core Principles

### 1. Notes Are Private, Tokens Are Public
Everything you learn about a contact goes in NOTES.
Everything the contact might see goes through `/brand-brent`.
See `guardrails.md` for details.

### 2. Signals Drive Actions
Don't just report engagement. Recommend specific next actions.
"8 clicks" → "Follow up within 48 hours with demo-specific CTA"

### 3. Enrich Before Personalizing
Always check if enrichment data exists before writing personalization.
Run `/hubspot-enrich` if tech stack, company info, or context is missing.

### 4. Score-Aware Prioritization
Check both custom scores AND HubSpot predictive scores.
High scores + high engagement = immediate attention.

### 5. Multi-Channel Thinking
Email silence doesn't mean disinterest. Recommend LinkedIn touches.
Track which channel gets response.

---

## HubSpot Properties Reference

### Lifecycle Stages (in order)
| Stage | Meaning |
|-------|---------|
| Subscriber | Opted in, no sales activity |
| Lead | Basic qualification, in outreach |
| MQL | Marketing Qualified - engagement threshold met |
| SQL | Sales Qualified - fit + engagement confirmed |
| Opportunity | Active deal in pipeline |
| Customer | Closed won |
| Evangelist | Customer + referral potential |

### Lead Status (outreach tracking)
| Status | Meaning |
|--------|---------|
| New | Not yet contacted |
| Open | Active outreach in progress |
| Attempted to Contact | Outreach sent, no response |
| Connected | Response received |
| Bad Timing | Interested but not now |
| Past Client | Former customer |
| Unqualified | Not a fit |
| No More Emails | Opted out of email |

### Scoring Properties
| Property | Source | Use |
|----------|--------|-----|
| `hubspotscore` | Custom | Manual/workflow score |
| `primary_contact_lead_score_v1` | Custom | Combined fit + engagement |
| `primary_contact_lead_score_v1_fit` | Custom | Company/role fit score |
| `primary_contact_lead_score_v1_engagement` | Custom | Activity-based score |
| `hs_predictivecontactscore_v2` | HubSpot | AI likelihood to close |
| `hs_predictivescoringtier` | HubSpot | Contact priority tier |

---

## Integration with Other Commands

| Command | When to Use |
|---------|-------------|
| `/hubspot-enrich` | Before personalizing, when tech stack unknown |
| `/brand-brent` | Before writing ANY client-facing content |
| `/send-email` | After personalization is ready |

---

## Quick Decision Tree

```
New HubSpot Task
    │
    ├─► Is contact enriched?
    │       NO → Run /hubspot-enrich first
    │       YES ↓
    │
    ├─► Check engagement signals
    │       • Last activity date
    │       • Email opens/clicks (if visible)
    │       • hs_last_sales_activity_timestamp
    │
    ├─► Check scores
    │       • Custom score
    │       • HubSpot predictive score
    │       • Fit vs engagement balance
    │
    ├─► Determine action (see recommended-actions.md)
    │       • High engagement → Immediate follow-up
    │       • Low engagement → Try different channel
    │       • No engagement → Sequence or drop
    │
    ├─► Write internal insights → NOTES
    │
    └─► Write personalization → Tokens (via /brand-brent)
```

---

## Data Sources for Enrichment

| Source | Data |
|--------|------|
| HubSpot contact | Basic info, activity history, scores |
| HubSpot company | Industry, size, tech stack (if populated) |
| Wappalyzer | Tech stack detection |
| Company website | Products, messaging, differentiators |
| LinkedIn | Role, tenure, connections, content |
| HubSpot sequences | Which sequence, which step, engagement |

---

## MQL/SQL Definitions (Current State)

**Note:** MQL and SQL criteria are being refined. Current state:

**MQL (Marketing Qualified Lead):**
- Engagement threshold met (opens, clicks, form fills)
- Property: `mql` (enumeration)
- Needs: Clear scoring threshold definition

**SQL (Sales Qualified Lead):**
- Fit confirmed (right company size, industry, tech stack)
- Engagement confirmed (responded, booked meeting, demo completed)
- Needs: Clear criteria documentation

**Action:** As we work contacts, document what actually qualifies them. This skill will evolve with real examples.
