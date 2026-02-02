# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/wordpress-sites`
2. **Branch:** `git checkout feature/hubspot-audit-page`
3. **Local Site:** Ensure Local by Flywheel (contentcucumber.local) is running

## SESSION METADATA
**Branch:** feature/hubspot-audit-page
**Last Commit:** 9d221aa Fix CSV importer: native WP blocks, HTML converter, auto-landing page
**Saved:** 2026-01-14 17:30
**Project:** wordpress-sites (wps) / contentcucumber

## CURRENT STATUS: WAITING FOR DEPLOYMENT

User is pushing the site from Local by Flywheel to live. The page is ready locally.

## WHAT WAS COMPLETED THIS SESSION

### 1. Fixed CSV Importer (aeo-template-importer.php)
- Rewrote `requestdesk_build_service_page_content()` to use native WordPress blocks
- Hero now uses `wp:cover` instead of GenerateBlocks (no more "Attempt recovery" errors)
- Sections use `wp:group` with `align:full` for full-width backgrounds
- Added `requestdesk_html_to_blocks()` function to convert CSV HTML to valid WP blocks
- Auto-sets landing page meta on import:
  - `_wp_page_template` → `page-builder-canvas.php`
  - `_generate_sidebar_layout` → `no-sidebar`
  - `_generate_content_width` → `full-width`
  - `_requestdesk_landing_page` → `true`

### 2. Fixed Slideshow CSS (style.css)
- Added `!important` overrides to beat WordPress gallery defaults
- Targets `.wp-block-gallery.is-style-slideshow` with proper flex layout
- Each image set to `flex: 0 0 100%` for one-at-a-time display

### 3. Smart Slider 3 Installation
- User installed Smart Slider 3 plugin for proper slideshow functionality
- CSS-only approach wasn't a true slideshow (just horizontal scroll)
- Smart Slider provides prev/next arrows, dots, proper transitions

## KEY FILES MODIFIED
- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/admin/aeo-template-importer.php`
- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/style.css`

## DEPLOYMENT CHECKLIST
User is pushing everything from Local to live:
- [x] Database (Smart Slider config, page content)
- [x] Uploads (`/wp-content/uploads/hubspot-audit/` images)
- [x] Theme files (CSS changes)
- [x] Plugin files (importer updates)

## TODO LIST STATE
- ✅ COMPLETED: Fix importer to auto-set GP Canvas template for full-width hero
- ✅ COMPLETED: Add HTML-to-blocks converter for CSV content
- ⏳ PENDING: Test on live after deployment
- ⏳ PENDING: Verify Smart Slider works on live with images

## NEXT ACTIONS (AFTER DEPLOYMENT)
1. Verify the HubSpot Audit page loads correctly on live
2. Check Smart Slider slideshow works with all 12 images
3. Test full-width hero and section backgrounds
4. Verify CTA links work (booking link)

## NOTES
- CSV location: `/Users/brent/scripts/CB-Workspace/wordpress-sites/test-data/csv-examples/cucumber-services/602-hubspot-audit.csv`
- Slideshow pattern exists but not needed if using Smart Slider: `patterns/hubspot-audit-slideshow.php`
- The "Enable landing page styling" checkbox in Hero Background metabox triggers `_requestdesk_landing_page` meta
