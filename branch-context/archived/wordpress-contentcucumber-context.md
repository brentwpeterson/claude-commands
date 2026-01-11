# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/wordpress-sites`
2. **Verify plugin location:** `ls requestdesk-connector/admin/aeo-template-importer.php`
3. **LocalWP site:** http://contentcucumber.local/wp-admin/
4. **Branch:** master (standalone project)

## SESSION METADATA
**Plugin Version:** 2.6.0
**Saved:** 2025-12-28

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Landing Page Styling System Built
- **Child theme CSS** (`hero-styles.css`) - Hides GP page header on landing pages
- **Child theme PHP** (`functions.php`) - Adds body class `requestdesk-landing-page`
- **Sidebar meta box** "🎨 Hero Background" with:
  - Color options: Default, Black, Green (CC Brand), Orange
  - Checkbox to enable/disable landing page styling
- **Dynamic CSS** output for hero background color

### 2. Importer Updated
- Sets `_requestdesk_landing_page` post meta on import
- Supports `hero_bg_color` CSV column (values: black, green, orange)

### 3. Green Header Hiding (IN PROGRESS)
- Found GP Elements classes: `gb-element-f58439fd`, `gb-shape-45457938`, `gb-text-52f5b998`
- Added CSS targeting these specific classes
- **NEEDS TESTING** - User needs to hard refresh to verify green header is hidden

## KEY FILES MODIFIED

### LocalWP (child theme):
- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/functions.php`
- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/hero-styles.css`

### Plugin (workspace - hardlinked to LocalWP):
- `/Users/brent/scripts/CB-Workspace/wordpress-sites/requestdesk-connector/admin/aeo-template-importer.php`

### wp-config.php (LocalWP fix):
- Added WP_HOME and WP_SITEURL to fix localhost:10013 redirect issue

## TODO LIST STATE
- ✅ COMPLETED: Modify hero banner system
- ✅ COMPLETED: Add background color option to CSV and sidebar
- 🔄 IN PROGRESS: Test landing page styling (green header hiding)
- ⏳ PENDING: Import CSV files (01-10)
- ⏳ PENDING: Push plugin to live site
- ⏳ PENDING: Phase 2: Create reusable WordPress blocks

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Hard refresh http://contentcucumber.local/services-2/ to test green header hiding
2. **IF NOT WORKING:** Inspect element and get exact parent container class
3. **THEN:** Import all 10 CSV files
4. **VERIFY:** Check pages render correctly without green header

## TEST PAGE
http://contentcucumber.local/services-2/
- Has `requestdesk-landing-page` body class ✅
- Has "Enable landing page styling" checked ✅
- Green header should be hidden (testing)

## GP ELEMENTS CLASSES FOUND
```
gb-element-f58439fd - Green background (--accent-2)
gb-element-6d59db7d - Background decoration
gb-element-5b52fd41 - Inner container
gb-text-52f5b998 - "Services B" title
gb-shape-45457938 - Curvy wave SVG
```

## CSV FILES TO IMPORT
| File | Type |
|------|------|
| 01-services-parent.csv | Parent |
| 02-blog-writing.csv | Child |
| 03-seo-content.csv | Child |
| 04-website-copy.csv | Child |
| 05-email-marketing.csv | Child |
| 06-social-media.csv | Child |
| 07-aeo-optimization.csv | Child |
| 08-hubspot-redirect.csv | Redirect |
| 09-flywheel-redirect.csv | Redirect |
| 10-case-studies-redirect.csv | Redirect |

## CONTEXT NOTES
- Files between workspace and LocalWP are hardlinked
- LocalWP site: http://contentcucumber.local/ (port 80 via nginx router)
- PHP caching may require site restart for template changes
