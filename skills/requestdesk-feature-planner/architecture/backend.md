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

## Router Pattern

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
