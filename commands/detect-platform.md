Detect Platform - HubSpot Contact Platform Detection via Wappalyzer

**USAGE:**
- `/detect-platform <contact_id>` - Detect platform for a single contact
- `/detect-platform --batch <limit>` - Process multiple contacts missing platform
- `/detect-platform --score-min <score>` - Filter by minimum lead score

**Arguments:**
- `<contact_id>` (optional): HubSpot contact ID to process
- `--batch <limit>`: Process up to N contacts missing platform field
- `--score-min <score>`: Only process contacts with lead score >= value
- `--dry-run`: Detect platforms but don't update HubSpot

---

## Purpose

Detect e-commerce platforms for HubSpot contacts using Wappalyzer and update their `platform` field.

## Workflow

```
HubSpot Contact (missing platform)
       ↓
Get associated Company → domain field
       ↓
Run Wappalyzer on domain
       ↓
Map result to HubSpot platform value
       ↓
Update Contact.platform field
```

---

## EXECUTION STEPS

### Step 1: Get Contact (or find contacts missing platform)

**If contact_id provided:**
```
Use mcp__hubspot__hubspot-batch-read-objects:
- objectType: "contacts"
- inputs: [{"id": "<contact_id>"}]
- properties: ["firstname", "lastname", "email", "company", "platform", "primary_contact_lead_score_v1"]
```

**If --batch mode (find contacts missing platform):**
```
Use mcp__hubspot__hubspot-search-objects:
- objectType: "contacts"
- filterGroups: [{"filters": [
    {"propertyName": "platform", "operator": "NOT_HAS_PROPERTY"}
  ]}]
- properties: ["firstname", "lastname", "email", "company", "primary_contact_lead_score_v1"]
- limit: <batch limit>
- sorts: [{"propertyName": "primary_contact_lead_score_v1", "direction": "DESCENDING"}]
```

**If --score-min provided, add filter:**
```
{"propertyName": "primary_contact_lead_score_v1", "operator": "GTE", "value": "<score>"}
```

### Step 2: Get Associated Company

For each contact, get the associated company:

```
Use mcp__hubspot__hubspot-list-associations:
- objectType: "contacts"
- objectId: "<contact_id>"
- toObjectType: "companies"
```

Extract the `toObjectId` from the result (company ID).

### Step 3: Get Company Domain

```
Use mcp__hubspot__hubspot-batch-read-objects:
- objectType: "companies"
- inputs: [{"id": "<company_id>"}]
- properties: ["name", "domain", "website"]
```

Extract the `domain` field. If empty, try `website` field.

### Step 4: Run Wappalyzer

```bash
wappalyzer https://<domain> --pretty 2>/dev/null | jq '.technologies[].name'
```

**Timeout:** 60 seconds per domain

### Step 5: Map Platform

Check Wappalyzer results against this mapping:

| Wappalyzer Detects | HubSpot Value |
|--------------------|---------------|
| "Shopify" | `Shopify` |
| "Magento" | `Magento` |
| "BigCommerce" | `BigCommerce` |
| "WooCommerce" | `Wordpress` |
| "Shopware" | `Shopware` |
| None of above | `Other` or `N/A` |

**Logic:**
```python
PLATFORM_MAP = {
    "Shopify": "Shopify",
    "Magento": "Magento",
    "BigCommerce": "BigCommerce",
    "WooCommerce": "Wordpress",
    "Shopware": "Shopware",
}

detected_platform = None
for tech in wappalyzer_results:
    if tech in PLATFORM_MAP:
        detected_platform = PLATFORM_MAP[tech]
        break

if not detected_platform:
    # Check if any e-commerce indicators exist
    ecommerce_indicators = ["Cart Functionality", "Shop Pay", "Payment"]
    has_ecommerce = any(ind in wappalyzer_results for ind in ecommerce_indicators)
    detected_platform = "Other" if has_ecommerce else "N/A"
```

### Step 6: Update HubSpot (unless --dry-run)

```
Use mcp__hubspot__hubspot-batch-update-objects:
- objectType: "contacts"
- inputs: [{"id": "<contact_id>", "properties": {"platform": "<detected_platform>"}}]
```

### Step 7: Report Results

Display summary:

```
| Contact | Company | Domain | Detected | Updated |
|---------|---------|--------|----------|---------|
| Chris Thornley | Squirrel's Nut Butter | squirrelsnutbutter.com | Shopify | Yes |
```

---

## HubSpot Properties Reference

### Source: Company.domain
- **Object:** companies
- **Property:** `domain`
- **Type:** string
- **Description:** Company Domain Name - used for Wappalyzer lookup

### Target: Contact.platform
- **Object:** contacts
- **Property:** `platform`
- **Type:** enumeration
- **Valid Values:**
  - `Shopify`
  - `Magento`
  - `BigCommerce`
  - `Wordpress` (includes WooCommerce)
  - `Shopware`
  - `Other`
  - `N/A`

### Lead Score: Contact.primary_contact_lead_score_v1
- **Object:** contacts
- **Property:** `primary_contact_lead_score_v1`
- **Type:** number
- **Description:** Marketing engagement score for prioritizing contacts

---

## Error Handling

| Error | Action |
|-------|--------|
| No associated company | Skip contact, report "No company associated" |
| Company has no domain | Skip contact, report "No domain found" |
| Wappalyzer timeout | Report "Timeout", do not update platform |
| Wappalyzer error | Report "Error", do not update platform |
| HubSpot API error | Report error, continue to next contact |

---

## Examples

**Single contact:**
```
/detect-platform 182220553822
```
Result: Detects platform for contact ID 182220553822

**Batch of 10 high-scoring contacts:**
```
/detect-platform --batch 10 --score-min 20
```
Result: Processes up to 10 contacts with lead score >= 20 that are missing platform

**Dry run to preview:**
```
/detect-platform --batch 5 --dry-run
```
Result: Shows what would be detected without updating HubSpot

---

## Requirements

- Wappalyzer CLI installed: `npm install -g wappalyzer`
- HubSpot MCP tools available
- Internet access for domain lookups

---

## Related Files

- Documentation: `/Users/brent/scripts/CB-Workspace/skunk-works/site-discovery/README.md`
- Original script: `/Users/brent/scripts/CB-Workspace/skunk-works/site-discovery/process-magento-list.py`
