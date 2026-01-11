# Resume Instructions for Claude - Shopify Product Media Fix

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify`
2. **Branch:** `git checkout infrastructure/shopify-api-upgrade`
3. **Last Commit:** `9904c92 Fix shopifyProductImage deprecation - use shopifyProductMedia instead`

## SESSION METADATA
**Saved:** 2026-01-08 16:20
**Branch:** infrastructure/shopify-api-upgrade

## WHAT WAS ACCOMPLISHED THIS SESSION

### Fixed Shopify API 2025-01 Deprecation
The `shopifyProductImage` model was deprecated in Shopify API 2025-01. We migrated to the new `shopifyProductMedia` model.

**Changes Made:**
1. ✅ Enabled `shopifyProductMedia`, `shopifyFile`, `shopifyProductVariantMedia` in Gadget UI (Settings → Plugins → Shopify)
2. ✅ Added `write_images` scope to settings.gadget.ts
3. ✅ Updated /public/products API to query `media` relation
4. ✅ Updated RAG sync to use new media model
5. ✅ Fixed image URL extraction - URLs are in `image.originalSrc` not `url` field
6. ✅ Deployed to production - images now working
7. ✅ Added comprehensive documentation to CLAUDE.md

### Key Technical Details
- `shopifyFile.url` field is EMPTY - Shopify stores URLs in `image.originalSrc`
- The `media` relation on products returns `ShopifyFile` objects
- `featuredMedia` field returns `ShopifyProductMedia` (different type) - couldn't use it directly
- Current solution uses first media item as featured image

## CURRENT STATE
- **Production deployed:** Yes, images working
- **API verified:** `/public/products` returns images correctly
- **RAG sync:** Updated but needs testing with actual sync

## PENDING INVESTIGATION
User mentioned images might not be the exact "featured" image. The current implementation uses the first media item. To get the actual featured image:
- May need to query `shopifyProductMedia` and check `featuredMediaForProduct` field
- Or check if media items have a position/order that indicates featured

## KEY FILES MODIFIED
- `settings.gadget.ts` - added write_images scope, new enabledModels
- `accessControl/permissions.gadget.ts` - added permissions for new models
- `api/routes/public/products/GET.ts` - query media, extract image.originalSrc
- `api/actions/syncProductsToRAG.ts` - query media for RAG sync
- `api/utils/shopifyRAGSync.ts` - handle edges format, extract image.originalSrc
- `CLAUDE.md` - comprehensive documentation for enabling Shopify models

## NEXT ACTIONS
1. **Test RAG sync** - Run syncProductsToRAG action and verify images appear in RAG
2. **Investigate featured image** - If needed, look into `featuredMediaForProduct` field to get exact featured image
3. **Fix TOML warning** - There's a "misconfigured production Shopify TOML config" warning during deploy

## VERIFICATION COMMANDS
```bash
# Test products API with images
curl -s 'https://contentbasis.gadget.app/public/products?limit=1' \
  -H 'x-requestdesk-api-key: tDAC-hZnE7EdAPRKITjxNUjkB0C3UjvkTnK5V55wXtU' | jq '.products[0] | {title, featured_image}'

# Check Gadget sync status
ggt status --env=development
```

## DOCUMENTATION ADDED
See CLAUDE.md section "🔧 Enabling New Shopify Models" for complete process documentation.
