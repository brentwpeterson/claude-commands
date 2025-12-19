# Task Structure & Workflow

## Authoritative Sources

**READ THESE DOCUMENTS BEFORE IMPLEMENTING:**

| Document | Location | Purpose |
|----------|----------|---------|
| **TODO Workflow Guidelines** | `cb-requestdesk/todo/todo-workflow-guidelines.md` | Session management, file structure, save commands |
| **Technical Implementation** | `cb-requestdesk/todo/technical-implementation-guidelines.md` | CB dev standards, templates, checklists |
| **Architecture Map Template** | `cb-requestdesk/todo/architecture-map-template.md` | CB flow mapping for each task |
| **TODO README Template** | `cb-requestdesk/todo/README.md` | Task folder structure template |

## Standardized 7-File Structure

Every task uses this structure:

```
/todo/current/[category]/[task-name]/
├── README.md                 # Task overview and current status
├── [branch-name]-plan.md     # Requirements + acceptance + implementation + testing
├── progress.log              # Daily progress tracking
├── debug.log                 # Debug attempts (/debug-attempt command)
├── notes.md                  # Discoveries, blockers, insights
├── architecture-map.md       # CB technical flow mapping
└── user-documentation.md     # Public and private docs
```

## CB Architecture Flow

**Memorize this flow - every feature touches these layers:**

```
Frontend → DataLayer → Router → Service Layer → Model → Collection
```

| Layer | Location | Responsibility |
|-------|----------|----------------|
| Frontend | `/frontend/src/components/` | React components, user interaction |
| DataLayer | `/frontend/src/dataProvider/` | API calls, data transformation |
| Router | `/backend/app/routers/` | HTTP endpoints, request handling |
| Service | `/backend/app/services/` | Business logic (THICK layer) |
| Model | `/backend/app/models/` | Pydantic validation |
| Collection | MongoDB | Data storage |

## File Size Limits

From `todo-workflow-guidelines.md`:

| Size | Performance | Action |
|------|-------------|--------|
| 200-500 lines | Instant | Ideal |
| 500-1000 lines | Excellent | Good |
| 1000-2000 lines | Challenging | Consider splitting |
| 2000+ lines | Degraded | Must refactor |

**Target: 300-400 lines per file maximum**

## Task Categories

```
todo/current/
├── feature/         # New functionality
├── fix/             # Bug fixes
├── infrastructure/  # Deployment, AWS, Docker
├── refactor/        # Code cleanup
└── debug/           # Troubleshooting sessions
```

## Workflow Commands

| Command | Purpose |
|---------|---------|
| `/create-branch [requirements-doc]` | Start new feature with 7-file structure |
| `/create-bugfix [ticket-id]` | Start bug fix with 7-file structure |
| `/resume-todo [todo-readme-path]` | Resume existing TODO |
| `/claude-save [project]` | Full save with TODO path |
| `/claude-start [project]` | Resume from context |
| `/debug-attempt [try-number]` | Add structured debug entry |
| `/claude-complete` | Complete with checklist |

## Critical Session Rule

**IF YOU DON'T KNOW WHAT TODO YOU'RE WORKING ON:**
1. ASK THE USER IMMEDIATELY
2. NEVER GUESS
3. NEVER PROCEED without explicit todo context

Every save command MUST include the todo path.
