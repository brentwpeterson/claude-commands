# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/LocalSites/contentcucumber`
2. **Identity:** Claude-Mozart
3. **Branch:** `main`
4. **Last Commit (plugin repo):** `0c82001 Add contact page import type and child grid redirect URL support`
5. **Last Commit (contentcucumber):** `c1b35f4` (plugin synced but not committed here yet)
6. **Status:** Plugin repo committed. contentcucumber repo has uncommitted synced plugin files.

## WORKSPACES TOUCHED THIS SESSION
**Started in:** wpp (wordpress-plugin)
**Current workspace:** wpp (wordpress-plugin)
**All workspaces:** wpp

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `wpp` | requestdesk-wordpress | Contact page import type, child grid redirect support |
| LocalWP contentcucumber | contentcucumber repo | DB link replacements, plugin synced for testing |

## SESSION METADATA
**Saved:** 2026-01-31
**Plugin Repo:** `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress`
**LocalWP Site:** `/Users/brent/LocalSites/contentcucumber`
**Local Site URL:** `http://contentcucumber.local/`

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Link Audit (Obsidian)
- Queried LocalWP MySQL database for all booking/calendar links across 695 published URLs
- Found: 21 posts with Calendly links, 19 pages with HubSpot meeting links, 28 posts with get.contentcucumber.com links
- Saved full report to `Brent Notes/Company Websites/Content Cucumber/Link Audit.md`

### 2. Contact Page Import Type (Plugin)
- Added `contact` / `contact_page` template type to the CSV importer
- GenerateBlocks V2 markup with sections: hero, HubSpot form + contact info (email, phone, meeting button), local meetup, company group (3-card grid), FAQ
- Example CSV pre-filled with Content Cucumber data:
  - HubSpot form: portal 39487190, form c0151b30-e8f4-4489-ae19-ce554315f7b2
  - Phone: +1 808 210 3611
  - Email: hello@contentcucumber.com
  - Meeting URL: https://get.contentcucumber.com/meetings/cucumber/cucumber-sales-meeting
  - Company group: Talk Commerce, ContentBasis.ai, RequestDesk.ai
- Download button added to Template Importer admin UI

### 3. Database Link Replacements (LocalWP)
Replaced all external booking links in the WordPress database:
- **Calendly links** (21 posts) -> `/contact`
- **HubSpot meeting links on pages** (19 pages including isaac-morey/meeting, flywheel-demo, brent-strategy) -> new meeting URL `https://get.contentcucumber.com/meetings/cucumber/cucumber-sales-meeting` with `target="_blank"`
- **get.contentcucumber.com links** (29 posts) -> `/contact`
- **narcis-bejtic link** (1 post) -> `/contact`
- SQL script saved at: `/Users/brent/LocalSites/contentcucumber/replace-booking-links.sql`

### 4. Child Grid Redirect URL Support (Plugin)
- Added `_requestdesk_redirect_url` meta support to `requestdesk_child_grid` shortcode
- If meta is set on a child page, the card links directly to that URL instead of the child page permalink
- Fixed 3 child pages under Marketing Management (ID 20817):
  - HubSpot Services (20818) -> `/hubspot-audit/`
  - Agency White Label (20819) -> `/shopify-content-services/`
  - Case Studies (20820) -> `/casestudies/`
- Also cleaned date-stamped slugs (removed `-2025-12-29-17-24` suffixes)
- Updated excerpts on all 3 child pages

### 5. Old "Demo" Page
- Page ID 1111 at `/demo` uses a missing `calendly.php` template with empty content
- User should delete this page

## PENDING WORK

### User Testing Required
- Contact page: User needs to delete old contact page (ID 82), import new one via Template Importer using example-csv-contact.csv, and preview
- Marketing Management child grid: Verify the 3 "Learn More" cards now link to correct pages
- Spot-check blog posts for /contact links replacing old Calendly/get.cc URLs
- Spot-check service pages for new meeting URL opening in new tab

### Contentcucumber Repo Commit
- Plugin files synced to LocalWP but not committed to contentcucumber repo
- DB changes are in LocalWP only (not in any repo, would need to push via LocalWP)

### S3 Backlog: WP.org Distribution (697d491db2c257332616162d)
Remaining cleanup in requestdesk-wordpress plugin:
- `admin/aeo-template-enhanced.php`: CC branding (schema, testimonials, stats, FAQ, logos)
- `admin/aeo-template-about.php`: CC founding story, team members, FAQ, schema
- `admin/aeo-template-importer.php`: str_replace mappings with CC text as search keys
- Decision needed: Remove default templates entirely vs rewrite with generic content

### Delete Old Demo Page
- Page ID 1111 at `/demo` - empty content, missing `calendly.php` template - should be trashed

## KEY FILES

### Plugin (committed to requestdesk-wordpress repo)
- `admin/aeo-template-importer.php` - Contact page import type + switch cases
- `admin/example-csv-contact.csv` - Example CSV with CC data
- `includes/class-requestdesk-child-grid.php` - Redirect URL meta support

### Database Changes (LocalWP only)
- All Calendly, HubSpot meeting, and get.contentcucumber.com URLs replaced
- 3 child page slugs cleaned (removed date stamps)
- 3 child pages have `_requestdesk_redirect_url` meta set
- 3 child pages have updated excerpts
- SQL script: `/Users/brent/LocalSites/contentcucumber/replace-booking-links.sql`

### Obsidian
- `Brent Notes/Company Websites/Content Cucumber/Link Audit.md` - Full audit report

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User tests contact page import (delete old page, import CSV, preview draft)
2. **THEN:** Verify marketing-management child grid cards link correctly
3. **THEN:** Spot-check 5-10 blog posts for /contact links
4. **THEN:** Commit contentcucumber repo changes if satisfied
5. **LATER:** Address WP.org distribution cleanup (S3 backlog item)

## CONTEXT NOTES
- LocalWP MySQL socket: `/Users/brent/Library/Application Support/Local/run/GV3SQPopW/mysql/mysqld.sock`
- MySQL binary: `/Users/brent/Library/Application Support/Local/lightning-services/mysql-8.0.16+6/bin/darwin/bin/mysql`
- Table prefix: `wp_83rxila95v_`
- DB credentials: root/root, database: local
- The contentcucumber repo is at `/Users/brent/LocalSites/contentcucumber` (LocalWP site)
- The requestdesk-wordpress plugin repo is at `/Users/brent/scripts/CB-Workspace/requestdesk-wordpress`
