Deploy current project branch to production using tag-based deployment system

**Usage**: `/deploy-project [project-name]`

**Purpose**: Deploy specified project to production (project auto-detected from current directory if not specified)

**🗂️ DIRECTORY HANDLING:**
**CRITICAL**: This command works from any directory in the workspace. It will:
1. **Detect current location** and navigate to `[project]/` if needed (based on argument or auto-detection)
2. **Execute all operations** within the target project directory
3. **Return to original directory** when deployment is complete

**🚨 CRITICAL VERSION POLICY:**
🚫 **NEVER INCREMENT `/VERSION` FILE** during deployment - Version increments are separate from deployments
📖 **ALWAYS READ** existing version from `[project]/VERSION` file (e.g., "0.30.0")
🔄 **VERSION INCREMENTS** only happen during migrations or when user explicitly requests
💡 **USE DESCRIPTIVE TAGS** to identify deployments (e.g., app-v0.30.0-content-terms-fix)
⚠️  **DO NOT CREATE NEW VERSION NUMBERS** - Use the EXISTING version from VERSION file
❌ **WRONG**: backend-v0.31.0-fix (if VERSION file says 0.30.0)
✅ **RIGHT**: backend-v0.30.0-fix (matches VERSION file)

**Current Branch:** [Claude will auto-detect]
**Branch Type:** [feature/fix/hotfix/enhancement/etc.]
**Status:** Implementation complete, testing required

**Phase 0: Directory Setup & Validation**
0. **Navigate to [project] Directory:**
   - Store original working directory: `ORIGINAL_DIR=$(pwd)`
   - Check if currently in [project]: `basename $(pwd)`
   - If not in [project] directory:
     - Navigate: `cd [project]/` (from workspace root)
     - OR Navigate: `cd /path/to/workspace/[project]/` (absolute path fallback)
   - Verify location: `pwd` should end with `/[project]`
   - Verify VERSION file exists: `ls VERSION` (should show VERSION file)
   - Store current branch BEFORE any operations: `ORIGINAL_BRANCH=$(git branch --show-current)`

**🚨 CRITICAL: Pre-Deployment Git Status Check**
1. **Mandatory Git Status Validation:**
   - Check git status: `git status --porcelain`
   - **IF ANY UNCOMMITTED FILES FOUND:**
     ```
     ❌ DEPLOYMENT BLOCKED - UNCOMMITTED FILES DETECTED

     The following files have uncommitted changes:
     [list files from git status]

     🚨 CRITICAL: ALL files must be committed before deployment

     Actions required:
     1. Review changes: git diff
     2. Stage files: git add [files]
     3. Commit changes: git commit -m "[description]"
     4. Re-run deployment after committing

     DEPLOYMENT CANNOT PROCEED until all files are committed.
     ```
     **STOP DEPLOYMENT IMMEDIATELY**

   - **IF CLEAN:** Continue with deployment process

2. **Branch Sync Validation:**
   - Check if current branch is behind master: `git fetch origin master && git rev-list --count HEAD..origin/master`
   - **IF BEHIND MASTER:**
     ```
     ⚠️ BRANCH OUT OF SYNC - [X] commits behind master

     Current branch needs to be updated before deployment:
     1. Merge master: git merge origin/master
     2. Resolve any conflicts if they occur
     3. Push updated branch: git push origin [current-branch]
     4. Re-run deployment

     Would you like to auto-merge master now? (Y/N): _
     ```
     **If Y:** Auto-merge master, if N: **STOP DEPLOYMENT**

   - **IF UP TO DATE:** Continue with deployment

**Phase 1: Update Internal Documentation**
1. **Update Progress in todo/current/:** (now using relative paths)
   - Find the current task folder in `todo/current/` that matches current branch
   - Update progress documents to show "DEPLOYED - NEEDS PRODUCTION TESTING"
   - Add deployment timestamp and version tag
   - Note any edge cases or areas that need specific testing attention

