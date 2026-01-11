# EMERGENCY CONTEXT SAVE - 2026-01-08

## CRITICAL: LOW CONTEXT SAVE
This save was triggered with <8% context remaining. Minimal validation performed.

## BRANCH
infrastructure/shopify-api-upgrade

## DIRECTORY
/Users/brent/scripts/CB-Workspace/cb-shopify

## WHAT WE WERE DOING
Fixing product images after Shopify API 2025-01 deprecated `shopifyProductImage` model.

**Solution in progress:** Using Gadget's recommended `shopifyProductMedia` model.

## COMPLETED THIS SESSION
1. User enabled `shopifyProductMedia`, `shopifyProductVariantMedia`, and `shopifyFile` in Gadget UI (Settings → Plugins → Shopify)
2. Pulled new model files from Gadget - models now exist locally
3. Added unauthenticated permissions for: shopifyFile, shopifyProduct, shopifyProductMedia, shopifyProductVariant, requestDeskAccount
4. Pushed permissions to Gadget - working

## CURRENT STATE - BLOCKED
**Issue:** `shopifyProductMedia` model exists but has NO DATA. Need to trigger a Shopify sync.

**GraphQL test result:**
```json
{ "shopifyProductMedias": { "edges": [] } }
```

**Models available (confirmed):**
- ShopifyFile has: `url`, `alt`, `image`, `preview`, etc.
- ShopifyProductMedia has: `file` (relation to ShopifyFile), `product`, `position`, `featuredMediaForProduct`

## PENDING TODOS
1. Trigger Shopify sync to populate shopifyProductMedia data
2. Update `/public/products` API to use shopifyProductMedia instead of public JSON workaround
3. Deploy to production
4. Test images work

## KEY FILES MODIFIED THIS SESSION
- `settings.gadget.ts` - added shopifyFile, shopifyProductMedia to enabledModels (Gadget UI did this)
- `accessControl/permissions.gadget.ts` - added unauthenticated read permissions
- `api/models/shopifyProductMedia/` - NEW model directory (pulled from Gadget)
- `api/models/shopifyFile/` - NEW model directory (pulled from Gadget)
- `api/routes/public/products/GET.ts` - has temporary public JSON workaround (needs to be updated)

## CURRENT WORKAROUND IN PLACE
The API currently fetches images from Shopify's public JSON endpoint (`https://store.com/products/handle.json`). This WORKS but is a workaround. Proper solution is shopifyProductMedia.

## NEXT STEPS
1. **FIRST:** Trigger Shopify sync in Gadget UI:
   - Go to Installs → click shop → look for Sync/Resync button
   - OR wait for scheduled sync (02:32 UTC daily)

2. **AFTER SYNC:** Update API to use shopifyProductMedia:
   ```typescript
   // Query products with media
   const products = await api.shopifyProduct.findMany({
     select: {
       id: true,
       title: true,
       // ... other fields
       media: {
         edges: {
           node: {
             file: {
               url: true,
               alt: true
             }
           }
         }
       }
     }
   });
   ```

3. **THEN:** Deploy and test

## SCREENSHOTS SAVED (for documentation)
User took screenshots during Gadget UI navigation - they were synced to Gadget and deleted, but showed:
- Settings → Plugins → Shopify connection
- Model selection UI with Product media, Product variant media, File checkboxes
