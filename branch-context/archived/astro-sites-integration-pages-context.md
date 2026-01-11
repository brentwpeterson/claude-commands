# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Verify branch:** `git branch --show-current` (should be: master)
3. **Start dev server:** `cd requestdesk-ai && npm run dev` (runs on port 3003)

## SESSION METADATA
**Last Commit:** Pending - integration pages created but not committed
**Saved:** 2026-01-02
**Project:** astro-sites (requestdesk.ai website)

## CURRENT TODO FILE
**Path:** /Users/brent/scripts/CB-Workspace/astro-sites/todo/current/feature/magento-integration-landing-page/
**Status:** Working on integration page images before deployment
**Directory Structure:** 7/7 files

## WHAT YOU WERE WORKING ON
Integration pages for RequestDesk.ai - auditing which pages have images and planning image additions before deployment.

## SESSION ACCOMPLISHMENTS
1. **Audited all 6 integration pages** for image content
2. **Updated /claude-save command** with new progress.log linking feature:
   - Added `--no-todo` flag for ad-hoc work
   - New Phase 4.5: Link context file to progress.log
   - Only Full/Quick modes link (not Emergency)
3. **Documented image needs** per integration page

## INTEGRATION PAGE IMAGE AUDIT
| Page | Status | Social Card | Content Images | Needs Work |
|------|--------|-------------|----------------|------------|
| **Magento** | LIVE | Custom | None | Add screenshots |
| **WordPress** | LIVE | Default | None | Custom social card + screenshots |
| **Shopify** | BETA | Default | None | Custom social card + screenshots |
| **Astro** | LIVE (new) | Default | None | Custom social card + screenshots |
| **HubSpot** | Coming Soon (new) | Default | None | Lower priority |
| **WooCommerce** | Coming Soon (new) | Default | None | Lower priority |

## UNCOMMITTED FILES
```
requestdesk-ai/src/pages/integrations/astro.astro      # NEW - GitHub webhook integration
requestdesk-ai/src/pages/integrations/hubspot.astro    # NEW - Coming soon page
requestdesk-ai/src/pages/integrations/woocommerce.astro # NEW - Coming soon page
```

## TODO LIST STATE
- Pending: Magento - Add content screenshots (admin UI, schema output)
- Pending: WordPress - Create custom social card + add screenshots
- Pending: Shopify - Create custom social card + add screenshots
- Pending: Astro - Create custom social card + add screenshots
- Pending: Commit 3 new integration pages (Astro, HubSpot, WooCommerce)
- Pending: Deploy after images added

## INTEGRATIONS DATA
Webflow is included in `integrations.ts` with status `radar` (On Our Radar / Evaluating).

Full tier breakdown:
- **Live:** WordPress, Shopify, Astro, Magento
- **In Progress:** HubSpot, WooCommerce
- **Planned:** BigCommerce, Wix, Shopware, Adobe Commerce SaaS, Adobe AEM, Contentful, ButterCMS, Strapi
- **On Our Radar:** Webflow, Ghost, Sanity, Storyblok, Prismic, Squarespace, Drupal, + more

## CONTEXT FOR MAGENTO SCHEMA EXTENSION
User mentioned needing to add context about the new Magento Schema extension. From previous sessions:
- Modular architecture: `core` + `blog` + `brand-score` + `schema` as separate modules
- `RequestDesk_Core` exists (API client, config, test connection)
- `RequestDesk_Blog` exists (posts, sync, import)
- Schema module planned but not yet scaffolded
- User needs to provide details on what the schema extension will do

## NEXT ACTIONS
1. **Get Magento schema extension details** from user to document
2. **Create/gather screenshots** for integration pages
3. **Commit new integration pages** when images ready
4. **Deploy** with appropriate tag

## BRAND GUIDELINES REMINDER
- No em dashes
- Avoid: "game-changing", "revolutionary", "Here's the thing"
- Tone: Direct, confident, clever not comedic
- "You're the hero, we're the guide" positioning
