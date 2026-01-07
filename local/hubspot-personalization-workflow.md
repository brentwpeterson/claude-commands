# HubSpot Personalization Workflow

**Purpose:** Document how to use the `personalization_paragraph` field for targeted outreach campaigns.

**Created:** 2026-01-06
**Use Case:** Shopify Integration Demo Invites

---

## Field Details

| Property | Value |
|----------|-------|
| **Field Name** | `personalization_paragraph` |
| **Type** | textarea (string) |
| **Group** | personalization_group |
| **Location** | Contact record |

---

## Research Workflow

### Step 1: Pull Contact + Context from HubSpot

Before writing personalization, gather:

```
1. Contact properties (name, title, company, email)
2. Associated company details
3. Associated notes (shows activity history)
4. Associated deals (if any)
```

**Claude Commands:**
```
# Find contact
mcp__hubspot__hubspot-search-objects (objectType: contacts, query: "Name")

# Get notes
mcp__hubspot__hubspot-list-associations (contacts → notes)
mcp__hubspot__hubspot-batch-read-objects (notes with IDs)

# Get company
mcp__hubspot__hubspot-list-associations (contacts → companies)
mcp__hubspot__hubspot-batch-read-objects (companies with ID)
```

### Step 2: Analyze History

Look for:
- Previous calls (Fireflies transcripts in notes)
- Email opens (Mixmax tracking in notes)
- What was discussed
- What went cold and WHY
- Any action items that were never completed

### Step 3: Write Personalization

**Template Structure:**
```
[Reference to past interaction OR specific observation about their business]
[Bridge to what's NEW/different now]
[Why it matters to them specifically]
```

**Rules:**
- Keep under 50 words for email flow
- Reference something REAL (past call, their website, mutual connection)
- Don't be generic - if you can swap company names, it's not personalized enough
- Acknowledge time passed if re-engaging cold contact

### Step 4: Update HubSpot

```
mcp__hubspot__hubspot-batch-update-objects
  objectType: "contacts"
  inputs: [{"id": "CONTACT_ID", "properties": {"personalization_paragraph": "YOUR TEXT"}}]
```

---

## Example: Paul Rosenwald (Re-engagement)

### Contact Summary

| Field | Value |
|-------|-------|
| **Name** | Paul Rosenwald |
| **Title** | VP Sales & Partnerships |
| **Company** | SeaMonster Studios (Seattle, WA) |
| **Email** | paul@seamonsterstudios.com |
| **LinkedIn** | linkedin.com/in/paulrosenwald |
| **Background** | Costco, Amazon |

### History from HubSpot Notes

**June 26, 2024 - 15 min call (Fireflies transcript)**
- Discussed potential partnership for content services
- Paul interested, was to discuss pricing with colleague Wes
- Brent was to send follow-up with partner agreement
- Planned regular check-in calls

**July-August 2024 - Email Activity**
- Opened "Shopify Content Program" emails multiple times
- Opened "eTail Boston" email
- No response/reply captured

**Status:** Went cold after August 2024 (18 months ago)

### Personalization Drafted

```
Paul - we talked back in June 2024 about content partnerships for SeaMonster's Shopify clients. Since then, I've built something new: a Shopify app that automates blog content creation directly in the merchant's store. Given your agency's focus, I'd love to show you how it works and see if there's a fit for your portfolio.
```

### Why This Works
- References the specific past call (not generic)
- Acknowledges time passed ("since then")
- Highlights what's NEW (Shopify app vs. just services)
- Ties to HIS business (agency portfolio)

---

## Campaign Tracking: Shopify Integration Demo (Jan 2026)

| Contact | Company | Context | Personalization | Status |
|---------|---------|---------|-----------------|--------|
| Paul Rosenwald | SeaMonster Studios | Past call Jun 2024, went cold | Drafted | Ready to update |
| | | | | |
| | | | | |

---

## Notes

- Always check notes BEFORE writing - the history changes everything
- Fireflies transcripts are goldmines for personalization hooks
- If they opened emails but didn't reply, the subject line worked but the offer didn't land
- Re-engagement works best when you have something genuinely NEW to offer
