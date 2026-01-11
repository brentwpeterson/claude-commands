# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Branch:** `main`
3. **Load brand persona:** Run `/brand-brent` before generating content

## SESSION SUMMARY
**Task:** HubSpot Contact Personalization Enrichment POC

## WHAT WE WERE WORKING ON
Building a workflow to enrich HubSpot contacts with `personalization_paragraph` field using Claude to generate personalized outreach hooks for Shopify prospects.

### Approach Decided
- Use MCP/Claude directly (cheaper than Anthropic API credits)
- Generate paragraphs in Brent's voice (loaded via /brand-brent)
- Output CSV with email + paragraph for HubSpot import
- Process in batches of 50 to manage context

### Voice Guidelines Established
- Don't start with "As the [role] of [company]..."
- Lead with company/product, not person's role
- Direct, confident, make client the hero
- No em dashes, no "just" when minimizing
- Under 50 words per paragraph

## CURRENT STATE
- **Source file:** `/Users/brent/Downloads/hubspot-crm-exports-shopify-all-2026-01-10.csv`
- **Total contacts:** 351 missing personalization_paragraph
- **Validated:** First 10 all pass validation (have name, email, company, description)
- **Generated:** First 10 personalization paragraphs (approved by user)
- **Pending:** Contacts 11-351 (remaining 341)

### POC Scripts Created (for future standalone use)
Location: `/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/hubspot-enrichment/`
- `enrich.py` - Single contact enrichment
- `enrich_batch.py` - Batch processing
- `validate.py` - Contact validation checks
- `.env.example` - API key template
- `requirements.txt` - Dependencies
- `README.md` - Setup instructions

## FIRST 10 PARAGRAPHS (APPROVED)

```
1. ethan@curistrelief.com
Curist is disrupting OTC medications by cutting out the pharmacy middleman and selling direct on Shopify. Product content in healthcare walks a fine line between building trust and driving conversions. That balance gets harder as your catalog grows.

2. bursu@zoomget.com
B2B glove sales on Shopify is an unusual play. Most platform best practices assume impulse shoppers, not procurement managers comparing bulk pricing and compliance specs. Your content has to work differently than typical DTC.

3. crazdan@careandwear.com
Care+Wear is solving a real problem for patients and caregivers. The challenge with healthwear content is speaking to both the emotional journey and the functional benefits. Every product page needs to balance empathy with specifics.

4. billy@betterrhodes.com
The alcohol-free beverage space is exploding, and Better Rhodes is riding that wave on Shopify. Content in this category has to overcome skepticism. Convincing someone that NA drinks are worth buying requires storytelling, not just product specs.

5. brandon@revelrysupply.com
Smell-proof luggage for "off the clock" adventures. Revelry has carved out a niche that requires careful messaging. Your content has to speak to your audience without saying too much, and that's a unique challenge most agencies don't understand.

6. brianna@goodlyshop.com
Curated gift boxes live and die by how well the story sells. Brightlane's challenge is making each box feel personal and intentional through a screen. Product photography gets you halfway there. Content gets you the rest.

7. devon.saenz@bumkins.com
Kids' reusable gear means speaking to two audiences at once. Parents want practical and durable. Kids want fun. Keeping that voice consistent across hundreds of Shopify product pages while hitting SEO targets is a lot to juggle.

8. enich@caddislife.com
Caddis is doing something interesting with reading glasses. Crushing age stereotypes through eyewear requires brand content that actually feels different, not just says it's different. That voice has to show up everywhere, from product pages to social.

9. erika@alexaleigh.com
High-end jewelry demands product descriptions that feel as premium as the pieces themselves. Maintaining that elevated voice across your Shopify catalog while optimizing for search and conversion is the tension every luxury brand deals with.

10. carmen@currentboutique.com
Consignment e-commerce is a content machine. Every piece is unique, every description matters, and inventory turns over constantly. Keeping quality high when you're publishing that much content is the real challenge.
```

## NEXT ACTIONS (PRIORITY ORDER)
1. **Run `/brand-brent`** to load brand persona
2. **Continue batch processing:** Generate paragraphs for contacts 11-50 (batch 1 remainder)
3. **Write to CSV after each batch:** Append to output file
4. **Continue with batches 2-7:** (51-100, 101-150, etc.)
5. **Final output:** Complete CSV ready for HubSpot import

## OUTPUT FILE FORMAT
```csv
Email,Personalization paragraph
ethan@curistrelief.com,"Curist is disrupting OTC medications..."
```

## BATCH PROCESSING PLAN
| Batch | Contacts | Status |
|-------|----------|--------|
| 1 | 1-50 | 10 done, 40 pending |
| 2 | 51-100 | Pending |
| 3 | 101-150 | Pending |
| 4 | 151-200 | Pending |
| 5 | 201-250 | Pending |
| 6 | 251-300 | Pending |
| 7 | 301-351 | Pending |

## CONTEXT NOTES
- Day off work - casual POC exploration
- Goal is to show workflow for RequestDesk integration later
- User prefers batches of 50 to avoid context issues
- Once POC complete, will add to RequestDesk as formal feature
