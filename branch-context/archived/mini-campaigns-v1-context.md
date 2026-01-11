# Resume Instructions for Claude - Mini Campaigns V1

## IMMEDIATE SETUP

1. **Change directory:**
   ```bash
   cd /Users/brent/scripts/CB-Workspace/requestdesk-app-testing
   ```

2. **Verify branch:**
   ```bash
   git checkout feature/mini-campaigns-v1
   git branch --show-current
   ```

3. **Read full todo context:**
   ```bash
   cat todo/current/feature/mini-campaigns-v1/README.md
   ```

## SESSION METADATA

- **Last Commit:** `46ea977a Add mini-campaigns v1 todo documentation`
- **MCP Entity:** `mini-campaigns-v1`
- **Saved:** 2025-12-31
- **Workspace:** requestdesk-app-testing (testing worktree)
- **Ports:** 3100 (backend) / 3101 (frontend)

## CURRENT TODO FILE

**Path:** `file:/Users/brent/scripts/CB-Workspace/requestdesk-app-testing/todo/current/feature/mini-campaigns-v1/README.md`
**Status:** Architecture planned, ready to start migration
**Directory Structure:** ✅ Has README.md and RESUME-INSTRUCTIONS.md

## WHAT YOU WERE WORKING ON

Building a **personal CLI tool** for Brent to interactively create and publish social content via Vista Social integration.

**Key Architecture (APPROVED BY USER):**
```
CAMPAIGN → AGENT → VISTA SOCIAL PROFILES
    │
    └──→ POSTS (with post_type: "social")
```

**Key Decisions:**
1. NO new collection - reuse existing `posts` collection
2. Add `post_type: "social"` to distinguish social posts
3. Campaign links to Agent - Agent already has Vista Social profiles
4. Follow WordPress/Shopify sync pattern for Vista Social fields

## CURRENT STATE

- **Last action:** Committed todo documentation, pushed branch
- **Files created:** `todo/current/feature/mini-campaigns-v1/README.md`
- **No code changes yet** - stopped before writing migration

## TODO LIST STATE

- ⏳ PENDING: Create migration v0.35.1
- ⏳ PENDING: Update PostType enum in post.py
- ⏳ PENDING: Add campaign-to-agent linking
- ⏳ PENDING: Create CLI skeleton
- ⏳ PENDING: Test workflow

## NEXT ACTIONS (PRIORITY ORDER)

1. **FIRST:** Create migration file:
   ```bash
   # Check latest migration version
   ls backend/app/migrations/versions/ | tail -3
   # Create v0_35_1_add_campaign_social_posts.py
   ```

2. **Migration should add:**
   - `SOCIAL` to PostType enum
   - `campaign_id` field to posts collection
   - `vista_social_post_id` field
   - `vista_social_sync_status` field
   - `vista_social_last_sync` field
   - Index on `campaign_id`

3. **THEN:** Update `backend/app/models/post.py`

4. **NEXT:** Create CLI at `scripts/cli/campaign.py`

## KEY FILES TO REFERENCE

| File | Purpose |
|------|---------|
| `backend/app/models/post.py` | Has PostType enum - add SOCIAL |
| `backend/app/routers/campaigns.py` | Existing campaigns (already comprehensive) |
| `backend/app/services/vista_social_service.py` | Vista Social API |
| `backend/app/migrations/versions/v0_35_0_*.py` | Latest migration pattern |

## CONTEXT NOTES

- **Testing worktree** - separate from main cb-requestdesk
- Ports 3100/3101 (not 3000/3001)
- Goal: Personal tool → later add to RequestDesk
- Vista profiles come through Agent (no need on Campaign)
