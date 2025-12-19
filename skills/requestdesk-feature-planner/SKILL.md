# RequestDesk Feature Planner Skill

## 🚨 CRITICAL RULES - READ FIRST 🚨

### 1. NEVER Directly Modify the Database
**ALL database changes MUST go through migrations. NO EXCEPTIONS.**

This has caused 5+ hour debugging sessions when:
- Claude added data directly to local MongoDB
- Production failed because data didn't exist
- Nobody documented what was added

**If a feature needs data:**
1. Create a migration file in `backend/app/migrations/versions/`
2. Migration runs on ALL environments automatically
3. Document what data is being added

See `architecture/database.md` for full details.

### 2. NO MUI Components
All new UI must use Tailwind CSS + Catalyst UI Kit. See `architecture/frontend.md`.

### 3. Use Service Layer Pattern
Business logic goes in services, not routers. See `architecture/backend.md`.

---

## Purpose
Help plan features and enhancements for RequestDesk.ai by understanding the existing architecture, identifying reusable components, and generating implementation specs that Claude Code can execute.

## When to Use This Skill
- Planning new features before implementation
- Designing enhancements to existing functionality
- Understanding how a feature fits into the existing architecture
- Generating specs for handoff to Claude Code

## Planning Workflow

### Step 1: Understand the Request
Ask clarifying questions:
- What problem does this solve for users?
- Who are the target users (admin, content manager, writer, client)?
- What's the expected user workflow?
- Are there similar features we can reference?

### Step 2: Architecture Analysis
Reference the architecture docs to determine:
- Which layers are affected (Frontend, Backend, Database)
- Which existing services/components can be reused
- What new endpoints/models are needed
- Database schema changes required

### Step 3: Check Feature Registry
Look for:
- Similar existing features to reference
- Reusable components and patterns
- Potential conflicts or dependencies
- Integration points

### Step 4: Generate Spec
Use the `templates/feature-spec.md` template to create:
- Clear requirements and acceptance criteria
- Technical implementation plan
- File-by-file changes needed
- Testing strategy

## Architecture Reference

| Layer | Location | Key Patterns |
|-------|----------|--------------|
| Frontend | `frontend/src/` | React Admin, TanStack Table, Tailwind CSS |
| Backend | `backend/app/` | FastAPI, Service Layer, Pydantic Models |
| Database | MongoDB 8 | Document-based, no foreign keys |
| Infrastructure | AWS ECS | Fargate, ALB, Secrets Manager |

## Output Format

Always generate specs in this format for Claude Code:

```markdown
## Feature: [Name]

### Requirements
- [ ] Requirement 1
- [ ] Requirement 2

### Acceptance Criteria
- [ ] AC 1
- [ ] AC 2

### Implementation Plan
1. Backend changes
2. Frontend changes
3. Database changes

### Files to Modify
- `path/to/file.py` - Description of changes
- `path/to/component.tsx` - Description of changes

### Testing
- Manual test steps
- Edge cases to verify
```

## Key Principles

1. **Use Existing Patterns** - Don't reinvent; follow established conventions
2. **Service Layer First** - Business logic in services, not routers
3. **Company Isolation** - All data filtered by company_id
4. **Role-Based Access** - Check user roles for permissions
5. **No Hardcoding** - Use database-driven configuration
6. **Docker Development** - All testing in containers

## Handoff to Claude Code

When spec is complete, user should:
1. Save spec to `todo/current/[category]/[feature-name]/`
2. Run `/create-branch cb-requestdesk [spec-path]`
3. Claude Code will implement based on the spec
