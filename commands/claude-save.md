Claude Session Save - Create Resume Instructions + Preserve Work

**USAGE:** `/claude-save <project>` - Save work + create handoff instructions for next Claude session

**🎯 PURPOSE:**
Create comprehensive INSTRUCTION FILE for next Claude to resume exactly where you left off

**🚨 CRITICAL: NEVER ASSUME COMPLETION WITHOUT HUMAN CONFIRMATION 🚨**

**⚠️ ABSOLUTE PROHIBITION: NEVER SAY THESE PHRASES:**
- ❌ "Successfully completed"
- ❌ "Task finished"
- ❌ "Implementation complete"
- ❌ "Work done"
- ❌ "Ready for deployment"
- ❌ "Feature complete"
- ❌ Any variation suggesting work is finished

**🛑 MANDATORY BEHAVIOR:**
- **NEVER assume anything is done** - even if it appears to work
- **NEVER mark tasks complete** without explicit user approval
- **NEVER say "finished" or "completed"** - things may look done but haven't been tested
- **ALWAYS wait for user confirmation** before marking anything as complete
- **ASK EXPLICITLY**: "Is this task complete and ready to mark as done?"

**🚨 COMPLETION APPROVAL RULES:**
- **NEVER mark tasks as completed** without explicit user approval
- **Always ask user**: "Is this task complete and ready to mark as done?"
- **In context files**: Note "USER APPROVED: Yes" for any completed items
- **TodoWrite with Acceptance Criteria**: All todos must include clear completion criteria

**💀 WHY THIS IS CRITICAL:**
- Code may appear to work but hasn't been tested
- Integration points may have hidden issues
- Edge cases may not have been considered
- User requirements may not be fully met
- Only the human can confirm true completion

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
   - **Architecture Map Completeness Check**: Validate `architecture-map.md` is properly filled out:
     ```bash
     # Check for incomplete template markers:
     # - [TASK-NAME] should be replaced with actual task name
     # - [bracketed placeholders] should be filled with real paths/methods
     # - Completion checklist should have some items checked (- [x])
     # - Key sections should have content beyond template text
     ```
     - **Template validation**: Check if placeholder text `[TASK-NAME]`, `[path/to/`, `[describe` still exists
     - **Completion checklist**: Count checked items `- [x]` vs unchecked `- [ ]`
     - **Content analysis**: Verify key sections have actual content, not just template text
     - **Architecture status**: Report "✅ Complete" or "⚠️ Template" or "⚠️ Partial ([X]/[Y] checklist items)"

   - **🚨 CRITICAL: Validate /update-architecture Has Been Run**:
     - **Check for outdated architecture map**: Compare git changes vs architecture map content
     - **Get current changes**: Run `git status --porcelain` and `git diff --name-only HEAD~1`
     - **Validate architecture freshness**:
       ```bash
       # If git shows modified files BUT architecture-map.md still has:
       # - Template placeholders like [TASK-NAME], [path/to/, [describe
       # - Generic template text instead of actual file paths
       # - Missing CB flow documentation for current changes
       # = ARCHITECTURE MAP IS OUTDATED
       ```
     - **Outdated architecture map detection**:
       - **Template markers present**: `[TASK-NAME]`, `[path/to/`, `[describe` still exist
       - **Missing actual files**: Git shows changes but architecture map doesn't reference them
       - **Generic content**: Architecture map has template text instead of real implementation details

     - **🚫 SAVE BLOCKED - Require /update-architecture First**:
       ```
       ⚠️ ARCHITECTURE MAP OUTDATED - SAVE BLOCKED

       Git shows file changes but architecture-map.md appears outdated:

       Modified Files Detected:
       - frontend/src/UserList.tsx
       - backend/app/routers/users.py
       - backend/app/services/user_service.py

       But architecture-map.md still contains:
       - Template placeholders: [TASK-NAME], [path/to/
       - No reference to actual modified files
       - Generic template content

       🔧 REQUIRED ACTION:
       Run `/update-architecture` first to document current changes
       Then retry `/claude-save`

       This ensures next Claude session has complete modification trail.
       ```

     - **Architecture validation passed**: Architecture map contains actual file paths and CB flow documentation
     - **CRITICAL PURPOSE**: Ensures session handoffs include complete, current technical context

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
**Architecture Map:** [✅ Complete and Current or ⚠️ Template or ⚠️ Partial (X/Y checklist items) or 🚫 OUTDATED - /update-architecture required]

