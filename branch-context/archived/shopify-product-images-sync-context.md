# Resume Instructions for Claude - Shopify Product Images Sync

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify`
2. **Branch:** `git checkout infrastructure/shopify-api-upgrade`
3. **Last Commit:** `9d718ae Link progress to context file for session resume`

## SESSION METADATA
**Saved:** 2026-01-07
**Todo Path:** `todo/current/infrastructure/shopify-api-upgrade/`

## BLOCKED: WAITING FOR GADGET SUPPORT

### THE PROBLEM
Product images return EMPTY arrays from API even though data EXISTS in the table.

### ROOT CAUSE IDENTIFIED
`shopifyProductImage` model cannot be added to `enabledModels` in settings.gadget.ts. When we try, Gadget returns:
> "The 'shopifyProductImage' enabled Shopify model does not exist"

### KEY DISCOVERIES
1. **Data exists** in dev and client `shopifyProductImage` tables (user confirmed via Gadget UI)
2. **Model directory exists** at `api/models/shopifyProductImage/` with schema and actions
3. **Model appears** in Gadget UI Data section
4. **Relationship defined** in `shopifyProduct` schema (hasMany → shopifyProductImage)
5. **BUT** model is NOT in `enabledModels` in ANY environment (dev, client, production)
6. **AND** we cannot add it - Gadget rejects it as "does not exist"

### WHAT BROKE
- Images worked earlier today BEFORE switching to production
- The `--allow-data-delete` deployment likely affected sync state
- Model was never properly registered as a Shopify sync model

## EMAIL SENT TO GADGET SUPPORT

User has email ready to send asking Gadget how to properly enable `shopifyProductImage` for Shopify sync.

## TODO LIST STATE
- 🔄 IN PROGRESS: BLOCKED - waiting for Gadget support response
- ⏳ PENDING: Implement fix based on Gadget's guidance
- ⏳ PENDING: Deploy to production and verify images appear

## NEXT ACTIONS (PRIORITY ORDER)

1. **WAIT** for Gadget support response (expected next day)
2. **Based on response:**
   - If they can enable the model → deploy and test
   - If not → implement custom image sync code

## VERIFICATION COMMANDS
```bash
# Check if images return (currently returns 0)
curl -s "https://contentbasis--client.gadget.app/public/products?limit=1" \
  -H "x-requestdesk-api-key: tDAC-hZnE7EdAPRKITjxNUjkB0C3UjvkTnK5V55wXtU" | jq '.products[0].images'

# Check client status
ggt status --env=client
```

## KEY FILES
- `settings.gadget.ts` - enabledModels list (shopifyProductImage NOT included)
- `api/models/shopifyProductImage/schema.gadget.ts` - model exists but not recognized
- `accessControl/permissions.gadget.ts` - permissions are correct

## CONTEXT NOTES
- Dev environment has image data (oldest environment, ~months old)
- Client has image data (user confirmed via Gadget UI)
- Production has empty shopifyProductImage table
- The model was somehow populated in the past without being in enabledModels
- This is likely a Gadget platform quirk or legacy issue
