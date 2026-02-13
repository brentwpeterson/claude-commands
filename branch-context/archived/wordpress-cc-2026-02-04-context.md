# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/LocalSites/contentcucumber/app/public/wp-content/themes/cucumber-gp-child`
2. **Identity:** Claude-CC
3. **Branch:** `git checkout main`
4. **Last Commit:** `a32a752 Fix mega menu ghost hover zone triggering in middle of screen`
5. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| wordpress-cc | Fixed mega menu ghost hover zone, wrote AI workshop delivery email |
| brent | Wrote AI-Ready Workshop delivery email to Obsidian |

## CURRENT TODO
**Path:** None
**Status:** Emergency fix session, no formal todo

## WHAT YOU WERE WORKING ON

### 1. MEGA MENU FIX (READY FOR PRODUCTION PUSH)
Fixed Content Cucumber mega menu ghost hover zone issue where:
- Menu would activate when mousing from bottom of screen upward
- Hover triggered in middle of screen instead of on SERVICES nav item

**Root cause:** Hidden sub-menu had bounding box that triggered parent `:hover` state even when invisible.

**Fix applied to `nav-dropdown.css`:**
- Added `clip-path: inset(50%)`, `height: 0`, `overflow: hidden` to hidden state
- Made mouse bridge `::before` only render when actually hovered (`content: none` by default)
- Added `clip-path: none` and `height: auto` to hover state

**Note:** Also modified `mega-menu.css` but that file is NOT being loaded (old code). The active file is `nav-dropdown.css`.

### 2. DATABASE FIX PENDING
User needs to run WP-CLI search-replace for broken images:
```bash
wp search-replace 'contentcucumber.local' 'contentcucumber.com'
```
Dry run showed 1107 replacements needed. User has not run the actual replace yet.

### 3. AI READINESS WORKSHOP EMAIL
Wrote delivery email for AI-Ready Workshop slides to:
- Obsidian: `Presentations/AI-Ready Workshop - Delivery Email.md`

## CURRENT STATE
- **Files modified:** `nav-dropdown.css`, `mega-menu.css` (committed)
- **Tests run:** User confirmed menu fix works locally
- **Issues found:** None, fix verified

## TODO LIST STATE
- Completed: Mega menu fix (USER APPROVED: Yes, "ok that appears to have fixed the issue")
- In Progress: None
- Pending: Push CSS to Flywheel production, run database search-replace

## NEXT ACTIONS
1. **FIRST:** Push `nav-dropdown.css` changes to Flywheel production
2. **THEN:** Run `wp search-replace 'contentcucumber.local' 'contentcucumber.com'` (without --dry-run)
3. **VERIFY:** Check production site menu behavior and images

## CONTEXT NOTES
- Content Cucumber green: `#58c558`
- LocalWP site: `contentcucumber.local`
- Production: `contentcucumber.com`
- Theme: GeneratePress child theme (`cucumber-gp-child`)
- Hosting: Flywheel (has built-in redirect management in dashboard)
- The `mega-menu.css` file exists but is NOT enqueued in functions.php - all active styling is in `nav-dropdown.css`
