# Resume Instructions for Claude - Shopify Production Images Debug

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify`
2. **Verify branch:** `git branch --show-current` (should be: infrastructure/shopify-api-upgrade)

## SESSION METADATA
**Last Commit:** `af4768b Session save: Shopify production deployment + Gadget URL fix`
**Saved:** 2026-01-07

## CRITICAL DEBUGGING STATE

### THE PROBLEM
Product images are NOT syncing to Gadget production. They work in client but not production.

### ROOT CAUSE FOUND
1. **`shopifyProductImage` model is NOT in production's Shopify connection data models**
2. Client has: shopifyProductImage in data models list
3. Production MISSING: shopifyProductImage from data models list
4. This is why images return empty arrays

### BLOCKED BY ERROR
When trying to add `shopifyProductImage` to production data models, user gets:
```
Shopify app configuration with api key "037394b1e98d35edfce74114b2f16148" has an invalid app URL
```

### TOML CONFIGURATION
Production `shopify.app.toml`:
- client_id = "037394b1e98d35edfce74114b2f16148"
- application_url = "https://contentbasis.gadget.app/"

### SCOPE MISMATCH NOTED
Client shows only: read_content, write_content, read_products
But TOML files have many more scopes

### SYNC ERRORS IN GADGET LOGS
```
sync for shop failed
GGT_RECORD_NOT_FOUND: Couldn't find record with id=... to delete
```
Multiple records trying to be deleted that don't exist (due to --allow-data-delete deployment)

## WHAT WAS ACCOMPLISHED THIS SESSION
1. Deployed public routes to Gadget production (products, collections, articles, blogs)
2. Product sync from RequestDesk now works (content comes through)
3. Blog publish confirmed working
4. Added version number (1.3.0) to settings page
5. Updated CLAUDE.md with verification checklist for client vs production parity

## WHAT BROKE
- Product images stopped syncing after `ggt deploy --from client --allow-data-delete`
- The --allow-data-delete flag may have wiped image data
- shopifyProductImage model missing from production data models

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIX APP URL ERROR** - Investigate why "invalid app URL" when adding shopifyProductImage
2. **ADD shopifyProductImage** to production Shopify connection data models
3. **TRIGGER FULL SYNC** from Shopify to Gadget production
4. **VERIFY** images appear in `/public/products` response

## VERIFICATION COMMANDS
```bash
# Check if images come through
curl -s "https://contentbasis.gadget.app/public/products?limit=1" -H "x-requestdesk-api-key: tDAC-hZnE7EdAPRKITjxNUjkB0C3UjvkTnK5V55wXtU" | jq '.products[0].images'

# Compare client (has images) vs production (empty)
curl -s "https://contentbasis--client.gadget.app/public/products?limit=1" -H "x-requestdesk-api-key: tDAC-hZnE7EdAPRKITjxNUjkB0C3UjvkTnK5V55wXtU" | jq '.products[0].images'
```

## KEY URLS
- Gadget Production Editor: https://contentbasis.gadget.app/edit
- Gadget Client Editor: https://contentbasis.gadget.app/edit/client
- Production Shopify Connection: Check Connections → Shopify → Data Models
- Chalet Market Store: chaletmarket.myshopify.com

## FILES MODIFIED THIS SESSION
- CLAUDE.md (added verification checklist)
- VERSION (set to 1.3.0)
- web/routes/settings.tsx (added version display)
- shopify.app.development.toml (fixed URLs from --development to --client)
