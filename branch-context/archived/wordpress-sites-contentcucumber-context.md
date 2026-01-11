# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
2. **Verify branch:** `git branch --show-current` (should be: main)
3. **Plugin location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`
4. **Theme location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
5. **Local WP site:** `http://contentcucumber.local/wp-admin/`

## SESSION METADATA
**Last Commit:** `9ac076b Add dynamic mega menu system that reads from WordPress menu structure`
**Saved:** 2025-12-30
**Purpose:** Dynamic mega menu, CSV term fixes, Commerce LLM Discovery service

## CRITICAL: MEGA MENU NEEDS TESTING
**🔄 IN PROGRESS:** User has NOT tested the dynamic mega menu yet

### What Changed:
- Built custom `Cucumber_Mega_Menu_Walker` class in `functions.php`
- Reads parent/child/grandchild hierarchy from WordPress menus
- All dropdown items automatically become mega menus
- Promo column fills space when <3 children
- Banner + promo customizable via Appearance → Customize → Mega Menu Settings

### Test Instructions:
1. Hard refresh local site: `http://contentcucumber.local` (Cmd+Shift+R)
2. Hover over menu items with children (Services)
3. Verify columns display correctly from WordPress menu structure
4. Check promo area shows when fewer than 3 columns

### Menu Structure Expected:
```
Services (top-level, triggers mega menu)
├── Content Creation (column 1 header)
│   ├── Blog Writing (link)
│   ├── SEO Content (link)
│   └── ...
├── Content in Commerce (column 2 header)
│   ├── Product Descriptions (link)
│   └── ...
└── Marketing Management (column 3 header)
    └── ...
```

## VIOLATION LOGGED THIS SESSION
**Violation #86** - Hardcoded mega menu links instead of reading from WordPress. User had to explain the purpose of a mega menu. Fixed by rebuilding with dynamic Walker class.

## OTHER WORK COMPLETED THIS SESSION

### 1. Fixed 47 CSV Term Violations
All 10 CSV files cleaned:
- 103-website-copy.csv (8 fixes)
- 00-services-hub.csv (7 fixes)
- 102-seo-content.csv (6 fixes)
- 105-social-media.csv (6 fixes)
- 101-blog-writing.csv (4 fixes)
- 104-email-marketing.csv (4 fixes)
- 201-product-descriptions.csv (4 fixes)
- 202-category-pages.csv (4 fixes)
- 03-marketing-management-parent.csv (2 fixes)
- 01-content-creation-parent.csv (2 fixes)

Replacements: resonate→connect, aligned→support, ensures→delivers, refine→polish, journey→path, dive→session, landscape→environment, etc.

### 2. Created New Commerce Service CSV
**File:** `/Users/brent/scripts/CB-Workspace/wordpress-sites/test-data/csv-examples/cucumber-services/203-commerce-llm-discovery.csv`
- Service Name: Commerce LLM Discovery
- Parent: Content in Commerce
- Focus: AI assistant optimization, structured data, semantic content

### 3. Created `/check-terms` Command
**File:** `/Users/brent/scripts/CB-Workspace/.claude/commands/check-terms.md`
- Scans content against RequestDesk content terms API
- Supports file paths, direct text, and list modes

## KEY FILES MODIFIED THIS SESSION
1. `themes/cucumber-gp-child/functions.php` - Custom Walker class `Cucumber_Mega_Menu_Walker`
2. `themes/cucumber-gp-child/mega-menu.css` - Dynamic mega menu styles (v2.0.0)
3. Various CSV files in `wordpress-sites/test-data/csv-examples/cucumber-services/`
4. `.claude/commands/check-terms.md` - New command
5. `.claude/violations/incorrect-instruction-log.md` - Added violation #86

## TODO LIST STATE
- ✅ Create [requestdesk_related_services] shortcode (USER APPROVED)
- ✅ Update child template to use shortcode (USER APPROVED)
- ✅ Create /check-terms command (USER APPROVED)
- ✅ Fix CSV term violations - 47 total (USER APPROVED)
- ✅ Create Commerce LLM Discovery service CSV
- 🔄 IN PROGRESS: Test mega menu on local site (USER MUST TEST)
- ⏳ PENDING: Fix any mega menu issues found during testing

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User tests mega menu on local site
2. **THEN:** Fix any styling or functionality issues
3. **VERIFY:** Menu items come from WordPress admin, not hardcoded

## VERIFICATION COMMANDS
- Local WP site: http://contentcucumber.local
- Local WP Admin: http://contentcucumber.local/wp-admin/
- Customizer: http://contentcucumber.local/wp-admin/customize.php (check Mega Menu Settings)

## CONTEXT NOTES
- Live site: https://www.contentcucumber.com (Flywheel hosting)
- Theme: GeneratePress child theme
- Mega menu applies to `primary` theme location only
- Dynamic FAQs via `RequestDesk_Frontend_QA` class using `ai_questions` data
