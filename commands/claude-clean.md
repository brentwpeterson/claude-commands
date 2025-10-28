Save current work to branch and start clean session on master

**🎯 PURPOSE:**
Save all current work to the active branch, switch to master, and clear restart context for a completely clean development session while preserving branch work.

**⚡ QUICK USAGE:**
`/claude-clean` - Save work and start clean

**🔄 WORKFLOW:**

**Phase 1: Safety Checks & Validation**
1. **Pre-flight Safety Checks:**
   - Verify not already on master branch (refuse if on master)
   - Check git status for uncommitted changes
   - Warn user about any uncommitted files that will be saved
   - Ask for confirmation: "Save all work to [current-branch] and switch to clean master? (Y/N)"

2. **Branch Validation:**
   - Ensure current branch follows naming convention (feature/, fix/, enhancement/, etc.)
   - Store current branch name for preservation in commit message
   - Verify git repository is in good state (not in middle of merge/rebase)

3. **Security Scan & File Size Check (NEW):**
   - Run fast security scan (~2-3 seconds) for exposed credentials:
     ```
     SECURITY VALIDATION...
     [████████████████████] 100% - Scanning for exposed credentials
     ```
   - **File Size Validation (NEW):**
     - Check all new/modified Python files for size violations
     - **BLOCKING condition**: Any Python file over 1000 lines
     - Files between 500-1000 lines get warnings
     - Use Python File Size Guide criteria:
       ```
       FILE SIZE CHECK...
       OPTIMAL: optimal.py (324 lines) - Optimal for Claude
       WARNING: growing.py (847 lines) - Monitor for growth
       CRITICAL: large.py (1,247 lines) - EXCEEDS 1000 LINE LIMIT
       ```
   - **BLOCKING patterns (refuse save):**
     - API Keys: OpenAI (`sk-`), Anthropic (`sk-ant-`), AWS (`AKIA`)
     - Database URLs with embedded passwords
     - Private keys, JWT tokens with real signatures
   - **WARNING patterns (require confirmation):**
     - Hardcoded production URLs
     - Long alphanumeric strings near "key", "token", "secret"
   - If CRITICAL issues found:
     ```
     CRITICAL SECURITY ISSUES - SAVE BLOCKED

     EXPOSED CREDENTIALS DETECTED:
     1. File: [file:line]
        Issue: [description]
        Risk: [security risk]

     FILE SIZE VIOLATIONS:
     1. File: [file] ([line count] lines)
        Issue: Exceeds 1000-line limit for Claude Code
        Impact: Degraded Claude refactoring capability

     REQUIRED ACTIONS:
     1. Remove hardcoded credentials
     2. Use environment variables
     3. Refactor large files into smaller modules
     4. Run /claude-clean again after fixing
     ```
   - If HIGH warnings found, ask for explicit confirmation to continue

**Phase 2: Save Current Work**
4. **Commit All Changes:**
   - Stage all changes: `git add -A`
   - Create commit with security-aware message:
     ```
     wip: save work before clean session
     
     BRANCH: [current-branch-name]
     STATUS: Work in progress - saved via /claude-clean
     
     SECURITY SCAN: ✅ PASSED (or ⚠️ WARNINGS)
     - [Security scan summary]
     - Security report: .claude/security-clean-[timestamp].md
     
     FILES CHANGED:
     [List of modified files with brief descriptions]
     
     WARNINGS TO ADDRESS (if any):
     ⚠️ [Warning description and fix recommendation]
     
     Use /claude-start to resume work on this branch
     
     🤖 Generated with Claude Code - Security Enhanced
     Co-Authored-By: Claude <noreply@anthropic.com>
     ```
   - Push branch to remote: `git push origin [current-branch]` (create remote if needed)

5. **Preserve Branch Context with Security Status:**
   - Get current branch name and extract type: `feature/api-integration` → `feature-api-integration`
   - Create/update branch-specific file: `.claude/branch-context/[type]-[branch-name]-context.md`
   - Include timestamp, session state, and security scan results:
     ```markdown
     ## Security Status ✅
     **Last Scan**: [timestamp]
     **Status**: SAFE (or WARNINGS)
     **Findings**: [summary of any issues]
     
     ### Remediation Plan (if warnings exist)
     1. [Specific fixes needed]
     2. [Testing requirements]
     ```
   - Include security report path for later reference

