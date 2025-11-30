Claude Session Save - Create Resume Instructions + Preserve Work

**USAGE:**
- `/claude-save <project>` - Full comprehensive save with validation
- `/claude-save <project> --quick` - Fast save with minimal context usage (skips validation)

**🗂️ PROJECT-TO-DIRECTORY MAPPING:**
```
| Project Name   | Directory Path                                          |
|----------------|--------------------------------------------------------|
| requestdesk    | /Users/brent/scripts/CB-Workspace/cb-requestdesk       |
| astro-sites    | /Users/brent/scripts/CB-Workspace/astro-sites          |
| shopify        | /Users/brent/scripts/CB-Workspace/cb-shopify           |
| wordpress      | /Users/brent/scripts/CB-Workspace/cb-wordpress         |
| magento        | /Users/brent/scripts/CB-Workspace/cb-magento           |
| junogo         | /Users/brent/scripts/CB-Workspace/cb-junogo            |
| memory-system  | /Users/brent/scripts/CB-Workspace/cb-memory-system     |
| jobs           | /Users/brent/scripts/CB-Workspace/jobs                 |
```

**🚨 CRITICAL: Always use this mapping to resolve project names to full paths!**
- If project name not in mapping, ASK USER for the correct path
- NEVER guess or assume directory locations

**🗂️ CRITICAL PATH DEFINITION:**
```
WORKSPACE_ROOT = /Users/brent/scripts/CB-Workspace
CONTEXT_DIR    = /Users/brent/scripts/CB-Workspace/.claude/branch-context/
CONTEXT_FILE   = /Users/brent/scripts/CB-Workspace/.claude/branch-context/[branch-name]-context.md
```
**⚠️ ALWAYS use absolute paths. The `.claude/` directory is at WORKSPACE ROOT, NOT inside individual project directories.**

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
3. **Todo Directory Detection:**

   **🚀 QUICK MODE (--quick flag):**
   ```bash
   # Minimal todo detection with single command
   TODO_PATH=$(find . -path "*/todo/current/*" -name "README.md" | head -1)
   FILE_COUNT=$(dirname "$TODO_PATH" | xargs ls -1 | wc -l 2>/dev/null || echo "0")
   echo "Todo: ${TODO_PATH:-'None found'} (${FILE_COUNT} files)"
   ```

   **📋 FULL MODE (default):**
   - **MANDATORY: Get current todo path** - Ask user if not obvious
   - **Check todo directory exists**: Verify `todo/current/[category]/[task-name]/` path
   - **Verify README.md Branch Reference**: Ensure README.md shows current git branch:
     ```bash
     CURRENT_BRANCH=$(git branch --show-current)
     if [ -f "todo/current/[category]/[task]/README.md" ]; then
       if ! grep -q "**Branch:** $CURRENT_BRANCH" "todo/current/[category]/[task]/README.md"; then
         echo "⚠️ README.md shows incorrect branch - updating before save..."
         sed -i.bak "s/\*\*Branch:\*\* .*/\*\*Branch:\*\* $CURRENT_BRANCH/" "todo/current/[category]/[task]/README.md"
         echo "✅ Updated README.md to show current branch: $CURRENT_BRANCH"
       fi
     fi
     ```
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

   - **Quick Architecture Status** (for context only):
     - Note if project is external (cb-shopify, cb-junogo, astro-sites) or CB internal
     - Simple status check - don't validate completeness during save

