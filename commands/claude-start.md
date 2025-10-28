Claude Session Start - Standardized Context Recovery

**USAGE:**
- `/claude-start <project>` - Standard development session context recovery
- `/claude-start <project> --debug` - Debug session context recovery with attempt tracking

**Arguments**:
- `<project>` (required): Project to work on - any Git repository in your workspace (auto-discovered based on `.claude/local/workspace.env` configuration)

**🚨 CRITICAL: THIS COMMAND IS READ-ONLY CONTEXT RECOVERY ONLY**
**NEVER EXECUTE ACTIONS AUTOMATICALLY - ALWAYS ASK USER FIRST**
**CONTEXT DESCRIPTIONS ARE NOT PERMISSION TO ACT**

**🔍 MANDATORY FIRST STEPS: ROOT VALIDATION & PROJECT DIRECTORY CHANGE**
**BEFORE ANY OTHER ACTION:**
1. **Read** `.claude/root-directory-map.md` to understand expected structure
2. **Compare** with actual root directory contents using `ls -la`
3. **STOP and ASK USER** if any differences found: "I notice the root directory differs from the expected structure. Here's what I found: [differences]. Should I investigate why these files/directories exist, or proceed anyway?"
4. **🚨 CRITICAL: CHANGE TO PROJECT DIRECTORY** - `cd [project]` (e.g., `cd frontend` or `cd backend`)
5. **Verify project has separate git repo** - Each project should have its own git repository
6. **Wait for user guidance** before continuing with context recovery

**🚀 IMMEDIATE CONTEXT RECOVERY (IN PROJECT DIRECTORY):**
✅ **VALIDATE ROOT STRUCTURE** - Compare actual workspace directory with approved map
✅ **CHANGE TO PROJECT DIRECTORY** - `cd [project]` - WORK IN PROJECT'S GIT REPO
✅ **READ [PROJECT]/CLAUDE.MD HEADER** - Extract restart context from project-specific file
✅ **PARSE NEXT STEPS** - Get specific actions from previous session
✅ **RESTORE TODOS** - Set up TodoWrite with current priorities from saved context
✅ **PRESENT OPTIONS** - Show user the context and ask for direction (DO NOT RESUME WORK AUTOMATICALLY)

**📋 STANDARDIZED START WORKFLOW:**

**Phase 1: Context Recovery & Branch Validation (IN PROJECT DIRECTORY)**
0. **🚨 ESSENTIAL: CHANGE TO PROJECT DIRECTORY FIRST**
   - **CRITICAL**: `cd [project]` (e.g., `cd frontend` or `cd backend`)
   - **Each CB project has its own separate git repository**
   - **All subsequent git commands work in PROJECT'S repo, not workspace root**
   - **Working directory must match project for all context recovery**

1. **🔍 Debug Log Validation & Normalization (IN PROJECT DIR):**
   - Get current branch name: `git branch --show-current` (IN PROJECT REPO)
   - **CRITICAL: Extract working directory from CLAUDE.md context**
   - Parse CLAUDE.md header for "Working Directory:" field (should match current project dir)
   - Check PROJECT directory for debug logs (not workspace root)
   - Expected debug log name: `[branch-name]-debug.log`
   - **Check PROJECT directory for debug logs:**
     - Look for `*debug*.log`, `*test*.log`, `*progress*.log` files
     - Look for files matching TEST ATTEMPT LOG format
   - **If wrong name found:**
     - Ask user: "Found debug log '[filename]' in [project-dir] but expected '[branch-name]-debug.log'. Rename it? [Y/n]"
     - If yes, rename preserving content: `mv [old-name] [branch-name]-debug.log`
   - **If no debug log found in PROJECT directory:**
     - Ask user: "No debug log found in project directory [project-dir]. Create '[branch-name]-debug.log' there? [Y/n]"
     - If yes, create debug log in PROJECT directory
     - Initialize with TEST ATTEMPT LOG template:
       ```
       ##############################################################################
       # TEST ATTEMPT LOG
       ##############################################################################
       # 1. YYYY-MM-DD HH:MM - [Description of session start in project directory]
       # [Add additional entries as testing progresses]
       ##############################################################################
       ```

2. **Read PROJECT/CLAUDE.md Header (IN PROJECT DIR):**
   - Extract `LAST SESSION STATUS` section from PROJECT'S CLAUDE.md
   - Parse `IMMEDIATE NEXT STEPS` for specific actions
   - Understand current project state and priorities
   - Identify any time-sensitive or urgent items
   - **Extract expected branch name from context** (if mentioned)
   - **Extract security status from previous session** (if present)

