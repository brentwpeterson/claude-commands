Deploy current project branch to production using tag-based deployment system with iteration support

**Usage**:
- `/deploy-project [project-name]` - Deploy iteration (auto-increments iter-1, iter-2, etc.)
- `/deploy-project --mark-tested [iter-N]` - Mark iteration as production tested
- `/deploy-project --final` - Final deployment (requires all iterations tested)

**Purpose**: Deploy specified project to production with phased iteration tracking (project auto-detected from current directory if not specified)

**🔄 ITERATION DEPLOYMENT SYSTEM:**
Supports phased deployments where features are released incrementally and tested before final release.

| Flag | Purpose | Example |
|------|---------|---------|
| (none) | Deploy next iteration | `matrix-v0.32.0-shopify-rag-iter-1` |
| `--mark-tested iter-1` | Mark iteration as production tested | Updates tracking file |
| `--final` | Complete deployment after all tested | `matrix-v0.32.0-shopify-rag-complete` |

**🗂️ DIRECTORY HANDLING:**
**CRITICAL**: This command works from any directory in the workspace. It will:
1. **Detect current location** and navigate to `[project]/` if needed (based on argument or auto-detection)
2. **Execute all operations** within the target project directory
3. **Return to original directory** when deployment is complete

**🚨 CRITICAL VERSION POLICY:**
🔄 **SYNC VERSION FILE** with API before deployment - Run Phase 0.25 to ensure VERSION matches `/api/current_version`
📖 **SOURCE OF TRUTH** is the API endpoint (reflects migration versions), NOT the VERSION file
🔢 **VERSION FILE** must be synced and committed before creating deployment tags
💡 **USE DESCRIPTIVE TAGS** with synced version (e.g., matrix-v0.39.2-content-terms-fix)
⚠️  **ALWAYS RUN VERSION SYNC** - VERSION file can drift behind migrations
❌ **WRONG**: Using VERSION file value without checking API (may be outdated)
✅ **RIGHT**: Query API, sync VERSION file, then create tag with correct version

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

**🔢 Phase 0.25: Version Sync (MANDATORY)**

**🚨 CRITICAL: Sync VERSION file with actual database version BEFORE deployment**

The VERSION file can become outdated. The source of truth is the API endpoint which reflects migration versions.

1. **Query Actual Version from API:**
   ```bash
   ACTUAL_VERSION=$(curl -s http://localhost:3000/api/current_version | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
   echo "API Version: $ACTUAL_VERSION"
   ```

2. **Read VERSION File:**
   ```bash
   FILE_VERSION=$(cat VERSION)
   echo "FILE Version: $FILE_VERSION"
   ```

3. **Compare and Sync:**
   ```bash
   if [ "$ACTUAL_VERSION" != "$FILE_VERSION" ]; then
     echo "⚠️ VERSION MISMATCH DETECTED!"
     echo "   API reports: $ACTUAL_VERSION"
     echo "   FILE shows:  $FILE_VERSION"
     echo ""
     echo "🔄 Updating VERSION file to $ACTUAL_VERSION..."
     echo "$ACTUAL_VERSION" > VERSION
     git add VERSION
     git commit -m "Sync VERSION file to $ACTUAL_VERSION (from API/migrations)"
     echo "✅ VERSION file updated and committed"
   else
     echo "✅ VERSION file is in sync: $ACTUAL_VERSION"
   fi
   ```

4. **Use Synced Version for Deployment Tags:**
   - All deployment tags MUST use the synced version: `matrix-v$ACTUAL_VERSION-[description]`
   - **NEVER use the old FILE_VERSION if they differed**

**WHY THIS STEP EXISTS:**
- VERSION file was 4 versions behind (0.35.0 vs 0.39.2) causing misleading deployment tags
- Migrations increment version but VERSION file wasn't being updated
- API endpoint `/api/current_version` reflects actual migration state

**🔄 Phase 0.5: Iteration Mode Detection**

**ITERATION TRACKING FILE:** `todo/current/[category]/[task]/deployment-iterations.md`

1. **Detect Command Mode:**
   - **`--mark-tested [iter-N]`** → Jump to MARK TESTED MODE (below)
   - **`--final`** → Jump to FINAL DEPLOYMENT MODE (below)
   - **No flags** → Continue with ITERATION DEPLOYMENT MODE

2. **Find/Create Iteration Tracking File:**
   - Locate todo folder matching current branch in `todo/current/`
   - Check for existing `deployment-iterations.md`
   - **If exists:** Read current iteration state
   - **If not exists:** Create with template (see below)

3. **Determine Next Iteration Number:**
   - Parse `deployment-iterations.md` for existing iterations
   - Find highest iteration number
   - Next iteration = highest + 1 (or 1 if none exist)

---

**📋 MARK TESTED MODE** (`--mark-tested [iter-N]`)

When invoked with `--mark-tested iter-1` (or any iteration):

1. **Locate iteration tracking file** in todo folder
2. **Find the specified iteration row** in the table
3. **Update the "Prod Tested" column:**
   - Change from `⏳ pending` to `✅ [TODAY'S DATE]`
