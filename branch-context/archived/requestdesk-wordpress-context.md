# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector`
2. **Also working in theme:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
3. **LocalWP site:** `http://contentcucumber.local/`
4. **Branch:** `main`

## SESSION METADATA
**Last Commit:** `4008dcc Add hero padding constraints and empty paragraph fixes`
**Saved:** 2026-01-05 ~11:00 AM
**Project:** RequestDesk Connector WordPress Plugin + Content Cucumber Theme

## WHAT WE WERE WORKING ON
Plugin and theme maintenance for Content Cucumber WordPress site:

### Completed This Session:
1. **Theme CSS fixes** (`style.css`):
   - Reduced padding on `.wp-block-group__inner-container.is-layout-constrained` (30px 40px)
   - Reset padding on `.wp-block-group` (padding-top: 0, padding-bottom: 0)
   - Reset margin on `.entry-content .wp-block-group` (margin-bottom: 0)
   - Pushed to live via LocalWP

2. **Dashboard Layout Fix** (`admin/aeo-settings-page.php`):
   - Added full-width CSS matching Bulk Optimizer (calc(100vw - 180px))
   - Redesigned stats grid with 4 cards across top
   - Created freshness bar with 5 color-coded segments
   - Updated all cards to use `dashboard-card` class
   - Added Quick Actions section at bottom
   - Made responsive for mobile

3. **Case Study Module Plan Updated** (in wordpress-sites repo):
   - Added fully structured data model (10 JSON objects)
   - Added Schema.org JSON-LD specification
   - Updated wizard to 8 steps matching interview guide
   - Added Platform taxonomy
   - Location: `/Users/brent/scripts/CB-Workspace/wordpress-sites/todo/current/feature/case-study-module/`

## CURRENT STATE
- **Theme CSS:** Changes pushed to live via LocalWP
- **Plugin Dashboard:** Changes made locally, NOT pushed to live yet
- **Case Study Plan:** Updated in wordpress-sites repo

### Files Modified (not committed):
- `app/public/wp-content/plugins/requestdesk-connector/admin/aeo-settings-page.php` - Dashboard layout
- `app/public/wp-content/themes/cucumber-gp-child/style.css` - Section spacing CSS

## TODO LIST STATE
- ✅ COMPLETED: Fix Dashboard layout to use full width
- ⏳ PENDING: Review other screens for similar layout issues
- ⏳ PENDING: Push plugin changes to live

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Refresh Dashboard in WordPress admin to verify layout fix works
2. **THEN:** Review Settings and Template Importer pages for similar layout issues
3. **IF APPROVED:** Push plugin changes to live via LocalWP or S3 update system
4. **LATER:** Begin Case Study Module implementation (Phase 1: CPT Foundation)

## VERIFICATION COMMANDS
- View Dashboard: `http://contentcucumber.local/wp-admin/admin.php?page=requestdesk-aeo-analytics`
- View Bulk Optimizer: `http://contentcucumber.local/wp-admin/admin.php?page=requestdesk-aeo-bulk-optimizer`
- Compare layouts between the two pages

## CONTEXT NOTES
- LocalWP site, not CB-Workspace git repo
- Theme pushed via LocalWP push feature
- Plugin can be pushed via LocalWP OR via S3 update system (version bump required)
- Case Study interview guide: `/Users/brent/Downloads/Shopware Case Study Questions v250312.1.md`
- Known issue: Flywheel WAF blocks some REST API calls - work locally first

## PLUGIN VERSION
Current: 2.5.1 (in requestdesk-connector.php)
If pushing update, bump version and update S3 bucket

## RELATED WORK
- CSS inconsistency between /contentbasis/ and /shopify-content-services/ pages - user noted but skipped for now
- Empty `<p></p>` being inserted on CSV imports - noted but not fixed yet
