Start Work - Smart Task Creation with Mandatory Acceptance Criteria

**USAGE:**
`/start-work [optional: task-name]`

**PURPOSE:**
Single entry point for all new work. Asks questions to determine the right setup, enforces acceptance criteria, and creates appropriate structure.

**REQUIRED SKILL:** `.claude/skills/new-work-standards/SKILL.md`

---

## QUESTION FLOW

### Question 1: Work Phase

```
What phase is this work?

1. Backlog    - Just capturing an idea for later
2. Planning   - Need to think through before coding
3. Implementation - Ready to write code now

Select (1/2/3):
```

**Routing:**
- Backlog → Simple capture flow
- Planning → Planning docs flow (no branch)
- Implementation → Full flow (branch + docs)

---

### Question 2: Category

```
What category?

1. Feature        - New functionality
2. Fix            - Bug fix or issue resolution
3. Infrastructure - DevOps, deployment, tooling
4. Refactor       - Code improvements, cleanup
5. Debug          - Investigation session

Select (1/2/3/4/5):
```

---

### Question 3: Task Name (if not provided)

```
Task name (kebab-case, e.g., drag-drop-board):
> _
```

**Validation:**
- Must be kebab-case (lowercase, hyphens)
- No spaces or special characters
- Max 50 characters

---

### Question 4: Git Branch (Implementation only)

```
Does this need a git branch?

1. Yes - Significant changes, will need PR
2. No  - Quick change, direct commit OK

Select (1/2):
```

**Default:** Yes for features, No for quick fixes

---

### Question 5: Complexity

```
How complex is this work?

1. Quick     - Simple task, lightweight docs (4 files)
2. Standard  - Normal feature, full structure (8 files)

Select (1/2):
```

---

### Question 6: Acceptance Criteria (MANDATORY)

```
ACCEPTANCE CRITERIA (Required)

What does "done" look like? Enter 2-5 measurable criteria.
Good criteria are specific and testable.

Examples:
- "User can drag card from Todo to Done column"
- "API returns 200 with updated status"
- "Error toast shows on failed update"

Enter criteria (one per line, blank line to finish):
> _
```

**Validation:**
- Minimum 2 criteria required
- Each must be specific (warn if vague)
- Cannot proceed without criteria

**Vague Criteria Detection:**
Flag and ask for clarification if criteria contain:
- "works correctly"
- "is complete"
- "looks good"
- "no bugs"
- "functions properly"

---

## EXECUTION BY PHASE

### Backlog Flow

**Creates:** `todo/backlog/[category]/[task-name].md`

```markdown
# [Task Name]

**Category:** [category]
**Size:** [to be estimated]
**Added:** [date]

## Idea
[Brief description - prompt user]

## Initial Thoughts
- [Any notes from user]

## Acceptance Criteria (Draft)
[Criteria entered, marked as draft for refinement later]
```

**No branch, no current/ folder, just backlog capture.**

---

### Planning Flow

**Creates:** `todo/current/[category]/[task-name]/`

**Structure (4-file lightweight):**
```
[task-name]/
├── README.md
├── [task-name]-plan.md
├── [task-name]-criteria.md    # Acceptance criteria
└── notes.md
```

**README.md Template:**
```markdown
# [Task Name] - Planning Phase

**Status:** PLANNING
**Category:** [category]
**Created:** [date]
**Branch:** Not created yet (planning phase)

## Overview
[Description from user]

## Files
- [x] README.md - This file
- [ ] [task-name]-plan.md - Implementation approach
- [x] [task-name]-criteria.md - Acceptance criteria
- [ ] notes.md - Discoveries and decisions

## Next Steps
1. Complete planning document
2. Refine acceptance criteria
3. When ready: `/start-work [task-name]` to begin implementation
```

**[task-name]-criteria.md Template:**
```markdown
# [Task Name] - Acceptance Criteria

**Status:** Draft (refine before implementation)

## Criteria

[User's entered criteria as checkboxes]
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Verification

How to verify each criterion:

### [Criterion 1]
**Test:** [How to test this]
**Expected:** [Expected result]

### [Criterion 2]
**Test:** [How to test this]
**Expected:** [Expected result]

## Sign-off

- [ ] Criteria reviewed and approved
- [ ] Ready for implementation
```

---

### Implementation Flow

**Step 0: Verify Todo Structure**
```bash
# Check if todo/ exists
ls [project-path]/todo/ 2>/dev/null || {
    echo "Todo structure missing. Scaffolding..."
    mkdir -p [project-path]/todo/{backlog/{features,enhancement,infrastructure,refactoring,research},current/{feature,fix,infrastructure,refactor,debug},completed/{feature,fix,infrastructure,refactor},review,recurring-bugs}
    # Create template files per project-todo-init skill
}
```

