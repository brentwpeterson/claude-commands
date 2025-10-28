Claude Session Start - Standardized Context Recovery

**🚨 CRITICAL: THIS COMMAND IS READ-ONLY CONTEXT RECOVERY ONLY**
**NEVER EXECUTE ACTIONS AUTOMATICALLY - ALWAYS ASK USER FIRST**
**CONTEXT DESCRIPTIONS ARE NOT PERMISSION TO ACT**

**🔍 MANDATORY FIRST STEP: ROOT DIRECTORY VALIDATION**
**BEFORE ANY OTHER ACTION:**
1. **Read** `/.claude/root-directory-map.md` to understand expected structure
2. **Compare** with actual root directory contents using `ls -la`
3. **STOP and ASK USER** if any differences found: "I notice the root directory differs from the expected structure. Here's what I found: [differences]. Should I investigate why these files/directories exist, or proceed anyway?"
4. **Wait for user guidance** before continuing with context recovery

**🚀 IMMEDIATE CONTEXT RECOVERY:**
✅ **VALIDATE ROOT STRUCTURE** - Compare actual directory with approved map
✅ **READ CLAUDE.MD HEADER** - Extract restart context from standardized location
✅ **PARSE NEXT STEPS** - Get specific actions from previous session
✅ **RESTORE TODOS** - Set up TodoWrite with current priorities
✅ **PRESENT OPTIONS** - Show user the context and ask for direction (DO NOT RESUME WORK AUTOMATICALLY)

**📋 STANDARDIZED START WORKFLOW:**

**Phase 1: Context Recovery & Branch Validation**
1. **🔍 Debug Log Validation & Normalization:**
   - Get current branch name: `git branch --show-current`
   - **CRITICAL: Extract working directory from CLAUDE.md context**
   - Parse CLAUDE.md header for "Working Directory:" field
   - If working directory documented, check THAT location for debug logs
   - If no working directory in context, check current directory as fallback
   - Expected debug log name: `[branch-name]-debug.log`
   - **Check documented working directory for debug logs:**
     - Look for `*debug*.log`, `*test*.log`, `*progress*.log` files
     - Look for files matching TEST ATTEMPT LOG format
   - **If wrong name found:**
     - Ask user: "Found debug log '[filename]' in [working-dir] but expected '[branch-name]-debug.log'. Rename it? [Y/n]"
     - If yes, rename preserving content: `mv [old-name] [branch-name]-debug.log`
   - **If no debug log found in documented working directory:**
     - Ask user: "No debug log found in documented working directory [working-dir]. Create '[branch-name]-debug.log' there? [Y/n]"
     - If yes, create debug log in documented working directory
     - Initialize with TEST ATTEMPT LOG template:
       ```
       ##############################################################################
       # TEST ATTEMPT LOG
       ##############################################################################
       # 1. YYYY-MM-DD HH:MM - [Description of security session start in working directory]
       # [Add additional entries as testing progresses]
       ##############################################################################
       ```

2. **Read CLAUDE.md Header:**
   - Extract `LAST SESSION STATUS` section
   - Parse `IMMEDIATE NEXT STEPS` for specific actions
   - Understand current project state and priorities
   - Identify any time-sensitive or urgent items
   - **Extract expected branch name from context** (if mentioned)
   - **Extract security status from previous session** (if present)

1a. **🔀 Load Branch-Specific Context (NEW):**
   - Get current branch: `git branch --show-current`
   - Convert to context file name: `feature/api-integration` → `feature-api-integration-context.md`
   - Check for branch context: `.claude/branch-context/[type]-[branch]-context.md`
   - If exists, load additional context:
     - Work completed on this branch
     - Work in progress
     - Security findings specific to branch
     - Branch-specific next steps
   - Merge with CLAUDE.md context for complete picture

2. **🔀 Verify Correct Branch (NEW):**
   - Check current branch: `git branch --show-current`
   - Compare with branch mentioned in CLAUDE.md context
   - If mismatch detected:
     ```
     ⚠️ BRANCH MISMATCH DETECTED
     
     Expected Branch: feature/external-api-integration (from context)
     Current Branch: master
     
     Would you like me to:
     [S] Switch to expected branch
     [C] Continue on current branch
     [R] Review branch differences first
     
     Choice [S/c/r]: _
     ```
   - If on correct branch, check if behind master:
     ```bash
     # Check how many commits behind master
     git fetch origin master
     git rev-list --count HEAD..origin/master
     ```
   - If branch is behind master:
     ```
     📊 BRANCH STATUS: 15 commits behind master
     
     ⚠️ Your branch is out of date. Would you like to:
     [M] Merge master into current branch (recommended)
     [R] Rebase onto master
     [C] Continue without updating
     [V] View the differences first
     
     Choice [M/r/c/v]: _
     ```