3. **🔀 Load Branch-Specific Context (FROM WORKSPACE ROOT):**
   - Get current branch: `git branch --show-current` (IN PROJECT REPO)
   - Convert to context file name: `feature/api-integration` → `feature-api-integration-context.md`
   - Check for branch context: `../claude/branch-context/[type]-[branch]-context.md` (WORKSPACE LEVEL)
   - If exists, load additional context:
     - Work completed on this branch
     - Work in progress
     - Security findings specific to branch
     - Branch-specific next steps
   - Merge with PROJECT CLAUDE.md context for complete picture

4. **🔀 Verify Correct Branch (IN PROJECT REPO):**
   - Check current branch: `git branch --show-current` (IN PROJECT REPO)
   - Compare with branch mentioned in PROJECT CLAUDE.md context
   - If mismatch detected:
     ```
     ⚠️ BRANCH MISMATCH DETECTED

     Expected Branch: feature/external-api-integration (from context)
     Current Branch: master
     Project: [project-name]

     Would you like me to:
     [S] Switch to expected branch
     [C] Continue on current branch
     [R] Review branch differences first

     Choice [S/c/r]: _
     ```
   - If on correct branch, check if behind master (IN PROJECT REPO):
     ```bash
     # Check how many commits behind master (IN PROJECT REPO)
     git fetch origin master
     git rev-list --count HEAD..origin/master
     ```
   - If branch is behind master:
     ```
     📊 BRANCH STATUS: 15 commits behind master (Project: [project-name])

     ⚠️ Your branch is out of date. Would you like to:
     [M] Merge master into current branch (recommended)
     [R] Rebase onto master
     [C] Continue without updating
     [V] View the differences first

     Choice [M/r/c/v]: _
     ```

5. **Validate Context (IN PROJECT DIR):**
   - Check if context makes sense with current git status (PROJECT REPO)
   - Verify any mentioned processes/deployments are still relevant
   - Confirm file paths and URLs are still valid within PROJECT

**Phase 2: Priority Setup**
4. **Initialize TodoWrite:**
   - Convert IMMEDIATE NEXT STEPS into TodoWrite tasks
   - **Restore saved todos from branch context** if available
   - Set appropriate priorities (high/medium/low)
   - Mark any in-progress items from previous session
   - Add any new urgent items discovered
   - **Add security remediation tasks if issues found**

5. **Interactive Todo Review:**
   - **ASK CLARIFYING QUESTIONS** about restored todos:
     - "I found these todos from your previous session: [list]. Are these still accurate?"
     - "Should I adjust the priority of any tasks based on what's happened?"
     - "Are there any todos that are no longer relevant and should be removed?"
     - "Do any of these todos need more context or details to continue effectively?"
   - **VALIDATE UNDERSTANDING** before proceeding:
     - "Which task should I focus on first?"
     - "Is there anything important I should know about the current state of [specific todo]?"
   - **ESSENTIAL when context was saved due to limits**: Always ask these questions when resuming

6. **Check System Status:**
   - Verify any ongoing processes mentioned in context
   - Check deployment status if mentioned
   - Validate development environment is ready
   - Test any URLs or endpoints mentioned in next steps

**Phase 3: Present Status (NO ACTIONS)**
7. **Present Context Summary with Branch & Security Status:**
   - Show parsed context and priorities to user
   - **Display current branch and sync status with master**
   - **Show security health check results**
   - Present TodoWrite setup for user review
   - **MANDATORY: Ask interactive todo questions** (see Phase 2, step 5)
   - **NEVER execute any tasks automatically**
   - **NEVER assume handoff context gives permission to act**

8. **Wait for User Direction with Todo Validation:**
   - Ask: "I've recovered the context from previous session and reviewed the todos. Which task would you like me to work on first?"
   - **CRITICAL for context limit saves**: "Since you saved due to context limits, let me confirm - are all these todos still relevant and do they have the right priority?"
   - Wait for explicit user instruction about what to do next
   - **NEVER take deployment actions without explicit "deploy now" permission**
   - **NEVER take any actions based solely on context descriptions**

9. **🚨 CRITICAL COMPLETION VERIFICATION:**
   - **NEVER assume something was complete in saved context todos**
   - Claude tends to mark everything as "complete" before actually testing
   - This is deceiving and hard to catch as a human
   - **ALWAYS verify completion claims** by asking: "The context shows [X] as complete, but should I verify this is actually working before proceeding?"
   - **Challenge completion status** if not explicitly tested in previous session