**Step 1: Handle Existing Work (if upgrading from Planning)**
```bash
# Check if planning docs exist
if [ -d "todo/current/[category]/[task-name]" ]; then
    echo "Found existing planning docs. Upgrading to implementation..."
    # Preserve existing files, add missing ones
fi
```

**Step 2: Git Branch (if needed)**
```bash
# Verify clean state
git status
git checkout master
git pull origin master

# Create branch
git checkout -b [category]/[task-name]
git push -u origin [category]/[task-name]
```

**Step 3: Create Full Structure (8-file)**
```
todo/current/[category]/[task-name]/
├── README.md                 # Task overview
├── success-criteria.md       # Acceptance criteria (MANDATORY)
├── [task-name]-plan.md       # Implementation plan
├── progress.log              # Daily progress
├── debug.log                 # Debug attempts
├── notes.md                  # Discoveries
├── architecture-map.md       # Technical flow
└── user-documentation.md     # User docs
```

**success-criteria.md Template:**
```markdown
# [Task Name] - Success Criteria

**Branch:** [category]/[task-name]
**Created:** [date]

## Acceptance Criteria

[User's entered criteria]
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Verification Commands

```bash
# How to verify criterion 1
[command or manual step]
# Expected: [result]

# How to verify criterion 2
[command or manual step]
# Expected: [result]
```

## Verification Status

| Criterion | Local | Production | Verified By |
|-----------|-------|------------|-------------|
| [Criterion 1] | ⏳ | ⏳ | |
| [Criterion 2] | ⏳ | ⏳ | |
| [Criterion 3] | ⏳ | ⏳ | |

**Legend:** ⏳ Pending | ✅ Passed | ❌ Failed

## Completion Checklist

- [ ] All criteria verified locally
- [ ] User confirmed in testing
- [ ] No regressions introduced
- [ ] Documentation updated
- [ ] Ready for /claude-complete
```

**README.md Template:**
```markdown
# [Task Name]

**Branch:** [category]/[task-name]
**Status:** IN PROGRESS
**Category:** [category]
**Created:** [date]

## Overview
[Description]

## Acceptance Criteria
See `success-criteria.md` for full criteria and verification status.

**Quick View:**
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Files
- [x] README.md - This file
- [x] success-criteria.md - Acceptance criteria (MANDATORY)
- [ ] [task-name]-plan.md - Implementation plan
- [ ] progress.log - Progress tracking
- [ ] debug.log - Debug attempts
- [ ] notes.md - Notes and discoveries
- [ ] architecture-map.md - Technical architecture
- [ ] user-documentation.md - User documentation

## Quick Commands
```bash
# Check branch
git branch --show-current

# Run tests (if applicable)
[test command]

# Verify criteria
[verification steps]
```
```

---

## OUTPUT SUMMARY

After completion, display:

```
✅ Work created successfully!

📁 Location: todo/[phase]/[category]/[task-name]/
🌿 Branch: [category]/[task-name] (or "No branch")
📋 Phase: [Backlog/Planning/Implementation]
📝 Structure: [Lightweight 4-file / Full 8-file]

📌 Acceptance Criteria:
  - [ ] [Criterion 1]
  - [ ] [Criterion 2]
  - [ ] [Criterion 3]

🔜 Next Steps:
  [Phase-specific next steps]
```

---

## EDGE CASES

### Existing Task Name
```
Task "drag-drop-board" already exists in todo/current/feature/

Options:
1. Resume existing task
2. Choose different name
3. Archive existing and start fresh

Select (1/2/3):
```

### Upgrading Planning to Implementation
```
Found planning docs for "drag-drop-board".

Upgrading to implementation phase:
- [ ] Create git branch
- [ ] Add missing files (debug.log, architecture-map.md, etc.)
- [ ] Update README status to IN PROGRESS

Proceed? (y/n):
```

### Missing Acceptance Criteria
```
⚠️ Cannot proceed without acceptance criteria.

Acceptance criteria define what "done" looks like.
See: .claude/skills/new-work-standards/SKILL.md

Enter at least 2 specific, measurable criteria:
> _
```

---

## RELATED COMMANDS

- `/claude-save` - Save session with task reference
- `/claude-complete` - Complete task (verifies all criteria pass)
- `/add-backlog` - Quick add to backlog (alias for `/start-work` with phase=backlog)

## RELATED SKILLS

- `.claude/skills/new-work-standards/SKILL.md` - Work standards and criteria
- `.claude/skills/project-todo-init/SKILL.md` - Todo structure scaffolding

---

## DEPRECATION NOTE

This command replaces `/create-branch`. The old command is preserved as an alias but will show:
```
Note: /create-branch is now /start-work
Redirecting...
```
