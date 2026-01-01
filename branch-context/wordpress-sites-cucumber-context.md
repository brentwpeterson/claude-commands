# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
2. **Verify branch:** `git branch --show-current` (should be: main)
3. **Plugin location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`
4. **Theme location:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
5. **Local WP site:** `http://contentcucumber.local/wp-admin/`

## SESSION METADATA
**Last Commit:** `a203543 Fix mega menu hover behavior + remove GeneratePress footer credit`
**Saved:** 2025-12-31
**Purpose:** Mega menu fixes + WAF 403 investigation

## MEGA MENU STATUS: ✅ COMPLETE (USER TESTED)
The dynamic mega menu is fully working:
- 3-column layout for Services dropdown
- Hover bridge on nav item (::after) - doesn't block Login
- Grandchildren items display correctly
- "Built with GeneratePress" removed from footer
- Customizer settings for banner/promo content

### Key Commits This Session:
1. `a203543` - Fix hover bridge (moved from dropdown ::before to nav item ::after)
2. `b39aa28` - Walker class, CSS positioning, clickable links

## CRITICAL ISSUE: FLYWHEEL WAF BLOCKING PAGE SAVES

### Problem Summary
- **Symptom:** 403 Forbidden on ALL REST API endpoints when editing certain pages on LIVE
- **Affected pages:** Content Creation, Marketing Management (parent landing pages)
- **Working pages:** Content in Commerce
- **LOCAL:** Works perfectly
- **LIVE:** 403 errors immediately when opening page in Gutenberg

### 403 Error Details
When opening affected pages in Gutenberg on live:
```
OPTIONS /wp-json/wp/v2/settings - 403
GET /wp-json/wp/v2/users/96 - 403
GET /wp-json/wp/v2/comments - 403
GET /wp-json/wp/v2/taxonomies - 403
GET /wp-json/wp/v2/wp_pattern_category - 403
```

### Root Cause
Flywheel's WAF (Web Application Firewall) is blocking requests because something in the page CONTENT triggers a ModSecurity rule. The same pages work perfectly on local WordPress.

### Previous Fix Attempt (From Earlier Session)
JSON-LD `<script type="application/ld+json">` tags were removed from templates. Templates are now clean - but WAF still triggers on certain content.

### WORKAROUND
- Edit pages LOCALLY
- Push database to live
- Pages display correctly, just can't be edited on live

### REQUIRED ACTION
**Contact Flywheel Support** with this message:
```
Subject: WAF blocking REST API requests when editing specific pages

Hi Flywheel Support,

I'm getting 403 Forbidden errors on my site (contentcucumber.com) when trying to edit certain pages in WordPress Gutenberg editor.

Issue:
- Opening specific pages in Gutenberg immediately triggers 403 errors on ALL REST API endpoints
- The same pages work fine on my local WordPress installation
- Other pages on the same site edit/save without issue
- The 403 happens before I even click Save - just loading the page in the editor triggers it

Affected endpoints (all return 403):
- /wp-json/wp/v2/settings
- /wp-json/wp/v2/comments
- /wp-json/wp/v2/users
- /wp-json/wp/v2/taxonomies

Could you please check the WAF/ModSecurity logs to identify which rule is being triggered by my page content?

Thank you!
```

## TODO LIST STATE
- ✅ COMPLETED: Mega menu working (USER TESTED)
- ✅ COMPLETED: Remove "Built with GeneratePress" footer
- ✅ COMPLETED: Fix hover bridge blocking Login nav item
- ⏳ PENDING: Contact Flywheel about WAF 403 issue
- ⏳ PENDING: Update featured field in Email Marketing/Social Media CSVs (if wanted)
- ⏳ PENDING: Remove DEBUG comments from functions.php (optional)

## NEXT ACTIONS (PRIORITY ORDER)
1. **CONTACT FLYWHEEL** - Send the support message above
2. **WORKAROUND** - Edit pages locally, push DB to live
3. **OPTIONAL** - Clean up DEBUG comments in functions.php Walker class

## KEY FILES MODIFIED THIS SESSION
1. `functions.php` - Added footer copyright filter, simplified mega menu JS
2. `mega-menu.css` - Fixed hover bridge (now on nav item ::after instead of dropdown ::before)

## CONTEXT NOTES
- Live site: https://www.contentcucumber.com (Flywheel hosting)
- Theme: GeneratePress child theme (cucumber-gp-child)
- The WAF issue is NOT fixable in code - it's a hosting configuration issue
- Local and live use same WordPress version, same plugins, same content
