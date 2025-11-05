Claude Session Start - Read Resume Instructions and Execute

🚨 **CRITICAL COMMUNICATION RULE**: Never say "You're absolutely right!" or similar repetitive agreement phrases ("Perfect!", "Exactly!", "That's completely right!"). Use brief acknowledgment instead ("Got it.", "I understand.") then proceed with actual response. Violations will be logged.

🚨 **CRITICAL DEVELOPMENT ENVIRONMENT RULE**: This project uses DOCKER containers for development. DO NOT look for local dev servers (npm, python, etc.). ALL development happens in Docker containers. If you can't find the expected Docker containers running, ASK THE USER immediately instead of spending time troubleshooting. The user will guide you to start the correct containers.

**USAGE:**
- `/claude-start <project>` - Read instruction file from save command and resume exactly where left off

**Arguments**:
- `<project>` (required): Project name (used to find context file)

**🎯 PURPOSE:**
Read the instruction file created by `/claude-save` or `/claude-save-fast` and follow those exact instructions

**⚡ SIMPLE WORKFLOW:**
1. **Find instruction file:** `.claude/branch-context/[current-branch]-context.md`
2. **Read instructions:** Load the handoff document
3. **Follow instructions:** Execute exactly what the previous Claude documented
4. **Ask for direction:** Present status and wait for user guidance

**📋 EXECUTION STEPS:**

**Step 1: Navigate to Project**
1. **Change to project directory:** `cd [project]`
2. **Get current branch:** `git branch --show-current`

**Step 2: Find and Read Instructions**
3. **Locate context file:** `.claude/branch-context/[branch-name]-context.md`
4. **Read instruction file:** Load the complete handoff document
5. **Parse instructions:** Extract setup steps, current state, todos, next actions
6. **Todo directory inventory check:** Verify todo directory has exactly 7 files:
   ```bash
   # Expected 7 files exactly:
   # 1. README.md  2. [branch-name]-plan.md  3. progress.log
   # 4. debug.log  5. notes.md  6. architecture-map.md  7. user-documentation.md
   ```
   - **File count validation**: `ls -1 [todo-path] | wc -l` should return 7
   - **Missing file alert**: Report any missing required files
   - **Extra file warning**: Report any unexpected files
   - **Structure status**: "✅ Complete (7/7 files)" or "⚠️ Incomplete (X/7 files, missing: [files])"

**Step 2.5: OpenMemory Context Retrieval (Automatic with Fallback)**
6.5. **Query OpenMemory for Relevant Context:**
   - **Check OpenMemory server availability:**
     ```bash
     curl -s http://localhost:8080/health 2>/dev/null
     ```

   - **If server available (automatic):**
     ```bash
     cd /Users/brent/scripts/CB-Workspace/cb-memory-system

     # Query for project-specific recent work
     ./scripts/query-memory.sh "project:[project-name] recent work" 5

     # Query for similar problems/patterns
     ./scripts/query-memory.sh "[current-task-keywords]" 5

     # Query for cross-project patterns if relevant
     ./scripts/query-memory.sh "[technology/architecture] patterns" 3
     ```

   - **If server not available (fallback):**
     ```
     ⚠️ OpenMemory server not running - using file-based context only
     💡 Start server: cd /Users/brent/scripts/OpenMemory/backend && npm run dev
     ✅ Continuing with context file instructions
     ```

   - **Memory Integration:**
     - **Surface relevant memories** alongside file-based context
     - **Cross-reference patterns** from other projects
     - **Highlight solutions** to similar problems
     - **Note**: Memory results supplement, don't replace, the instruction file

**Step 3: Execute Setup Instructions**
7. **Follow IMMEDIATE SETUP section:** Execute each command listed
8. **Verify expected state:** Confirm git status, processes, etc. match expectations
   - **Docker containers check:** Use `docker ps` to verify containers are running
   - **If containers not found:** ASK USER immediately - do not troubleshoot Docker issues
9. **Restore TodoWrite:** Set up todos exactly as documented in instruction file

**Step 4: Present Status and Wait**
10. **Show resume summary:** Display what was restored and current state (including todo inventory results)
11. **Present OpenMemory insights (if available):** Surface relevant memories and cross-project patterns
12. **Present next actions:** Show the priority actions from instruction file
13. **Ask for direction:** "I've restored your session. Which task should I work on first?"

**🎯 KEY PRINCIPLES:**
- **Follow the instructions exactly** as written in the context file
- **Don't improvise** - the previous Claude documented everything needed
- **Verify state matches expectations** from the instruction file
- **Ask user for guidance** after restoring the session

**📄 INSTRUCTION FILE FORMAT:**
The context file contains everything needed to resume:
```markdown
# Resume Instructions for Claude

## IMMEDIATE SETUP
[Exact commands to run]

## WHAT YOU WERE WORKING ON
[Task description]

## CURRENT STATE
[File states, processes, last command]

## TODO LIST STATE
[TodoWrite items with status]

## NEXT ACTIONS (PRIORITY ORDER)
[Exact next steps]

## VERIFICATION COMMANDS
[How to check everything works]
```

**🔄 EXPECTED WORKFLOW:**
1. Previous session: `/claude-save <project>` → Shows path to instruction file
2. Current session: `/claude-start <project>` → Reads instruction file and follows it
3. Result: **Perfect resume** exactly where previous Claude left off

**✅ SUCCESS CRITERIA:**
- Context file found and read successfully
- All setup commands executed as instructed
- TodoWrite restored to exact previous state
- User presented with next actions and asked for direction
- **Zero information loss** between sessions

**🚨 CRITICAL: NO AUTOMATIC ACTIONS**
- **READ ONLY**: Follow instructions but don't execute work automatically
- **VERIFY FIRST**: Confirm the expected state matches reality
- **ASK USER**: Always ask which task to work on after restoring session
- **NO IMPROVISATION**: Stick to exactly what's in the instruction file

**📋 COMMUNICATION REMINDER**: Do not use repetitive agreement phrases like "You're absolutely right!" - violations go to the violation log. Use brief acknowledgment then focus on the actual work.

**🐳 DOCKER ENVIRONMENT REMINDER**: Only look for Docker containers (`docker ps`). Do not troubleshoot missing containers - ASK USER immediately for guidance on starting the development environment.