2. **Update Technical Documentation:**
   - Update relevant files in `documentation/docs/technical/` for internal team reference
   - Document any technical changes, API updates, configuration changes
   - Add troubleshooting notes if applicable

**Phase 2: User Documentation Validation**
3. **Check User-Facing Changes:**
   ```
   📚 USER DOCUMENTATION VALIDATION
   ================================
   
   Checking if deployment includes user-facing changes that need documentation...
   
   🔍 SCANNING FOR USER-FACING CHANGES:
   
   📊 FRONTEND COMPONENT ANALYSIS:
   - Modified components in: frontend/src/components/ (relative path)
   - New user-facing features
   - Changed user workflows
   - Updated navigation items
   
   📋 USER DOCUMENTATION REQUIREMENTS:
   
   IF user-facing changes found:
   ⚠️ REMINDER: User documentation may need updates
   📝 Consider running: /update-user-documentation
   
   IF new components created:
   ⚠️ REMINDER: New features may need user guides
   📝 Consider running: /audit-user-documentation [component-name]
   
   IF navigation changes detected:
   ⚠️ REMINDER: Navigation documentation needs updates
   📝 Update: documentation/docs/user-guides/navigation.md (relative path)
   
   📋 VALIDATION QUESTIONS:
   Q1: Does this deployment change how users interact with the application?
   Q2: Are there new features users need to learn?
   Q3: Have existing user workflows changed?
   Q4: Do error messages or UI text need documentation updates?
   
   If YES to any: Consider documentation updates before deployment
   
   Continue with deployment? (Y/N/U=Update docs first): _
   ```

