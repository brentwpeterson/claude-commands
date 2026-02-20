# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Edison
**Status:** SAVED
**Last Saved:** 2026-02-20 10:30
**Last Started:** 2026-02-20 08:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Branch:** `git checkout feature/tc-site-audit`
3. **Last Commit:** `2888458 Add Running Commerce landing page and nav entry`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| astro | Cross-linking deploy, domain fix, Running Commerce page, CLAUDE.md |
| wps | CC WordPress footer cross-links committed |
| cc | Brand ecosystem skills, workspace CLAUDE.md domain rule, violation log, learning moments |
| brent | Company Websites README filled in Obsidian |

## WHAT YOU WERE WORKING ON

### Deployed This Session (3 deploys)
1. **sites-v2026.02.20-cross-linking-brand-footer-v2** - Cross-linking all Astro sites + podcast-automation page + brand footer sections
2. **sites-v2026.02.20-tc-domain-fix** - Fixed talk-commerce.com -> talkcommerce.com across 11 files
3. **sites-v2026.02.20-running-commerce-landing** - Running Commerce landing page at /running-commerce

### Running Commerce Page (URGENT - just deployed)
- New podcast series landing page at talkcommerce.com/running-commerce
- Series within Talk Commerce feed, focused on specialty running industry
- Guest signup with email CTA (brent@talk-commerce.com)
- HubSpot form placeholder ready: replace `REPLACE_WITH_RUNNING_COMMERCE_FORM_ID` in running-commerce.astro
- Added to Podcasts dropdown nav (now a dropdown with Talk Commerce + Running Commerce)
- Added to sitemap
- User has a meeting NOW to show this to a potential guest

### Domain Fix (talk-commerce.com -> talkcommerce.com)
- Fixed 11 files: astro.config.mjs, robots.txt, llms.txt, sitemap, feed, all JSON-LD schema
- Email addresses (@talk-commerce.com) and WP API (wp.talk-commerce.com) left unchanged
- Hard rule added to workspace CLAUDE.md and astro-sites/CLAUDE.md
- Violation #119 logged: deployed without local build test

### CC WordPress Footer
- Cross-links committed in functions.php (755054a on feature/author-pages branch)
- User tests in LocalWP then pushes to live

### Company Websites README
- Filled in Obsidian: brent-workspace/ob-notes/Brent Notes/Company Websites/README.md
- All 4 brands with Word/Tagline/Sentence/Paragraph
- All domains with platform and purpose
- Brand skill file reference table

### Documentation Added
- astro-sites/CLAUDE.md (NEW): deployment rules, submodule checklist, domain rule
- Workspace CLAUDE.md: domain rule (talkcommerce.com not talk-commerce.com)
- Learning moment #11: push submodules before deploying
- Violation #119: deploy without local testing
- MEMORY.md created at ~/.claude/projects/-Users-brent-scripts-CB-Workspace/

## CURRENT STATE
- **Branch:** feature/tc-site-audit (all work merged to master and deployed)
- **3 deploys pushed today**, all successful
- **Submodule dirty state:** CB, EO, RD show modified (local build artifacts, not affecting deploys)
- **CC WP:** committed but not deployed (user handles via LocalWP)

## TODO LIST STATE
- Completed: Deploy astro-sites, domain fix deploy, Running Commerce page deploy, Company Websites README, CC WP footer commit, domain URL fix
- Pending: Test deployed sites for cross-linking, share CC positioning with Isaac, newsletter iteration (VTEX, eTail LinkedIn)
- Pending from Running Commerce: Create HubSpot form, swap form ID in running-commerce.astro

## NEXT ACTIONS
1. **FIRST:** User testing deployed sites (cross-links on CB, RD, TC + Running Commerce page)
2. **THEN:** Create HubSpot form for Running Commerce guest signup, swap ID in running-commerce.astro
3. **THEN:** Share Content Cucumber positioning with Isaac for feedback
4. **THEN:** Newsletter iteration (VTEX needs Brent personal hook, eTail LinkedIn posts)
5. **THEN:** Content plan discussion to connect all sites editorially (was started but interrupted)

## CONTEXT NOTES
- The brand-family skill at `.claude/skills/brand-family/SKILL.md` was NOT updated this session (older positioning). May need sync.
- Running Commerce targets: brand founders, specialty retailers, race directors, vendors, coaches
- Content Cucumber is repositioning from "writing service" to "marketing company" - needs Isaac's feedback
- The content plan discussion about connecting all sites was started but paused for Running Commerce urgency
- talkcommerce-com is NOT a submodule (direct directory in astro-sites repo)
- Deploy process for astro-sites: always check submodules first, use sites-v* tags

## DEFERRED QUESTIONS
- Did the Running Commerce page deploy in time for the meeting?
- Ready to test cross-links on live sites?
- Should we create the HubSpot form for Running Commerce?
- Isaac feedback on CC positioning?
