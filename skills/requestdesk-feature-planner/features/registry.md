# Feature Registry

## Existing Features & Reusable Components

### Core Features

#### User Management
- **Location**: `backend/app/routers/users.py`, `frontend/src/components/users/`
- **Capabilities**: CRUD, role assignment, company membership, guest access
- **Reusable**: User picker component, role selector

#### Agent System
- **Location**: `backend/app/routers/agents.py`, `backend/app/services/agents/`
- **Capabilities**: AI agent creation, chat, integrations, knowledge base
- **Reusable**: Agent picker, chat interface, integration patterns

#### Ticket/Request System
- **Location**: `backend/app/routers/tickets.py`, `frontend/src/components/tickets/`
- **Capabilities**: CRUD, assignment, status workflow, comments
- **Reusable**: Status badges, assignment picker, comment thread

#### Campaign Management
- **Location**: `backend/app/routers/campaigns.py`
- **Capabilities**: Campaign CRUD, scheduling, agent assignment
- **Reusable**: Date range picker, status workflow

#### Knowledge Base (RAG)
- **Location**: `backend/app/routers/knowledge_chunks.py`, `backend/app/services/rag/`
- **Capabilities**: Document upload, chunking, embedding, vector search
- **Reusable**: File uploader, chunk viewer, search interface

### Integration Features

#### Shopify Integration
- **Location**: `backend/app/services/agents/shopify_sync_service.py`
- **Capabilities**: Product sync, collection sync, blog article sync
- **Via**: Gadget.dev middleware
- **Reusable**: Sync button pattern, progress indicator

#### WordPress Integration
- **Location**: `backend/app/services/agents/wordpress_service.py`
- **Capabilities**: Post creation, media upload, featured images
- **Reusable**: Publishing modal, site picker

### UI Components (Reusable)

#### Data Tables
- **Pattern**: TanStack Table with Tailwind styling
- **Location**: `frontend/src/components/common/`
- **Features**: Sorting, filtering, pagination, selection

#### Forms
- **Pattern**: Catalyst UI inputs with React Hook Form
- **Features**: Validation, error display, loading states

#### Modals/Dialogs
- **Pattern**: HeadlessUI Dialog
- **Features**: Focus trap, backdrop, animations

#### Status Badges
- **Pattern**: Tailwind badges with color coding
- **Colors**:
  - Green: completed, active
  - Yellow: pending, in_progress
  - Red: failed, urgent
  - Gray: draft, inactive

### LLM Features

#### Text Generation
- **Endpoint**: `POST /api/llm/completion`
- **Models**: GPT-4o, Claude 3.5 Sonnet, etc.
- **Features**: Streaming, token limits, temperature

#### Brand Builder
- **Location**: `frontend/src/components/personas/`
- **Capabilities**: Guided questionnaire, AI assistance, persona generation
- **Reusable**: Question wizard pattern, "I'm Stuck" AI helper

#### Content Generation
- **Location**: `backend/app/services/content/`
- **Capabilities**: Blog posts, product descriptions, social media
- **Reusable**: Content type templates, tone settings

### Authentication Patterns

#### JWT Authentication
- **Location**: `backend/app/utils/auth.py`
- **Pattern**: `get_current_user` dependency
- **Token**: Bearer token in Authorization header

#### Role-Based Access
- **Location**: `backend/app/utils/permissions.py`
- **Pattern**: `@require_role(["admin", "manager"])` decorator
- **Roles**: superadmin, company_admin, content_manager, content_writer, client

### Common Patterns

#### CRUD Operations
```python
# Backend pattern
@router.get("/")
async def list_items(current_user = Depends(get_current_user)):
    service = ItemService()
    return await service.list_for_user(current_user)
```

#### Company Isolation
```python
# Always filter by company_id
query = {"company_id": user.get("company_id")}
```

#### Error Handling
```python
from fastapi import HTTPException

if not found:
    raise HTTPException(404, "Not found")
if not authorized:
    raise HTTPException(403, "Access denied")
```

#### API Response Format
```python
# List endpoints return:
{"data": [...], "total": 100}

# Single item endpoints return:
{"id": "...", "name": "...", ...}
```

### Recently Added Features

#### Shopify RAG Sync (v0.33.8)
- Products, Collections, Blog Articles sync to knowledge base
- Sync history tracking with timestamps
- KB selection persistence per agent

#### Brand Builder (v0.33.0)
- 5-category question system
- AI-powered "I'm Stuck" suggestions
- Persona generation from answers

#### Email OTP (In Progress)
- Login verification via email
- IP/region tracking
- Trusted device management

### Feature Dependencies

| Feature | Depends On |
|---------|------------|
| Agent Chat | Knowledge Base, LLM Providers |
| Shopify Sync | Agent System, Knowledge Base |
| WordPress Publish | Agent System, Content Generation |
| Campaign Scheduling | Agent System, Cron Jobs |
| RAG Search | Knowledge Base, Embeddings |

### Anti-Patterns (Don't Do)

1. **Hardcoded IDs** - Always use dynamic references
2. **MUI Components** - Use Tailwind/Catalyst instead
3. **localhost URLs** - Use relative paths
4. **Direct DB in routers** - Use service layer
5. **Skipping company_id** - Always filter by company