4. **Show confirmation:**
   ```
   ✅ Marked iter-1 as production tested

   Current Iteration Status:
   | Iteration | Deployed | Prod Tested |
   |-----------|----------|-------------|
   | iter-1    | 2025-12-18 | ✅ 2025-12-19 |
   | iter-2    | 2025-12-19 | ⏳ pending |

   Next: Deploy more iterations or run --final when all tested
   ```
5. **EXIT** - Do not proceed with deployment

---

**🏁 FINAL DEPLOYMENT MODE** (`--final`)

When invoked with `--final`:

1. **Locate iteration tracking file** in todo folder
2. **Safety Check - ALL iterations must be tested:**
   ```
   🔍 Checking iteration status...

   | Iteration | Deployed | Prod Tested |
   |-----------|----------|-------------|
   | iter-1    | 2025-12-18 | ✅ 2025-12-18 |
   | iter-2    | 2025-12-19 | ⏳ pending    | ← BLOCKS FINAL
   ```

   **If ANY iteration has `⏳ pending` in Prod Tested:**
   ```
   🚫 FINAL DEPLOYMENT BLOCKED

   The following iterations have not been production tested:
   - iter-2 (deployed 2025-12-19)

   To proceed:
   1. Test iter-2 in production
   2. Run: /deploy-project --mark-tested iter-2
   3. Then run: /deploy-project --final
   ```
   **EXIT** - Do not proceed

3. **If ALL iterations tested:**
   - Create clean final tag: `matrix-v[VERSION]-[task-name]-complete`
   - Generate changelog entry summarizing ALL iterations
   - Update iteration tracking file with "FINAL DEPLOYMENT" entry
   - Continue with standard deployment process (merge to master, push tag)

4. **After successful final deployment:**
   - Show summary of all iterations included
   - Remind user to run `/claude-complete` to archive todo

---

**📄 ITERATION TRACKING FILE TEMPLATE:**

When creating new `deployment-iterations.md`:
```markdown
# Deployment Iterations

## Feature: [task-name from folder]
## Branch: [current branch name]
## Started: [TODAY'S DATE]

| Iteration | Tag | Deployed | Prod Tested | Notes |
|-----------|-----|----------|-------------|-------|
| (iterations will be added here) |

## Iteration Details

### iter-1
- **Scope:** [To be filled on deployment]
- **Key Changes:** [To be filled on deployment]

## Final Deployment
- [ ] All iterations deployed
- [ ] All iterations production tested
- [ ] Final tag created
- [ ] Todo archived
```

---

**🚨 Phase 0.75: Change Scope Detection (MANDATORY - RUNS BEFORE ANYTHING ELSE)**

**This step determines the deployment tag. It is NOT optional. Do NOT skip it.**

```bash
# Count frontend and backend files changed on this branch vs master
FRONTEND_COUNT=$(git diff --name-only origin/master...HEAD -- frontend/ | wc -l | tr -d ' ')
BACKEND_COUNT=$(git diff --name-only origin/master...HEAD -- backend/ | wc -l | tr -d ' ')
OTHER_COUNT=$(git diff --name-only origin/master...HEAD -- ':!frontend/' ':!backend/' | wc -l | tr -d ' ')
```

**Display this EVERY time (no exceptions):**
```
📊 CHANGE SCOPE:
   Frontend files changed: [FRONTEND_COUNT]
   Backend files changed:  [BACKEND_COUNT]
   Other files changed:    [OTHER_COUNT]
```

**Tag decision is AUTOMATIC based on counts:**
- `FRONTEND_COUNT == 0` → **backend-v[VERSION]-[description]** (no frontend rebuild needed)
- `BACKEND_COUNT == 0` → **frontend-v[VERSION]-[description]** (no backend rebuild needed)
- Both > 0 → **matrix-v[VERSION]-[description]** (both need rebuilding)

**Claude CANNOT override this decision.** If frontend count is 0, the tag MUST be `backend-v*`. Period.

