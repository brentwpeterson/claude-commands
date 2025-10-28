Claude Session Close - Standardized Handoff System

**USAGE:**
- `/claude-close` - Standard session close with CLAUDE.md restart context update
- `/claude-close CLEAN` - Close session but leave CLAUDE.md unchanged for fresh feature start

**🔄 SAME PATTERN EVERY TIME:**
✅ **UPDATE EXISTING PROGRESS LOGS** - Find and append to current progress files
✅ **UPDATE EXISTING DOCUMENTATION** - Enhance current docs, don't create new ones
✅ **VERBOSE COMMIT** - Comprehensive commit message with session summary
✅ **UPDATE CLAUDE.MD HEADER** - Write restart context at the very top

**📋 STANDARDIZED CLOSE WORKFLOW:**

**Phase 1: Update Existing Progress Logs & Security Scan**
1. **🔍 Debug Log Validation & Normalization:**
   - Get current branch name: `git branch --show-current`
   - **CRITICAL: Save current working directory**: `pwd` output
   - Expected debug log name: `[branch-name]-debug.log`
   - Check current working directory for debug logs:
     - Look for `*debug*.log`, `*test*.log`, `*progress*.log` files
     - Look for files matching TEST ATTEMPT LOG format
   - **If wrong name found:**
     - Ask user: "Found debug log '[filename]' but expected '[branch-name]-debug.log'. Rename it? [Y/n]"
     - If yes, rename preserving content: `mv [old-name] [branch-name]-debug.log`
   - **If no debug log found:**
     - Create blank debug log: `[branch-name]-debug.log` in current working directory
     - Initialize with TEST ATTEMPT LOG template:
       ```
       ##############################################################################
       # TEST ATTEMPT LOG
       ##############################################################################
       # 1. YYYY-MM-DD HH:MM - [Description of security session close]
       # [Add additional entries as testing progresses]
       ##############################################################################
       ```
   - **CRITICAL: Document working directory for next session**

2. **Find Current Progress Files:**
   - Search `/todo/current/` for active progress logs (e.g., MVP-manyrequest-progress-log.md)
   - Look for existing technical documentation that needs updates
   - Identify any CHANGELOG.md entries that need current session info

2. **🔒 Run Comprehensive Security Scan (NEW):**
   - Perform full codebase security scan (~10-15 seconds):
     ```
     🔒 FINAL SECURITY VALIDATION...
     [████████████████████] 100% - Comprehensive codebase scan
     ```
   - Check for:
     - API keys and credentials (OpenAI, Anthropic, AWS, database URLs)
     - Hardcoded production URLs that should use environment variables
     - Private keys, JWT tokens, authentication secrets
   - Generate security report: `.claude/securuty-scans/security-session-end-[timestamp].md`
   - Track security improvements made during session

