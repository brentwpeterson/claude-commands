Complete branch workflow with comprehensive checklist and finalization

**🎯 PURPOSE:**
Systematically complete a branch by verifying all work is done, merging to master, archiving documentation, and cleaning up - ensuring nothing is forgotten.

**⚡ QUICK USAGE:**
`/claude-complete` - Run full completion checklist for current branch

---

## 🚨 PHASE -1: WORKSPACE & BRANCH CONFIRMATION (MANDATORY FIRST STEP)

**This phase MUST be completed before ANY other action. Do NOT skip this.**

### Step 1: Detect Current State
```bash
echo "=== WORKSPACE DETECTION ==="
echo "Current Directory: $(pwd)"
echo "Git Root: $(git rev-parse --show-toplevel 2>/dev/null || echo 'NOT A GIT REPO')"
echo "Current Branch: $(git branch --show-current 2>/dev/null || echo 'N/A')"
echo "Last Commit: $(git log -1 --oneline 2>/dev/null || echo 'N/A')"
echo ""
echo "=== UNCOMMITTED CHANGES ==="
git status --short
```

### Step 1.5: Branch Ownership Verification (HARD STOP - NO EXCEPTIONS)

**🚨 THIS CHECK CANNOT BE SKIPPED, OVERRIDDEN, OR WORKED AROUND 🚨**

You can ONLY complete a branch that YOUR session is actively working on. Jumping onto a pre-existing branch and trying to complete it is forbidden.

**Verification Logic:**

1. **Get current Claude identity and branch:**
   ```bash
   # Use YOUR name from conversation memory (primary source)
   CLAUDE_NAME="YOUR_NAME_FROM_MEMORY"
   # If unknown, query session DB:
   source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
   session_db_get_json "$CLAUDE_NAME"
   # DO NOT read active-session.json (deprecated, shared file that overwrites between sessions)
   CURRENT_BRANCH=$(git branch --show-current)
   echo "Claude Identity: $CLAUDE_NAME"
   echo "Current Branch: $CURRENT_BRANCH"
   ```

2. **Check for a context file linking THIS Claude to THIS branch:**
   ```bash
   CONTEXT_DIR="/Users/brent/scripts/CB-Workspace/.claude/branch-context"
   # Search active context files for this Claude + this branch
   MATCH=$(grep -rl "$CURRENT_BRANCH" "$CONTEXT_DIR"/*.md 2>/dev/null | xargs grep -l "$CLAUDE_NAME" 2>/dev/null | head -1)
   echo "Context file match: ${MATCH:-NONE}"
   ```

3. **Check if this session started the branch (via /start-work):**
   ```bash
   # Look for todo directory matching the branch
   BRANCH_SHORT=$(echo "$CURRENT_BRANCH" | sed 's|.*/||')
   TODO_DIR=$(find todo/current -maxdepth 2 -type d -name "*${BRANCH_SHORT}*" 2>/dev/null | head -1)
   echo "Todo directory: ${TODO_DIR:-NONE}"
   ```

4. **HARD STOP if ownership cannot be verified:**

   If ALL of the following are true, **STOP IMMEDIATELY**:
   - No context file links this Claude identity to this branch
   - The branch was not created in this session
   - The branch is not `master` or `main` (direct-to-master work is allowed)

   ```
   ╔══════════════════════════════════════════════════════════════════╗
   ║           🛑 HARD STOP: BRANCH OWNERSHIP FAILED 🛑              ║
   ╠══════════════════════════════════════════════════════════════════╣
   ║                                                                   ║
   ║  Claude-[Name] does NOT own branch: [branch-name]               ║
   ║                                                                   ║
   ║  This branch belongs to another session or was pre-existing      ║
   ║  active work. You cannot complete a branch you didn't start.     ║
   ║                                                                   ║
   ║  What you CAN do:                                                ║
   ║  • /claude-save to save YOUR work from this session              ║
   ║  • Commit your changes (they'll merge when the branch completes) ║
   ║  • Switch to a branch you own and complete that instead          ║
   ║                                                                   ║
   ║  What you CANNOT do:                                             ║
   ║  • Complete this branch                                           ║
   ║  • Merge this branch to master                                    ║
   ║  • Delete this branch                                             ║
   ║  • Archive this branch's todo directory                          ║
   ║                                                                   ║
   ╚══════════════════════════════════════════════════════════════════╝

   /claude-complete ABORTED. No further phases will execute.
   ```

   **DO NOT continue to Step 2 or any other phase. The command is done.**

