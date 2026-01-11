# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **WordPress sites directory:** `cd /Users/brent/scripts/CB-Workspace/wordpress-sites`
2. **Theme directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
3. **Plugin directory:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`
4. **Local WP site:** `http://contentcucumber.local/wp-admin/`
5. **Verify LocalWP is running** - Start in LocalWP app if needed

## SESSION METADATA
**Theme Last Commit:** `4008dcc Add hero padding constraints and empty paragraph fixes`
**WordPress-sites Last Commit:** `55a2a72 Update docs and create Case Study module plan`
**Saved:** 2026-01-05
**Purpose:** Shopify landing page, CSS fixes, Case Study module planning

## WHAT WAS COMPLETED THIS SESSION

### 1. Documentation Updates
- **test-data/README.md** - Complete template documentation with all CSV columns
- **README.md** - Added "Creating Landing Pages" section with quick start guide
- Documented Open Base template, file naming conventions (00, 1XX, 2XX, etc.)

### 2. Shopify "Done For You" Landing Page CSV
**File:** `test-data/csv-examples/cucumber-services/601-shopify-done-for-you.csv`
- Target: Shopify merchants for 3-month free pilot (20 stores)
- Uses Open Base template
- Sections: Hero, Limited offer, What you get, How it works, Chalet Market case study, Video section, CTA
- Meeting link: `https://contentbasis.io/meetings/cucumber/cucumber-sales-meeting`
- **Note:** test-data/ is in .gitignore - CSV exists but not tracked

### 3. CSS Fixes for Landing Pages
**File:** `cucumber-gp-child/style.css`
- Added `.hero .wp-block-cover__inner-container` - max-width 1200px, auto margins, 40px padding
- Added `.wp-block-cover.hero` - padding 80px 60px
- Added `p:empty { display: none; }` - hides empty paragraphs from template imports
- Added section spacing resets between consecutive blocks

### 4. Case Study Module Plan (Complete)
**Location:** `wordpress-sites/todo/current/feature/case-study-module/`
**Files:** 7 standard files created
- README.md - Overview and quick links
- case-study-module-plan.md - Full requirements, acceptance criteria, 6 phases
- architecture-map.md - System diagrams, data flow, file structure, API spec
- progress.log, debug.log, notes.md, user-documentation.md

**Implementation Phases:**
1. CPT Foundation (Days 1-2)
2. Shortcodes (Days 3-4)
3. Frontend Templates (Days 5-6)
4. REST API (Days 7-8)
5. Admin Wizard with AI (Days 9-12)
6. Brand Integration & Polish (Days 13-14)

## STYLING ISSUES STILL IN PROGRESS
User was testing the Shopify landing page when session ended:
- Hero padding added but may need more adjustment
- Empty `<p>` tags should now be hidden with CSS
- Section spacing may still need tuning
- **User should hard refresh (Cmd+Shift+R) to see CSS changes**

## TODO LIST STATE
- ✅ Update test-data/README.md with template documentation
- ✅ Update main README.md with landing page workflow
- ✅ Create Shopify landing page CSV (601-shopify-done-for-you.csv)
- ✅ Create Case Study Module plan (7 files)
- 🔄 IN PROGRESS: CSS styling fixes for landing pages
- ⏳ PENDING: User testing of Shopify landing page
- ⏳ PENDING: Import CSV and verify output
- ⏳ PENDING: 6 templates still need CSS conversion (from previous session)

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User hard refresh and test landing page styling
2. **THEN:** Adjust CSS if spacing/padding still needs work
3. **IMPORT:** User imports 601-shopify-done-for-you.csv via RequestDesk → AEO Templates
4. **VERIFY:** Check page renders correctly, replace video placeholder with YouTube embed
5. **LATER:** Begin Case Study module implementation when ready

## PLACEHOLDERS IN SHOPIFY CSV
- ✅ Meeting link updated to: `https://contentbasis.io/meetings/cucumber/cucumber-sales-meeting`
- ⚠️ Hero image: placeholder URL needs real image
- ⚠️ Video section: User needs to manually add YouTube embed block after import

## KEY FILES MODIFIED
1. `wordpress-sites/README.md` - Landing page docs
2. `wordpress-sites/test-data/README.md` - Full template documentation
3. `wordpress-sites/test-data/csv-examples/cucumber-services/601-shopify-done-for-you.csv` - New
4. `wordpress-sites/todo/current/feature/case-study-module/` - 7 files created
5. `cucumber-gp-child/style.css` - Hero padding, empty p fix, section spacing

## CONTEXT NOTES
- **Flywheel WAF Issue:** Still blocking REST API on staging/live - work locally
- **LocalWP:** Site at `http://contentcucumber.local/`
- **test-data/ is gitignored** - CSV files exist locally but not tracked in git
- **Previous session context:** CSS refactoring started, 6 templates still pending conversion