10. **🚨 CRITICAL: NO IMMEDIATE TESTING:**
    - **DO NOT START IMMEDIATELY TESTING OR CHECKING SERVERS**
    - Do not jump into testing, server status checks, or validation without explicit user request
    - This wastes time and tokens when the user may want to discuss priorities first
    - **ALWAYS ASK**: "What would you like me to focus on next?"
    - **WAIT for explicit user direction** before starting any testing or validation work
    - User decides the next step, not Claude

**🎯 CONTEXT EXTRACTION PATTERNS:**
```markdown
From CLAUDE.md header, extract:
- **Branch**: Expected working branch (if mentioned)
- **Completed**: What previous session finished
- **In Progress**: What might still be running/pending  
- **Security Status**: Previous session security score/warnings
- **Next Priority**: Most important immediate action
- **Success Criteria**: How to know when work is complete
- **Specific Commands**: Exact commands to run first
```

**📋 TODOWRITE INITIALIZATION:**
Convert context into structured todos and restore saved todos:
```javascript
// Example extraction from CLAUDE.md:
"1. Check Smart Deployment completion: `gh run list --limit 5`"
→ TodoWrite: "Check Smart Deployment status" (status: pending, priority: high)

"2. Test AdminUserEdit save: `http://localhost:3001/users/[id]/edit`"
→ TodoWrite: "Test AdminUserEdit functionality in production" (status: pending, priority: high)

