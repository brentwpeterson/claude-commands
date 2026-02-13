# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Opus
**Status:** ACTIVE
**Last Saved:** 2026-02-07 07:10
**Last Started:** 2026-02-07 08:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
2. **Branch:** `git checkout feature/author-pages`
3. **Last Commit:** `18bd7fe Mobile homepage fixes, global page hero banner, related services shortcode`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| wps | Content Cucumber child theme: mobile fixes, global page hero, related services shortcode |

## CURRENT TODO
**Path:** None (tracked via session)
**Status:** Mobile homepage and global page hero work in progress, ready for testing

## WHAT YOU WERE WORKING ON
Three areas of work on the Content Cucumber WordPress child theme:

### 1. Mobile Homepage Fixes
- Footer columns were overlapping on mobile. Added CSS in style.css to force single-column stack (`float: none; width: 100%; clear: both`) at max-width 768px.
- White gaps between content sections and footer on homepage. Added aggressive resets on `#page`, `.site-content`, `.site-main > *` for homepage (body.home / body.page-id-2). Also set `.cc-homepage-content > *` to `max-width: 100%; margin-left: 0; margin-right: 0` in homepage-hero.css.
- **STILL IN PROGRESS:** White strips on sides of content blocks on mobile are partially fixed. The block editor sections don't go fully edge-to-edge. The bottom gap between content and footer may still show. Need user to test on mobile and inspect specific elements causing remaining gaps.
- Reduced `.cc-home-hero` bottom padding from 70px to 50px per user request.

### 2. Global Page Hero Banner
- Replaced the default GeneratePress green swoosh page header with the `.cc-page-hero` thin navy banner site-wide.
- Added `cucumber_page_hero_banner()` in functions.php hooked to `generate_before_main_content` at priority 5.
- Handles: blog index, category, tag, search, archive, single post, page, 404.
- Skips: front page, Our Writers template, author archives (they have their own heroes).
- Removed default GP archive title action: `remove_action('generate_archive_title', 'generate_archive_title')`.
- Added inline CSS via `wp_head` to hide `.page-header`, `.entry-header`, `.page-hero`, `.inside-page-header`.
- Made the GP green swoosh GB elements (`.gb-element-f58439fd`, etc.) hidden globally via `body:not(.home)` selector in style.css, replacing the previous author/writers-only scoping.
- **NEEDS TESTING:** Verify the green swoosh is gone on all pages. Verify the navy hero shows correct title/eyebrow on blog, categories, single posts, pages, search, 404.

### 3. Related Services Shortcode
- The `[requestdesk_related_services]` shortcode was showing as raw text on production (e.g., `/services/content-in-commerce/commerce-llm-discovery/`).
- Found in archived context that this was marked "completed" in a Dec 2025 session but never implemented.
- Added the shortcode to `class-requestdesk-child-grid.php` in the RequestDesk connector plugin.
- Shows sibling pages (other children of the same parent), excluding the current page.
- Uses the same card rendering as `[requestdesk_child_grid]`.
- Adds a "Related Services" heading. Supports columns, heading, orderby, order attributes.

## CURRENT STATE
- **Files modified (committed):** style.css, functions.php, homepage-hero.css, class-requestdesk-child-grid.php
- **Last commit:** `18bd7fe` on `feature/author-pages`
- **Tests run:** User visually tested mobile. Footer overlap fixed. White gaps partially addressed. Green swoosh hidden on blog. Navy hero banner showing on blog.
- **Issues found:** White strips on sides of mobile homepage content blocks may still exist (block editor sections not edge-to-edge). Need further mobile testing.

## TODO LIST STATE
- Completed: Footer mobile column stacking fix, global page hero banner, related services shortcode, hero padding reduction
- In Progress: White gap removal between homepage content and footer (partially fixed, needs mobile testing)
- Pending:
  - "Talk to Us" CTA button in nav header
  - CC brand font decision
  - Author pages testing (/our-writers/ and individual author archives)
  - Homepage hero copy/design iteration
  - Push to production and test all changes
  - Verify global page hero on all page types (categories, tags, search, single posts, 404)

## NEXT ACTIONS
1. **FIRST:** Test mobile homepage on device - check for remaining white strips on sides and bottom gap
2. **THEN:** If white gaps persist, inspect the specific element in mobile devtools and share with Claude
3. **VERIFY:** Check global page hero on: blog listing, single blog post, category page, search results, 404, regular pages
4. **VERIFY:** Check `[requestdesk_related_services]` renders on production after plugin update
5. **CONSIDER:** "Talk to Us" CTA in nav header
6. **LATER:** Merge feature/author-pages to main when all changes are tested

## CONTEXT NOTES
- The homepage page ID is 2 (title "HOME") set as static front page in WP settings
- The block editor hero content in GenerateBlocks wrapper `.gb-element-fe911258` is hidden via CSS when front-page.php renders its own hero
- The GP green swoosh header uses GenerateBlocks elements: `.gb-element-f58439fd`, `.gb-element-6d59db7d`, `.gb-element-5b52fd41`, `.gb-text-52f5b998`, `.gb-shape-45457938`, plus `div[style*="58c558"]` for the green color
- The `.cc-page-hero` CSS is in style.css (lines ~1457+), uses `width: 100vw` with negative margin to break out of containers
- The `front-page.php` uses its own `<main>` tag and doesn't use the standard GP article wrapper. The GP header opens `#page > .site-content` and footer.php closes both with `</div></div>`
- Untracked requestdesk-connector plugin files (headless API, docs) and sql/ directory are NOT related to this work
- The `feature/homepage-generateblocks-hero` branch still has a stash. Don't pop it on this branch.
- WP-CLI works via MySQL socket: `--socket="/Users/brent/Library/Application Support/Local/run/GV3SQPopW/mysql/mysqld.sock"`
- Table prefix: `wp_83rxila95v_`
- Local DB was not running during this session (503 error when trying to query)