**Why this exists:** Claude-Darwin committed log cleanup work onto `feature/feed-aggregator` (an active branch owned by another session) and then tried to `/claude-complete` it, which would have merged, archived, and deleted someone else's active work.

---

### Step 2: Multi-Workspace Detection
**CRITICAL:** Check session tracking file for workspaces touched this session.

1. **Read session tracking from SQLite DB:**
   ```bash
   source /Users/brent/scripts/CB-Workspace/.claude/local/session-db.sh
   session_db_get_json "YOUR_NAME"
   # DO NOT read active-session.json (deprecated)
   ```

2. **Also check context files in `.claude/branch-context/` for additional context**

3. **Display using shortcodes:**
   ```
   MULTI-WORKSPACE CHECK
   =====================
   Session tracking file found:
   - Started: 2026-01-08T07:00:00
   - Start workspace: [as] astro-sites

   Workspaces touched this session:
   1. [as] astro-sites     - /Users/brent/.../astro-sites (Branch: master)
   2. [rd] requestdesk     - /Users/brent/.../cb-requestdesk (Branch: master)

   ⚠️  Multiple workspaces detected!
       You must run /claude-complete separately for each workspace.

   Which workspace are you completing now?
   Type shortcode to confirm (e.g., 'as' for astro-sites): _
   ```

**SHORTCODE REFERENCE:**
| Shortcode | Workspace |
|-----------|-----------|
| `rd` | cb-requestdesk |
| `as` | astro-sites |
| `sh` | cb-shopify |
| `wp` | cb-wordpress |
| `mg` | cb-magento-integration |
| `jg` | cb-junogo |
| `job` | jobs |
| `ms` | cb-memory-system |
| `bw` | brent-workspace |
| `cc` | .claude (claude-commands) |

### Step 3: Explicit User Confirmation (REQUIRED)
**Present this to the user and WAIT for confirmation:**

```
╔══════════════════════════════════════════════════════════════════╗
║              WORKSPACE & BRANCH CONFIRMATION                      ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                   ║
║  Workspace:   [as] astro-sites                                   ║
║  Directory:   /Users/brent/scripts/CB-Workspace/astro-sites/     ║
║  Branch:      master                                              ║
║  Last Commit: abc1234 - Add feature XYZ                          ║
║                                                                   ║
║  This completion will:                                            ║
║  • Archive context files for [as] only                           ║
║  • Update documentation in [as]                                   ║
║  • Potentially delete branches in [as]                           ║
║                                                                   ║
╚══════════════════════════════════════════════════════════════════╝

Type the shortcode to confirm (e.g., 'as'): _
```

**If user says NO:** Stop immediately and ask which workspace they want to complete.

**If multiple workspaces were modified:** Inform user they need to run `/claude-complete` for each workspace separately.

---

## Phase 0: Pre-Completion Checklist ✅

1. **🔒 Final Security Scan:**
   - Run comprehensive security scan one last time
   - Ensure no credentials or sensitive data in commits
   - Generate final security report for branch
   - Block completion if CRITICAL issues found

2. **📋 Completion Checklist (Interactive):**
   ```
   BRANCH COMPLETION CHECKLIST - feature/api-integration

   Code Quality:
   ✅ All tests passing? [Y/n]: _
   ✅ Linting/type checking clean? [Y/n]: _
   ✅ Code reviewed/tested? [Y/n]: _

   Documentation:
   ✅ README updated? [Y/n]: _
   ✅ API docs updated? [Y/n]: _
   ✅ CHANGELOG entry added? [Y/n]: _
   ✅ Technical docs complete? [Y/n]: _

   Testing:
   ✅ Local testing complete? [Y/n]: _
   ✅ Production deployed? [Y/n]: _
   ✅ Production verified? [Y/n]: _

   Cleanup:
   ✅ No console.logs/debug code? [Y/n]: _
   ✅ Environment variables documented? [Y/n]: _
   ✅ Migration notes added (if needed)? [Y/n]: _

   Continue with completion? [Y/n]: _
   ```

