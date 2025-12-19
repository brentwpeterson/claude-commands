# RequestDesk Architecture Overview

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        FRONTEND (React)                          │
│  localhost:3001 / app.requestdesk.ai                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐               │
│  │  Tailwind   │ │ Catalyst UI │ │  TanStack   │               │
│  │    CSS      │ │ + HeadlessUI│ │   Table     │               │
│  └─────────────┘ └─────────────┘ └─────────────┘               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼ HTTP/REST
┌─────────────────────────────────────────────────────────────────┐
│                        BACKEND (FastAPI)                         │
│  localhost:3000 / api.requestdesk.ai                            │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐               │
│  │   Routers   │ │  Services   │ │   Models    │               │
│  │  (API Layer)│ │  (Business) │ │  (Pydantic) │               │
│  └─────────────┘ └─────────────┘ └─────────────┘               │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼ PyMongo
┌─────────────────────────────────────────────────────────────────┐
│                      DATABASE (MongoDB 8)                        │
│  localhost:27017 (local) / MongoDB Atlas (production)           │
│  ┌─────────────┐ ┌─────────────┐ ┌─────────────┐               │
│  │   users     │ │   agents    │ │   tickets   │               │
│  │  companies  │ │  campaigns  │ │    ...      │               │
│  └─────────────┘ └─────────────┘ └─────────────┘               │
└─────────────────────────────────────────────────────────────────┘
```

## Request Flow Pattern

```
User Action → React Component → DataProvider → API Endpoint → Router → Service → Database
                                                                          ↓
User Sees   ← React Component ← DataProvider ← API Response  ← Router ← Service
```

## Key Architecture Principles

### 1. Multi-Tenant by Company
- Every user belongs to a company
- All data queries filter by `company_id`
- Users can be guests in multiple companies
- Company isolation is enforced at service layer

### 2. Role-Based Access Control
| Role | Access Level |
|------|-------------|
| `superadmin` | All companies, all data |
| `company_admin` | Own company, all features |
| `content_manager` | Own company, manage content/writers |
| `content_writer` | Own assignments only |
| `client` | Own tickets/requests only |

### 3. Service Layer Pattern
- **Routers**: HTTP handling, request validation, response formatting
- **Services**: Business logic, data access, cross-cutting concerns
- **Models**: Pydantic schemas for validation and serialization

### 4. Docker Development
- All development happens in Docker containers
- Backend auto-reloads on Python file changes
- Frontend auto-reloads on React file changes
- Never install dependencies locally

## Environment URLs

| Environment | Frontend | Backend |
|-------------|----------|---------|
| Local | http://localhost:3001 | http://localhost:3000 |
| Production | https://app.requestdesk.ai | https://api.requestdesk.ai |

## External Integrations

| Integration | Purpose | Connection |
|-------------|---------|------------|
| MongoDB Atlas | Production database | Via AWS Secrets Manager |
| AWS S3 | File storage | Direct SDK |
| OpenAI | LLM completions | API key in secrets |
| Anthropic | Claude models | API key in secrets |
| Shopify | E-commerce sync | Via Gadget.dev |
| WordPress | Blog publishing | REST API |
