Claude Fast Save - Ultra-Minimal Resume Instructions

**USAGE:** `/claude-save-fast <project>` - Create bare minimum resume instructions in seconds

**🎯 PURPOSE:**
Ultra-fast context save using minimal resources - captures only essential resume info

**🚨 COMPLETION APPROVAL RULES:**
- **NEVER mark tasks as completed** without explicit user approval
- **Always note**: "USER APPROVED: Yes/No" for completed items in context
- **TodoWrite with Acceptance Criteria**: Include clear completion criteria in todos

**⚡ ULTRA-MINIMAL WORKFLOW:**

**Step 1: Capture Essentials + Todo Inventory**
1. **Get bare minimum:**
   - Current directory: `pwd`
   - Current branch: `git branch --show-current`
   - **MANDATORY: Current todo path** - Ask user if not obvious
   - **Todo inventory check**: Verify exactly 7 files exist:
     ```bash
     # Expected 7 files exactly:
     # 1. README.md  2. [branch-name]-plan.md  3. progress.log
     # 4. debug.log  5. notes.md  6. architecture-map.md  7. user-documentation.md
     ```
   - **File count validation**: `ls -1 [todo-path] | wc -l` should return 7
   - **Structure status**: Report "✅ 7/7" or "⚠️ X/7 missing: [files]"
   - Current TodoWrite state (if any)

**Step 2: Create Minimal Instructions**
2. **Write tiny instruction file:**
   - Create: `.claude/branch-context/[branch-name]-context.md`
   - **Ultra-simple format:**

```markdown
# Quick Resume

## SETUP
- `cd [working-directory]`
- Branch: [branch-name]

## TODO
**Path:** file:[exact-path-to-todo-readme]
**Files:** [✅ 7/7 or ⚠️ X/7 missing: files]

## TASK
[One line: what you were doing]

## TODOS
[Current TodoWrite state with acceptance criteria]
- ✅ COMPLETED: [task] (USER APPROVED: Yes/No)
- 🔄 IN PROGRESS: [task]
- ⏳ PENDING: [task]

## COMPLETION STATUS
**User Approval Required**: NEVER mark complete without user saying "done"

### Completion Trigger Protocol
**BEFORE marking any task complete:**
1. **Check Acceptance Criteria**: Does todo have clear criteria?
2. **If NO criteria**: Ask user for acceptance criteria first
3. **If criteria exist**: Verify ALL points are met
4. **Ask for approval**: "Ready to mark complete?"
5. **Wait for confirmation**: User must explicitly approve

## NEXT
[One action to continue]
```

**Step 3: Save and Show Path (NO COMMITS)**
3. **Save file and display path:**
   - Write context file directly (no git operations)
   - **⚠️ CRITICAL**: If todo path doesn't exist, STOP and ask user to clarify
   - Display: "📁 Fast resume: `.claude/branch-context/[branch-name]-context.md`"

**🚀 ULTRA-FAST FEATURES:**
- **Zero git operations** (no status, no commits, no analysis)
- **Zero process checking** (no docker, no lsof)
- **Minimal template** (4 sections, ~5 lines)
- **No file analysis** (just capture current state)
- **Instant execution** (seconds, not minutes)

**⚡ SPEED OPTIMIZATIONS:**
- No git status checking
- No file modification analysis
- No process verification
- No work commits
- No detailed context
- Minimal instruction template

**🔄 EXPECTED WORKFLOW:**
1. `/claude-save-fast <project>` → Instant minimal save, shows path
2. `/clear new` → Clear session
3. `/claude-start <project>` → Resume from minimal instructions

**📝 WHEN TO USE:**
- Context getting full and need quick save
- Don't need work preservation
- Want instant save with zero analysis
- Minimal resume instructions sufficient