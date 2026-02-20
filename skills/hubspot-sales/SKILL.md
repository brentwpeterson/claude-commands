# HubSpot Sales Skill

**Skill Description:** Complete sales workflow management in HubSpot. Covers task triage, contact lookup, behavioral analysis, lead scoring, enrichment, personalization, sequences, and multi-channel outreach (email + LinkedIn).

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

## Task Decision Tree

When Brent gives a HubSpot task, follow this workflow:

### Step 1: Pull Context

```
Search contact by name/company:
  mcp__hubspot__hubspot-search-objects
    objectType: contacts
    query: "[Name or Company]"
    properties: ["firstname", "lastname", "email", "company", "jobtitle",
                 "platform", "hubspotscore", "hs_predictivecontactscore_v2",
                 "hs_lead_status", "lifecyclestage",
                 "hs_last_sales_activity_timestamp"]
```

Check for associated deals and company record if relevant.

### Step 2: Present Summary

Show Brent a quick card:

```
CONTACT: [Name] | [Company] | [Title]
STAGE: [Lifecycle] | STATUS: [Lead Status]
SCORES: Custom [X] | Predictive [X]
LAST TOUCH: [Date and type]
PLATFORM: [Shopify/Magento/WordPress/etc.]
SEQUENCE: [Active sequence if any]
TASK: [What the task says to do]
```

### Step 3: Recommend Action

Based on signals, recommend ONE of:

| Signal Pattern | Recommendation |
|---------------|----------------|
| High engagement + recent activity | Email follow-up (draft it) |
| Opened emails, no reply | Try different channel (LinkedIn) |
| No engagement, multiple attempts | Skip or archive |
| New lead, no outreach yet | Enrich first, then personalize |
| Replied positively | Book a meeting |
| Unsubscribed/bounced | Close task, update status |
| Already in active deal | Check deal stage, follow deal workflow |

### Step 4: Brent Decides

Present the recommendation. Brent picks:
- **Email** - Draft in Gmail (ALWAYS draft, never send)
- **LinkedIn** - Draft the message text
- **Call** - Prepare talking points
- **Skip** - Mark task complete, note why
- **Archive** - Update lead status, close task
- **Enrich first** - Run `/hubspot-enrich` then return to Step 2

### Step 5: Execute

- **Emails:** Create Gmail draft via `mcp__gmail__gmail_create_draft` (NEVER send)
- **HubSpot updates:** Use `mcp__hubspot__hubspot-batch-update-objects`
- **Task completion:** Set `hs_task_status: COMPLETED`

---

## Core Principles

### 1. Notes Are Private, Tokens Are Public
Everything you learn about a contact goes in NOTES.
Everything the contact might see goes through `/brand-brent`.
See `guardrails.md` for details.

### 2. Signals Drive Actions
Don't just report engagement. Recommend specific next actions.
"8 clicks" -> "Follow up within 48 hours with demo-specific CTA"

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

## Contact Lookup Reference

### Finding Contacts

**By name:**
```
mcp__hubspot__hubspot-search-objects
  objectType: contacts
  query: "[Name]"
  properties: ["firstname", "lastname", "email", "company", "jobtitle", "platform"]
```

**By company association:**
```
# Find company first
mcp__hubspot__hubspot-search-objects
  objectType: companies
  query: "[Company Name]"

# Then get associated contacts
mcp__hubspot__hubspot-list-associations
  objectType: companies
  objectId: "[COMPANY_ID]"
  toObjectType: contacts
```

### Updating Contact Fields

```
mcp__hubspot__hubspot-batch-update-objects
  objectType: contacts
  inputs: [{"id": "[CONTACT_ID]", "properties": {"field": "value"}}]
```

| Field | Property Name | Common Values |
|-------|---------------|---------------|
| Company | `company` | Pull from associated company name |
| Platform | `platform` | Shopify, Magento, BigCommerce, Wordpress, Shopware, Other, N/A |
| Job Title | `jobtitle` | CEO, CMO, Director of Marketing, etc. |

### Task Completion

```
mcp__hubspot__hubspot-batch-update-objects
  objectType: tasks
  inputs: [{"id": "[TASK_ID]", "properties": {"hs_task_status": "COMPLETED"}}]
```

