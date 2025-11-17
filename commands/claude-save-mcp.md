Claude Session Save with MCP Verification - Create Resume Instructions + Preserve Work

**USAGE:** `/claude-save-mcp <project>` - Verify MCP + Save work + create handoff instructions for next Claude session

**🎯 PURPOSE:**
Verify OpenMemory MCP server is working, then create comprehensive INSTRUCTION FILE for next Claude to resume exactly where you left off

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

**Phase 0: MCP Verification (NEW)**
1. **Test Official Anthropic MCP Memory Server:**
   - **Test MCP connectivity:** Use `mcp__memory__search_nodes` with simple query to verify connection
   - **⚠️ NEVER use `mcp__memory__read_graph` - it returns massive token dumps (~14k+)**
   - **Expected result:** Should return search results (even if empty) without errors
   - **If MCP fails:**
     ```
     ❌ Official Anthropic MCP Memory Server Connection Failed!

     🔧 Troubleshooting Steps:
     1. Check Claude Code MCP configuration in .mcp.json
     2. Verify official memory server is configured: @modelcontextprotocol/server-memory
     3. Restart Claude Code to reload MCP connections
     4. Check memory file exists: /Users/brent/scripts/CB-Workspace/.claude/cb-workspace-memory.json

     ⏸️ STOPPING SAVE - Fix official MCP first, then retry /claude-save-mcp
     ```
   - **If MCP succeeds:**
     ```
     ✅ Official Anthropic MCP Memory Server Connected Successfully!
     🧠 Knowledge graph storage ready - multi-window safe
     📋 Proceeding with official MCP save workflow...
     ```

2. **Test Memory Operations:**
   - **Create test entity:** Use `mcp__memory__create_entities` to store test data
   - **Query test data:** Use `mcp__memory__search_nodes` to verify retrieval works
   - **Report status:** "🧠 Official MCP fully operational - knowledge graph storage/retrieval confirmed"

**Phase 1: Work Preservation**
3. **Check Development Status:**
   - Run `git status` to capture exact file states
   - Analyze changes to understand what work was completed
   - Ensure no sensitive files (.env, keys, etc.) are included

4. **Commit Development Work:**
   - Stage all relevant development files: `git add [relevant-files]`
   - Create descriptive commit message based on changes
   - Format: `git commit -m "[Description of work completed] 🤖 Generated with Claude Code"`
   - **IMPORTANT**: Commit actual development work FIRST before context

**Phase 2: Todo Directory Inventory Check**
5. **Verify Todo Directory Structure:**
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
6. **Create Resume Instruction File:**
   - Get current branch: `git branch --show-current`
   - Get working directory: `pwd`
   - Include todo inventory results in context
   - Check running processes: `docker ps`, `lsof -i :3000`, etc.
   - Create: `.claude/branch-context/[branch-name]-context.md`
   - **Format as INSTRUCTIONS TO CLAUDE**, not status report:

