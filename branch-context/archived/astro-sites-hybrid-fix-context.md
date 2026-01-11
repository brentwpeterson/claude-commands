# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Branch:** `git checkout master`
3. **Verify containers:** `docker ps` (expect: backend, frontend, mailhog for cb-requestdesk)

## SESSION METADATA
**Last Commit:** `8688b12 Fix Dockerfile for hybrid Astro output`
**Deployment Tag:** `main-site-v1.11.2-hybrid-fix`
**Saved:** 2026-01-07

## WHAT WAS COMPLETED THIS SESSION

### 1. Fixed requestdesk.ai Nginx Error - DEPLOYED ✅
User reported nginx error on requestdesk.ai. Root cause identified and fixed:

**Problem:**
- Astro config has `output: 'hybrid'` with Node.js adapter
- Hybrid mode puts static files in `dist/client/` NOT `dist/`
- Dockerfile was copying `dist/` which was empty for hybrid output
- Nginx couldn't find index.html, returned 403/500 errors

**Fix:**
- Updated `deployment/Dockerfile` line 35:
  - FROM: `COPY --from=builder /app/requestdesk-ai/dist /usr/share/nginx/html/requestdesk-ai`
  - TO: `COPY --from=builder /app/requestdesk-ai/dist/client /usr/share/nginx/html/requestdesk-ai`

**Deployed:** `main-site-v1.11.2-hybrid-fix` - Site fully restored

### 2. Previous Session: System Prompt Templates - DEPLOYED ✅
From earlier in day (cb-requestdesk):
- Added system prompt templates feature
- Migration v0.36.3 adds is_system_template field
- Deployed: `matrix-v0.35.0-requestdesk-blog-system-prompts`

## CURRENT STATUS
- **requestdesk.ai:** ✅ Working (200 on homepage, blog index, blog posts)
- **Blog pages:** Working via nginx SPA fallback + client-side JS loading
- **cb-requestdesk:** On branch `feature/github-webhook-integration`, 13 commits ahead

## TODO LIST STATE
- ✅ COMPLETED: Fix requestdesk.ai nginx error (USER TESTED - site works)
- ✅ COMPLETED: System prompt templates feature (deployed earlier)
- ✅ COMPLETED: RequestDesk Blog integration (deployed earlier)

## NEXT ACTIONS (if continuing)
1. **Verify production:** Check https://requestdesk.ai/blog loads posts correctly
2. **Consider:** Run `/claude-complete` on github-webhook-integration branch to archive
3. **Or:** Start new feature work

## CONTEXT NOTES
- astro-sites uses hybrid Astro mode for requestdesk-ai (static + SSR)
- Blog post pages use `export const prerender = false` but work via nginx fallback
- All content loaded client-side via JavaScript, so SSR not strictly needed
- Other sites (contentbasis-io, contentbasis-ai, magento-masters-com) are pure static

## VERIFICATION COMMANDS
```bash
curl -s -o /dev/null -w "%{http_code}" https://requestdesk.ai/
curl -s -o /dev/null -w "%{http_code}" https://requestdesk.ai/blog
```
