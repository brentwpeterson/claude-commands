# Todo File Structure Guide - The WHY Behind Each File

**Purpose:** Explain why each of the 8 required files exists in the todo structure.

**Location:** Every todo task uses this structure: `/todo/current/[category]/[task-name]/`

---

## The 8 Required Files

### 1. README.md
**What:** Task overview, branch name, current status, links to guidelines.

**WHY IT EXISTS:**
- First file Claude reads when resuming a session
- Provides immediate context without digging through other files
- Links to required reading (workflow guidelines, technical standards)
- Shows current branch name so Claude knows which git branch to use
- Prevents the #1 problem: "Claude doesn't know what task it's working on"

**Without this file:** Claude starts working blindly, may modify wrong files, loses context.

---

### 2. success-criteria.md
**What:** Explicit, measurable conditions that define "done".

**WHY IT EXISTS:**
- **THE MOST IMPORTANT FILE** - defines what success looks like
- Prevents Claude from claiming "done" without meeting specific criteria
- Provides checklist for deployment verification
- Forces upfront thinking about what "complete" means
- Easy to reference during testing and deployment

**Without this file:**
- Claude claims things work when they don't
- Success criteria gets buried in plan.md and ignored
- Deployment happens without verification
- User has to repeatedly ask "did you check X?"

**Example content:**
```markdown
# Success Criteria for [Task Name]

## MUST PASS (All required for completion)
- [ ] API returns 84 records
- [ ] Each record has agent_id, user_id, company_id
- [ ] Response time under 500ms

## VERIFICATION COMMANDS
```bash
curl -s 'http://localhost:3000/api/backlog' -H 'Authorization: Bearer TOKEN' | jq '.total'
# Expected: 84
```

## VERIFIED BY
- [ ] Claude tested locally
- [ ] User confirmed in production
```

---

### 3. [branch-name]-plan.md
**What:** Requirements, implementation approach, testing strategy.

**WHY IT EXISTS:**
- Detailed roadmap prevents scope creep
- Implementation phases keep work organized
- Testing strategy ensures quality before deployment
- Captures requirements so they're not forgotten mid-task

**Without this file:** Claude makes it up as it goes, misses requirements, implements wrong approach.

---

### 4. progress.log
**What:** Chronological log of what happened and when.

**WHY IT EXISTS:**
- Tracks work across multiple Claude sessions
- Shows what was tried and what worked
- Timestamps help correlate with git commits
- Essential for debugging "what changed?"
- Provides velocity data for estimates

**Without this file:** No history of what was done, repeated work, lost context.

---

### 5. debug.log
**What:** Structured debug attempts using `/debug-attempt` command.

**WHY IT EXISTS:**
- Prevents repeating failed approaches
- Documents systematic problem-solving
- Shows what was tried, what failed, what was learned
- Critical for complex multi-session debugging
- Helps identify patterns in failures

**Without this file:** Same bugs get debugged repeatedly, solutions get lost.

---

### 6. notes.md
**What:** Insights, discoveries, decisions, blockers.

**WHY IT EXISTS:**
- Captures "aha moments" that might be forgotten
- Documents architectural decisions and rationale
- Records blockers and their resolutions
- Preserves context that doesn't fit elsewhere
- Brain dump location for important observations

**Without this file:** Valuable insights lost between sessions, decisions forgotten.

---

### 7. architecture-map.md
**What:** CB technical flow mapping across all layers.

**WHY IT EXISTS:**
- Maps changes across Frontend → DataLayer → Router → Service → Model → Collection
- Required by `/claude-save` - save blocked if outdated
- Shows exactly what files were touched
- Prevents "archaeological digs" to find what changed
- Essential for code review and handoffs

**Without this file:** Next Claude session doesn't know what was modified, wastes time investigating.

---

### 8. user-documentation.md
**What:** Public and internal documentation for the feature.

**WHY IT EXISTS:**
- Plans documentation alongside development
- Separates user-facing docs from internal docs
- Ensures features ship with documentation
- API docs, guides, troubleshooting in one place

**Without this file:** Features ship undocumented, users confused, support burden increases.

---

## File Validation

**Commands that validate the 8-file structure:**
- `/claude-start` - Checks all 8 files exist
- `/claude-save` - Validates structure before saving
- `/create-branch` - Creates all 8 files

**Expected file count:** 8 files exactly

```
/todo/current/[category]/[task-name]/
├── README.md              # 1. Task overview
├── success-criteria.md    # 2. What defines "done"
├── [task]-plan.md         # 3. Implementation plan
├── progress.log           # 4. Timeline of work
├── debug.log              # 5. Debug attempts
├── notes.md               # 6. Insights and decisions
├── architecture-map.md    # 7. Technical layer mapping
└── user-documentation.md  # 8. User-facing docs
```

---

## Why 8 Files Instead of Fewer?

**Previous approach (fewer files):**
- Success criteria buried in plan.md → got ignored
- Notes mixed with debug logs → hard to find insights
- No architecture tracking → "what did I change?" problems

**Current approach (8 files):**
- Each file has ONE purpose
- Harder to skip or ignore
- Easy to validate completeness
- Clear ownership of information

**Rule:** If Claude isn't checking something, give it its own file.