3. **Append Session Summary with Security Context:**
   - Add new entry to existing progress logs (don't create new files)
   - Include security scan results and any fixes made
   - Update current version in CHANGELOG.md with session accomplishments
   - Enhance existing technical docs with any new implementation details
   - Document security warnings for next session

**Phase 2: Update Existing Documentation & Branch Context**
4. **Enhance Current Documentation:**
   - Find relevant technical docs in `/documentation/docs/` that relate to current work
   - Update existing architecture docs if changes were made
   - Add to existing API documentation if endpoints were modified
   - **RULE: Enhance existing, don't create new unless absolutely necessary**

5. **🔀 Save Branch-Specific Context (NEW):**
   - Get current branch name: `git branch --show-current`
   - Extract branch type and name (e.g., `feature/api-integration` → `feature-api-integration`)
   - Create/update context file: `.claude/branch-context/[type]-[branch-name]-context.md`
   - Include comprehensive session summary:
     ```markdown
     # Branch Context: [full-branch-name]
     
     **Saved:** [timestamp] UTC via /claude-close
     **Last Commit:** [hash] - [commit message]
     **Security Status:** [score]/100 ([warnings] warnings)
     
     ## Work Completed ✅
     [Summary of what was accomplished]
     
     ## Work In Progress 🔄
     [Any partial implementations]
     
     ## Files Modified
     [List of key files changed]
     
     ## Security Findings
     [Any security warnings or fixes]
     
     ## Next Steps
     [What needs to be done next session]
     
     ## Documentation & Work Directory
     **📁 TODO Directory**: `/todo/current/[category]/[task-name]/` - [View README](file://[project-path]/todo/current/[category]/[task-name]/README.md)
     
     ## Recovery Instructions
     To resume work on this branch:
     ```bash
     git checkout [branch-name]
     /claude-start
     ```
     
     ## Status
     [ACTIVE/COMPLETE/BLOCKED] - [Brief status description]
     ```
   - This file will be read by `/claude-start` when resuming work

**Phase 3: Comprehensive Commit with Security Context**
6. **Create Verbose Commit Statement with Security Summary:**
   - Analyze all changed files in current session
   - Document what was accomplished and why
   - **Include security scan results and improvements made**
   - Include context for future developers/Claude sessions
   - Reference any ongoing work or next steps needed
   - Use structured format with clear sections including security status

7. **Commit All Work:**
   - Stage all changes: `git add .`
   - Create comprehensive commit with detailed message including security context
   - Ensure all session work is preserved in git history

**Phase 4: Update CLAUDE.md Header with Security Status (Standard Close Only)**
8. **Write Restart Context with Security Summary at Top of CLAUDE.md:**
   - **STANDARD CLOSE**: Insert session handoff info at very beginning of CLAUDE.md
   - **CLEAN CLOSE**: Skip this step - leave CLAUDE.md unchanged for fresh start
   - **CRITICAL: Include current working directory**: `pwd` output
   - **CRITICAL: Include branch name**: `git branch --show-current` output
   - **CRITICAL: Document debug log location**: `[branch-name]-debug.log (in working directory)`
   - Include specific next steps for `/claude-start`
   - Document current status of any ongoing processes
   - Keep format consistent and easy to parse

**🎯 WHAT GETS UPDATED (NOT CREATED):**
- **Existing Progress Logs**: Add session entry to current active logs
- **Current CHANGELOG.md**: Update current version section
- **Existing Technical Docs**: Enhance with new implementation details
- **Branch Context File**: `.claude/branch-context/[type]-[branch]-context.md` (created/updated)
- **CLAUDE.md Header**: Replace previous session context with current (Standard Close only)

**🧹 CLEAN CLOSE BEHAVIOR:**
- Skips CLAUDE.md restart context update
- Leaves CLAUDE.md in clean state for new feature work
- Still updates all progress logs, changelog, and documentation
- Still creates comprehensive commit message
- Use when switching to completely different feature/context

**📝 EXAMPLE PROGRESS LOG UPDATE:**
```markdown
## UPDATE: [Session Topic] (2025-07-27)

### Overview
[Brief summary of what was accomplished this session]

### Issues Addressed ✅
- [Specific problem 1]: [Solution implemented]
- [Specific problem 2]: [Solution implemented]

### Technical Implementation
[Key technical details for future reference]

### Next Steps
[What needs to happen in next session]

---
```

**🔧 CLAUDE.md HEADER FORMAT WITH SECURITY:**
```markdown
# Claude Code Guide for RequestDesk.ai

<!-- CLAUDE RESTART CONTEXT - 2025-07-27 15:30 -->
**🔄 LAST SESSION STATUS:**
- **Completed**: [What was finished]
- **In Progress**: [What's currently running/pending]
- **Next Priority**: [Most important next step]

**🔒 SECURITY STATUS:**
- **Critical Issues**: [count] (fixed: [count])
- **Warnings**: [count] (new: [count])
- **Security Score**: [score]/100 ([change] from session start)
- **Report**: `.claude/security-session-end-[timestamp].md`

**📋 IMMEDIATE NEXT STEPS FOR /claude-start:**
1. [Specific action with commands/URLs]
2. [Specific action with commands/URLs]
3. [Security-related action if warnings exist]

**🎯 Success Criteria**: [Clear definition of when next session is complete]
<!-- END CLAUDE RESTART CONTEXT -->

## CLAUDE CODE INSTRUCTIONS - READ FIRST
[Existing CLAUDE.md content continues...]
```

**🎯 COMMIT MESSAGE STRUCTURE WITH SECURITY:**
```
[type]: [session summary]

SESSION SUMMARY:
• [Major accomplishment 1]
• [Major accomplishment 2]
• [Major accomplishment 3]

SECURITY IMPROVEMENTS:
• Fixed: [count] critical issues
• Resolved: [specific security fixes]
• Identified: [count] warnings for future attention
• Security Score: [score]/100 ([change])

FILES UPDATED:
• [file1]: [what was changed and why]
• [file2]: [what was changed and why]

DOCUMENTATION UPDATES:
• [progress log]: Added session summary with security context
• [technical doc]: Enhanced with implementation details
• CHANGELOG.md: Updated current version
• Security Report: .claude/security-session-end-[timestamp].md

NEXT SESSION PRIORITIES:
• [Priority 1 with specific action needed]
• [Security warnings to address if any]
• [Priority 2 with specific action needed]

STATUS: [Current state - deployed/testing/debugging/etc.]

🤖 Generated with [Claude Code](https://claude.ai/code)
Co-Authored-By: Claude <noreply@anthropic.com>
```

**⚡ KEY PRINCIPLES:**
- **FIND existing files, don't create new ones**
- **APPEND to current progress logs**
- **ENHANCE existing documentation**
- **UPDATE current CHANGELOG version**
- **PRESERVE all work in comprehensive commit**
- **HANDOFF via CLAUDE.md header**

**🔍 FILE DISCOVERY PATTERNS:**
- Progress logs: `find /todo/current -name "*progress*.md"`
- Technical docs: `find /documentation -name "*.md" -mtime -7`
- Active changelogs: `CHANGELOG.md` (update current version)
- Implementation docs: Look for files related to current work

This ensures every session follows the exact same pattern while respecting existing project structure and documentation.