```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Verify MCP first:** Run `/claude-save-mcp` initial MCP test or use `mcp__memory__search_nodes` tool with simple query
2. **Change directory:** `cd [exact-working-directory]`
3. **Verify git status:** `git status` (expect: [list files])
4. **Check processes:** `docker ps` (expect: [containers running])
5. **Verify branch:** `git branch --show-current` (should be: [branch])

## MCP STATUS
**Official Anthropic MCP Memory Server:** ✅ Verified working during save
**Memory Storage:** ✅ Session stored in knowledge graph format
**MCP Tools Available:** Create entities/relations, Search nodes, Read graph

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

7. **Update CLAUDE.md Header (Optional):**
   - Add brief status to project CLAUDE.md if needed
   - Keep minimal - main instructions are in context file

**Phase 4: Context Commit + Display Path**
8. **Commit Instructions:**
   - Stage context files: `git add ../.claude/branch-context/`
   - Commit with: "Save resume instructions for session restart"

**Phase 5: Official MCP-Only Memory Storage**
9. **Store Session Summary to Official Anthropic MCP Memory Server:**
   - **🚨 NO FALLBACKS - OFFICIAL MCP REQUIRED:**
     - This command ONLY works with official Anthropic MCP
     - If MCP failed in Phase 0, this command should have stopped
     - No file-based context, no HTTP API fallback

   - **Use official MCP tools for storage:**
     Use `mcp__memory__create_entities` tool with:
     ```
     entities: [
       {
         "name": "Session-YYYY-MM-DD-[project]-[branch]",
         "entityType": "session",
         "observations": [
           "Session saved for [project] on [branch]",
           "[What was accomplished]",
           "[Current focus]",
           "[Next priority]"
         ]
       }
     ]
     ```

   - **Query verification:**
     Use `mcp__memory__search_nodes` with: "Session-YYYY-MM-DD project [name]" to verify storage

   - **Success confirmation:**
     ```
     ✅ Session stored to Official Anthropic MCP Memory Server ONLY
     🧠 Knowledge graph updated with session entity
     🔍 Searchable via MCP tools: mcp__memory__search_nodes
     ℹ️ Multi-window safe - no SQLite locking issues
     ```

10. **END BY SHOWING CONTEXT FILE PATH:**
    - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
    - Display: "📁 Resume instructions saved to: `.claude/branch-context/[branch-name]-context.md`"
    - **MCP Status**: "🧠 ✅ Session stored EXCLUSIVELY to Official Anthropic MCP Memory Server"
    - **Multi-Window Safe**: "⚡ Knowledge graph storage - no SQLite locking issues"

**🎯 KEY DIFFERENCES FROM /claude-save:**
- **🔍 Pre-flight MCP verification** - tests MCP connectivity before any save operations
- **🧠 MCP-ONLY storage** - NO fallbacks to file-based context, MCP is required
- **🛡️ Fail-fast approach** - stops immediately if MCP doesn't work
- **⚡ Guaranteed intelligent memory** - ensures OpenMemory storage or fails completely
- **📋 Enhanced resume instructions** - includes MCP verification in resume steps

**📊 COMMAND COMPARISON:**

| Command | MCP Required | Fallback Strategy | Use Case |
|---------|--------------|-------------------|----------|
| `/claude-save` | Optional | File-based context always works | General saves, MCP uncertainty |
| `/claude-save-mcp` | **REQUIRED** | **NO FALLBACKS** - MCP or fail | Guaranteed intelligent memory |

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save-mcp <project>` → Tests MCP first, fails if broken, stores ONLY to MCP memory
2. `/clear new` → Clear current session
3. `/claude-start <project>` → Reads instruction file, verifies MCP, and resumes with intelligent context

**🚀 WHEN TO USE /claude-save-mcp:**
- **Session start verification**: Run early to ensure MCP works before heavy development
- **Critical projects**: When intelligent cross-project memory is essential
- **Pre-context-limit saves**: Before token limits when you need guaranteed memory handoff
- **Quality assurance**: When you want to ensure memory system is operational

**🚀 WHEN TO USE /claude-save (regular):**
- **MCP uncertainty**: When you're not sure if MCP is working
- **Backup scenarios**: When you want file-based context as primary/fallback
- **Simple projects**: When basic context files are sufficient

**🧠 OFFICIAL MCP MEMORY SERVER BEST PRACTICES:**
- **✅ USE**: `mcp__memory__search_nodes` for targeted queries - efficient and focused
- **❌ AVOID**: `mcp__memory__read_graph` - returns massive token dumps (~14k+) that fill context quickly
- **Search Examples**: "Session-2025-11-17-keyword", "project-name recent", "authentication issues"
- **Entity Naming**: Use "Session-YYYY-MM-DD-[keyword]" format for consistency
- **Observations**: Keep concise (1-2 sentences each) to prevent token bloat
- **Benefits**: Cross-session continuity, pattern discovery, intelligent context bridging
- **Multi-Window Safe**: Knowledge graph approach prevents SQLite locking issues