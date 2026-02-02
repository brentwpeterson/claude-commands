# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `master`
3. **Last Commit:** `453f425c Sync VERSION file to 0.39.2 (from API/migrations)`

## WORKSPACES TOUCHED THIS SESSION
**Started in:** rd (requestdesk-app)
**All workspaces:** rd, cc

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `rd` | requestdesk-app | VERSION file sync, PostsEdit/PostsShow UI deployment |
| `cc` | claude-commands | Added version sync step to deploy-project.md and claude-complete.md |

⚠️ **Multiple workspaces modified** - cc changes already committed and pushed.

## SESSION SUMMARY

### What Was Accomplished
1. **Deployed to production:** `matrix-v0.35.0-posts-ui-integrations` (tag name has wrong version)
   - PostsEdit.tsx 2-column Tailwind layout with SEO sidebar
   - PostsShow.tsx full SEO/Social metadata display
   - Integrations system (integration_types + agent_integrations collections)

2. **Fixed VERSION file drift issue:**
   - VERSION file was 0.35.0, but API/migrations showed 0.39.2
   - Updated VERSION file to 0.39.2
   - Committed and pushed

3. **Added version sync to commands:**
   - `/deploy-project` now has Phase 0.25: Version Sync (MANDATORY)
   - `/claude-complete` now has Step 13.5: Version Sync
   - Both query `/api/current_version` and sync VERSION file before deployment

## VERSION SYNC PROCESS (NEW)
The commands now do this before deployment:
```bash
ACTUAL_VERSION=$(curl -s http://localhost:3000/api/current_version | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
FILE_VERSION=$(cat VERSION)
# If different, update VERSION and commit
```

## CURRENT STATE
- **VERSION file:** 0.39.2 (now correct)
- **Latest migration:** v0_39_2_migrate_agent_integrations.py
- **Deployment in progress:** matrix-v0.35.0-posts-ui-integrations (~25 min build)
- **Git status:** Clean (all changes committed and pushed)

## TODO LIST STATE
- ✅ COMPLETED: Fix VERSION file to match actual version (0.39.2)
- ✅ COMPLETED: Update deploy-project.md with version sync step
- ✅ COMPLETED: Update claude-complete.md with version sync step
- ✅ COMPLETED: Commit all changes

## NEXT ACTIONS
1. **Monitor deployment:** Check GitHub Actions for matrix-v0.35.0-posts-ui-integrations completion
2. **Test in production:** Verify PostsEdit/PostsShow UI works after deployment
3. **Future deployments:** Will now use correct version (0.39.2+) due to version sync

## NOTES
- The deployment tag `matrix-v0.35.0-posts-ui-integrations` has misleading version number
- The code deployed is correct, only the tag name is wrong
- Future deployments will have correct version numbers

## DOCKER STATUS
- cbtextapp-frontend-1: Up (port 3001)
- cbtextapp-backend-1: Up (port 3000)
- cbtextapp-mailhog-1: Up (ports 1025, 8025)
