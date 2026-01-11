# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/LocalSites/contentcucumber`
2. **Verify git status:** `git status` (expect: clean after commit 5a5fbf1)
3. **Verify branch:** `git branch --show-current` (should be: main)

## SESSION METADATA
**Last Commit:** `5a5fbf1 Add page update capability + Convert grid shortcode to CSS classes`
**Saved:** 2026-01-03

## 🚨 CRITICAL ISSUE TO FIX FIRST
The grid shortcode CSS was updated but **cards are displaying in ROWS not columns**!
- User reported: Cards on `/services/content-creation/` look terrible in rows
- Root cause: CSS is loading (verified) but grid may have specificity issue
- **FIRST ACTION**: Debug why `.requestdesk-grid--cols-3 { grid-template-columns: repeat(3, 1fr); }` isn't applying

## WHAT WAS COMPLETED THIS SESSION

### 1. Page Update Capability via /import-page (WORKING)
- Added `page_id` parameter to `/import-page` endpoint
- If `page_id` provided: regenerates template content and updates existing page
- If no `page_id`: creates new page as before
- Fixed `/publish` endpoint bug that was converting pages to posts on update

### 2. Batch Updated 12 AEO Pages (WORKING)
All child pages (landing_child template) updated successfully:
- Blog Writing (20808): 4 inline styles ✅
- SEO Content (20809): 4 inline styles ✅
- Website Copy (20810): 4 inline styles ✅
- Email Marketing (20811): 4 inline styles ✅
- Social Media (20812): 4 inline styles ✅
- AEO Optimization (20813): 4 inline styles ✅
- Product Descriptions (20815): 4 inline styles ✅
- Category Pages (20816): 4 inline styles ✅
- Commerce LLM Discovery (20855): 4 inline styles ✅

Hub/Parent pages still have many inline styles (219-223 each):
- Services (20806): 223 inline styles - from grid shortcode
- Content Creation (20807): 219 inline styles
- Content in Commerce (20814): 219 inline styles
- Marketing Management (20817): 219 inline styles

### 3. Grid Shortcode CSS Conversion (IN PROGRESS - BROKEN)
- Converted `requestdesk_child_grid_shortcode()` in `requestdesk-connector.php`
- Changed from inline styles to CSS classes
- Added CSS to `cucumber-gp-child/style.css`:
  - `.requestdesk-grid--cols-*` for column layouts
  - `.requestdesk-card`, `.requestdesk-card--category`, `.requestdesk-card--service`
  - Responsive breakpoints at 900px and 600px
- **PROBLEM**: Cards showing in rows, not grid columns

## KEY FILES MODIFIED
- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/includes/class-requestdesk-api.php`
  - Added `page_id` param to `/import-page`
  - Added `generate_template_content()` helper
  - Fixed `/publish` to preserve post_type on update

- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/requestdesk-connector.php`
  - Converted `requestdesk_child_grid_shortcode()` to CSS classes
  - Lines ~416-530

- `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/style.css`
  - Added ~150 new lines of CSS for grid and card styles
  - Look for "RequestDesk Grid Shortcode Styles" section

## TODO LIST STATE
- ✅ COMPLETED: Update all 12 AEO pages with CSS classes (batch script worked)
- 🔄 IN PROGRESS: Convert child_grid shortcode to CSS classes (CSS not applying correctly)
- ⏳ PENDING: Debug grid layout issue - cards in rows not columns
- ⏳ PENDING: Verify hub/parent pages after grid fix

## NEXT ACTIONS (PRIORITY ORDER)
1. **DEBUG GRID**: Check why grid isn't displaying columns:
   ```bash
   # Check the actual CSS being loaded
   curl -s "http://contentcucumber.local/wp-content/themes/cucumber-gp-child/style.css" | grep -A5 "requestdesk-child-grid"

   # Check if there's conflicting CSS
   curl -s "http://contentcucumber.local/services/content-creation/" | grep -o 'style="[^"]*display[^"]*"'
   ```

2. **POSSIBLE FIXES**:
   - Add `!important` to grid display if needed
   - Check if GeneratePress theme is overriding
   - Verify the HTML structure matches the CSS selectors

3. **TEST**: Visit `http://contentcucumber.local/services/content-creation/` and verify grid

## VERIFICATION COMMANDS
```bash
# Check page for grid classes
curl -s "http://contentcucumber.local/services/content-creation/" | grep "requestdesk-grid"

# Check CSS file for grid rules
grep -A10 "Grid Layouts" /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/style.css

# Count inline styles on hub page
curl -s -H "X-RequestDesk-API-Key: spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8" \
  "http://contentcucumber.local/wp-json/requestdesk/v1/pull-pages?per_page=100" | \
  jq -r '.pages[] | select(.id == 20807) | .content' | grep -o 'style="[^"]*"' | wc -l
```

## CONTEXT NOTES
- This is Content Cucumber WordPress site on Local WP (not cb-wordpress plugin)
- Directory: `/Users/brent/LocalSites/contentcucumber`
- API Key for testing: `spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`
- Child theme is `cucumber-gp-child` extending GeneratePress
- The hub/parent pages have high inline style counts because the `[requestdesk_child_grid]` shortcode dynamically renders - those counts will drop once grid CSS works
