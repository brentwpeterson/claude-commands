Claude Session Save - Create Resume Instructions + Preserve Work

# 🚨🚨🚨 ABSOLUTE RULE #1: NEVER ASK QUESTIONS DURING SAVE 🚨🚨🚨

**THIS IS THE MOST IMPORTANT RULE - VIOLATIONS CAUSE SESSION LOSS**

❌ **NEVER DO THIS DURING /claude-save:**
- Ask about time tracking
- Ask if task is complete
- Ask for clarification on anything
- Wait for user response
- Read active-task.md or other files for questions

✅ **ONLY DO THIS:**
- Save context from conversation memory
- Write the context file
- Exit immediately

**WHY:** Asking questions uses context tokens. If you're already low on context when saving, questions will cause auto-compact and LOSE THE SESSION. This has happened multiple times.

**DEFER ALL QUESTIONS TO /claude-start** - that's when context is fresh.

---

**USAGE:**
- `/claude-save <project>` - Full comprehensive save with validation
- `/claude-save <project> --quick` - Fast save with minimal context usage (skips validation)
- `/claude-save <project> --close` - Formal session close with security scan and CLAUDE.md update
- `/claude-save <project> --no-todo` - Save without linking to todo directory (for ad-hoc work)
- `/claude-save <project> <X%>` - Context-aware save (e.g., `/claude-save requestdesk 9%`)

**🚨 CONTEXT-AWARE SAVE MODES (CRITICAL - READ FIRST):**

| Context % | Mode | Behavior |
|-----------|------|----------|
| **>15%** | FULL | All tasks: git ops, context files, memory, verbose summaries |
| **8-15%** | QUICK | Essential only: brief context, minimal git output, skip verbose ops |
| **<8%** | EMERGENCY | JUST save context - NO git reads, NO tests, pure context dump |

---

## 🔒 CLOSE MODE (`--close` flag)

**When to use:** End of work session, switching to different project, formal handoff.

**What `--close` adds beyond normal save:**

1. **Comprehensive Security Scan:**
   - Scan all staged/modified files for credentials
   - Check for API keys (OpenAI, Anthropic, AWS, GitHub)
   - Detect hardcoded URLs, database credentials, JWT tokens
   - Generate security report if issues found
   - **BLOCK close if CRITICAL security issues detected**

2. **Update CLAUDE.md Header:**
   - Add `## LAST SESSION STATUS` section at top of project's CLAUDE.md
   - Include: branch, last commit, next steps, any blockers
   - Format for quick context recovery on next session

3. **Progress Log Final Entry:**
   - Add formal "SESSION CLOSED" entry to progress.log
   - Include timestamp, session duration if known, summary

4. **Verbose Commit:**
   - Comprehensive commit message with session summary
   - List all files changed, features worked on
   - Note any incomplete work or known issues

**Close Mode Workflow:**

```
1. Run security scan
   ├─ CRITICAL issues → STOP, show issues, require fix
   └─ No issues → Continue

2. Normal save operations (Phase 1-4)

3. Update CLAUDE.md header:
   ## LAST SESSION STATUS - [DATE]
   **Branch:** [branch-name]
   **Last Commit:** [hash] [message]
   **Status:** [summary]
   **Next Steps:** [1-3 priority actions]

4. Add progress.log entry:
   [DATE TIME] - SESSION CLOSED
   Summary: [work completed]
   Next: [what to do on resume]

5. Verbose commit:
   Session close: [summary]

   Changes:
   - [file1]: [what changed]
   - [file2]: [what changed]

   Next session:
   - [action 1]
   - [action 2]

6. Show completion:
   ✅ Session closed
   📁 Context: [path]
   🔒 Security: Passed
   📝 CLAUDE.md: Updated
```

---

**⚡ EMERGENCY MODE (<8% context) - IMMEDIATE ACTION:**

When context % is passed and is <8%, SKIP ALL OTHER INSTRUCTIONS and do ONLY this:

1. **DO NOT run any bash commands except ONE:**
   ```bash
   git branch --show-current
   ```

2. **Write emergency context file IMMEDIATELY from conversation memory:**
   - What branch we're on (from the one command above)
   - What we were working on (from YOUR memory of this conversation)
   - What's left to do (from YOUR memory of pending todos)
   - Key files modified (from YOUR memory, NOT git diff)
   - Any critical state (tokens, IDs, test results from memory)

3. **Use this minimal template:**
   ```markdown
   # EMERGENCY CONTEXT SAVE - [DATE]

   ## CRITICAL: LOW CONTEXT SAVE
   This save was triggered with <8% context remaining. Minimal validation performed.

   ## BRANCH
   [branch-name]

   ## DIRECTORY
   [project directory from conversation context]

   ## WHAT WE WERE DOING
   [From conversation memory - what task was in progress]

   ## PENDING TODOS
   [From conversation memory - what's still pending]

   ## KEY FILES MODIFIED THIS SESSION
   [From conversation memory - files you remember editing/creating]

   ## CRITICAL STATE TO PRESERVE
   [Any tokens, IDs, test results, error messages from conversation]

   ## NEXT STEPS
   [What should happen next when resuming]
   ```