---

## Phase 1: Branch Analysis & Validation

3. **Analyze Current Branch:**
   - Detect current branch name and type (feature/fix/enhancement/etc.)
   - Find corresponding task folder in `/todo/current/[branch-type]/`
   - **Verify README.md Branch Reference** in task folder:
     ```bash
     CURRENT_BRANCH=$(git branch --show-current)
     TASK_FOLDER=$(find todo/current -type d -name "*$(echo $CURRENT_BRANCH | sed 's|.*/||')*" 2>/dev/null | head -1)

     if [ -n "$TASK_FOLDER" ] && [ -f "$TASK_FOLDER/README.md" ]; then
       if ! grep -q "**Branch:** $CURRENT_BRANCH" "$TASK_FOLDER/README.md"; then
         echo "⚠️ README.md shows incorrect branch - updating before completion..."
         sed -i.bak "s/\*\*Branch:\*\* .*/\*\*Branch:\*\* $CURRENT_BRANCH/" "$TASK_FOLDER/README.md"
         echo "✅ Updated README.md to show current branch: $CURRENT_BRANCH"
       fi
     fi
     ```
   - Verify branch is fully merged to master or ready to merge
   - Check for any uncommitted changes

---

## Phase 2: Merge to Master

4. **Ensure Branch is Merged:**
   - Check if already merged: `git branch --merged master`
   - If not merged:
     ```bash
     git checkout master
     git pull origin master
     git merge [branch-name] --no-ff -m "merge: Complete [branch-name]"
     git push origin master
     ```
   - Verify merge was successful
   - Handle any merge conflicts if they arise

---

## Phase 3: Archive Work & Context

5. **Move Task to Completed:**
   - Move entire branch folder from `/todo/current/[branch-type]/` to `/todo/completed/`
   - Add completion timestamp to folder name: `[branch-name]-completed-[date]`
   - Update final status in task documents
   - Add final testing results and production notes

6. **Archive Branch Context:**
   - Move `.claude/branch-context/[type]-[branch]-context.md` to completed task folder
   - Update context file with completion status and final notes
   - This preserves complete history with the completed work

7. **🔒 Validate Completed Directory Structure:**
   - **CRITICAL**: Ensure `/todo/completed/` contains exactly 4 subdirectories
   - **Required subdirectories**: `feature`, `fix`, `infrastructure`, `refactor`
   - **Validation script**:
     ```bash
     COMPLETED_DIRS=$(ls -1 /todo/completed/ | wc -l)
     EXPECTED_DIRS=4

     if [ "$COMPLETED_DIRS" -ne "$EXPECTED_DIRS" ]; then
       echo "❌ ERROR: Invalid completed directory structure!"
       echo "Expected exactly 4 subdirectories: feature, fix, infrastructure, refactor"
       echo "Found $COMPLETED_DIRS directories:"
       ls -1 /todo/completed/
       echo "Please fix directory structure before completing."
       exit 1
     fi

     echo "✅ Completed directory structure validated (4 subdirectories)"
     ```
   - **Prevents**: Random directories like `hotfix/`, `enhancement/`, `bugfix/`
   - **Ensures**: Clean, organized, predictable structure for team collaboration

---

## Phase 4: Update User Documentation

8. **Comprehensive Documentation Update:**
   - Based on branch type, update appropriate `/docs/` sections:
     - **Features:** User guides, feature documentation, API docs
     - **Fixes:** Update known issues lists, troubleshooting guides, Bug Registry status
     - **Enhancements:** Update existing feature documentation
     - **Bug Fixes:** Mark bug as resolved in `/documentation/docs/technical/bug-fixes/BUG-REGISTRY.md`
   - Include screenshots, examples, or tutorials if needed
   - Update navigation/index files to reflect changes

