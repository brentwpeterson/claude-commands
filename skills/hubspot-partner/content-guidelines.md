# HubSpot Content Guidelines

Rules for writing HubSpot-related content on contentcucumber.com.

---

## HubSpot Branding Rules

These come from HubSpot's brand guidelines. Follow them in all content.

### Capitalization & Naming
- **HubSpot** - Always capitalize the H and S (never "Hubspot" or "hubspot")
- **CRM** - Can say "HubSpot CRM" or "HubSpot's CRM"
- **Hub names** - Always capitalize: Marketing Hub, Sales Hub, Service Hub, CMS Hub, Operations Hub, Commerce Hub
- **Tier names** - Capitalize: Free, Starter, Professional, Enterprise
- **Features** - Use HubSpot's own naming: Sequences (not "drip campaigns"), Workflows (not "automations"), Playbooks (not "scripts")
- **Partner designation** - "HubSpot Solutions Partner" (not "HubSpot partner", "HubSpot certified partner", or "HubSpot agency")

### Terms to Use
| Correct | Incorrect |
|---------|-----------|
| HubSpot Solutions Partner | HubSpot partner, HubSpot agency |
| Marketing Hub Professional | Marketing Hub Pro (acceptable in casual context) |
| Sequences | Drip campaigns, auto-emails |
| Workflows | Automations, auto-rules |
| Playbooks | Scripts, call sheets |
| Smart content | Dynamic content, personalized content |
| Topic clusters | Content pillars (acceptable but not HubSpot's term) |
| Contact | Lead (in HubSpot context, "contact" is the correct object name) |

### When "Pro" Is Acceptable
In casual/conversational content (blog posts, social media), "Sales Hub Pro" and "Marketing Hub Pro" are fine. On formal service pages and in schema markup, use "Professional."

---

## CC Voice Rules for HubSpot Content

### Positioning Language
CC is an **implementation and content partner**, not a vendor. Use relationship language.

| Use | Avoid |
|-----|-------|
| "We partner with you to..." | "We deliver solutions that..." |
| "Your HubSpot portal" | "The HubSpot instance" |
| "We'll configure" | "We'll deploy" |
| "Get more from HubSpot" | "Maximize your HubSpot ROI" |
| "Is HubSpot right for you?" | "HubSpot is the best platform" |

### Honesty Policy
CC is honest about HubSpot's limitations. This builds trust.

**Good:** "HubSpot CMS doesn't have the plugin ecosystem WordPress has. But if CRM integration matters more than unlimited customization, it's the better choice."

**Bad:** "HubSpot CMS is superior to WordPress in every way."

### Forbidden Terms (standard CC rules apply)
- No em dashes (use periods, commas, parentheses)
- No emojis unless explicitly requested
- No "unlock", "game-changer", "next level", "synergy"
- No fabricated quotes, stats, or testimonials

---

## Schema Markup Requirements

Every HubSpot service page needs structured data for search engines and AI answer engines.

### Required Schema Per Page

**Pillar page (`/hubspot/`):**
```json
{
  "@context": "https://schema.org",
  "@type": "Service",
  "name": "HubSpot Services",
  "provider": {
    "@type": "Organization",
    "name": "Content Cucumber",
    "url": "https://contentcucumber.com"
  },
  "description": "HubSpot Solutions Partner services including CMS migration, content creation, implementation, and audits.",
  "serviceType": ["CMS Migration", "Content Creation", "HubSpot Implementation", "HubSpot Audit"],
  "areaServed": "US"
}
```

**Each child page:**
- `Service` schema with specific service type
- `FAQPage` schema wrapping all FAQ questions
- `BreadcrumbList` schema showing hierarchy

**FAQ schema structure:**
```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question text]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer text]"
      }
    }
  ]
}
```

**BreadcrumbList schema:**
```json
{
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://contentcucumber.com/" },
    { "@type": "ListItem", "position": 2, "name": "HubSpot Services", "item": "https://contentcucumber.com/hubspot/" },
    { "@type": "ListItem", "position": 3, "name": "[Child Page Name]", "item": "https://contentcucumber.com/hubspot/[slug]/" }
  ]
}
```

### Schema Implementation
The requestdesk-connector plugin auto-generates Article and BreadcrumbList schema. FAQ schema is generated when the schema generator detects Q&A pairs in the content. Service schema should be added as a JSON-LD block within the page content.

---

## Internal Linking Strategy

### Link Map

```
/hubspot/ (pillar)
  ├── /hubspot/cms/
  ├── /hubspot/sales-hub-pro/
  ├── /hubspot/marketing-hub-pro/
  └── /hubspot/audit/
```

### Linking Rules
1. **Every child page** links back to the pillar page (`/hubspot/`)
2. **Every child page** links to the audit page (`/hubspot/audit/`) as a secondary CTA
3. **Every child page** links to at least one sibling page
4. **The pillar page** uses `[requestdesk_child_grid columns="2"]` to display all children
5. **Blog posts** about HubSpot topics link to the relevant service page

### Suggested Cross-Links

| From | To | Link Context |
|------|----|--------------|
| `/hubspot/cms/` | `/hubspot/audit/` | "Not sure if you need a migration? Start with a free audit." |
| `/hubspot/cms/` | `/hubspot/marketing-hub-pro/` | "After migration, make the most of Marketing Hub." |
| `/hubspot/sales-hub-pro/` | `/hubspot/marketing-hub-pro/` | "Align sales and marketing with both hubs configured." |
| `/hubspot/sales-hub-pro/` | `/hubspot/audit/` | "Already on Sales Hub? Get an audit to see what you're missing." |
| `/hubspot/marketing-hub-pro/` | `/hubspot/sales-hub-pro/` | "Marketing feeds sales. Configure both for full pipeline visibility." |
| `/hubspot/marketing-hub-pro/` | `/hubspot/cms/` | "Your website is your biggest marketing asset. Build it on HubSpot." |
| `/hubspot/audit/` | `/hubspot/cms/` | "Audit often reveals migration opportunities." |
| `/hubspot/audit/` | `/hubspot/sales-hub-pro/` | "Most audits find underused Sales Hub features." |

### CTA Destinations
- Primary CTA: `[NEED: /contact/ form? Calendar link? Dedicated HubSpot form?]`
- Audit CTA: `[NEED: Same form or dedicated audit request form?]`

---

## Meta Titles & Descriptions (templates)

### Pillar Page
- **Title:** HubSpot Services | Content Cucumber - HubSpot Solutions Partner
- **Description:** Content Cucumber is a HubSpot Solutions Partner offering CMS migration, content creation, Sales Hub and Marketing Hub implementation, and HubSpot audits.

### Child Pages
- **CMS:** HubSpot CMS Website Build & Migration | Content Cucumber
- **Sales Hub Pro:** Sales Hub Pro Implementation | Content Cucumber
- **Marketing Hub Pro:** Marketing Hub Pro Implementation | Content Cucumber
- **Audit:** HubSpot Audit & Optimization | Content Cucumber

Descriptions should be 150-160 characters, include "Content Cucumber" and "HubSpot", and describe the specific service.