---

## Sequence Rules

### Sequence Naming Convention

**Format:** `SEQ-[TARGET]-[TYPE]-[NUMBER]`

| Component | Description | Examples |
|-----------|-------------|----------|
| SEQ | Prefix (always) | SEQ |
| TARGET | Who it's for | SHOPIFY, MAGENTO, HUBSPOT, WOOCOMMERCE |
| TYPE | What it does | DEMO, NURTURE, REACTIVATE, ONBOARD |
| NUMBER | Version/variant | 001, 002, 003 |

### Rule: Sequence Code in Manual Tasks

ALL manual task subjects MUST include the sequence code.

**Format:** `[SEQUENCE-CODE]: [Task Description]`

**Example:**
```
Subject: SEQ-TRE-001: Richard from Utu Sun opened Email 3
Body: Contact opened "Running Commerce episodes start recording this month" email.
Sequence doc: obsidian://open?vault=Brent%20Notes&file=HubSpot%2Ftemplates%2Femail-sequences%2FSEQ-TRE-001
Follow up referencing the recording timeline / urgency angle.
```

### Existing Sequences

| Code | Target | Type | Doc |
|------|--------|------|-----|
| SEQ-SHOPIFY-DEMO-001 | Shopify store owners | Demo booking | Obsidian: HubSpot/templates/email-sequences/ |
| SEQ-TRE-001 | Running brand founders | Podcast booking | Obsidian: HubSpot/templates/email-sequences/ |
| SEQ-PARTNER-001 | Partners | TBD | Obsidian: HubSpot/templates/email-sequences/ |

### Sequence Documentation Location

All sequences MUST have a doc in:
```
brent-workspace/ob-notes/Brent Notes/HubSpot/templates/email-sequences/
```

### Task Cleanup Rules

Delete/close tasks for contacts who have:
- Unsubscribed
- Bounced
- Already replied
- Already booked a meeting
- Entered a deal

---

## HubSpot Email Templates

Saved templates in HubSpot for manual sends:

| Template Code | Purpose | When to Use |
|---------------|---------|-------------|
| Shopify RD follow up - 012026 | RequestDesk free offer + 3 months managed content | Shopify leads |
| WordPress RD follow up - 012026 | WordPress plugin + AEO + managed content | WordPress leads |
| CC Generic follow up - 012026 | Content Cucumber Content Flywheel Plan | Platform-agnostic |

**Template Properties Used:**
- `personalization_paragraph` - Custom intro paragraph per contact

### Personalization Paragraph Rules

The personalization_paragraph is a CUSTOM HOOK, not a mini version of the offer.

**IS:** A specific hook about THEIR brand/situation that shows research.
**IS NOT:** A repeat of the offer (template already has that), links, or generic copy.

**Good example:**
```
Hi Maddie. Created Co. stands out in a market full of YETI and Stanley knockoffs.
The craftsmanship story is there, but is it getting told? Your blog could be where
customers learn why a Created tumbler is worth the investment.
```

**Bad example:** Anything that repeats the offer, includes demo links, or says "great meeting you" when you didn't actually meet.

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

## Reference Files (in this directory)

| File | Purpose |
|------|---------|
| guardrails.md | Internal vs external content rules (READ FIRST) |
| funnel-stages.md | Lifecycle stages and lead status definitions |
| scoring.md | Lead scores (custom + HubSpot predictive) |
| behavioral-signals.md | How to interpret engagement data |
| enrichment-workflow.md | When/how to enrich records |
| personalization-rules.md | Writing client-facing content |
| linkedin-outreach.md | LinkedIn-specific workflow |
| recommended-actions.md | Signal -> Action mapping |
| campaigns.md | Active campaign details |
| partner-track.md | Partner outreach workflow |

---

## Integration with Other Commands

| Command | When to Use |
|---------|-------------|
| `/hubspot-enrich` | Before personalizing, when tech stack unknown |
| `/brand-brent` | Before writing ANY client-facing content |
| `/send-email` | After personalization is ready |

---

*Last Updated: 2026-02-19*
