# Resume Instructions for Claude - Shopify App Production Deploy

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify`
2. **Verify branch:** `git branch --show-current` (should be: infrastructure/shopify-api-upgrade)
3. **Check Gadget sync:** `ggt status`

## SESSION METADATA
**Last Commit:** `af4768b Session save: Shopify production deployment + Gadget URL fix`
**MCP Entity:** `cb-shopify-production-deploy`
**Saved:** 2026-01-07

## CURRENT TODO FILE
**Path:** `/Users/brent/scripts/CB-Workspace/cb-shopify/todo/current/infrastructure/shopify-api-upgrade/`
**Status:** Production deployed, blog publish fix deployed separately

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Shopify Production Deployment
- Deployed cb-shopify Gadget app to PRODUCTION environment
- Created separate dev/production Shopify apps per Gadget best practices
- New production app: "RequestDesk Content Builder" (client_id: 037394b1e98d35edfce74114b2f16148)
- Development app uses old client_id: 55d84bce9343999eab6423a3c94a190f

### 2. TOML Configuration Updated
- `shopify.app.toml` → Production config with new client_id
- `shopify.app.development.toml` → Created for development environment
- Removed old `shopify.app.production.toml`

### 3. Client Store Installation
- Installed production app on Chalet Market (chaletmarket.myshopify.com)
- Removed old app first

### 4. Blog Publish Bug Fixed (Separate Branch)
**ROOT CAUSE:** Hardcoded URLs in cb-requestdesk pointing to `--client` instead of production Gadget URL

**FIX DEPLOYED:** `backend-v0.35.0-gadget-url-fix`
- Added `GADGET_APP_URL` config variable to cb-requestdesk
- Default: `https://contentbasis.gadget.app` (production)
- Updated 6 files in cb-requestdesk:
  - config.py (added variable)
  - shopify_blog_service.py (lines 1362, 1424)
  - shopify_service.py (line 69)
  - agent_integration_service.py (lines 564, 624, 867)
  - agents.py (line 533)

### 5. Documentation Added
- Added new critical rule to workspace CLAUDE.md: "USE DATABASE CONFIG SYSTEM - NOT config.py"
- Documents the proper way to add configuration using the database-driven config system at https://app.requestdesk.ai/configs
- Logged as Violation #84

## CURRENT STATE
- **cb-shopify:** On branch `infrastructure/shopify-api-upgrade`, all changes committed
- **cb-requestdesk:** Fix merged to master and deployed (`backend-v0.35.0-gadget-url-fix`)
- **Deployment status:** Awaiting user confirmation that blog publish works

## NEXT STEPS
1. **User to test:** Publish a blog post from RequestDesk to Shopify (Chalet Market)
2. **If working:** Consider deleting the old `--client` Gadget environment
3. **If not working:** Check Gadget production logs at https://contentbasis.gadget.app

## ENVIRONMENT URLS
- **Gadget Production:** https://contentbasis.gadget.app
- **Gadget Development:** https://contentbasis--development.gadget.app
- **Gadget Editor:** https://contentbasis.gadget.app/edit
- **Client Store:** chaletmarket.myshopify.com

## KEY LESSON LEARNED
**Never hardcode URLs in config.py - use the database config system at /configs instead.**
The hardcoded Gadget URLs caused a production outage. If the URL had been in the database config, the fix would have taken 30 seconds instead of requiring a code deployment.
