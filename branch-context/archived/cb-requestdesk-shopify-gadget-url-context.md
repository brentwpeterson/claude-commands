# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Branch:** `master` (feature branch `enhancement/shopify-rag-product-sync` was merged)
3. **Last Commit:** `1ce95bff Add Shopify Gadget URL configuration and migration`
4. **Status:** All changes committed and deployed

## SESSION METADATA
**Deployment Tag:** `app-v0.33.8-shopify-gadget-url`
**Saved:** 2025-12-17

## WHAT WAS ACCOMPLISHED

### Problem Solved
- **Issue:** Shopify product sync was failing with 400 error on PRODUCTION but working locally
- **Root Cause:** Production MongoDB agent document was missing `shopify_store_url` field
- **Why:** The field was hardcoded in frontend (AgentEdit.tsx) but only saved when agent was re-saved through UI locally. Production agent was never re-saved after that code was added.

### Solution Implemented
1. **Migration v0.33.8** - Backfills `shopify_store_url` for all agents with `shopify_enabled=true`
   - File: `backend/app/migrations/versions/v0_33_8_backfill_shopify_store_url.py`
   - Sets URL to: `https://contentbasis--client.gadget.app`

2. **Auto-set Logic** - When Shopify is enabled on an agent, automatically set the Gadget URL
   - File: `backend/app/routers/agents.py` (lines ~523-529)
   - Prevents this issue from recurring for new agents

3. **UI Configuration** - Added editable Gadget URL field on Shopify Integration page
   - File: `frontend/src/components/integrations/ShopifyIntegrationPage.tsx`
   - Users can now view/edit the Gadget URL in Connection Status section

### Files Changed
- `backend/app/migrations/versions/v0_33_8_backfill_shopify_store_url.py` (NEW)
- `backend/app/routers/agents.py` (MODIFIED - auto-set logic)
- `frontend/src/components/integrations/ShopifyIntegrationPage.tsx` (MODIFIED - UI field)
- `frontend/src/components/agents/AgentEdit.tsx` (MODIFIED - use form data instead of hardcoded)

## DEPLOYMENT STATUS
- **Tag Created:** `app-v0.33.8-shopify-gadget-url`
- **GitHub Actions:** Should be running deployment
- **Migration:** Will run automatically on backend startup and backfill production agents

## NEXT STEPS FOR USER
1. **Wait for deployment to complete** (check GitHub Actions)
2. **Verify migration ran** - Check production logs for migration v0.33.8 output
3. **Test Shopify sync** - Should now work without 400 error
4. **Verify UI** - Check Shopify Integration page shows Gadget URL field

## IMPORTANT NOTES
- The Gadget URL `https://contentbasis--client.gadget.app` is constant for all Shopify integrations
- Version 0.33.8 was used (not 0.33.7 as user mentioned earlier - VERSION file showed 0.33.8 during deployment)
- Debug logging from previous deployment (v0.33.9) is still in place and will show the config values

## VERIFICATION COMMANDS
```bash
# Check GitHub Actions deployment
gh run list --limit 5

# Check production logs for migration
aws logs get-log-events --log-group-name /ecs/cb-app-backend --log-stream-name [latest-stream] --limit 50

# Test sync via API (with valid token)
curl -X POST "https://app.requestdesk.ai/api/shopify-sync/sync-products/[agent-id]" \
  -H "Authorization: Bearer [TOKEN]"
```