**Phase 3: Clean Master Switch**
6. **Switch to Clean Master:**
   - `git checkout master`
   - `git pull origin master` (ensure up to date)
   - Verify switch was successful

7. **Clear Restart Context with Security Summary:**
   - Update CLAUDE.md restart context section to:
     ```markdown
     <!-- CLAUDE RESTART CONTEXT - [DATE] -->
     **🔄 CLEAN SESSION STATUS:**
     - **PREVIOUS WORK**: Saved to branch [branch-name] ✅
     - **SECURITY STATUS**: ✅ SAFE (or ⚠️ [X] warnings logged)
     - **CURRENT STATUS**: Clean master branch - ready for new work
     - **LAST SAVE**: [timestamp]
     
     **🔒 SECURITY SUMMARY:**
     - **Critical Issues**: 0 ✅
     - **Warnings**: [count] ([brief description if any])
     - **Report**: `.claude/security-clean-[timestamp].md`
     
     **📋 AVAILABLE ACTIONS:**
     - Start new feature: `/project:create-branch [requirements-doc]`
     - Resume previous work: `git checkout [branch-name]` then `/claude-start`
     - Fix security warnings: `/claude-commit --security-only`
     - Review completed work: Check `/todo/completed/` folders
     
     **🎯 Clean slate - ready for new development
     **⚠️ Reminder**: Address [X] security warnings in [branch] when resuming (if applicable)
     <!-- END CLAUDE RESTART CONTEXT -->
     ```

8. **Commit Clean State:**
   - Stage CLAUDE.md changes  
   - Commit with message: "session: clean start from [previous-branch] (security: [status])"
   - Push to master

**Phase 4: Confirmation & Summary**
9. **Success Summary:**
   - Display summary of actions taken:
     ```
     ✅ CLEAN SESSION STARTED
     
     📁 Previous Work Saved:
     - Branch: [branch-name]
     - Commit: [commit-hash]
     - Context: .claude/branch-context/[type]-[branch-name]-context.md
     
     🔒 Security Status:
     - Scan Result: [PASSED/WARNINGS]
     - Critical Issues: 0
     - Warnings: [count]
     - Report: .claude/security-clean-[timestamp].md
     
     🏠 Current Status:
     - Branch: master (clean)
     - Ready for: New feature development
     
     🔄 To Resume Previous Work:
     1. git checkout [branch-name]
     2. /claude-start
     
     ⚠️ Security Reminders (if applicable):
     - [List any warnings to address]
     
     ✨ Ready for clean development session!
     ```

**🛡️ SAFETY FEATURES:**

1. **Pre-execution Validation:**
   - Refuse to run if already on master
   - Warn about uncommitted changes before proceeding
   - Confirm action with user before any destructive operations
   - Verify git repository is in clean state

2. **Work Preservation:**
   - All changes committed before switching
   - Branch context saved for later recovery
   - Remote backup created automatically
   - Clear recovery instructions provided

3. **Error Handling:**
   - Check git operations for failures
   - Rollback on any error during process
   - Provide clear error messages with recovery steps
   - Never leave repository in inconsistent state

**🚫 BLOCKING CONDITIONS:**
- Currently on master branch
- Repository in middle of merge/rebase
- Git repository not initialized
- No remote configured (will create origin push)

**📝 EXAMPLE SESSION:**
```
User: /claude-clean
Claude: 
🔍 Current branch: feature/user-management
📝 Found 3 uncommitted files: UserList.tsx, UserAPI.py, README.md

⚠️  This will:
1. Commit all changes to feature/user-management
2. Switch to clean master branch  
3. Clear restart context for fresh session

Continue? (Y/N): Y

✅ Committing changes to feature/user-management...
✅ Pushing branch to remote...
✅ Switching to master...
✅ Clearing restart context...

🎯 Clean session ready! Previous work saved to feature/user-management
```

**🔗 INTEGRATION:**
- Works with existing `/claude-start` and `/claude-close` commands
- Compatible with `/project:*` workflow commands
- Preserves branch context for seamless resumption
- Maintains git best practices and safety

This command enables worry-free context switching while ensuring no work is ever lost.