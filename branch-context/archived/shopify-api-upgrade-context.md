# Resume Instructions for Claude - Shopify API Upgrade

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify`
2. **Verify branch:** `git checkout infrastructure/shopify-api-upgrade`
3. **Check Gadget status:** `ggt status`

## SESSION METADATA
**Last Commit:** `e6116f1 WIP: Shopify API upgrade to 2025-10 and production deploy prep`
**Saved:** 2026-01-07

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-shopify/todo/current/infrastructure/shopify-api-upgrade/README.md
**Status:** Stuck on TOML Client ID mismatch during deploy
**Directory Structure:** ✅ Complete (7/7 files)

## WHAT YOU WERE WORKING ON
Deploying cb-shopify to PRODUCTION environment in Gadget. The "client" environment is a dev environment that auto-pauses, causing issues. User wants:
1. Deploy to PRODUCTION (priority #1)
2. Delete "client" environment
3. End up with just: development → production workflow

## CURRENT STATE - BLOCKING ISSUE
**Problem:** Gadget deploy shows "Client ID in TOML does not match Shopify settings" even after:
- Adding `client_id = "55d84bce9343999eab6423a3c94a190f"` to TOML
- Updating URLs to match Gadget expected format:
  - `application_url = "https://contentbasis--client.gadget.app/api/shopify/install-or-render"`
  - `redirect_urls = ["https://contentbasis--client.gadget.app/api/connections/auth/shopify/callback"]`
  - All GDPR URLs point to: `https://contentbasis--client.gadget.app/api/webhooks/shopify`

**Gadget Connection Settings show:**
- Client ID: `55d84bce9343999eab6423a3c94a190f`
- App URL: `https://contentbasis--client.gadget.app/api/shopify/install-or-render`
- Redirect URL: `https://contentbasis--client.gadget.app/api/connections/auth/shopify/callback`
- GDPR URL: `https://contentbasis--client.gadget.app/api/webhooks/shopify`

**User updated TOML in Gadget's web editor** - still getting the same warning.

## CHANGES MADE THIS SESSION
1. **API Version Updates:**
   - `settings.gadget.ts`: 2025-01 → 2025-10
   - `shopify.app.toml` webhooks: 2024-07 → 2025-10
   - `shopify.app.production.toml` webhooks: 2024-07 → 2025-10

2. **Fixed Deprecated Shopify Schema Fields:**
   - shopifyArticle: removed "published"
   - shopifyBlog: removed "commentable", "feedburner", "feedburnerLocation"
   - shopifyCollect: removed "position", "shopifyCreatedAt", "shopifyUpdatedAt", "sortValue"
   - shopifyCollection: removed "disjunctive"
   - shopifyComment: removed "email"
   - shopifyFulfillment: removed "notifyCustomer", "variantInventoryManagement"
   - shopifyOrder: removed "number", "orderNumber"
   - shopifyPage: removed "author"
   - shopifyShop: removed "cookieConsentLevel", "eligibleForCardReaderGiveaway", "forceSsl"

3. **Fixed TypeScript Error:**
   - `api/routes/api/external/create-blog/POST.ts` - added missing closing brace

4. **Updated TOML Files:**
   - Added client_id
   - Fixed application_url to include `/api/shopify/install-or-render`
   - Fixed redirect_urls to match Gadget expected format
   - Fixed GDPR webhooks to use single URL

## TODO LIST STATE
- 🔄 IN PROGRESS: Deploy to Gadget PRODUCTION (blocked by Client ID warning)
- ✅ COMPLETED: Update API versions to 2025-10
- ⏳ PENDING: Create Gadget environment documentation

## NEXT ACTIONS (PRIORITY ORDER)
1. **RESOLVE Client ID warning** - The TOML and Gadget settings appear to match but deploy still warns
   - Try: Check if there's a "Sync TOML" or "Update from Shopify" option in Gadget
   - Try: See if user can force/skip the warning and deploy anyway
   - Try: Contact Gadget support if warning persists

2. **Once deployed to production:**
   - Delete the "client" environment
   - Update local `.gadget/sync.json` to use "development" instead of "client"
   - Update documentation

3. **After production is stable:**
   - Create GADGET_ENVIRONMENT.md documentation
   - Update CLAUDE.md with complete Gadget workflow

## KEY URLS
- Gadget Editor: https://contentbasis.gadget.app/edit/client
- Gadget Settings: Settings → Connections → Shopify
- Shopify Partner Dashboard: https://partners.shopify.com
- Production URL (after deploy): https://contentbasis.gadget.app

## CONTEXT NOTES
- Gadget TOML files don't sync via `ggt push` - must edit in Gadget web editor
- User confirmed "client" is a dev environment that auto-pauses (causing issues)
- Target setup: development → production (delete "client")
- Data deletion warnings during deploy are EXPECTED (deprecated fields)
