# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector`
2. **Verify branch:** `git branch --show-current` (should be: main)
3. **Plugin location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`
4. **Theme location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
5. **Local WP site:** `http://contentcucumber.local/wp-admin/`

## SESSION METADATA
**Last Commit:** `f998988 Add Open Base template - flexible Claude-friendly landing pages`
**Saved:** 2026-01-02
**Purpose:** Open Base template implementation for flexible landing pages

## CONTENT SOURCE CSVs - CRITICAL REFERENCE
**Path:** `/Users/brent/scripts/CB-Workspace/wordpress-sites/test-data/csv-examples/cucumber-services/`
All page content is defined in these CSVs - NOT in theme files!

## FLYWHEEL WAF ISSUE - WAITING ON SUPPORT
- **Status:** Escalated to Hosting Operations team (Dec 31)
- **Issue:** 403 Forbidden on all REST API endpoints when editing pages in Gutenberg
- **Workaround:** Edit locally → push to staging → push to live

## COMPLETED THIS SESSION

### 1. Open Base Template (NEW)
Created flexible template for Claude-assisted landing page creation:
- **Template file:** `admin/aeo-template-open-base.php`
- **Import function added to:** `admin/aeo-template-importer.php`
- Dropdown option: "🎨 Open Base - Flexible sections (Claude-friendly)"

### 2. CSV Structure for Open Base
| Section | Columns |
|---------|---------|
| Hero | title, subtitle, hero_tagline, hero_image_url, hero_image_alt, hero_cta_text, hero_cta_url, color_theme |
| Sections (1-10) | section_N_heading, section_N_content, section_N_image_url, section_N_image_alt, section_N_image_position |
| CTA | cta_heading, cta_text, cta_button_text, cta_button_url |

### 3. Sample CSVs Created
- `500-open-base-example.csv` - Generic example with 3 sections
- `600-contentbasis-welcome-openbase.csv` - ContentBasis welcome page converted

### 4. Spacing Fixes Applied
- Reduced section padding: 70px → 50px
- Removed nested content wrapper groups (was adding extra margins)
- Added explicit `margin:0` to sections, headings, images
- Added `blockGap:"0"` to prevent default WordPress spacing

## TODO LIST STATE
- ✅ COMPLETED: Create aeo-template-open-base.php with dynamic sections
- ✅ COMPLETED: Add Open Base to template dropdown in importer
- ✅ COMPLETED: Add import function for Open Base CSV
- ✅ COMPLETED: Add template getter with CSV replacements
- ✅ COMPLETED: Create sample CSV for testing
- ⏳ PENDING: User test landing page import (re-import after spacing fix)
- ⏳ PENDING: Push theme/plugin changes Local → Staging → Live
- 🔄 BACKGROUND: Wait for Flywheel WAF response

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Delete existing "Welcome ContentBasis" page (has old template structure)
2. **THEN:** Re-import `600-contentbasis-welcome-openbase.csv` with Open Base template
3. **VERIFY:** Check that spacing is tighter after the fix
4. **IF STILL BAD:** May need to further adjust or check WordPress theme CSS overrides
5. **WHEN READY:** Push changes Local → Staging → Live

## VERIFICATION COMMANDS
- Import landing page: WP Admin → RequestDesk → AEO Template Importer → Open Base
- CSV location: `/Users/brent/scripts/CB-Workspace/wordpress-sites/test-data/csv-examples/cucumber-services/600-contentbasis-welcome-openbase.csv`

## KEY FILES MODIFIED THIS SESSION
1. `admin/aeo-template-open-base.php` - **NEW** - Template with dynamic section generators
2. `admin/aeo-template-importer.php` - Added dropdown, import function, template getter
3. `500-open-base-example.csv` - **NEW** - Example CSV
4. `600-contentbasis-welcome-openbase.csv` - **NEW** - ContentBasis welcome page

## CONTEXT NOTES
- Live site: https://www.contentcucumber.com (Flywheel hosting)
- Theme: GeneratePress child theme (cucumber-gp-child)
- Workflow: Local → Staging → Live (due to WAF issue)
- User mentioned excessive spacing in first test - applied fixes, needs re-test
