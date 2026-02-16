# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Faraday
**Status:** SAVED
**Last Saved:** 2026-02-16 14:05
**Last Started:** 2026-02-15 (resumed from emergency context)

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Branch:** `git checkout feature/tc-site-audit`
3. **Last Commit:** `81980f3 Add TC migration gap analysis todo + update audit README`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| astro | TC site audit (17 tasks, 4 deploys), WP-to-RD gap analysis |
| cc | Added --help text to /site-audit command |

## CURRENT TODO
**Path:** `todo/current/infrastructure/tc-wordpress-to-rd-migration/`
**Status:** Gap analysis complete, implementation planning needed

## WHAT YOU WERE WORKING ON
Talk Commerce site audit and WordPress-to-RequestDesk migration planning.

**Completed this session:**
1. TC site audit - all 17 tasks across quick + deep audit
2. 4 production deployments, all verified live (9/9 checks passed)
3. WordPress-to-RD gap analysis comparing TC's wordpress.ts API contract against RD's public posts API
4. Created migration todo with phased implementation plan

**The gap analysis identified:**
- 6 critical gaps (taxonomy collections, exclude_category filter, author slug/avatar, search, sort)
- 4 important gaps (featured_image_alt, pagination extras, category list endpoint, RSS feed generation)
- Recommended strategy: build RD headless API to match WP contract (Option A)

## CURRENT STATE
- **TC Site Audit:** ALL 17 tasks deployed and verified. Ready for /claude-complete.
- **Migration Planning:** Gap analysis done. Todo created at `todo/current/infrastructure/tc-wordpress-to-rd-migration/`. Needs /start-work to create branch and begin implementation.
- **Branch:** feature/tc-site-audit (all work committed, merged to master 4x)

## TODO LIST STATE
- Completed: TC site audit (17/17 tasks, 4 deploys, all verified)
- Pending: TC WordPress-to-RD migration (10 gaps identified, 5 phases planned)

## NEXT ACTIONS
1. **FIRST:** Run `/claude-complete` on tc-site-audit to archive it
2. **THEN:** Run `/start-work` for tc-wordpress-to-rd-migration (creates branch in rd workspace)
3. **NOTE:** Migration work is primarily in RD backend (requestdesk-app), not astro-sites

## CONTEXT NOTES
- TC site went from 57/100 to estimated 85+/100 on SEO/AEO/AIO scoring
- The `podcasts` category slug is hardcoded throughout TC as the discriminator between podcasts and blog posts
- TC's wordpress.ts already uses the RD Headless WP Plugin API (not native WP REST), so the contract is already RD-shaped
- Transistor.fm integration is independent of WordPress and stays as-is
- Migration todo lives in astro-sites but actual implementation will be in requestdesk-app (RD backend)
