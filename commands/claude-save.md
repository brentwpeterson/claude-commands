Claude Session Save - Create Resume Instructions + Preserve Work

**USAGE:** `/claude-save <project>` - Save work + create handoff instructions for next Claude session

**🎯 PURPOSE:**
Create comprehensive INSTRUCTION FILE for next Claude to resume exactly where you left off

**🚨 COMPLETION APPROVAL RULES:**
- **NEVER mark tasks as completed** without explicit user approval
- **Always ask user**: "Is this task complete and ready to mark as done?"
- **In context files**: Note "USER APPROVED: Yes" for any completed items
- **TodoWrite with Acceptance Criteria**: All todos must include clear completion criteria

**📋 COMPLETE SAVE WORKFLOW:**

**Phase 1: Work Preservation**
1. **Check Development Status:**
   - Run `git status` to capture exact file states
   - Analyze changes to understand what work was completed
   - Ensure no sensitive files (.env, keys, etc.) are included

2. **Commit Development Work:**
   - Stage all relevant development files: `git add [relevant-files]`
   - Create descriptive commit message based on changes
   - Format: `git commit -m "[Description of work completed] 🤖 Generated with Claude Code"`
   - **IMPORTANT**: Commit actual development work FIRST before context

**Phase 2: Create Handoff Instructions**
3. **Create Resume Instruction File:**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - **MANDATORY: Get current todo path** - Ask user if not obvious
   - Check running processes: `docker ps`, `lsof -i :3000`, etc.
   - Create: `.claude/branch-context/[branch-name]-context.md`
   - **Format as INSTRUCTIONS TO CLAUDE**, not status report:

```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd [exact-working-directory]`
2. **Verify git status:** `git status` (expect: [list files])
3. **Check processes:** `docker ps` (expect: [containers running])
4. **Verify branch:** `git branch --show-current` (should be: [branch])

## CURRENT TODO FILE
**Path:** file:[exact-path-to-todo-readme]
**Status:** [Working on step X of Y - specific current focus]

## WHAT YOU WERE WORKING ON
[Clear description of the task in progress]

## CURRENT STATE
- **Last command executed:** [exact command]
- **Files modified:** [list with status]
- **Tests run:** [what was tested, results]
- **Issues found:** [any blockers or problems]

## TODO LIST STATE
[Current TodoWrite items with exact status]
- ✅ COMPLETED: [task] (USER APPROVED: Yes/No)
- 🔄 IN PROGRESS: [task]
- ⏳ PENDING: [task]

## COMPLETION APPROVAL STATUS
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves
- **Completed Items**: Only mark as completed if user has said "this is done" or "approved"
- **Context Indicator**: Always note "USER APPROVED: Yes" for completed items
- **Acceptance Criteria**: All todos should include clear acceptance criteria for completion

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** [exact command to run]
2. **THEN:** [next command]
3. **VERIFY:** [how to check it worked]

## VERIFICATION COMMANDS
- Check feature: [command]
- Test endpoint: [curl/url]
- View logs: [log command]

## CONTEXT NOTES
[Any important details, gotchas, or background]
```

4. **Update CLAUDE.md Header (Optional):**
   - Add brief status to project CLAUDE.md if needed
   - Keep minimal - main instructions are in context file

**Phase 3: Context Commit + Display Path**
5. **Commit Instructions:**
   - Stage context files: `git add ../.claude/branch-context/`
   - Commit with: "Save resume instructions for session restart"

6. **END BY SHOWING CONTEXT FILE PATH:**
   - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
   - Display: "📁 Resume instructions saved to: `.claude/branch-context/[branch-name]-context.md`"

**🎯 KEY CHANGES:**
- **Creates INSTRUCTION FILE** instead of status report
- **Ends with context file path** for next session
- **Includes everything needed** for immediate resume
- **Ready for `/claude-start` to read and execute**

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save <project>` → Creates instruction file, shows path
2. `/clear new` → Clear current session
3. `/claude-start <project>` → Reads instruction file and resumes