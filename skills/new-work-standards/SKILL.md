# New Work Standards - Definition of Proper Work Setup

**Skill Description:** Defines what constitutes properly structured work, including mandatory acceptance criteria, work phases, and completion standards. Referenced by `/start-work` command.

---

## CORE PRINCIPLE

**No work starts without knowing what "done" looks like.**

Every piece of work, regardless of size, must have:
1. Clear acceptance criteria (measurable, testable)
2. Defined scope (what's in, what's out)
3. Known completion state (how we verify it's done)

---

## WORK PHASES

Work moves through phases. Each phase has different requirements.

### Phase 1: Backlog (Idea Stage)

**Purpose:** Capture ideas for future consideration

**Location:** `todo/backlog/[category]/`

**Required:**
- Brief description (1-2 sentences)
- Category assignment
- Rough size estimate (S/M/L or points)

**Not required yet:**
- Detailed acceptance criteria
- Implementation plan
- Git branch

**Example:**
```markdown
# Drag-and-Drop Sprint Board

**Category:** feature
**Size:** M (medium)
**Added:** 2026-01-19

## Idea
Allow users to drag cards between columns on the sprint board to change status.
Would update backend via API on drop.
```

---

### Phase 2: Planning (Pre-Implementation)

**Purpose:** Think through the work before coding

**Location:** `todo/current/[category]/[task-name]/`

**Required:**
- Acceptance criteria (MANDATORY - see below)
- Scope definition (in/out)
- Basic implementation approach
- Risk identification

**Not required yet:**
- Git branch
- Full 8-file structure (can use lightweight)

**Transition to Phase 3:** When criteria are defined and approach is clear

---

### Phase 3: Implementation (Active Development)

**Purpose:** Write code, build the thing

**Location:** `todo/current/[category]/[task-name]/` + git branch

**Required:**
- Everything from Phase 2
- Git branch (for significant changes)
- Full documentation structure
- Progress tracking

**Completion:** All acceptance criteria pass, user approves

---

## ACCEPTANCE CRITERIA

### The Non-Negotiable Rule

**Every piece of work MUST have acceptance criteria BEFORE starting.**

This is not optional. This is not "nice to have." This is mandatory.

### What Makes Good Criteria

**Good criteria are:**
- **Measurable** - Can objectively verify pass/fail
- **Specific** - No ambiguity about what's expected
- **Testable** - Can demonstrate it works
- **User-focused** - Describe outcomes, not implementation

**Examples of GOOD criteria:**
```markdown
## Acceptance Criteria

- [ ] User can drag a card from "Todo" column to "In Progress" column
- [ ] Dropping a card calls PATCH /api/backlog/{id} with new status
- [ ] Card appears in new column immediately (optimistic update)
- [ ] If API fails, card returns to original column with error toast
- [ ] Drag operation works on mobile (touch events)
```

**Examples of BAD criteria:**
```markdown
## Acceptance Criteria (BAD - DO NOT USE)

- [ ] Drag and drop works (too vague)
- [ ] Feature is complete (circular, meaningless)
- [ ] It looks good (subjective, not measurable)
- [ ] Backend is updated (what specifically?)
- [ ] No bugs (impossible to verify)
```

### Criteria Template

```markdown
## Acceptance Criteria

**Functional:**
- [ ] [User action] results in [specific outcome]
- [ ] [System behavior] when [condition]
- [ ] [API endpoint] returns [expected response]

**Error Handling:**
- [ ] When [error condition], [expected behavior]
- [ ] Error message shows [specific text/type]

**Performance (if applicable):**
- [ ] [Action] completes in under [X]ms
- [ ] No console errors during [operation]
```

### Minimum Criteria Count

| Work Size | Minimum Criteria |
|-----------|------------------|
| Quick fix | 2 |
| Small task | 3 |
| Medium feature | 5 |
| Large feature | 7+ |

---

## DEFINITION OF DONE

Work is "done" when:

1. **All acceptance criteria pass** - Every checkbox checked
2. **User has verified** - Not just Claude saying it works
3. **No regressions** - Didn't break existing functionality
4. **Documentation updated** - If user-facing, docs reflect changes
5. **Code committed** - Changes are in version control

### Done Checklist Template

```markdown
## Completion Checklist

- [ ] All acceptance criteria verified
- [ ] Tested locally by user
- [ ] No console errors
- [ ] No TypeScript/lint errors
- [ ] Code committed to branch
- [ ] Ready for merge/deploy (if applicable)
- [ ] User approved completion
```

---

## SCOPE DEFINITION

Every task needs clear boundaries.

### In Scope / Out of Scope Template

```markdown
## Scope

**In Scope:**
- Drag cards between status columns
- Update status via API on drop
- Optimistic UI updates
- Error handling for failed updates

**Out of Scope (Future Work):**
- Drag to reorder within column
- Drag between sprints
- Bulk drag operations
- Keyboard accessibility for drag
```

### Why Scope Matters

- Prevents scope creep mid-implementation
- Sets clear expectations with user
- Makes "done" achievable
- Future items go to backlog, not forgotten

---

## ANTI-PATTERNS TO AVOID

### 1. Starting Without Criteria
**Bad:** "I'll figure out done when I get there"
**Good:** Define criteria first, then start

### 2. Vague Criteria
**Bad:** "Feature works correctly"
**Good:** "User can [specific action] and sees [specific result]"

### 3. Implementation-Focused Criteria
**Bad:** "Add DragContext provider to App.tsx"
**Good:** "Cards can be dragged between columns"

### 4. Moving Target
**Bad:** Adding criteria after work starts
**Good:** Criteria locked before implementation (scope changes require discussion)

### 5. Claude-Only Verification
**Bad:** Claude says "done" without user testing
**Good:** User verifies each criterion passes

---

## INTEGRATION WITH /start-work

The `/start-work` command enforces these standards:

1. **Phase Selection** - Determines what's required
2. **Criteria Prompt** - Forces criteria definition for Planning/Implementation
3. **Template Generation** - Creates properly structured files
4. **Validation** - Checks criteria exist before proceeding

---

## QUICK REFERENCE

| Question | Answer |
|----------|--------|
| When do I need criteria? | Always, for Planning and Implementation phases |
| Minimum criteria count? | 2-3 for small work, 5+ for features |
| Who verifies criteria? | User, not Claude |
| Can I add criteria later? | Discuss with user first, avoid scope creep |
| What if I'm unsure? | Ask user to help define criteria |

---

## WHEN CLAUDE SHOULD APPLY THIS SKILL

Apply automatically when:
- User wants to start new work
- `/start-work` command is invoked
- Creating task documentation
- Discussing what "done" means
- Work lacks clear acceptance criteria

**Keywords:** acceptance criteria, definition of done, start work, new task, what's done