9. **Finalize Changelog Entry:**
   - Update `/docs/changelog.md`
   - Mark current build as tested and confirmed
   - Add any additional user-facing details discovered during testing
   - Clean up technical details that users don't need to see
   - Mark build as "✅ Tested and Confirmed"

---

## Phase 5: Technical Documentation Finalization

10. **Complete Technical Docs:**
    - Finalize `/technical/` documentation
    - Add performance metrics, monitoring notes
    - Document any production-specific configurations
    - Add maintenance or troubleshooting procedures
    - Update technical architecture docs if needed
    - **For Bug Fixes:** Update Sentry Error Catalog with resolution details and monitoring notes

---

## 🚨 Phase 6: Branch & Git Cleanup (REQUIRES CONFIRMATION)

**This phase deletes branches. MUST get explicit confirmation.**

11. **Pre-Deletion Verification:**
    ```bash
    BRANCH_TO_DELETE="feature/xyz"

    echo "=== BRANCH DELETION PREVIEW ==="
    echo "Branch to delete: $BRANCH_TO_DELETE"
    echo ""
    echo "Commits on this branch:"
    git log master..$BRANCH_TO_DELETE --oneline 2>/dev/null || echo "Already merged or branch doesn't exist"
    echo ""
    echo "Merge status:"
    git branch --merged master | grep -q "$BRANCH_TO_DELETE" && echo "✅ MERGED to master" || echo "⚠️ NOT MERGED"
    ```

12. **🚨 EXPLICIT DELETION CONFIRMATION (REQUIRED):**
    ```
    ╔══════════════════════════════════════════════════════════════════╗
    ║                 ⚠️  BRANCH DELETION WARNING  ⚠️                   ║
    ╠══════════════════════════════════════════════════════════════════╣
    ║                                                                   ║
    ║  You are about to DELETE the following branch:                   ║
    ║                                                                   ║
    ║  Branch: feature/api-integration                                 ║
    ║  Commits: 24 commits (all merged to master)                      ║
    ║  Status: ✅ Fully merged                                         ║
    ║                                                                   ║
    ║  This will:                                                       ║
    ║  • Delete LOCAL branch: git branch -d feature/api-integration    ║
    ║  • Delete REMOTE branch: git push origin --delete feature/...    ║
    ║                                                                   ║
    ║  This action CANNOT be easily undone!                            ║
    ║                                                                   ║
    ╚══════════════════════════════════════════════════════════════════╝

    Type the branch name to confirm deletion: _
    (or type 'skip' to skip branch deletion)
    ```

    **User must type the exact branch name to confirm.** This prevents accidental deletion.

13. **Clean Up Development Branch (only after confirmation):**
    - Delete the branch locally: `git branch -d [confirmed-branch]`
    - Delete remote branch: `git push origin --delete [confirmed-branch]`
    - Switch to master branch after cleanup

**Special Case - Working on Master:**
If the work was done directly on master (no feature branch), skip this phase entirely and note in the completion report:
```
Branch Cleanup: N/A (work done directly on master, no feature branch to delete)
```

---

## Phase 7: Version Management & Tagging

**🔢 Step 13.5: Version Sync (MANDATORY BEFORE TAGGING)**

**Sync VERSION file with actual database version before creating any tags:**

```bash
# Query actual version from API
ACTUAL_VERSION=$(curl -s http://localhost:3000/api/current_version | grep -o '"version":"[^"]*"' | cut -d'"' -f4)
FILE_VERSION=$(cat VERSION)

echo "API Version:  $ACTUAL_VERSION"
echo "FILE Version: $FILE_VERSION"

if [ "$ACTUAL_VERSION" != "$FILE_VERSION" ]; then
  echo "⚠️ VERSION MISMATCH - Syncing..."
  echo "$ACTUAL_VERSION" > VERSION
  git add VERSION
  git commit -m "Sync VERSION file to $ACTUAL_VERSION (from API/migrations)"
  echo "✅ VERSION synced to $ACTUAL_VERSION"
else
  echo "✅ VERSION file is in sync"
fi
```

**WHY:** VERSION file can drift behind migrations. API endpoint is source of truth.

