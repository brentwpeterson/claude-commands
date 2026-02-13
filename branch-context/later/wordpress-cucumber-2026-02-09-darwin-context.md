> **PARKED SESSION: HubSpot pillar pages (CSS class rewrite) + FAQ schema fix (deployed) + Lighthouse audit**
> **Workspace:** wps, wpp | **Branch:** N/A (LocalWP) / main (wpp) | **Parked:** 2026-02-09
> **Why parked:** Pillar CSS done, schema fix deployed, robots.txt created, hero bleed needs template approach
> **To resume:** Read the full context below, then ask user what to work on first.

# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Darwin
**Status:** LATER
**Last Saved:** 2026-02-11 08:50
**Parked:** 2026-02-09 18:00

## IMMEDIATE SETUP
1. **Theme Dir:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child/`
2. **HTML Dir:** `/Users/brent/scripts/CB-Workspace/.claude/local/hubspot-pages/`
3. **CSV Dir:** `/Users/brent/LocalSites/contentcucumber/test-data/`
4. **Plugin Dir:** `/Users/brent/LocalSites/contentcucumber/app/public/wp-content/plugins/requestdesk-connector/`
5. **No git repo** - this is a LocalWP site, push via LocalWP UI

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| wps | HubSpot pillar page CSS class rewrite, theme CSS additions, hero bleed fix, FAQ schema fix |
| wpp | Synced plugin to canonical repo (frontend-qa.php JSON-LD fix) |

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. HubSpot Pillar Pages - Inline Styles to CSS Classes (DONE)
- Rewrote all 5 HTML files to use CSS classes instead of inline styles:
  - `hubspot-pillar.html` (parent page)
  - `hubspot-cms.html` (child)
  - `hubspot-sales-hub-pro.html` (child)
  - `hubspot-marketing-hub-pro.html` (child)
  - `hubspot-audit.html` (child)
- Added ~100 lines of new CSS classes to `style.css` (section backgrounds, labels, button variants, grids, comparison table, cross-links, text utilities, etc.)
- Added landing page banner skip to `functions.php` (checks `_requestdesk_landing_page` meta)
- Regenerated both test CSVs with Python for proper escaping

### 2. FAQ Schema JSON-LD Fix (DEPLOYED)
- Found root cause of Google Search Console "Bad escape sequence in string" error
- Bug was in `class-requestdesk-frontend-qa.php` line 245: `esc_js()` escapes `'` as `\'` which is invalid JSON
- Fixed by replacing hand-built JSON template with `wp_json_encode()` (line 234-251)
- Synced plugin to canonical repo via `/sync-wp-plugin`
- User pushed to production via LocalWP

### 3. Hero Full-Width Bleed (IN PROGRESS - NOT WORKING YET)
- Added CSS overrides in `hero-styles.css` to remove GP container max-width constraints
- Targets full GP DOM chain: `#page.grid-container > #content > main > article > .inside-article > .entry-content`
- Hero still shows gaps on left/right sides in screenshot
- Root cause: GeneratePress deeply nested container structure constrains width
- Options discussed with user:
  - Full-page template (custom `page-hubspot.php` skipping GP wrappers)
  - Page builder approach
  - Keep hacking CSS (current approach, frustrating)
- User acknowledged Astro gives much better design control than WP/GP

### 4. Lighthouse Audit (contentcucumber.com)
- Performance: 64 (mobile), Accessibility: 100, Best Practices: 35, SEO: 92
- FCP 4.5s, LCP 8.6s (poor), CLS 0.019 (good), TBT 10ms (good)
- Main issues: HubSpot third-party JS (~200KB), redirect chain (non-www to www, 780ms), 3 HTTP images on homepage
- Created physical `robots.txt` in LocalWP root (was 301 redirecting to /?robots=1)
- 3 insecure image URLs on homepage: creativity.png, Intelligence.png, Plans.png (need http->https fix in WP admin)

### 5. Plugin Canonical Repo Committed
- Committed all synced files to `requestdesk-wordpress` main branch: `ccac09a`
- Includes frontend-qa fix + stats bar + comparison table + homepage hero features

## PENDING ITEMS
- Hero bleed still not edge-to-edge (needs template approach, not more CSS hacking)
- Pages need to be re-imported via CSV to get the new class-based HTML
- robots.txt created locally, needs push via LocalWP
- 3 homepage images need http->https fix (manual edit in WP admin)
- Theme changes are only on LocalWP (not pushed to production yet)

## KEY FILES MODIFIED
| File | Change |
|------|--------|
| `functions.php` | Added landing page skip in `cucumber_page_hero_banner()` |
| `hero-styles.css` | Added GP container full-width overrides for landing pages |
| `style.css` | Added ~100 lines of pillar page CSS classes |
| `hubspot-pillar.html` | Rewritten: inline styles to CSS classes |
| `hubspot-cms.html` | Rewritten: inline styles to CSS classes |
| `hubspot-sales-hub-pro.html` | Rewritten: inline styles to CSS classes |
| `hubspot-marketing-hub-pro.html` | Rewritten: inline styles to CSS classes |
| `hubspot-audit.html` | Rewritten: inline styles to CSS classes |
| `pillar-hubspot-parent.csv` | Regenerated with updated HTML |
| `pillar-hubspot-cms-child.csv` | Regenerated with updated HTML |
| `class-requestdesk-frontend-qa.php` | Fixed JSON-LD: esc_js() to wp_json_encode() |
| `robots.txt` (LocalWP root) | Created physical file to avoid 301 redirect |

## NEXT ACTIONS
1. **FIRST:** Push LocalWP to get robots.txt live
2. **THEN:** Fix 3 homepage images (http->https) in WP admin
3. **THEN:** Create full-page template for pillar pages (skip GP wrappers) instead of CSS hacking
4. **THEN:** Re-import pillar CSVs and verify pages render correctly
5. **VERIFY:** Check Search Console clears structured data error + robots.txt resolves

## CONTEXT NOTES
- Plan file exists at `/Users/brent/.claude/plans/drifting-enchanting-quokka.md` with full implementation details
- The CSS class mapping table in the plan is the reference for all HTML conversions
- GP DOM chain is: body > #page.grid-container.container > #content.content-area > main.site-main > article > .inside-article > .entry-content > div (wp:html) > .cc-page-content > section
- `wp_json_encode()` is the correct WP function for JSON-LD output, never `esc_js()` in JSON context