4. **Write the file and STOP:**
   - Path: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[project]-emergency-context.md`
   - DO NOT commit (saves context tokens)
   - DO NOT run MCP memory operations
   - DO NOT validate anything
   - Just output: "🚨 Emergency context saved to: [path]"

**WHY EMERGENCY MODE EXISTS:**
- Auto-compact can trigger mid-save causing context loss
- At <8%, there's not enough tokens left for full save operations
- Preserving SOME context is better than losing everything
- Next session can restore and do proper cleanup

---

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
| brent-workspace| /Users/brent/scripts/CB-Workspace/brent-workspace      |
```

**🚨 CRITICAL: Always use this mapping to resolve project names to full paths!**
- If project name not in mapping, ASK USER for the correct path
- NEVER guess or assume directory locations

---

## 🕐 DEFERRED QUESTIONS (brent-workspace only)

**🚨 CRITICAL: NEVER ASK QUESTIONS DURING SAVE - YOU WILL RUN OUT OF CONTEXT 🚨**

**When project = `brent-workspace`:**
- **DO NOT** ask for time tracking
- **DO NOT** ask if task is complete
- **DO NOT** read active-task.md
- **DO NOT** wait for any user response
- **JUST SAVE** and defer questions to `/claude-start`

In the context file, add a `## DEFERRED QUESTIONS` section:

```markdown
## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on [task name]?"
   - Task: [describe from conversation memory]
   - Date: [today's date]
2. **Task status:** "Is [task name] complete or continuing?"
```

**Rules:**
- **NEVER ask these questions during save** - burns context when you need it most
- **NEVER wait for responses** - save and exit immediately
- **NEVER read active-task.md during save** - wastes tokens
- **claude-start will ask** when context is fresh

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
   LAST_COMMIT=$(git log --oneline -1)

   cat > /Users/brent/scripts/CB-Workspace/.claude/branch-context/${KEYWORD}-context.md << EOF
   # Resume Instructions for Claude

   ## IMMEDIATE SETUP
   1. **Directory:** \`cd $(pwd)\`
   2. **Branch:** \`git checkout $BRANCH\`
   3. **Last Commit:** \`$LAST_COMMIT\`
   4. **Status:** $(git status --porcelain | wc -l) files changed

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
   - Get last commit: `git log --oneline -1`
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

## SESSION METADATA
**Last Commit:** `[hash] [message]`
**MCP Entity:** `[project]-[branch-short-name]`
**Saved:** [YYYY-MM-DD HH:MM]

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

**Phase 4.5: Link Context to Todo Progress Log (Full & Quick modes only)**
6. **Update Progress Log with Context File Reference:**
   - **Skip if:** `--no-todo` flag passed, OR emergency mode (<8%), OR no todo directory found
   - **If todo directory exists:**
     ```bash
     TODO_DIR=$(dirname "$TODO_PATH")
     CONTEXT_FILE="[context-filename].md"
     echo "$(date '+%Y-%m-%d %H:%M') - SESSION SAVED → .claude/branch-context/${CONTEXT_FILE}" >> "$TODO_DIR/progress.log"
     ```
   - **Why:** Links todo work history to context files, making it easy to find the most recent/valid context
   - **Format:** `YYYY-MM-DD HH:MM - SESSION SAVED → .claude/branch-context/[filename].md`

**Phase 5: Official MCP Memory Integration (Automatic with Fallback)**
7. **Store Session Summary to Official Anthropic MCP Memory Server:**
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

8. **END BY SHOWING CONTEXT FILE PATH:**
   - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
   - Display: "📁 Resume instructions saved to: `/Users/brent/scripts/CB-Workspace/.claude/branch-context/[keyword]-context.md`"
   - **If todo linked**: "📝 + Linked in progress.log"
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
- **`/claude-save keyword`** → Full saves when context >15% (~8-13% context usage)
- **`/claude-save keyword --quick`** OR **`/claude-save keyword 12%`** → Quick saves 8-15% (~2-3% context usage)
- **`/claude-save keyword 5%`** → Emergency saves <8% (~1% context usage, memory-only)

**Context Usage Comparison:**
| Mode | Context Used | Progress.log Link | When to Use |
|------|-------------|-------------------|-------------|
| **Full** | ~8-13% | ✅ Yes | >15% remaining, normal end of session |
| **Quick** | ~2-3% | ✅ Yes | 8-15% remaining, or when --quick flag passed |
| **Emergency** | ~1% | ❌ No | <8% remaining, critical save before context loss |
| **--no-todo** | varies | ❌ No | Ad-hoc work without todo directory |

**Quick mode (8-15% or --quick) skips:**
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
- ✅ Progress.log context link (if todo exists)

**Emergency mode (<8%) skips EVERYTHING except:**
- ✅ One git command (branch name)
- ✅ Writing context from conversation memory
- ✅ That's it - pure survival mode

**🎯 PERCENTAGE PARSING:**
When a percentage is passed (e.g., "9%", "15%", "3%"):
1. Extract the number: `9%` → `9`
2. Apply threshold:
   - `< 8` → Emergency mode
   - `8-15` → Quick mode (same as --quick)
   - `> 15` → Full mode (default behavior)