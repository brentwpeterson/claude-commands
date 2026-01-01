# Project Agent: cb-shopify

**Project Type:** Gadget Platform App (Shopify Integration)
**Directory:** `/Users/brent/scripts/CB-Workspace/cb-shopify`

---

## 🚨 CRITICAL RULES

### Scope Restrictions
- ✅ **CAN MODIFY:** Only files within `cb-shopify/` directory
- ❌ **CANNOT MODIFY:** Any other CB-Workspace projects (cb-requestdesk, cb-wordpress, etc.)
- ❌ **CANNOT COMMIT:** To other project repositories

### Cross-Project Work
When RequestDesk or other projects need Gadget changes:
1. **DO NOT** modify their code
2. **CREATE** a handoff document in `.claude/cross-project-handoffs/`
3. **DOCUMENT** the endpoints/APIs available
4. **LET** the appropriate project agent implement their side

---

## 🔧 Technology Stack

| Layer | Technology |
|-------|------------|
| Platform | Gadget.dev |
| Backend | TypeScript (Gadget Actions/Routes) |
| Frontend | React + Shopify Polaris |
| Database | Gadget Models (auto-synced from Shopify) |
| Auth | Shopify OAuth + API Keys |

---

## 🚀 Deployment

### ⚠️ GADGET USES DIRECT SYNC - NOT GIT

```bash
# Development - syncs files in real-time
ggt dev --env=client

# Check sync status
ggt status
```

### Environments
| Environment | URL | Deployment |
|-------------|-----|------------|
| Client (Dev) | `https://contentbasis--client.gadget.app` | Auto via `ggt dev` |
| Production | `https://contentbasis.gadget.app` | **Web UI only** |

### Production Deployment
1. Go to: https://contentbasis.gadget.app/edit/client
2. Click **"Deploy"** button (top right)
3. This promotes client → production

### ❌ DO NOT
- Use `ggt deploy --env=production` (will fail)
- Push to git expecting deployment
- Use GitHub Actions for Gadget deployment

---

## 📁 Key Directories

```
cb-shopify/
├── api/
│   ├── actions/          # Gadget global actions
│   ├── models/           # Gadget data models
│   ├── routes/           # HTTP API endpoints ← PUBLIC ENDPOINTS HERE
│   │   └── public/       # RequestDesk-accessible endpoints
│   │       ├── products/
│   │       ├── collections/
│   │       ├── articles/
│   │       └── blogs/
│   └── utils/            # Shared utilities
├── web/
│   └── routes/           # React frontend pages
├── plugin-releases/      # WordPress plugin (NOT Gadget routes!)
└── todo/                 # Task tracking
```

### ⚠️ Common Mistake
`plugin-releases/` is for WordPress connector releases, NOT Gadget API routes.
Gadget routes go in `api/routes/`.

---

## 🔐 Authentication Pattern

### RequestDesk API Access
Public endpoints use `x-requestdesk-api-key` header:

```typescript
// Get API key from headers
const apiKey = request.headers['x-requestdesk-api-key'] as string ||
               request.headers['x-api-key'] as string;

// Validate against requestDeskAccount table
const accounts = await api.requestDeskAccount.findMany({...});
const account = accounts.find(acc => acc.apiKey === apiKey);
```

### ❌ DO NOT
- Use different auth headers than existing endpoints
- Create new auth mechanisms without consulting products endpoint pattern

---

## 📡 Available Public Endpoints

| Endpoint | Method | Purpose |
|----------|--------|---------|
| `/public/products` | GET | Fetch Shopify products for RAG |
| `/public/collections` | GET | Fetch Shopify collections for RAG |
| `/public/blogs` | GET | List Shopify blogs |
| `/public/articles` | GET | Fetch blog articles for RAG |

All endpoints require `x-requestdesk-api-key` header.

---

## 🤝 Cross-Project Handoff Protocol

When cb-requestdesk (or other project) needs Gadget functionality:

### Step 1: Implement in cb-shopify
Create/modify the Gadget endpoint following existing patterns.

### Step 2: Create Handoff Document
```bash
.claude/cross-project-handoffs/shopify-to-requestdesk-YYYY-MM-DD.md
```

Include:
- Endpoint URLs and methods
- Request/response formats
- Authentication requirements
- Example curl commands

### Step 3: Notify
Document what the other project needs to do on their side.

---

## 🧪 Testing

### Test Endpoints Locally
```bash
# Products
curl -s -H "x-requestdesk-api-key: API_KEY" \
  "https://contentbasis--client.gadget.app/public/products?limit=2"

# Collections
curl -s -H "x-requestdesk-api-key: API_KEY" \
  "https://contentbasis--client.gadget.app/public/collections"
```

### Verify Sync Status
```bash
ggt status
# Should show "Your files are up to date"
```

---

## 📋 Task Workflow

1. **Create branch:** `git checkout -b feature/task-name`
2. **Create todo:** `todo/current/feature/task-name/`
3. **Start Gadget sync:** `ggt dev --env=client`
4. **Implement & test:** Changes sync automatically
5. **Commit to git:** For version control (not deployment)
6. **Merge to main:** When complete
7. **Deploy production:** Via Gadget web UI (if ready)

---

## ⚠️ Forbidden Actions

1. **Never modify cb-requestdesk, cb-wordpress, or other projects**
2. **Never use `ggt deploy`** - it doesn't work for production
3. **Never put Gadget routes in `plugin-releases/`**
4. **Never hardcode API keys**
5. **Never create new auth patterns** - follow existing `requestDeskAccount` pattern
