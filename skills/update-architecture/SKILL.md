Update Architecture Map - Real-time CB Flow Documentation

**USAGE:** `/update-architecture [todo-path]` - Analyze current git changes and update architecture-map.md with actual file modifications

**Arguments:**
- `[todo-path]` (optional): Path to todo directory (auto-detects if not provided)

**🎯 PURPOSE:**
Automatically update architecture-map.md with REAL file modifications from current git changes, mapping each file to CB technical flow layers

**🏗️ CB LAYER MAPPING:**

**Phase 1: Analyze Current Changes**
1. **Get Modified Files:**
   - Run `git status --porcelain` to get changed files
   - Run `git diff --name-only HEAD` to get committed changes
   - Combine staged + unstaged + committed changes for complete picture

2. **Map Files to CB Layers:**
   ```bash
   # CB Technical Flow Mapping:
   Frontend Layer:     *.tsx, *.ts (in frontend/src/), *.jsx, *.js (React components)
   DataLayer:          *dataProvider*.ts, *Api.ts, *api*.ts (API integration files)
   Router Layer:       *router*.py, *routers/*.py (FastAPI endpoints)
   Service Layer:      *service*.py, *services/*.py (business logic)
   Model Layer:        *model*.py, *models/*.py, *schema*.py (data models)
   Collection Layer:   *migration*.py, database changes, collection operations
   ```

3. **Trace CB Flow Path:**
   - Identify the complete modification path through CB architecture
   - Example: `UserList.tsx → userDataProvider.ts → users_router.py → user_service.py → user_model.py → users_collection`

**Phase 2: Update Architecture Map**
4. **Read Current architecture-map.md:**
   - Find architecture-map.md in todo directory
   - If missing, copy from `/todo/architecture-map-template.md`
   - Parse existing content to preserve manual entries

5. **Update "Files Modified/Created" Section:**
   - Replace template text with actual file paths
   - Organize by CB layer:
   ```markdown
   ### Files Modified/Created
   - **Frontend**:
     - `frontend/src/components/UserList.tsx` - Added user filtering functionality
     - `frontend/src/dataProviders/userApi.ts` - New getUsersByRole endpoint
   - **Backend**:
     - `backend/app/routers/users.py` - Added GET /users/by-role endpoint (lines 45-67)
     - `backend/app/services/user_service.py` - Implemented role-based filtering (lines 123-145)
     - `backend/app/models/user.py` - Added role validation (lines 34-42)
   ```

6. **Update Data Flow Section:**
   - Document complete request flow with actual file paths
   - Example:
   ```markdown
   ### Request Processing Flow
   1. **User Action**: Click "Filter by Role" in UserList.tsx (line 78)
   2. **Frontend**: UserList.tsx calls userApi.getUsersByRole() (line 45)
   3. **DataLayer**: userApi.ts sends GET /api/users/by-role?role=writer (line 23)
   4. **Router**: users_router.py handles GET /users/by-role (line 56)
   5. **Service**: user_service.py.get_users_by_role() filters users (line 134)
   6. **Model**: user_model.py validates role parameter (line 38)
   7. **Collection**: MongoDB users collection query {role: "writer"}
   8. **Response**: Filtered user list flows back through all layers
   ```

**Phase 3: CB Flow Analysis**
7. **Component Integration Analysis:**
   - Document how changes integrate with existing CB systems
   - Identify dependencies and integration points
   - Note authentication, permissions, validation touchpoints

8. **Update Progress Indicators:**
   - Check off completed items in completion checklist
   - Update status indicators based on actual progress
   - Mark which CB layers have been implemented vs pending

**Phase 4: Validation and Summary**
9. **Validate Completeness:**
   - Ensure all modified files are documented
   - Verify CB flow path is complete and accurate
   - Check that integration points are documented

10. **Display Summary:**
    ```
    ✅ Architecture Map Updated: [todo-path]/architecture-map.md

    📊 CB Flow Impact:
    Frontend Layer:    2 files modified
    DataLayer:         1 file modified
    Router Layer:      1 file modified
    Service Layer:     1 file modified
    Model Layer:       1 file modified
    Collection:        0 files modified

    🔄 Complete Flow Path:
    UserList.tsx → userApi.ts → users_router.py → user_service.py → user_model.py → users_collection

    📋 Completion Status: 5/6 layers implemented (83% complete)
    ⏳ Next: Implement database migration for new user role index
    ```

**🎯 INTELLIGENT FILE MAPPING:**

**Frontend Detection:**
- `frontend/src/**/*.tsx` - React components
- `frontend/src/**/*.ts` - TypeScript utilities
- `**/dataProvider*.ts` - API integration layer
- `**/*Api.ts` - API client files

**Backend Detection:**
- `backend/app/routers/**/*.py` - API endpoints
- `backend/app/services/**/*.py` - Business logic
- `backend/app/models/**/*.py` - Data models
- `backend/app/migrations/**/*.py` - Database changes

**🔍 SMART ANALYSIS FEATURES:**

**Flow Path Detection:**
- Automatically identifies related files across layers
- Detects common patterns (UserList → userApi → users_router → user_service)
- Shows incomplete flow paths (missing service layer, etc.)

**Integration Point Analysis:**
- Identifies authentication touchpoints
- Detects permission system integration
- Notes validation layer interactions

**Progress Tracking:**
- Counts implementation across CB layers
- Identifies bottlenecks and incomplete flows
- Suggests next implementation steps

**📋 USAGE WORKFLOW:**

**During Development:**
1. Make code changes across CB layers
2. Run `/update-architecture` to document changes
3. Continue development with updated architecture map
4. Run `/update-architecture` again after more changes
5. Architecture map stays current throughout development

**Before Save/Handoff:**
1. Run `/update-architecture` one final time
2. Review and customize any auto-generated content
3. Use `/claude-save` - architecture validation will pass
4. Next session has complete modification trail

**✅ SUCCESS CRITERIA:**
- All modified files mapped to correct CB layers
- Complete flow path documented with actual file paths
- Integration points identified and documented
- Architecture map shows real work done, not template text
- Ready for seamless session handoff

**🚨 CRITICAL BENEFITS:**
- **Real-time documentation** - Keep architecture current during development
- **No session continuity loss** - Always know exactly what was modified
- **Efficient debugging** - Clear trail through CB technical stack
- **Team collaboration** - Others can understand changes immediately
- **Professional handoffs** - Complete technical context for next developer

**🔧 AUTO-DETECTION INTELLIGENCE:**
- Recognizes CB file patterns automatically
- Maps files to appropriate layers without manual classification
- Identifies common CB development flows
- Suggests missing implementation steps
- Validates flow completeness