**Phase 3: Create Handoff Instructions**
4. **Create Resume Instruction File:**

   **🚀 QUICK MODE (--quick flag):**
   ```bash
   # Single efficient context creation
   BRANCH=$(git branch --show-current)
   KEYWORD=${1:-$(echo $BRANCH | sed 's/\//-/g')}
   TODO_PATH=$(find . -path "*/todo/current/*" -name "README.md" | head -1)

   cat > /Users/brent/scripts/CB-Workspace/.claude/branch-context/${KEYWORD}-context.md << EOF
   # Resume Instructions for Claude

   ## IMMEDIATE SETUP
   1. **Directory:** \`cd $(pwd)\`
   2. **Branch:** \`git checkout $BRANCH\`
   3. **Status:** $(git status --porcelain | wc -l) files changed

   ## CURRENT TODO
   **Path:** ${TODO_PATH:-"No todo found"}
   **Status:** [Current work focus]

   ## WORKING ON
   [Brief description of current task]

   ## NEXT ACTIONS
   1. **FIRST:** [Next command to run]
   2. **THEN:** [Follow-up action]

   ## NOTES
   [Important context]
   EOF
   ```

   **📋 FULL MODE (default):**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - Include todo inventory results in context
   - Check running processes: `docker ps`, `lsof -i :3000`, etc.
   - Create: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[keyword]-context.md`
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
**Directory Structure:** [✅ Complete (7/7 files) or ⚠️ Incomplete (X/7 files)]
**Architecture Map:** [Project type and basic status - full validation on resume]

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
   - Stage context files: `git add /Users/brent/scripts/CB-Workspace/.claude/branch-context/`
   - Commit with: "Save resume instructions for session restart"

**Phase 5: Official MCP Memory Integration (Automatic with Fallback)**
6. **Store Session Summary to Official Anthropic MCP Memory Server:**
   - **Check official MCP memory server availability:**
     Try to use `mcp__memory__search_nodes` with a simple query to test connectivity
     **⚠️ NEVER use `mcp__memory__read_graph` - it returns massive token dumps (~14k+)**

   - **If MCP available (automatic):**
     Use `mcp__memory__create_entities` tool with:
     ```
     entities: [
       {
         "name": "Session-YYYY-MM-DD-[keyword]",
         "entityType": "session",
         "observations": [
           "Session saved for [keyword] work",
           "Branch: [current-branch]",
           "Work: [brief-summary]",
           "Todo status: [todo-structure-status]",
           "Files changed: [count]",
           "Architecture status: [architecture-status]"
         ]
       }
     ]
     ```

   - **If MCP not available (fallback):**
     ```
     ⚠️ Official MCP Memory Server not available - using file-based context only
     💡 MCP should be configured in .mcp.json with @modelcontextprotocol/server-memory
     ✅ Session still saved to context file successfully
     ```

   - **Session Entity Format for Memory:**
     - **Name**: "Session-YYYY-MM-DD-[keyword]"
     - **Type**: "session"
     - **Observations**: Current state, accomplishments, next steps

7. **END BY SHOWING CONTEXT FILE PATH:**
   - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
   - Display: "📁 Resume instructions saved to: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[keyword]-context.md`"
   - **If MCP worked**: "🧠 + Session stored to official MCP memory server"
   - **If MCP failed**: "⚠️ (Official MCP unavailable - file-based only)"

**🧠 OFFICIAL MCP MEMORY SERVER BEST PRACTICES:**
- **✅ USE**: `mcp__memory__search_nodes` for targeted queries - efficient and focused
- **❌ AVOID**: `mcp__memory__read_graph` - returns massive token dumps (~14k+) that fill context quickly
- **Search Examples**: "Session-2025-11-17-keyword", "project-name recent", "authentication issues"
- **Entity Naming**: Use "Session-YYYY-MM-DD-[keyword]" format for consistency
- **Observations**: Keep concise (1-2 sentences each) to prevent token bloat
- **Benefits**: Cross-session continuity, pattern discovery, intelligent context bridging

**🎯 KEY CHANGES:**
- **Creates INSTRUCTION FILE** instead of status report
- **Ends with context file path** for next session
- **Includes everything needed** for immediate resume
- **Ready for `/claude-start` to read and execute**

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save <project>` → Creates instruction file, shows path
2. `/clear new` → Clear current session
3. `/claude-start <project>` → Reads instruction file and resumes

**⚡ CONTEXT OPTIMIZATION:**

**When to use each mode:**
- **`/claude-save keyword --quick`** → Fast saves (2-3% context usage)
- **`/claude-save keyword`** → Comprehensive saves (8-13% context usage)

**Context Usage Comparison:**
- **Full mode**: Comprehensive validation, detailed context (~13% context)
- **Quick mode**: Essential validation, template context (~3% context)

**Quick mode skips:**
- ❌ Detailed todo directory validation
- ❌ Architecture map completeness checking
- ❌ Multiple file update operations
- ❌ Verbose bash command outputs
- ❌ Complex MCP memory operations

**Quick mode includes:**
- ✅ Git commit with changes
- ✅ Basic todo detection
- ✅ Essential context template
- ✅ Branch and directory capture