**Phase 3: Version & Changelog Update**
4. **Update Build Changelog:**
   - **Read current version from `VERSION` file** (relative path - e.g., "0.21.6")
   - **🚫 DO NOT INCREMENT VERSION** - Use existing version from file
   - Update `CHANGELOG.md` under current version (v[VERSION]) (relative path)
   - **🚨 CRITICAL:** Only increment `VERSION` file during migrations or when user explicitly requests
   - Determine change type from branch name and add to appropriate section:
     - **feature/** → Added section
     - **fix/** or **bugfix/** → Fixed section  
     - **enhancement/** → Changed section
     - **hotfix/** → Fixed section (urgent)
     - **Other** → Ask which section to use
   - Use format with descriptive tag:
     ```
     ## [VERSION] 
     ### [Date] - Tag: app-v[VERSION]-[feature-description]
     #### Added
     - [New features for users]
     #### Changed  
     - [Improvements to existing features]
     #### Fixed
     - [Bug fixes users will notice]
     #### Technical
     - [Internal improvements - brief]
     ```

**Phase 3: Code Commit & Deploy**
4. **Create Deployment Commit:**
   - Analyze current branch type and changes
   - Generate verbose commit message with:
     - Branch type and name
     - Files modified and why
     - Functionality added/fixed/changed
     - Version tag that will be used
     - "STATUS: Deployed - requires production testing"
   - Stage and commit all changes

5. **Merge to Master:**
   - Store current branch name for reference
   - `git checkout master`
   - `git pull origin master`
   - `git merge [detected-branch-name]`
   - `git push origin master`

6. **Smart Change Detection & Deploy to Production:**
   - **Read current version from `VERSION` file** (e.g., content is "0.26.4")
   - **🚫 CRITICAL: DO NOT MODIFY `VERSION` file** - Use existing version as-is

   **🔍 CHANGE DETECTION (NEW):**
   - **Check what changed:** `git diff --name-only HEAD~1..HEAD` (or since last deployment)
   - **Frontend only:** Changes only in `frontend/` directory (relative path)
     - Ask: "Only frontend changed. Deploy frontend-only? (Y/N/F=Full)"
     - If Y: Use `frontend-v[VERSION]-[description]` tag (~15 min deployment)
   - **Backend only:** Changes only in `backend/` directory (relative path)
     - Ask: "Only backend changed. Deploy backend-only? (Y/N/F=Full)"
     - If Y: Use `backend-v[VERSION]-[description]` tag (~20 min deployment)
   - **Both changed:** Deploy both (use existing patterns below)

   **🚀 DEPLOYMENT TAG OPTIONS (Choose Best For Situation):**
   
   **⚡ MATRIX DEPLOYMENT (Recommended - 50% Faster):**
   - **Pattern:** `matrix-v[VERSION]-[description]`
   - **Build Time:** ~25 minutes (parallel builds)
   - **Cache:** Docker layer caching enabled
   - **Use for:** Regular deployments, features, bug fixes
   - **Examples:**
     - `matrix-v0.26.4-global-terms`
     - `matrix-v0.26.4-content-fix`
     - `matrix-v0.26.4-ui-improvements`
   
   **⚡ MATRIX FRESH BUILD (When Cache Issues Suspected):**
   - **Pattern:** `matrix-v[VERSION]-fresh-[description]`
   - **Cache:** Cleared automatically via keyword detection
   - **Build Time:** ~35-40 minutes (no cache)
   - **Use for:** Infrastructure changes, dependency updates, cache issues
   - **Cache-clearing keywords:** `fresh`, `clear`, `nocache`
   - **Examples:**
     - `matrix-v0.26.4-fresh-node-upgrade`
     - `matrix-v0.26.4-clear-dependencies`
     - `matrix-v0.26.4-nocache-security-patch`
   
   **🚀 STANDARD DEPLOYMENT (Legacy - Slower):**
   - **Pattern:** `app-v[VERSION]-[description]`  
   - **Build Time:** ~50 minutes (sequential builds)
   - **Use for:** When matrix deployment needs testing
   - **Examples:**
     - `app-v0.26.4-critical-hotfix`
     - `app-v0.26.4-fallback-deploy`
   
   **🔴 HOTFIX DEPLOYMENT (Emergency Only):**
   - **Pattern:** `hotfix-v[VERSION]-[critical-fix]`
   - **Use for:** Critical security issues, production-down scenarios
   - **Examples:**
     - `hotfix-v0.26.4-security-patch`
     - `hotfix-v0.26.4-critical-auth-bug`
   
   **📋 TAG SELECTION LOGIC:**
   - **Frontend only** → `frontend-v[VERSION]-[description]` (⚡ ~15 min)
   - **Backend only** → `backend-v[VERSION]-[description]` (⚡ ~20 min)
   - **Normal deployment** → `matrix-v[VERSION]-[description]` (⚡ ~25 min)
   - **Dependency changes** → `matrix-v[VERSION]-fresh-[description]` (🔄 Cache cleared)
   - **Infrastructure changes** → `matrix-v[VERSION]-fresh-[description]` (🔄 Cache cleared)
   - **Emergency** → `hotfix-v[VERSION]-[description]` (🚨 Critical only)
   - **Testing matrix issues** → `app-v[VERSION]-[description]` (🐢 Fallback)
   - **Tag Description Guidelines:**
     - Keep it short but descriptive (2-4 words)
     - Use kebab-case (hyphens, not spaces)
     - Focus on the main feature/fix being deployed
     - Examples: `global-terms`, `content-fix`, `auth-improvement`
   - Check if tag already exists: `git tag | grep [descriptive-tag]`
   - If tag exists, append timestamp: `[descriptive-tag]-$(date +%H%M)`
   - `git tag [final-tag]`
   - `git push origin [final-tag]` (triggers production deployment)
   - Monitor GitHub Actions for deployment success

7. **Deploy Documentation (if docs changed):**
   - Check if `documentation` or `docs` folder has changes (relative paths)
   - If yes: `git tag docs-v[version]` and `git push origin docs-v[version]`

**📚 DEPLOYMENT REFERENCES:**
- 📖 **[Cache Invalidation Guide](../../../documentation/docs/technical/deployment/DOCKER-CACHE-INVALIDATION.md)** - When and how to clear Docker cache
- 📖 **[Deployment Tags Guide](../../../documentation/docs/technical/deployment/DEPLOYMENT-TAGS.md)** - Complete tag patterns and examples
- 🚀 **Matrix Deployment**: Parallel builds, Docker caching, 50% faster deployments
- 🔄 **Cache Management**: Automatic cache clearing via tag keywords (`fresh`, `clear`, `nocache`)

**🚨 CRITICAL CONTEXT LOSS WARNING:**
**CONVERSATION COMPACTION RISK DURING DEPLOYMENT**

When `/deploy-code` triggers conversation compaction due to context limits, detailed debugging context can be lost, potentially causing:
- Re-investigation of already-solved problems
- Loss of critical fix details and root cause analysis
- Confusion about actual completion status of work
- Unnecessary re-debugging of resolved issues

**Example from 2025-08-12 File Upload Fix:**
- **Before Compaction**: Full awareness that route path mismatch was identified and fixed (`/comment-upload/` → `/upload/comment/`)
- **After Compaction**: Lost detailed context, started re-debugging the same resolved issue
- **Result**: Successful deployment (fix was already applied) but caused unnecessary confusion

**MITIGATION STRATEGIES:**
1. **Document completion status clearly** in debug logs BEFORE running `/deploy-code`
2. **Update progress files** with "COMPLETED" status before deployment
3. **Create clear deployment readiness markers** in todo documentation
4. **Consider breaking complex debugging into smaller sessions** to avoid compaction during deployment

**Phase 4: Return & Summary**
8. **Return to Working Branch & Original Directory:**
   - **Return to original branch:** `git checkout $ORIGINAL_BRANCH`
   - Verify branch switch: `git branch --show-current`
   - **Return to original directory:** `cd $ORIGINAL_DIR`
   - Verify directory: `pwd` (should show original working directory)
   - If any step fails, warn user but show deployment summary anyway
   - Show deployment summary:
     - Original directory: $ORIGINAL_DIR
     - Current directory: [result of pwd]
     - Original branch: $ORIGINAL_BRANCH
     - Current branch: [result of git branch --show-current]
     - Branch deployed: master (always deployed from master)
     - Version tag: [actual-tag-used] (e.g., app-v0.20.5-universal-chat-interface)
     - GitHub Actions: [link to deployment]
     - Changes that need production testing
     - **VERSION file unchanged:** [VERSION] (🚫 NEVER increment during deployment)
     - Remind to run `/claude-complete` after testing

**Next Step:** Test in production, then run `/claude-complete` when confirmed working

**Key Changes from Old System:**
- ❌ No more `production` branch
- ✅ **Matrix deployment:** `matrix-v*` triggers fast parallel builds (⚡ Recommended)
- ✅ **Cache invalidation:** Keywords in tags automatically clear Docker cache
- ✅ **Legacy fallback:** `app-v*` triggers standard sequential builds
- ✅ **Documentation deployment:** `docs-v*` triggers docs
- ✅ **All deployments from `master` branch**
- ✅ **Version tags provide clear deployment history**

**🚀 DEPLOYMENT SPEED COMPARISON:**
- **Matrix (cached):** ~25 minutes ⚡
- **Matrix (fresh):** ~35-40 minutes 🔄  
- **Standard (app-v*):** ~50 minutes 🐢
- **Previous system:** ~50+ minutes 🐌

**🎯 RECOMMENDED WORKFLOW:**
1. **Regular deployments** → Use `matrix-v[VERSION]-[description]`
2. **Infrastructure changes** → Use `matrix-v[VERSION]-fresh-[description]` 
3. **Emergency fixes** → Use `hotfix-v[VERSION]-[description]`
4. **Matrix issues** → Fallback to `app-v[VERSION]-[description]`