## WHAT YOU WERE WORKING ON
[Clear description of the task in progress]

## CURRENT STATE
- **Last command executed:** [exact command]
- **Files modified:** [list with status and CB layer mapping]
- **CB Flow Impact:** [trace: frontend-file → dataProvider → router → service → model → collection]
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
**🚫 CLAUDE CAN NEVER DECLARE TASKS COMPLETE - ONLY HUMANS CAN**

**BEFORE asking about completion, Claude MUST:**
1. **Check for Acceptance Criteria**: Does the todo have clear acceptance criteria?
2. **If NO criteria exist**: STOP and ask user: "What are the acceptance criteria for this task?"
3. **If criteria exist**: Verify each criteria point is met
4. **🚨 NEVER DECLARE COMPLETION - ASK FOR USER APPROVAL**:
   - **NEVER SAY**: "Task is complete" or "Implementation finished"
   - **ALWAYS ASK**: "Based on the acceptance criteria, does this appear ready for you to mark as complete?"
   - **WAIT FOR EXPLICIT CONFIRMATION**: User must say "yes", "complete", "done", or "approved"
   - **IF UNCERTAIN**: Ask "Should I mark this as complete?" and wait for response
5. **🔍 WHAT TO LOOK FOR IN USER RESPONSES**:
   - **Completion approved**: "yes", "done", "complete", "mark it complete", "approved"
   - **NOT completion**: "looks good", "almost there", "getting close", "seems right"
   - **When in doubt**: Ask for clarification

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

**Phase 5: OpenMemory Integration (Automatic with Fallback)**
6. **Store Session Summary to OpenMemory:**
   - **Check OpenMemory server availability:**
     ```bash
     curl -s http://localhost:8080/health 2>/dev/null
     ```

   - **If server available (automatic):**
     ```bash
     cd /Users/brent/scripts/CB-Workspace/cb-memory-system
     ./scripts/store-memory.sh "Session saved for [project-name] on [branch-name]. Work: [brief-summary]" \
       '["session:YYYY-MM-DD", "project:[project-name]", "branch:[branch-name]", "context-save"]' \
       '{"todo_status": "[todo-structure-status]", "files_changed": [count], "architecture_status": "[architecture-status]"}'
     ```

   - **If server not available (fallback):**
     ```
     ⚠️ OpenMemory server not running - using file-based context only
     💡 Start server: cd /Users/brent/scripts/OpenMemory/backend && npm run dev
     ✅ Session still saved to context file successfully
     ```

   - **Session Summary Format for Memory:**
     - **Content**: "Session saved for [project] on [branch]. [What was accomplished]. [Current focus]. [Next priority]."
     - **Tags**: `["session:YYYY-MM-DD", "project:[name]", "branch:[name]", "context-save"]`
     - **Metadata**: `{"todo_status": "7/7", "files_changed": 3, "architecture_status": "current"}`

7. **END BY SHOWING CONTEXT FILE PATH:**
   - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
   - Display: "📁 Resume instructions saved to: `.claude/branch-context/[branch-name]-context.md`"
   - **If OpenMemory worked**: "🧠 + Session stored to intelligent memory system"
   - **If OpenMemory failed**: "⚠️ (OpenMemory unavailable - file-based only)"

**🎯 KEY CHANGES:**
- **Creates INSTRUCTION FILE** instead of status report
- **Ends with context file path** for next session
- **Includes everything needed** for immediate resume
- **Ready for `/claude-start` to read and execute**

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save <project>` → Creates instruction file, shows path
2. `/clear new` → Clear current session
3. `/claude-start <project>` → Reads instruction file and resumes