14. **Create Completion Tag:**
    - Create a git tag for completed work:
      ```bash
      git tag -a "completed-[branch-name]-v[version]" -m "Completed: [description]"
      git push origin --tags
      ```
    - This preserves a permanent record of completion

---

## Phase 8: Version Planning

15. **Version Planning:**
    - Check if this completes a version milestone
    - Determine next version number based on current version
    - Update version planning documents in `/TODO/`
    - Note any dependencies this completion unlocks

---

## Phase 9: Final Documentation Commit

16. **Documentation Commit:**
    - Create comprehensive commit for documentation updates
    - Message format: "Complete [detected-version]: [branch-name] - all testing confirmed"
    - Commit from master branch (documentation-only changes)
    - Push to master

---

## Phase 10: Post-Completion Summary & Next Steps

17. **Generate Completion Report:**
    ```
    ✅ BRANCH COMPLETED: feature/api-integration

    📊 COMPLETION SUMMARY:
    - Workspace: /Users/brent/scripts/CB-Workspace/astro-sites/
    - Branch Type: feature
    - Work Duration: 3 days
    - Commits: 24
    - Files Changed: 18
    - Tests Added: 12
    - Security Score: 95/100

    📁 ARCHIVED TO:
    - Task: /todo/completed/feature-api-integration-20250904/
    - Context: Moved to task folder
    - Documentation: Updated in /documentation/

    🔒 SECURITY FINAL:
    - No critical issues ✅
    - 2 warnings documented for future work

    📋 DOCUMENTATION UPDATED:
    - CHANGELOG.md: v0.28.1 entry
    - README.md: New feature section
    - API docs: 3 new endpoints
    - Technical docs: Architecture updated

    🏷️ GIT STATUS:
    - Merged to master ✅
    - Branch deleted (local & remote) ✅
    - Tagged: completed-feature-api-integration-v0.28.1

    🎯 SUGGESTED NEXT STEPS:
    1. Review backlog in /todo/backlog/
    2. Start new feature with /project:create-branch
    3. Address security warnings in next session

    ⚠️  OTHER WORKSPACES:
    If you modified other workspaces in this session, remember to run
    /claude-complete for each one separately.
    ```

18. **Action Items Check (MANDATORY):**
    Before finishing, ask the user:
    ```
    Any open tasks to add to your Action Items list before closing?
    (These go to ACTION-ITEMS.md in your Obsidian Daily folder)

    1. Yes - let me tell you what to add
    2. No - nothing to track
    ```
    If yes: append items to `brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/ACTION-ITEMS.md`
    under a group named `From: [branch-name] completion ([today's date])`.
    Use the same format as `/action-items add`.

19. **Completion Summary:**
    - Branch completed: [branch-name]
    - Branch type: [feature/fix/etc.]
    - Documentation updated in: /docs/ and /technical/
    - Task moved to: /TODO/completed/
    - **Bug Fix Specific:** Bug registry updated, Sentry catalog updated, monitoring notes added
    - Next suggested action: Start new branch or continue with backlog

---

## 🛡️ SAFETY FEATURES:

1. **Workspace Confirmation (Phase -1):** MUST confirm correct workspace before ANY action
2. **Multi-Workspace Detection:** Alerts if multiple workspaces were modified in session
3. **Branch Deletion Confirmation (Phase 6):** Requires typing exact branch name to delete
4. **Security Scan:** Blocks completion if CRITICAL issues found
5. **Checklist Confirmation:** Requires confirmation for all checklist items
6. **Context Preservation:** Archives branch context with completed work
7. **Git Tag:** Creates permanent record of completion

---

## 🔄 INTEGRATION:
- Works with `/claude-start` for fresh begins after completion
- Updates all documentation touched by `/claude-close`
- Preserves context from `/claude-clean` branch saves
- Security validation from `/claude-commit` framework

---

## 📝 ADDITIONAL COMPLETION TASKS TO CONSIDER:
- Update team communication channels about completion
- Close related GitHub issues or tickets
- Update project roadmap/kanban board
- Schedule follow-up monitoring for new features
- Document any technical debt incurred
- Update dependency documentation if libraries added
- Notify stakeholders of feature availability

---

This ensures thorough, systematic branch completion with nothing forgotten!
