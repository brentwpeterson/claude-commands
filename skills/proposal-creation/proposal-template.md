# Proposal Template

Universal proposal template with tokens. Claude fills these tokens from the service type definition and discovery answers during generation.

---

## Token Reference

| Token | Source | Description |
|-------|--------|-------------|
| `{{SERVICE_NAME}}` | Service type definition | Display name of the service |
| `{{CLIENT_NAME}}` | Command argument | Client company name |
| `{{DATE}}` | Runtime | Today's date (Month DD, YYYY) |
| `{{REFERRAL}}` | `--referral` flag | Referral source (remove line if not provided) |
| `{{OVERVIEW}}` | Discovery answers | Customized overview paragraph |
| `{{DELIVERABLES_TABLE}}` | Service type definition | Deliverables table |
| `{{INVESTMENT_TABLE}}` | Service type definition | Investment/pricing table |
| `{{ADDONS_TABLE}}` | Service type definition | Optional add-ons table |
| `{{WHAT_WE_NEED}}` | Service type + discovery | Numbered list of requirements |
| `{{EQUIPMENT_SECTION}}` | Service type (video only) | Equipment table (omit for non-video) |
| `{{PROCESS_TABLE}}` | Service type definition | Process/timeline table |
| `{{TERMS}}` | Service type billing model | Payment terms |

---

## Template

```markdown
# {{SERVICE_NAME}}

**Prepared for:** {{CLIENT_NAME}}
**Prepared by:** Content Cucumber
**Date:** {{DATE}}
**Referred by:** {{REFERRAL}}

---

## Overview

{{OVERVIEW}}

---

## Package + Deliverables

{{DELIVERABLES_TABLE}}

---

## Investment

{{INVESTMENT_TABLE}}

---

## Optional Add-Ons

{{ADDONS_TABLE}}

---

## What We Need From You

{{WHAT_WE_NEED}}

---

{{EQUIPMENT_SECTION}}

## Process

{{PROCESS_TABLE}}

---

## Terms

{{TERMS}}

---

## About Content Cucumber

Content Cucumber helps businesses create content that drives discovery and sales. From blog content and SEO to video production and marketing management, we make your brand visible where customers are searching.

With 60K+ projects completed and 55M+ words written, we know what works. Our team of professional writers, strategists, and producers become an extension of yours.

**Contact:**
Brent Peterson
brent@contentbasis.io

---

## Next Steps

1. Review this proposal
2. Let us know any questions or adjustments
3. Confirm with signed agreement and deposit
4. We'll kick off your project

---

*This proposal is valid for 30 days from the date above.*
```

---

## Billing Model Templates

Use the correct terms section based on the service type's billing model.

### one-time

```
- 50% deposit to start
- 50% upon final delivery
- One round of revisions included
- Additional revisions billed at $X,XXX/hour
```

### monthly-retainer

```
- Monthly retainer, billed on the 1st of each month
- 30-day cancellation notice
- One round of revisions per deliverable included
- Additional revisions billed at $X,XXX/hour
```

### hybrid

```
- One-time setup/audit fee due upon signing
- Monthly retainer begins after setup phase, billed on the 1st
- 30-day cancellation notice after initial commitment period
- One round of revisions per deliverable included
- Additional revisions billed at $X,XXX/hour
```

---

## Customization Notes

**Overview section:** This is the most important customization. Use the discovery answers to write 2-3 sentences that:
1. Acknowledge the client's specific situation or problem
2. Describe what Content Cucumber will deliver for them
3. Connect the service to their business goals

If `--skip-discovery` was used, replace with: `[NEED: client overview - describe their business, problem, and how this service helps]`

**Referral line:** If `--referral` was not provided, remove the entire "Referred by" line from the header.

**Equipment section:** Only include for `video` service type. For all others, omit the section entirely (no heading, no placeholder).

**Investment table:** Copy the structure from the service type definition. NEVER fill in dollar amounts. Every price stays as `$X,XXX`.

**What We Need list:** Start with the service type's default list, then add any items that came up during discovery (e.g., if client mentioned a specific platform, add platform access to the list).
