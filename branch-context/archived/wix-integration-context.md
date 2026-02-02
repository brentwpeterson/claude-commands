# Resume Instructions for Claude - Wix Integration

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `git checkout feature/wix-integration`
3. **Verify:** `git branch --show-current` (should be: feature/wix-integration)

## SESSION METADATA
**Last Commit:** `e945e2c8` (Add author_name resolution to public posts API)
**Saved:** 2026-01-31 (Session 6)
**Project:** RequestDesk (rd)

## WHAT WAS ACCOMPLISHED

### Session 6 (this session)
- **Committed all Session 4 uncommitted changes** as `1c299a7e`
- **Synced VERSION file** from 0.44.2 to 0.45.2 (from API/migrations)
- **Deployed to production** as `matrix-v0.45.2-wix-integration` (merged to master, tag pushed)
- **Added author_name resolution** to public posts API (`e945e2c8`)
  - `resolve_author_names()` batch-resolves post_author -> display name
  - Looks up by ObjectId first, username fallback
  - Returns `first_name + last_name` or username
  - Both list and single post endpoints updated
  - NOT YET DEPLOYED - only on feature branch

### Session 4 (committed this session)
- Publishing pipeline working via curl: `curl -> RequestDesk API -> Wix Blog API -> Draft on PC Stretch`
- IST token support: connect-manual endpoint, site_id/member_id passthrough
- Migration v0_45_2: Wix app credentials on integration_types
- CLAUDE.md: Database write prohibition rules

## CRITICAL RULES LEARNED
- **NEVER write to the database. EVER.** Claude creates migration files (code). User runs them.
- **NEVER hardcode secrets** in migration files or any source code
- **Direct DB inserts don't reach production** - only migrations do
- **READ backend/app/migrations/README.md** before any migration work
- **IST tokens have 4 parts** when split by `.`: IST, header, payload, signature

## PRODUCTION STATUS
- **Deployed:** `matrix-v0.45.2-wix-integration` (Wix integration backend+frontend)
- **Migrations needed on production:** v0_45_0, v0_45_1, v0_45_2 (user needs to run these)
- **NOT deployed:** author_name resolution on public posts API (commit e945e2c8)

## PUBLIC POSTS AUTHOR_NAME STATUS
- Code is in place but could not be tested via public endpoint
- Zero posts currently meet all 3 conditions: publish status + publish_to_requestdesk_blog=True + agent requestdesk_blog_enabled=True
- Closest: "Generative Experience Optimization..." is published with blog flag, but its agent (Webscale Agent, 68c49483a809178df92c9c87) has requestdesk_blog_enabled=False
- To test: flip that agent's flag or publish a draft from a blog-enabled agent

## Wix Credentials (Test Site)
- **App ID:** b8e0f20d-ae86-40c6-9890-c39e98558254
- **App Secret:** 70e4e18f-5a81-4c91-9f26-b71d6336b79f (in migration v0_45_2)
- **Site ID:** cb7cdf52-da4e-4c9e-893b-d334adf22af2
- **Member ID:** cd43c435-541e-4440-a764-c13e114e957e
- **IST Token:** User has it (starts with IST.eyJraWQ...)
- **Connected user:** cucumber (user ID: 680001e183b4ee3baf84b146)

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/requestdesk-app/todo/current/feature/wix-integration/README.md

## NEXT ACTIONS (PRIORITY ORDER)
1. **Run production migrations** v0_45_0 through v0_45_2 (user action)
2. **Deploy author_name change** to production (merge + tag)
3. **Test `publish_immediately: true`** to verify live Wix publishing
4. **Clean up test drafts** from PC Stretch (2 test drafts)
5. **Frontend testing** - WixIntegrationPage.tsx in browser
6. **OAuth flow** - Publish app to Wix App Market or keep connect-manual
7. **Test author_name** - Need a published post with blog-enabled agent

## FILES MODIFIED THIS SESSION
- `backend/app/routers/public/posts.py` - author_name resolution (e945e2c8)
- `VERSION` - synced to 0.45.2 (7b8e19d1)

## BACKEND API ENDPOINT SUMMARY

### Public Posts (`/api/public-posts/...`)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `/public-posts/{company_id}` | List published posts (now includes author_name) |
| GET | `/public-posts/{company_id}/{post_slug}` | Single post detail (now includes author_name) |

### Wix OAuth (`/api/wix/...`)
| Method | Path | Purpose |
|--------|------|---------|
| GET | `/wix/auth-url?agent_id=X` | Get OAuth authorization URL |
| POST | `/wix/callback` | Complete OAuth flow |
| POST | `/wix/connect-manual` | Connect via IST token |
| GET | `/wix/status` | Get connection status |
| DELETE | `/wix/disconnect` | Disconnect Wix |
| POST | `/wix/refresh-token` | Refresh OAuth token |

### Wix Blog (`/api/wix-blog/...`)
| Method | Path | Purpose |
|--------|------|---------|
| POST | `/wix-blog/publish` | Publish/draft to Wix (TESTED - WORKING) |
| GET | `/wix-blog/products/{agent_id}` | Get products from RAG |
| POST | `/wix-blog/generate-topics` | Generate topic suggestions |
| POST | `/wix-blog/generate-topic-blog` | Generate blog post |
| POST | `/wix-blog/save-draft` | Save draft to RequestDesk |
