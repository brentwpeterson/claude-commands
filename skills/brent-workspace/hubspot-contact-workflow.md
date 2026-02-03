# HubSpot Contact Workflow

**Trigger:** When working HubSpot tasks that involve contact follow-up

---

## Personalization Token Updates

When a task mentions "update personalization token" or contact needs enrichment before outreach:

### Standard Flow

1. **Find the contact** - Search by name or company
2. **Check associated company** - Get company details if contact.company is null
3. **Update key fields:**

| Field | Property Name | Common Values |
|-------|---------------|---------------|
| Company | `company` | Pull from associated company name |
| Platform | `platform` | Shopify, Magento, BigCommerce, Wordpress, Shopware, Other, N/A |
| Job Title | `jobtitle` | CEO, CMO, Director of Marketing, etc. |

4. **Mark task complete**

### Platform Detection

If Brent says "they're on [platform]":
```
mcp__hubspot__hubspot-batch-update-objects
  objectType: contacts
  inputs: [{"id": "[CONTACT_ID]", "properties": {"platform": "[Platform]"}}]
```

Valid platform values:
- Shopify
- Magento
- BigCommerce
- Wordpress
- Shopware
- Other
- N/A

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

---

## Task Completion

After updating contact, mark task complete:
```
mcp__hubspot__hubspot-batch-update-objects
  objectType: tasks
  inputs: [{"id": "[TASK_ID]", "properties": {"hs_task_status": "COMPLETED"}}]
```

---

## Common Personalization Fields

| Field | Property | Use Case |
|-------|----------|----------|
| First Name | `firstname` | Email greeting |
| Last Name | `lastname` | Formal address |
| Company | `company` | "Hi [Name] at [Company]" |
| Job Title | `jobtitle` | Role-specific messaging |
| Platform | `platform` | Product-specific outreach |

---

*Last Updated: 2026-01-21*