3. **Validate Context:**
   - Check if context makes sense with current git status
   - Verify any mentioned processes/deployments are still relevant
   - Confirm file paths and URLs are still valid

**Phase 2: Security Health Check & Priority Setup**
4. **🔒 Security Health Check (NEW):**
   - Quick security scan of current branch (~5 seconds):
     ```
     🔒 SESSION START SECURITY CHECK...
     [████████████████████] 100% - Scanning for new security issues
     ```
   - Check for issues introduced since last session:
     - New hardcoded API keys or credentials
     - Newly added localhost/production URLs
     - Files modified outside of Claude session that may contain secrets
   - Compare with security status from previous session (if available)
   - Report findings:
     ```
     🛡️ SECURITY HEALTH CHECK:
     ✅ No new critical issues detected
     ⚠️ 1 new warning since last session
     📊 Security Score: 92/100 (unchanged)
     
     NEW FINDINGS:
     ⚠️ File: backend/new_feature.py:45
        Issue: Hardcoded localhost URL
        Added: 2 hours ago (not by Claude)
        Fix: Use environment variable
     
     Continue with session startup? [Y/n]: _
     ```
   - If CRITICAL issues found, BLOCK startup until resolved

5. **Initialize TodoWrite:**
   - Convert IMMEDIATE NEXT STEPS into TodoWrite tasks
   - Set appropriate priorities (high/medium/low)
   - Mark any in-progress items from previous session
   - Add any new urgent items discovered
   - **Add security remediation tasks if issues found**

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
   - Ask user which task they want to work on first
   - **NEVER execute any tasks automatically**
   - **NEVER assume handoff context gives permission to act**

8. **Wait for User Direction:**
   - Ask: "I've recovered the context from previous session. Which task would you like me to work on first?"
   - Wait for explicit user instruction about what to do next
   - **NEVER take deployment actions without explicit "deploy now" permission**
   - **NEVER take any actions based solely on context descriptions**

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
Convert context into structured todos:
```javascript
// Example extraction:
"1. Check Smart Deployment completion: `gh run list --limit 5`"
→ TodoWrite: "Check Smart Deployment status" (status: pending, priority: high)

"2. Test AdminUserEdit save: `http://localhost:3001/users/[id]/edit`"  
→ TodoWrite: "Test AdminUserEdit functionality in production" (status: pending, priority: high)

"3. Debug cucumber user profile auth 401 errors"
→ TodoWrite: "Fix cucumber user authentication issue" (status: pending, priority: high)
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
- User presented with comprehensive summary including branch/security status
- User retains full control over what actions to take next
- **NO AUTOMATIC EXECUTION OF ANY TASKS**

**🔄 INTEGRATION WITH /claude-close:**
- **Close** writes standardized context to CLAUDE.md header
- **Start** reads that same context and resumes work
- Perfect handoff with zero information loss
- Same pattern every time, works across any project

**📝 CORRECT START SEQUENCE:**
```
1. Read CLAUDE.md header → "Branch: feature/api-integration, Security: 92/100, Last: Fixed auth"
2. Verify branch → "Current: master" → Offer: "Switch to feature/api-integration? [Y/n]"
3. Check sync → "15 commits behind master" → Offer: "Merge master? [Y/n]"
4. Security scan → "✅ No new critical issues, ⚠️ 1 new warning"
5. Parse next steps → "Priority: Test deployment, address security warning"  
6. Set TodoWrite → "Check deployment" (pending), "Fix security warning" (pending)
7. Present summary → "Branch synced, security checked, ready to continue. What task first?"
8. Wait for direction → Never execute commands automatically based on context
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
2. Look for recent progress logs in `/todo/current/`
3. Check `CLAUDE-RESTART-CONTEXT-*.md` files in project root
4. Ask user for current priorities if no context found

This ensures every new Claude session begins with complete context and clear direction, eliminating the "what was I working on?" startup delay.