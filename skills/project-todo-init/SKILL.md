# Project Todo Init - Auto-Scaffold Task Management Structure

**Skill Description:** Automatically verify and scaffold the standardized todo folder structure when commands like `/start-work` are run on projects that lack the structure.

## PURPOSE

This is NOT a standalone command. It's a **verification and auto-scaffold utility** that other commands should invoke before creating tasks.

**Integration point:** Commands like `/start-work`, `/create-bugfix`, `/resume-todo` should check for todo structure and scaffold if missing.

---

## VERIFICATION LOGIC

### When to Trigger

Before any command that creates or references `todo/current/`:
1. `/start-work` - Creates new work (any phase)
2. `/create-bugfix` - Creates fix task
3. `/resume-todo` - Resumes existing task
4. `/claude-start` - Session resume (warning only)

### Verification Steps

```bash
# Step 1: Check if todo/ exists
if [ ! -d "[project-path]/todo" ]; then
    echo "Todo structure missing. Scaffolding..."
    # Proceed to scaffold
fi

# Step 2: Check for required subdirectories
REQUIRED_DIRS="backlog current completed"
for dir in $REQUIRED_DIRS; do
    if [ ! -d "[project-path]/todo/$dir" ]; then
        echo "Missing: todo/$dir"
        # Scaffold missing directories
    fi
done
```

---

## AUTO-SCAFFOLD STRUCTURE

When scaffolding is needed, create:

### Directory Structure
```
[project]/todo/
├── backlog/
│   ├── features/
│   ├── enhancement/
│   ├── infrastructure/
│   ├── refactoring/
│   └── research/
├── current/
│   ├── feature/
│   ├── fix/
│   ├── infrastructure/
│   ├── refactor/
│   └── debug/
├── completed/
│   ├── feature/
│   ├── fix/
│   ├── infrastructure/
│   └── refactor/
├── review/
└── recurring-bugs/
```

### Template Files
- `README.md` - Guidelines and quick reference
- `architecture-map-template.md` - Template for task architecture docs
- `todo-workflow-guidelines.md` - Claude workflow rules

---

## INTEGRATION WITH /start-work

The `/start-work` command includes this verification at the start of the Implementation flow:

```markdown
### Step 0: Verify Todo Structure (BEFORE any other steps)

1. **Check for todo directory:**
   ```bash
   ls [project-path]/todo/ 2>/dev/null
   ```

2. **If missing or incomplete:**
   - Display: "Todo structure missing. Creating..."
   - Run scaffold (see SKILL.md for structure)
   - Display: "Todo structure ready."

3. **If exists:**
   - Continue to next step
```

---

## SCAFFOLD COMMAND (for internal use)

```bash
# Full scaffold command
mkdir -p [project-path]/todo/{backlog/{features,enhancement,infrastructure,refactoring,research},current/{feature,fix,infrastructure,refactor,debug},completed/{feature,fix,infrastructure,refactor},review,recurring-bugs}
```

---

## README.md TEMPLATE

```markdown
# Todo Task Management

## Quick Start

1. **New task:** Create folder in `current/[category]/[task-name]/`
2. **Use 7-file structure:** README.md, plan.md, progress.log, debug.log, notes.md, architecture-map.md, user-documentation.md
3. **Track progress:** Update progress.log daily
4. **Complete:** Move to `completed/[category]/` when done

## Categories

| Folder | Purpose |
|--------|---------|
| `feature/` | New functionality |
| `fix/` | Bug fixes |
| `infrastructure/` | DevOps, deployment |
| `refactor/` | Code improvements |
| `debug/` | Investigation sessions |

## Task Status Flow

backlog/ -> current/ -> review/ -> completed/

## For Claude

- **Always know current todo** before starting work
- **Include todo path** in /claude-save commands
- **Ask if unclear** which task to work on
- **Never guess** task context from previous sessions
```

---

## WHEN CLAUDE SHOULD APPLY THIS SKILL

**Automatically verify todo structure when:**
- Running `/start-work` on any project
- Running `/create-bugfix` on any project
- Project path is referenced that lacks `todo/`

**Keywords that trigger verification:**
- "start work", "new feature", "start task", "new task"
- Any reference to `todo/current/` path that doesn't exist

---

## REFERENCE IMPLEMENTATION

**Canonical source:** `/Users/brent/scripts/CB-Workspace/requestdesk-app/todo/`

Copy structure and guidelines from requestdesk-app when scaffolding new projects.
