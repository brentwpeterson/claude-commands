# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/.claude`
2. **Verify branch:** `git branch --show-current` (should be: main)
3. **Review skill:** Read `skills/requestdesk-feature-planner/SKILL.md`

## SESSION METADATA
**Last Commit:** `ddd3f68 Add critical rule #6: Read guidelines before implementing + workflows reference`
**Saved:** 2025-12-19
**Working Directory:** /Users/brent/scripts/CB-Workspace/.claude

## WHAT WAS ACCOMPLISHED THIS SESSION

### Created: requestdesk-feature-planner Skill
Complete skill for planning RequestDesk.ai features with 6 critical rules to prevent past mistakes.

**Skill Location:** `/Users/brent/scripts/CB-Workspace/.claude/skills/requestdesk-feature-planner/`

**Structure:**
```
requestdesk-feature-planner/
├── SKILL.md                    # 6 critical rules + purpose
├── architecture/
│   ├── overview.md             # System diagram (Tailwind/Catalyst, NO MUI)
│   ├── backend.md              # Modular router pattern (v2/tickets)
│   ├── frontend.md             # Catalyst UI Kit docs
│   ├── database.md             # Model-first + migration rules
│   └── infrastructure.md       # AWS ECS
├── features/
│   └── registry.md             # Existing features catalog
├── templates/
│   └── feature-spec.md         # Spec template with checklists
└── workflows/
    └── task-structure.md       # References to authoritative docs
```

### 6 CRITICAL RULES DOCUMENTED

| # | Rule | Problem Solved |
|---|------|----------------|
| 1 | NEVER Directly Modify Database | 5+ hour debugging sessions from missing migrations |
| 2 | NO Collection Without a Model | Schema drift, no validation |
| 3 | NO MUI Components | Tailwind + Catalyst UI Kit only |
| 4 | Use Service Layer Pattern | Business logic in services, not routers |
| 5 | NO Large Files (< 300 lines) | llm.py at 2,447 lines is unmaintainable |
| 6 | Read Guidelines Before Implementing | Reference cb-requestdesk/todo/ docs |

### Key References Added
- Points to authoritative docs in `cb-requestdesk/todo/`:
  - `todo-workflow-guidelines.md`
  - `technical-implementation-guidelines.md`
  - `architecture-map-template.md`
  - `README.md` (7-file structure template)

### CB Architecture Flow (Documented)
```
Frontend → DataLayer → Router → Service Layer → Model → Collection
```

### v2/tickets Modular Pattern Documented
- `core/` - CRUD operations (create, read, update, delete)
- `features/` - Feature-specific endpoints
- `utils/` - Validators, permissions, helpers
- Main `__init__.py` - router composition only (< 100 lines)

## CURRENT STATE
- **All changes committed and pushed** to main branch
- **Skill is ready to use** for planning features
- **User asked:** "should I give this skill to claude now?" - Answer: Yes, it's ready

## NEXT ACTIONS (IF CONTINUING)
1. **Test the skill** - Try planning a new feature to validate rules work
2. **Invoke via `/plan-feature`** - If that command is set up to use this skill
3. **Or reference manually** - Tell Claude to read skill files when planning

## PENDING (NOT STARTED)
- User may want to start a new feature branch for cb-requestdesk
- Previous session mentioned waiting for Shopify RAG iter-1 and iter-2 production testing
- Tags deployed: `matrix-v0.33.8-shopify-rag-iter-1`, `matrix-v0.33.8-shopify-rag-iter-2`

## CONTEXT FROM PREVIOUS SESSION
- Emergency save had mentioned user frustration about:
  1. Claude directly modifying DB instead of migrations (5+ hours debugging)
  2. Claude committing without waiting for user response
  3. Large router files (llm.py 2,447 lines)
- These issues are now documented as CRITICAL RULES in the skill
