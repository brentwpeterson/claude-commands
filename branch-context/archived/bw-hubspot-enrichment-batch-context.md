# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/hubspot-enrichment`
2. **Branch:** `main`
3. **Load brand persona:** Run `/brand-brent` before generating content

## SESSION SUMMARY
**Task:** HubSpot Contact Primary Flag & Deduplication - COMPLETE

## WHAT WE DID THIS SESSION

### 1. Finalized Personalization Paragraphs
- Found 20 contacts missing personalization_paragraph in new export
- Generated 19 paragraphs (1 contact had no email) → `personalization-batch-final-20.csv`
- **PENDING:** Import CSV to HubSpot

### 2. Fixed Contact-Company Associations
Associated 6 contacts with their companies in HubSpot:
| Contact Email | Company |
|---------------|---------|
| kerry@manskape.com | Wild Willies |
| hello@zenandether.com | Zen + Ether |
| support@sharptactkreativ.com | Sharp Tact Kreativ |
| anya@taelor.ai | Taelor |
| info@craftklaris.com | Klaris |
| emailmarketing@aventon.com | Aventon |

### 3. Fixed Missing First Names
Updated 6 contacts with placeholder team names:
| Email | First Name |
|-------|------------|
| info@craftklaris.com | Klaris Team |
| emailmarketing@aventon.com | Aventon Marketing |
| press@zestypawspr.com | Zesty Paws PR |
| international@twobrothersindia.com | Two Brothers International |
| team@slateflosser.com | Slate Flosser Team |
| support@slateflosser.com | Slate Flosser Support |

### 4. Created primary_company_contact Property
- Created new HubSpot property for email list deduplication
- Type: enumeration with booleancheckbox fieldType
- Values: true (primary), false (excluded)
- Purpose: Only contacts with true will receive emails

### 5. Set Primary Flag for All 368 Contacts
Used scoring algorithm to determine best contact per company:
- **332 contacts** set to `true` (primary - will receive emails)
- **36 contacts** set to `false` (excluded from email lists)

**Scoring Logic:**
```
+10 has personalization_paragraph
+5  has real email (not generic)
+3  has first name
+2  has last name
-8  generic email prefix (info@, support@, team@, etc.)
-5  team names as last name (Team, Support, PR, Marketing)
```

## DATA FILES
Location: `/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/hubspot-enrichment/data/`

| File | Purpose |
|------|---------|
| `hubspot-crm-exports-shopify-all-2026-01-10-1.csv` | Main export (368 contacts) |
| `personalization-batch-final-20.csv` | 19 paragraphs to import |
| `personalization-batch-*.csv` | Previous batch files |

## CONTACT IDS (for reference)
Primary contacts (332): See `/tmp/hubspot_ids.py` for full list
Non-primary contacts (36): Set to primary_company_contact=false

## PENDING ACTIONS
1. **Import CSV:** Upload `personalization-batch-final-20.csv` to HubSpot
2. **Optional:** Run Wappalyzer on contact domains to verify Shopify platform
3. **Optional:** Address 69 contacts missing "Company Name" text field

## FIELD COVERAGE (after pending import)
| Field | Count | Notes |
|-------|-------|-------|
| Total contacts | 368 | Shopify ALL list |
| personalization_paragraph | 367 | +19 after import |
| first_name filled | 368 | All have names now |
| primary_company_contact=true | 332 | Will receive emails |
| primary_company_contact=false | 36 | Excluded duplicates |

## PLATFORM DETECTION
If needed, use `/detect-platform` skill or check:
- `skunk-works/site-discovery/README.md` for Wappalyzer workflow
- Maps to HubSpot platform values (Shopify, Magento, BigCommerce, etc.)

## CONTEXT NOTES
- This enrichment is for Shopify merchant outreach
- All paragraphs use Brent's brand voice via /brand-brent
- Deduplication ensures only 1 contact per company gets emails
