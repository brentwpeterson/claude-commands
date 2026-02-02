# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app-testing`
2. **Verify branch:** `git branch --show-current` (should be: feature/backlog-table-enhancements)
3. **Last commit:** `6b08b71d Add backlog type hierarchy: type, acceptance_criteria, child_ids, position, depth`

## SESSION METADATA
**Last Commit:** `6b08b71d Add backlog type hierarchy`
**Saved:** 2026-01-16
**Migration Version:** 0.39.3

## WORKSPACES TOUCHED THIS SESSION
**Started in:** brent (brent-workspace)
**Current workspace:** rd-test (requestdesk-app-testing)
**All workspaces:** brent, rd-test

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `brent` | brent-workspace | S2 sprint planning started, reviewed backlog |
| `rd-test` | requestdesk-app-testing | Added backlog type hierarchy feature |

## 🚨 CRITICAL: CODE CONFLICT TO RESOLVE
User mentioned there's a code conflict that needs to be resolved immediately on next session.

**First Action:** Run `git status` to check for conflict markers or merge issues.

## WHAT WAS COMPLETED THIS SESSION

### Backlog Table Enhancements (TESTED & WORKING)
Added new fields to backlog_items for story/task hierarchy:

**New Fields:**
| Field | Type | Description |
|-------|------|-------------|
| `type` | enum | epic, story, task, bug |
| `acceptance_criteria` | list[str] | Checklist of done conditions |
| `child_ids` | list[str] | IDs of child items |
| `position` | int | Order within parent |
| `depth` | int | Nesting level (0=epic, 1=story, 2=task) |

**New API Filters:**
- `?type=story` - Filter by item type
- `?parent_id=abc123` - Get children of a parent

**Files Changed:**
1. `backend/app/migrations/versions/v0_39_3_add_backlog_type_hierarchy.py` - New migration
2. `backend/app/models/backlog_item.py` - Added BacklogItemType enum and new fields
3. `backend/app/routers/public/backlog.py` - Updated serializer, create, update, list endpoints

**Testing Completed:**
- ✅ Docker build passes
- ✅ Migration runs successfully (0.39.2 → 0.39.3)
- ✅ New fields exist in documents (type, acceptance_criteria, child_ids, position, depth)
- ✅ New indexes created (idx_type, idx_depth, idx_parent_position)
- ✅ Version tracked in migrations collection

## TODO LIST STATE
- ⏳ PENDING: Review S1 retrospective with user
- ⏳ PENDING: Plan S2 Sprint (Jan 19-30) - need to estimate backlog items
- ✅ COMPLETED: Create migration v0_39_3 for type/hierarchy fields
- ✅ COMPLETED: Update backlog_item.py models
- ✅ COMPLETED: Update backlog.py router
- ✅ COMPLETED: Test backlog enhancements locally

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Code conflict:** "What is the code conflict that needs to be resolved?"
2. **S2 Planning:** "Ready to continue S2 sprint planning with 40 pts available?"
3. **Deploy question:** "Push feature/backlog-table-enhancements to remote for review?"

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Identify and resolve code conflict
2. **THEN:** Continue S2 planning OR deploy backlog feature
3. **VERIFY:** Run git status to see current state

## S2 PLANNING CONTEXT (From Earlier)
| Metric | Value |
|--------|-------|
| Committable capacity | 51 pts |
| Morning routine (1 pt × 8 days) | -8 pts |
| Carried from S1 | -3 pts |
| **Available for new items** | 40 pts |

## VERIFICATION COMMANDS
- Check migration ran: `docker exec [container] python -c "from motor... db.migrations.find_one({'version': '0.39.3'})"`
- Check fields exist: Query backlog_items for type, acceptance_criteria, etc.
- Check indexes: `db.backlog_items.index_information()`

## CONTEXT NOTES
- User noted item #1 (MM26FL Workshop) is "a story not a task" - triggered this feature
- Sprint planning paused to add story/task hierarchy to backlog
- brent-workspace still has uncommitted changes (workspace.json, twc draft)
- Auto-compact happened during previous save attempt - context was partially lost
