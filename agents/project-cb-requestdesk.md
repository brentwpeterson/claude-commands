# Project Agent: cb-requestdesk

**Project Type:** Main RequestDesk Application (FastAPI + React)
**Directory:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk`

---

## 🚨 CRITICAL RULES

### Scope Restrictions
- ✅ **CAN MODIFY:** Only files within `cb-requestdesk/` directory
- ❌ **CANNOT MODIFY:** cb-shopify, cb-wordpress, astro-sites, or other projects
- ❌ **CANNOT COMMIT:** To other project repositories

### Cross-Project Work
When needing Gadget/Shopify changes:
1. **DO NOT** modify cb-shopify code
2. **READ** handoff documents from `.claude/cross-project-handoffs/`
3. **REQUEST** changes via handoff document if needed
4. **LET** cb-shopify Claude handle Gadget changes

---

## 🐳 DOCKER-ONLY DEVELOPMENT

### ⚠️ THIS PROJECT USES DOCKER - NEVER INSTALL LOCALLY

```bash
# Start development environment
docker-compose up -d

# View logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Rebuild after dependency changes
docker-compose build --no-cache
docker-compose up -d
```

### ❌ NEVER DO
- `pip install` locally
- `npm install` locally
- `npm run dev` locally
- Run Python/Node outside Docker

### Hot Reload
- Backend: Auto-reloads on Python file changes
- Frontend: Auto-reloads on React file changes
- Only rebuild containers when adding NEW dependencies

---

## 🗄️ DATABASE: MongoDB (NO DOCKER)

### ⚠️ NEVER ADD MONGODB TO DOCKER-COMPOSE

| Environment | MongoDB Location |
|-------------|------------------|
| Local Dev | `host.docker.internal:27017` (local install) |
| Production | MongoDB Atlas (cloud) |

- Connection via `MONGO_URI` environment variable
- **DO NOT** add `mongo`, `mongodb`, or `mongodb8` services to docker-compose.yml

---

## 🚀 AWS Deployment

### ⚠️ ARM64/AMD64 ARCHITECTURE - CRITICAL

**Apple Silicon builds ARM64 by default - AWS Fargate requires AMD64**

```bash
# CORRECT - Always use platform flag
docker build --platform linux/amd64 -t image:tag .

# WRONG - Will fail in AWS
docker build -t image:tag .
```

### Verify Architecture
```bash
docker image inspect image:tag --format '{{.Architecture}}'
# Must output: amd64
```

---

## 📁 Key Directories

```
cb-requestdesk/
├── backend/
│   ├── app/
│   │   ├── api/           # API routes
│   │   ├── models/        # MongoDB models
│   │   ├── services/      # Business logic
│   │   └── core/          # Config, auth, etc.
│   ├── tests/
│   │   └── curl_scripts/  # API test scripts
│   └── requirements.txt
├── frontend/
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── pages/         # Page components
│   │   └── dataProvider/  # API integration
│   └── package.json
├── docker/                # Docker configs
├── documentation/         # User & tech docs
├── scripts/              # Utility scripts
├── tmp/                  # Temporary files (USE THIS, not /tmp/)
└── todo/                 # Task tracking
```

---

## 🔐 Security Rules

### NEVER Hardcode
- ❌ API keys, tokens, secrets
- ❌ `localhost:3000` or `localhost:3001` URLs
- ❌ Database IDs (`"68854c9c7f7e1c55ff8e6f07"`)
- ❌ Usernames (`'brent'`, `'admin'`)
- ❌ Company IDs or user IDs

### ALWAYS Use
- ✅ Environment variables: `os.environ.get()`
- ✅ Relative URLs: `/api/endpoint` not `http://localhost:3000/api/endpoint`
- ✅ JWT context: `jwtData.company_id`
- ✅ Role-based logic: `userRole === 'admin'`

---

## 👥 Multi-Company System

### User-Company Relationship
- **Primary Company:** Every user has their OWN company (created on registration)
- **Guest Companies:** Users can be INVITED to other companies
- **NOT Automatic:** Registration ≠ Invitation acceptance

### ❌ Wrong Assumption
"User should get inviter's company during registration"

### ✅ Correct Flow
1. User registers → gets own company
2. User accepts invitation → becomes guest of inviter's company

---

## 🌐 URL Routing

### ⚠️ NO HASH-BASED URLs

```bash
# WRONG - Hash routing doesn't work
http://localhost:3001/#/blog-posts

# CORRECT - Direct URLs
http://localhost:3001/blog-posts
```

---

## 📂 Temporary Files

### Use Project tmp/, NOT System /tmp/

```bash
# CORRECT
/Users/brent/scripts/CB-Workspace/cb-requestdesk/tmp/test-file.csv

# WRONG
/tmp/test-file.csv
```

---

## 🔧 Technology Stack

| Layer | Technology |
|-------|------------|
| Backend | FastAPI (Python 3.11+) |
| Frontend | React + React-Admin |
| Database | MongoDB (Beanie ODM) |
| Auth | JWT tokens |
| Deployment | Docker → AWS ECS/Fargate |
| AI | OpenAI, Anthropic APIs |

---

## 🧪 Testing

### Backend API Tests
```bash
# Run curl test scripts
./backend/tests/curl_scripts/[feature]/test-*.sh
```

### Docker Container Access
```bash
# Execute commands in backend container
docker-compose exec backend bash

# Run pytest inside container
docker-compose exec backend pytest
```

---

## 🤝 Shopify Integration

### Gadget Endpoints (from cb-shopify)
- Products: `https://contentbasis--client.gadget.app/public/products`
- Collections: `https://contentbasis--client.gadget.app/public/collections`

### Auth Header
```
x-requestdesk-api-key: <API_KEY>
```

### ⚠️ DO NOT
- Modify cb-shopify code
- Use `x-api-key` (wrong header)
- Call production Gadget without deploying first

---

## ⚠️ Forbidden Actions

1. **Never install dependencies locally** - Use Docker only
2. **Never add MongoDB to docker-compose**
3. **Never hardcode URLs, IDs, usernames, or secrets**
4. **Never use hash-based URLs** (`#/route`)
5. **Never build for AWS without `--platform linux/amd64`**
6. **Never modify other CB projects** - Use handoffs
7. **Never use system /tmp/** - Use project tmp/
