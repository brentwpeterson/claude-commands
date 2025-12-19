# Infrastructure Architecture (AWS)

## Overview

RequestDesk runs on AWS ECS Fargate with the following components:

```
┌─────────────────────────────────────────────────────────────────┐
│                         CLOUDFLARE                               │
│                  DNS + CDN + DDoS Protection                     │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                    APPLICATION LOAD BALANCER                     │
│                         (AWS ALB)                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ api.request  │  │ app.request  │  │ docs.request │          │
│  │ desk.ai:443  │  │ desk.ai:443  │  │ desk.ai:443  │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        AWS ECS FARGATE                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │   Backend    │  │   Frontend   │  │     Docs     │          │
│  │   (FastAPI)  │  │   (React)    │  │   (Astro)    │          │
│  │   Port 8000  │  │   Port 80    │  │   Port 80    │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      EXTERNAL SERVICES                           │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │ MongoDB Atlas│  │   AWS S3     │  │ AWS Secrets  │          │
│  │  (Database)  │  │   (Files)    │  │   Manager    │          │
│  └──────────────┘  └──────────────┘  └──────────────┘          │
└─────────────────────────────────────────────────────────────────┘
```

## AWS Services Used

| Service | Purpose |
|---------|---------|
| ECS Fargate | Container orchestration (no servers to manage) |
| ECR | Docker image registry |
| ALB | Load balancer with SSL termination |
| S3 | File storage (uploads, exports) |
| Secrets Manager | API keys, database credentials |
| CloudWatch | Logs and monitoring |
| Route 53 | DNS (backup to Cloudflare) |
| ACM | SSL certificates |

## Deployment

### Tag-Based Deployment

Deployments are triggered by git tags pushed to GitHub:

| Tag Pattern | Deploys | Build Time |
|-------------|---------|------------|
| `matrix-v*` | Backend + Frontend (parallel) | ~25 min |
| `matrix-v*-fresh-*` | Backend + Frontend (no cache) | ~35 min |
| `app-v*` | Backend + Frontend (sequential) | ~50 min |
| `frontend-v*` | Frontend only | ~15 min |
| `backend-v*` | Backend only | ~20 min |
| `docs-v*` | Documentation site | ~10 min |
| `hotfix-v*` | Emergency deployment | ~20 min |

### Deployment Process

```bash
# 1. Merge to master
git checkout master
git merge feature/my-feature

# 2. Create and push tag
git tag matrix-v0.33.8-my-feature
git push origin matrix-v0.33.8-my-feature

# 3. GitHub Actions builds and deploys
# Monitor at: https://github.com/brentwpeterson/cb-app/actions
```

### ⚠️ CRITICAL: ARM64/AMD64

**Apple Silicon builds ARM64 by default - AWS Fargate requires AMD64!**

```bash
# ✅ CORRECT
docker build --platform linux/amd64 -t image:tag .

# ❌ WRONG (will fail on AWS)
docker build -t image:tag .
```

## Environment Variables

### Production (via AWS Secrets Manager)

```
MONGO_URI=mongodb+srv://...
JWT_SECRET=...
OPENAI_API_KEY=...
ANTHROPIC_API_KEY=...
AWS_S3_BUCKET=cb-app-uploads
AWS_REGION=us-east-1
```

### Local (via .env file)

```
MONGO_URI=mongodb://host.docker.internal:27017/requestdesk_prod
JWT_SECRET=local-dev-secret
# API keys from local config
```

## Docker Compose (Local Development)

```yaml
services:
  backend:
    build: ./backend
    ports:
      - "3000:8000"
    volumes:
      - ./backend:/app  # Hot reload
    environment:
      - MONGO_URI=mongodb://host.docker.internal:27017/requestdesk_prod

  frontend:
    build: ./frontend
    ports:
      - "3001:80"
    volumes:
      - ./frontend/src:/app/src  # Hot reload
```

## Health Checks

| Endpoint | Purpose |
|----------|---------|
| `/api/health` | Backend health (ALB target group) |
| `/api/current_version` | Version info for frontend footer |

**DO NOT MODIFY** these endpoints - ALB depends on them.

## Logging

### View Logs
```bash
# Local
docker logs cbtextapp-backend-1 --tail 100 -f

# Production (AWS CloudWatch)
aws logs get-log-events \
  --log-group-name "/ecs/cb-app-backend" \
  --log-stream-name "ecs/backend/TASK_ID"
```

### Log Groups
- `/ecs/cb-app-backend` - Backend application logs
- `/ecs/cb-app-frontend` - Frontend nginx logs
- `/ecs/cb-app-docs` - Documentation site logs

## Scaling

- **Current**: Single task per service (cost optimization)
- **Auto-scaling**: Available but not enabled
- **Manual**: Can increase task count in ECS console

## Costs

| Service | Approximate Monthly |
|---------|-------------------|
| ECS Fargate | $50-100 |
| MongoDB Atlas | $60 |
| ALB | $20 |
| S3 | $5 |
| Other | $15 |
| **Total** | **~$150-200** |

## Monitoring

- **Health**: ALB target group health checks
- **Errors**: Sentry integration (backend)
- **Logs**: CloudWatch Logs
- **Metrics**: CloudWatch Metrics (CPU, Memory)
