# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Picasso
**Status:** SAVED
**Last Saved:** 2026-03-06 05:28
**Last Started:** 2026-03-05 07:40

## IMMEDIATE SETUP
1. **Directory:** `/Users/brent/scripts/CB-Workspace/astro-sites/sites/amplify/commerceking-ai`
2. **Branch:** `master`
3. **Last Commit:** `e1a9a7b Add CommerceKing crown logo, favicon, and GTM tracking`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| workspace (root) | Session coordination, logo extraction |
| astro (commerceking-ai) | Countdown page updates, favicon, GTM |
| cc (.claude) | Updated run-local.md command |
| brent | Saved logos to Company Websites/CommerceKing/logos/ |

## WHAT YOU WERE WORKING ON
CommerceKing.ai brand setup: logo design iteration, site updates, analytics installation.

### Completed this session:
- Extracted crown/shield logo from Canva SVG (isolated 3 sub-paths from even-odd composite path)
- Created two clean SVG files: black on transparent, white on transparent
- Saved logos to `brent-workspace/ob-notes/.../Company Websites/CommerceKing/logos/`
- Updated countdown page: inline white logo SVG centered above text
- Changed "King" text color from dark blue (#1e40af) to gold (#f59e0b) for contrast
- Replaced default Astro favicon with crown/shield logo SVG
- Added Google Tag Manager (GTM-MBNF2J7G) head script + noscript body fallback
- Deployed to Amplify (build SUCCEED)
- Verified GTM code live on commerceking.ai via curl
- Walked through HubSpot tracking install (portal 39487190) via GTM Custom HTML tag
- Walked through GA4 setup via GTM and Google Search Console verification via GTM
- Updated /run-local command to support container/ vs amplify/ site types

### Canva design the user loves:
- Design ID: DAHDGmTCsi0 ("Dynamic Logo with Geometric Crown")
- Crown/shield geometric logo, white on dark background

## CURRENT STATE
- **Site live at:** commerceking.ai (Amplify, auto-deploys on push to master)
- **GTM installed:** GTM-MBNF2J7G (verified live)
- **HubSpot tracking:** Installed via GTM Custom HTML (portal 39487190)
- **GA4:** User walked through setup, needs to confirm Measurement ID if not done
- **Search Console:** User walked through GTM verification method
- **Local dev:** Was running on port 3011 (may need restart)

## TODO LIST STATE
- Completed: Logo extraction, favicon, countdown page logo, GTM install, HubSpot via GTM
- Pending from brand bible punch list:
  - Define brand colors (logo is white, "King" text is gold #f59e0b)
  - OG image for social sharing
  - LinkedIn company page
  - Replace template content on holding pages
  - Contact form / discovery call booking

## NEXT ACTIONS
1. **FIRST:** Confirm GA4 and Search Console are fully set up (ask user)
2. **THEN:** Define brand color palette based on the logo direction
3. **THEN:** Create OG image for commerceking.ai social sharing
4. **THEN:** Work on holding page content (services, ecosystem pages under _holding/)

## CONTEXT NOTES
- commerceking-ai is an Amplify site (not container), lives at `astro-sites/sites/amplify/commerceking-ai/`
- Its own git repo: `brentwpeterson/commerceking-ai` on GitHub
- Port 3011 assigned for local dev (added to /run-local)
- Logo SVG path data is large (3 sub-paths with complex curves). The original Canva export used even-odd fill rule with 5 sub-paths (2 outer rects + 3 logo shapes). We extracted sub-paths 2-4 as the isolated logo.
- Brand bible at: `brent-workspace/ob-notes/.../brands/commerceking.md`