// Example restoration from branch context:
"Current Todos: ✅ Completed: Database migration, 🔄 In Progress: Fix user auth, ⏳ Pending: Update documentation"
→ TodoWrite: "Fix user authentication" (status: in_progress), "Update documentation" (status: pending)
```

**🔧 VALIDATION CHECKS:**
Before starting work, verify:
- [ ] **Root directory matches approved structure** (compare with `/.claude/root-directory-map.md`)
- [ ] **Current branch matches expected branch** from context
- [ ] **Branch is up to date with master** (merge if behind)
- [ ] **Security scan passes** (no new critical issues)
- [ ] Git status matches expected state from context
- [ ] Any mentioned deployments/processes are still active
- [ ] Development environment is running (docker, servers, etc.)
- [ ] File paths in next steps are valid
- [ ] URLs mentioned in context are accessible

**⚡ SAFE STARTUP ACTIONS (READ-ONLY + BRANCH OPS):**
1. **Read CLAUDE.md header** - Extract full context including branch/security info
2. **Verify branch** - Check current branch, offer to switch if needed
3. **Check branch sync** - Verify if behind master, offer to merge
4. **Run security scan** - Quick health check for new issues
5. **Set up TodoWrite** - Convert next steps to tasks (all as "pending")
6. **Validate environment** - Ensure everything is ready (read-only checks)
7. **Present comprehensive summary** - Show branch, security, and context status
8. **Wait for user instruction** - NEVER start work automatically

**🎯 SUCCESS INDICATORS:**
- Context recovery completed in < 30 seconds
- **Correct branch verified/switched**
- **Branch synced with master if needed**
- **Security health check completed**
- TodoWrite populated with actionable items (all "pending")
- **Interactive todo review completed** with user confirmation
- User presented with comprehensive summary including branch/security status
- **Todo priorities and relevance validated** by user
- User retains full control over what actions to take next
- **NO AUTOMATIC EXECUTION OF ANY TASKS**

**🔄 INTEGRATION WITH /claude-close:**
- **Close** writes standardized context to CLAUDE.md header
- **Start** reads that same context and resumes work
- Perfect handoff with zero information loss
- Same pattern every time, works across any project

**📝 CORRECT START SEQUENCE:**
```
1. Validate root structure → Check workspace vs approved map
2. cd [project] → ESSENTIAL: Change to project directory
3. git branch --show-current → Get current branch (IN PROJECT REPO)
4. Read [project]/CLAUDE.md → Extract context from PROJECT'S CLAUDE.md
5. Load branch context → Check workspace .claude/branch-context/ for branch-specific context
6. Verify branch → "Current: master, Expected: feature/api-integration" → Offer switch
7. Check sync → "15 commits behind master" → Offer merge (IN PROJECT REPO)
8. Parse next steps → "Priority: Test deployment, address security warning"
9. Set TodoWrite → "Check deployment" (pending), "Fix security warning" (pending)
10. Review todos → "I found these todos: Check deployment, Fix security warning. Are these still accurate priorities?"
11. Ask questions → "Do you need me to adjust any priorities or add context about the deployment status?"
12. Present summary → "Branch synced, PROJECT context loaded, todos validated. Which task should I focus on first?"
13. Wait for direction → Never execute commands automatically based on context
```

**🚨 CRITICAL DEPLOYMENT RULE INTEGRATION:**
- **Context status ≠ Permission to act**
- **"Ready for deployment" = informational status only**  
- **"Deploy enhanced features" = task description, NOT permission**
- **ALWAYS ask "Ready to deploy?" before any deployment actions**
- **User must explicitly say "deploy now" or "yes, deploy"**

**🚨 FALLBACK IF CONTEXT MISSING:**
If CLAUDE.md header doesn't have restart context:
1. Check recent git commit messages for context
2. Look for recent progress logs in `[project]/todo/current/`
3. Check `CLAUDE-RESTART-CONTEXT-*.md` files in project root
4. Ask user for current priorities if no context found

This ensures every new Claude session begins with complete context and clear direction, eliminating the "what was I working on?" startup delay.

---

## 🐛 **DEBUG MODE BEHAVIOR (`--debug` flag)**

When `/claude-start --debug` is used, the command switches to **debug session context recovery** instead of standard development mode.

### **Debug Mode Workflow:**

**Phase 1: Debug Context Recovery (IN PROJECT DIRECTORY)**
0. **🚨 ESSENTIAL: CHANGE TO PROJECT DIRECTORY FIRST**
   - **CRITICAL**: `cd [project]` (e.g., `cd frontend` or `cd backend`)
   - **Each CB project has its own separate git repository**
   - **All debug operations work in PROJECT'S repo, not workspace root**

1. **Find Debug Log (IN PROJECT DIR):**
   - Get current branch: `git branch --show-current` (IN PROJECT REPO)
   - Look for debug log: `todo/current/[category]/[task-name]/[branch-name]-debug.log` (IN PROJECT DIR)
   - If not found, alert user: "No debug log found in project directory. Are you sure this is a debug session?"

2. **Parse Current Attempt Number:**
   - Read SUMMARY OF ATTEMPTS section from debug log
   - Find highest attempt number (e.g., "Attempt #27")
   - Count FAILED/SUCCESS/PENDING attempts
   - Identify current attempt status

3. **Load Branch Context:**
   - Read `.claude/branch-context/[branch-name]-context.md`
   - Extract debug-specific context and progress
   - Preserve all existing context (never remove)

4. **Read CLAUDE.md Header:**
   - Extract restart context for additional information
   - Merge with debug log and branch context

**Phase 2: Debug-Focused Presentation**
5. **Present Debug Session Summary:**
   ```
   🐛 DEBUG SESSION RECOVERED
   📁 Debug Log: [project]/todo/current/feature/existing-user-team-addition/feature-existing-user-team-addition-debug.log
   🎯 Current Status: Attempt #27 PENDING
   📊 Attempt History: 26 FAILED, 1 SUCCESS, 1 PENDING
   🔄 Last Attempt: z@z.com FAILED - User had email_verified=true but wrong company
   📋 Next Ready: aa@aa.com - Root cause fix deployed, should get correct company

   ## Debug Context Loaded
   **Branch**: feature/existing-user-team-addition
   **Issue**: Invitation system - users getting wrong company assignments
   **Root Cause**: Fixed - link_user_to_pending_invitations() was destroying company data
   **Solution Applied**: Modified linking process to preserve company data

   ## Ready for Next Debug Attempt
   **Focus**: Systematic debugging with comprehensive documentation
   **Mindset**: Document everything, preserve all debug context
   **Next**: Test User AA invitation (attempt #27) to validate fix
   ```

6. **Set Debug Mindset:**
   - Emphasize systematic debugging approach
   - Remind to document everything in debug log
   - Focus on preserving debug context and attempt history

**Phase 3: Debug TodoWrite Setup**
7. **Initialize Debug-Focused TodoWrite:**
   - Convert debug next steps into todos
   - Include current attempt number in task descriptions
   - Set debug-specific priorities
   - Prepare for systematic attempt documentation

### **Debug Mode Differences:**
- ✅ **Loads debug log first** instead of just CLAUDE.md
- ✅ **Shows current attempt number and history**
- ✅ **Emphasizes systematic debugging approach**
- ✅ **Preserves all debug context (additive only)**
- ✅ **Sets debugging mindset for comprehensive documentation**
- ✅ **Focuses on attempt tracking and failure analysis**

### **Debug Session Context Priority:**
1. **Debug Log** - Primary source for attempt status and history
2. **Branch Context** - Debug-specific branch progress and findings
3. **CLAUDE.md** - General project context and next steps
4. **Combined View** - Merged comprehensive debug session context

This ensures debug sessions immediately restore debugging context with attempt tracking and systematic approach.