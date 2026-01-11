# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git checkout feature/github-webhook-integration`
3. **Check Docker:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)

## SESSION METADATA
**Last Commit:** `8c416390 Add public posts API for headless CMS content delivery`
**Project:** cb-requestdesk
**Saved:** 2026-01-05

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/github-webhook-integration/README.md
**Status:** Phase 0 (Content API) COMPLETE, Phase 1-6 pending
**Directory Structure:** ✅ Complete (7/7 files)

## WHAT WE COMPLETED THIS SESSION

### Phase 0: Public Content API ✅
Created public posts API for headless CMS content delivery:

**Endpoints created:**
- `GET /api/posts/{company_id}` - List published posts (paginated)
- `GET /api/posts/{company_id}/{post_slug}` - Get single post with full content

**Files created:**
- `backend/app/routers/public/posts.py` - New public posts router
- `backend/app/routers/public/__init__.py` - Updated to include posts router

**Tested and working:**
```bash
# List posts
curl "http://localhost:3000/api/posts/685b364ec902ddb30cc9a105?per_page=3"

# Get single post
curl "http://localhost:3000/api/posts/685b364ec902ddb30cc9a105/seo-is-dead-5"
```

## FEATURE OVERVIEW: GitHub Webhook Integration

Three-phase integration for automatic blog deployment:

| Phase | Component | Status | Description |
|-------|-----------|--------|-------------|
| 0 | Content API | ✅ DONE | Public endpoints for Astro to fetch posts |
| 1 | GitHub Webhook | ⏳ PENDING | Trigger rebuilds on publish |
| 2 | Git Content Push | ⏳ PENDING | Commit markdown to repos |

## PENDING DECISION: API Authentication

**Current state:** API is completely public (no auth required)

**Options discussed with user:**
1. **No auth** - Keep public (current)
2. **API Key per company** - Simple, recommended
3. **Bearer token** - More complex

**User question at session end:** "are we going to use the API key to connect?"

**Recommendation:** Implement company API key auth:
```bash
curl -H "X-API-Key: company_abc123xyz" \
  "https://api.requestdesk.ai/api/posts/{company_id}"
```

## TODO LIST STATE
- ✅ COMPLETED: Phase 0 - Public Content API (tested, working)
- ⏳ PENDING: API key authentication decision
- ⏳ PENDING: Phase 1 - GitHub webhook trigger
- ⏳ PENDING: Phase 2 - Git content push (optional)

## NEXT ACTIONS (PRIORITY ORDER)
1. **DECIDE:** API auth approach (public vs API key)
2. **IF API KEY:** Implement company API key generation and validation
3. **THEN:** Start Phase 1 - GitHub webhook database schema and service

## VERIFICATION COMMANDS
```bash
# Test list posts
curl -s "http://localhost:3000/api/posts/685b364ec902ddb30cc9a105?per_page=3" | python3 -m json.tool | head -30

# Test single post
curl -s "http://localhost:3000/api/posts/685b364ec902ddb30cc9a105/seo-is-dead-5" | python3 -m json.tool | head -30
```

## CONTEXT NOTES
- Company ID used for testing: `685b364ec902ddb30cc9a105`
- company_id stored as STRING in users collection (not ObjectId)
- 50 published posts available for testing
- Docker containers hot-reload on code changes