**WHY THIS EXISTS (Violation #100, #107, #109, #113):**
- Claude has used `matrix-v*` for backend-only deploys FOUR times
- Each time wastes ~19 minutes of paid GitHub Actions time
- The data was always available, Claude just didn't check it

---

**🚨 CRITICAL: Pre-Deployment Auto-Commit**
1. **Automatic Commit of All Changes:**
   - Check git status: `git status --porcelain`
   - **IF ANY UNCOMMITTED FILES FOUND:**

     **🔧 AUTO-COMMIT - NO QUESTIONS ASKED:**
     ```bash
     git add -A && git commit -m "[descriptive message of changes]"
     ```
     - **NEVER ask the user** if they want to commit
     - **NEVER block deployment** for uncommitted files
     - **ALWAYS commit automatically** with a descriptive message
     - Generate commit message based on what files changed
     - Continue immediately with deployment after committing

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

2. **Update Iteration Tracking (if iteration deployment):**
   - Add new row to `deployment-iterations.md` table:
     ```
     | iter-[N] | matrix-v[VERSION]-[task]-iter-[N] | [TODAY] | ⏳ pending | [Brief scope description] |
     ```
   - Add iteration details section:
     ```markdown
     ### iter-[N]
     - **Scope:** [What this iteration includes]
     - **Key Changes:** [Files/features modified]
     - **Testing Focus:** [What to verify in production]
     ```

3. **Update Technical Documentation:**
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

   **🔍 CHANGE DETECTION: Already determined in Phase 0.75 above.**
   **Use the tag prefix decided there. Do NOT reconsider or override it.**
   - Frontend 0 files → `backend-v*` (LOCKED)
   - Backend 0 files → `frontend-v*` (LOCKED)
   - Both > 0 → `matrix-v*` (LOCKED)

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

   **🔄 ITERATION DEPLOYMENT (Phased Releases):**
   - **Pattern:** `matrix-v[VERSION]-[task-name]-iter-[N]`
   - **Use for:** Phased feature releases that need production testing between iterations
   - **Examples:**
     - `matrix-v0.32.0-shopify-rag-iter-1` (products sync)
     - `matrix-v0.32.0-shopify-rag-iter-2` (collections sync)
     - `matrix-v0.32.0-shopify-rag-iter-3` (blog articles)
   - **Final:** `matrix-v0.32.0-shopify-rag-complete` (after all iterations tested)
   
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
   - **Iteration deployment** → `matrix-v[VERSION]-[task]-iter-[N]` (🔄 Phased release)
   - **Final deployment** → `matrix-v[VERSION]-[task]-complete` (✅ All iterations tested)
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
   - **🚨 CRITICAL DEPLOYMENT STEPS - BOTH REQUIRED:**
     1. **CREATE TAG:** `git tag [final-tag]`
     2. **🚀 PUSH TAG:** `git push origin [final-tag]` **← DEPLOYMENT ONLY STARTS AFTER PUSH!**
   - **⚠️ IMPORTANT:** Tag creation alone does NOT start deployment - you MUST push the tag!
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

**Phase 5: Social Post & Blog Check**

9. **Draft Deployment Social Post (X + BlueSky):**
   - Using deployment context already available (tag, version, branch type, changelog entry), draft a 1-2 sentence post about what shipped.
   - **Template guidance:**
     - **MUST follow brand-brent voice rules.** Load the brand-brent skill before drafting.
     - State what was deployed, not how it was built
     - Use the changelog "Added/Changed/Fixed" entry as the source
     - No em dashes, no emojis, no "actually", no adverbs
     - No "Just shipped", "Just deployed", or any "Just..." openers (banned phrase)
     - No vague hooks ("Something big", "Most people missed this")
     - Keep it factual. No hype words ("game-changing", "revolutionary")
     - First person voice
   - **Example posts:**
     - "RequestDesk now checks every piece of content against brand guidelines before publishing. Content terms enforcement is live."
     - "Fixed a bug where Shopify product sync was dropping collection assignments. Small fix, big impact for merchants with large catalogs."
   - **Display draft to user:**
     ```
     📣 DEPLOYMENT SOCIAL POST (Draft)

     X: [draft post]
     BlueSky: [same post or slightly adjusted for platform]

     Approve? (Y/Edit/Skip)
     ```
   - **If approved:** Schedule via Vista Social API
     - X profile: 23232, BlueSky profile: 457112
     - Schedule 30-60 minutes from now (irregular minute, not :00/:15/:30/:45)
     - Use -06:00 CST offset
     - Do NOT schedule both platforms at the same time. Stagger by at least 1 day.
   - **If user edits:** Use their version instead
   - **If skipped:** Move on

10. **Blog Post Check:**
    - After social post is handled, ask:
      ```
      📝 BLOG CHECK

      Can this deployment be compiled into a blog post?
      (Y = yes, start a draft / L = later, add to ideas list / N = no)
      ```
    - **If Y:** Hand off to `/publish-blog [destination]` command. Do NOT draft the post yourself. Do NOT ask for angle/framing. The publish-blog command handles the full workflow.
    - **If L:** Append one line to `brent-workspace/ob-notes/Brent Notes/Newsletters and Blogs/blog-ideas.md`:
      ```
      - [DATE] [tag] - [one-line description from changelog]
      ```
    - **If N:** Continue to next step

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

**Standard Deployments:**
1. **Regular deployments** → Use `matrix-v[VERSION]-[description]`
2. **Infrastructure changes** → Use `matrix-v[VERSION]-fresh-[description]`
3. **Emergency fixes** → Use `hotfix-v[VERSION]-[description]`
4. **Matrix issues** → Fallback to `app-v[VERSION]-[description]`

**Phased/Iteration Deployments:**
1. **Deploy iteration** → `/deploy-project` (creates iter-1, iter-2, etc.)
2. **Test in production** → Verify the iteration works as expected
3. **Mark as tested** → `/deploy-project --mark-tested iter-1`
4. **Repeat** → Deploy more iterations as needed
5. **Final release** → `/deploy-project --final` (only after all tested)
6. **Archive** → Run `/claude-complete` to close the todo

**When to Use Iterations:**
- Large features with multiple phases
- Features where each phase needs production validation
- Gradual rollouts where early phases inform later ones
- Risk mitigation for complex changes