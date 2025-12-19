# Backend Architecture (FastAPI)

## Directory Structure

```
backend/app/
├── main.py                 # FastAPI app initialization
├── config.py               # Configuration and secrets loading
├── database.py             # MongoDB connection
├── routers/                # API endpoints (thin layer)
│   ├── auth.py             # Authentication endpoints
│   ├── users.py            # User management
│   ├── agents.py           # Agent CRUD and integrations
│   ├── tickets.py          # Ticket/request management
│   ├── campaigns.py        # Campaign management
│   ├── knowledge_chunks.py # RAG knowledge base
│   ├── llm.py              # LLM completion endpoints
│   └── ...
├── services/               # Business logic (thick layer)
│   ├── user_service.py
│   ├── agent_service.py
│   ├── ticket_service.py
│   ├── llm_service.py
│   └── agents/             # Agent-specific services
│       ├── agent_integration_service.py
│       ├── shopify_sync_service.py
│       └── wordpress_service.py
├── models/                 # Pydantic models
│   ├── user.py
│   ├── agent.py
│   ├── ticket.py
│   └── ...
├── migrations/             # Database migrations
│   ├── migration_manager.py
│   └── versions/
└── utils/                  # Shared utilities
    ├── auth.py             # JWT and authentication
    └── permissions.py      # Role-based access
```

## 🚨 FILE SIZE LIMITS - CRITICAL

**Target: < 300 lines per file. Never keep adding to existing files.**

Current problem files (DO NOT make these worse):
- `llm.py` - 2,447 lines ❌
- `config.py` - 2,217 lines ❌
- `brand_personas.py` - 2,138 lines ❌

**When a file approaches 300 lines → Convert to modular structure**

## Modular Router Pattern (PREFERRED)

For any router with multiple features, use the v2/tickets pattern:

```
routers/v2/{resource}/
├── __init__.py           # Router composition only (< 100 lines)
├── core/
│   ├── __init__.py
│   ├── create.py         # POST endpoints
│   ├── read.py           # GET endpoints
│   ├── update.py         # PUT/PATCH endpoints
│   ├── delete.py         # DELETE endpoints
│   └── status.py         # Status transitions
├── features/
│   ├── __init__.py
│   ├── assignment.py     # Feature-specific endpoints
│   ├── archive.py
│   └── followers.py
├── notifications/
│   ├── __init__.py
│   └── status_notifications.py
└── utils/
    ├── __init__.py
    ├── validators.py     # Input validation
    ├── permissions.py    # Access control
    └── helpers.py        # Shared utilities
```

### Main `__init__.py` (Router Composition)

```python
"""
Resource Router Assembly
Max 100 lines - Only router composition, no business logic
"""
from fastapi import APIRouter
from .core import create, read, update, delete
from .features import assignment, archive

router = APIRouter(prefix="/resource", tags=["resource"])

# Include core CRUD routers
router.include_router(create.router)
router.include_router(read.router)
router.include_router(update.router)
router.include_router(delete.router)

# Include feature routers
router.include_router(assignment.router)
router.include_router(archive.router)

__all__ = ["router"]
```

### Feature Module Example

```python
# features/assignment.py
from fastapi import APIRouter, Depends
from app.utils.auth import get_current_user

router = APIRouter()

@router.post("/{id}/assign")
async def assign_resource(
    id: str,
    user_id: str,
    current_user: dict = Depends(get_current_user)
):
    """Assign resource to a user"""
    # Implementation
    pass
```

## Simple Router Pattern (Small Resources Only)

Only use for resources with < 300 lines total:

```python
from fastapi import APIRouter, Depends, HTTPException
from app.utils.auth import get_current_user
from app.services.example_service import ExampleService

router = APIRouter(prefix="/api/examples", tags=["examples"])

@router.get("/")
async def list_examples(
    current_user: dict = Depends(get_current_user),
    skip: int = 0,
    limit: int = 100
):
    """List examples - filtered by user's company"""
    service = ExampleService()
    return await service.list_for_user(current_user, skip, limit)

@router.post("/")
async def create_example(
    data: ExampleCreate,
    current_user: dict = Depends(get_current_user)
):
    """Create example - auto-assigns to user's company"""
    service = ExampleService()
    return await service.create(data, current_user)
```

## Service Pattern

```python
from app.database import get_database
from bson import ObjectId

class ExampleService:
    def __init__(self):
        self.db = get_database()
        self.collection = self.db.examples

    async def list_for_user(self, user: dict, skip: int, limit: int):
        """List examples filtered by company"""
        company_id = user.get("company_id")
        query = {"company_id": company_id}

        cursor = self.collection.find(query).skip(skip).limit(limit)
        return list(cursor)

    async def create(self, data: ExampleCreate, user: dict):
        """Create with automatic company assignment"""
        doc = data.dict()
        doc["company_id"] = user.get("company_id")
        doc["created_by"] = str(user.get("_id"))
        doc["created_at"] = datetime.utcnow()

        result = self.collection.insert_one(doc)
        doc["_id"] = result.inserted_id
        return doc
```

## Authentication

```python
# Getting current user in any endpoint
from app.utils.auth import get_current_user

@router.get("/protected")
async def protected_endpoint(current_user: dict = Depends(get_current_user)):
    # current_user contains:
    # - _id: ObjectId
    # - username: str
    # - email: str
    # - role: str (superadmin, company_admin, content_manager, content_writer, client)
    # - company_id: str
    # - is_active: bool
    pass
```

## Common Patterns

### Company Filtering
```python
# ALWAYS filter by company_id for multi-tenant isolation
query = {"company_id": user.get("company_id")}
```

### Role Checking
```python
from app.utils.permissions import require_role

@router.delete("/{id}")
@require_role(["superadmin", "company_admin"])
async def delete_item(id: str, current_user: dict = Depends(get_current_user)):
    pass
```

### Error Handling
```python
from fastapi import HTTPException

if not item:
    raise HTTPException(status_code=404, detail="Item not found")

if not has_permission:
    raise HTTPException(status_code=403, detail="Access denied")
```

### Pagination Response
```python
# React Admin expects this format
return {
    "data": items,
    "total": total_count
}
```

## Key Endpoints Reference

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/auth/token` | POST | Login (form-encoded) |
| `/auth/me` | GET | Current user info |
| `/api/users` | CRUD | User management |
| `/api/agents` | CRUD | Agent management |
| `/api/agents/{id}/chat` | POST | Chat with agent |
| `/api/tickets` | CRUD | Ticket management |
| `/api/campaigns` | CRUD | Campaign management |
| `/api/knowledge_chunks` | CRUD | RAG knowledge base |
| `/api/llm/completion` | POST | LLM text generation |

## Environment Variables

```python
# Loaded from AWS Secrets Manager in production
MONGO_URI = "mongodb://..."
JWT_SECRET = "..."
OPENAI_API_KEY = "..."
ANTHROPIC_API_KEY = "..."
AWS_S3_BUCKET = "..."
```
