# Resume Instructions for Claude - Vista Social Integration

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git checkout feature/vista-social-integration`
3. **Check Docker:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)
4. **Verify services:** `curl -s http://localhost:3000/api/health`

## SESSION METADATA
**Last Commit:** `70389334` - Implement Vista Social user-level access control (Phase 1)
**Saved:** 2025-12-20 20:30
**Branch:** feature/vista-social-integration

## WHAT WAS COMPLETED ✅

### Vista Social User-Level Access Control (Phase 1) - WORKING
The critical multi-tenancy security issue has been FIXED and TESTED:

1. **Problem Solved:** Isaac-Cucumber could previously see Brent's LinkedIn profile - FIXED
2. **Solution:** User-level assignments via existing relationships system (RESOURCE_SHARING)
3. **Testing Confirmed:**
   - Isaac sees ZERO profiles (proper isolation) ✅
   - Cucumber sees only assigned profiles ✅
   - Profile assignment via superadmin works ✅

### Files Modified:
- `backend/app/routers/vista_social.py` - Uses `current_user.get("id")` for relationship query
- `backend/app/routers/vista_social_admin.py` - User assignment endpoints added
- `backend/app/services/vista_social_service.py` - User-level service methods added
- `backend/app/migrations/versions/v0_34_0_add_vista_social_cache_collections.py` - Created
- `backend/app/migrations/versions/v0_34_1_fix_vista_social_assignment_company_ids.py` - Created

### Test Scripts Created:
- `/backend/tests/curl_scripts/vista_social/test-user-profiles.sh` - Shows profiles per user
- `/backend/tests/curl_scripts/vista_social/test-assign-profile.sh` - Tests assignment flow
- `/backend/tests/curl_scripts/vista_social/show-all-assignments.sh` - Lists all assignments

## CURRENT STATE

### Migrations Status:
- v0.34.0 - Vista Social cache collections (APPLIED)
- v0.34.1 - Fix company_ids in assignments (APPLIED)

### Current Assignments in Database:
```
cucumber → Profile 22469 (Brent W Peterson LinkedIn)
Isaac-Cucumber → NONE (proper isolation)
```

### API Endpoints Working:
- `GET /api/vista-social/profiles` - Returns only user's assigned profiles
- `GET /api/admin/vista-social/user-assignments` - List all assignments (superadmin)
- `POST /api/admin/vista-social/user-assignments` - Assign profile to user (superadmin)
- `DELETE /api/admin/vista-social/user-assignments/{user_id}/{profile_id}` - Remove (superadmin)
- `GET /api/admin/vista-social/users` - List users for dropdown (superadmin)

## PHASE 2 TODO (Future - Company-Level)
The `agent_vista_social_profiles` collection is kept in place for future company-level assignments.
Current implementation is user-level only (Phase 1).

## TEST CREDENTIALS
- **Admin (superadmin):** `admin / Test1234!`
- **Cucumber:** `cucumber / test1234`
- **Isaac-Cucumber:** `Isaac-Cucumber / test1234`

## VERIFICATION COMMANDS
```bash
# Run user profile test
bash /Users/brent/scripts/CB-Workspace/cb-requestdesk/backend/tests/curl_scripts/vista_social/test-user-profiles.sh

# Show all assignments
bash /Users/brent/scripts/CB-Workspace/cb-requestdesk/backend/tests/curl_scripts/vista_social/show-all-assignments.sh

# Run full assignment test
bash /Users/brent/scripts/CB-Workspace/cb-requestdesk/backend/tests/curl_scripts/vista_social/test-assign-profile.sh
```

## NEXT STEPS
1. **User should test in browser** - Login as Isaac, verify no profiles visible
2. **User should test as cucumber** - Verify assigned profile is visible
3. **Consider frontend UI** - Admin panel for user-profile assignments
4. **Phase 2 planning** - Company-level access control when ready

## CRITICAL NOTES
- **JWT `sub` contains username**, not user_id - we use `current_user.get("id")` instead
- **Relationships system used** - resource_type="vista_social_profile"
- **agent_vista_social_profiles kept** for future Phase 2 company-level
- **Admin password was reset** to `Test1234!` during testing
