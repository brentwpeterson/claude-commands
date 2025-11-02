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

**Phase 2: Todo Directory Inventory Check**
3. **Verify Todo Directory Structure:**
   - **MANDATORY: Get current todo path** - Ask user if not obvious
   - **Check todo directory exists**: Verify `todo/current/[category]/[task-name]/` path
   - **Inventory check**: Count files and verify standardized 7-file structure:
     ```bash
     # Expected 7 files exactly:
     # 1. README.md
     # 2. [branch-name]-plan.md
     # 3. progress.log
     # 4. debug.log
     # 5. notes.md
     # 6. architecture-map.md
     # 7. user-documentation.md
     ```
   - **File count validation**: `ls -1 [todo-path] | wc -l` should return 7
   - **Missing file alert**: List any missing required files
   - **Extra file warning**: List any unexpected files (should only be the 7 standard files)
   - **Structure status**: Report "✅ Complete (7/7 files)" or "⚠️ Incomplete (X/7 files)"

**Phase 3: Create Handoff Instructions**
4. **Create Resume Instruction File:**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - Include todo inventory results in context
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
**Directory Structure:** [✅ Complete (7/7 files) or ⚠️ Incomplete (X/7 files) with missing files listed]

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

### Completion Trigger Protocol
**BEFORE declaring any task complete, Claude MUST:**
1. **Check for Acceptance Criteria**: Does the todo have clear acceptance criteria?
2. **If NO criteria exist**: STOP and ask user: "What are the acceptance criteria for this task?"
3. **If criteria exist**: Verify each criteria point is met
4. **Ask user**: "Task appears complete per acceptance criteria. Do you approve marking this as done?"
5. **Wait for explicit approval**: User must confirm completion

**Completion Requirements:**
- **Completed Items**: Only mark as completed if user has said "this is done" or "approved"
- **Context Indicator**: Always note "USER APPROVED: Yes" for completed items
- **Acceptance Criteria**: All todos MUST include clear acceptance criteria before completion
- **Criteria Check**: Read and verify ALL acceptance criteria before asking for approval

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

**Phase 4: Context Commit + Display Path**
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