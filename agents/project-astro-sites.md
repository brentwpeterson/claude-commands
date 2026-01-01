# Project Agent: astro-sites

**Project Type:** Multi-Site Astro Container
**Directory:** `/Users/brent/scripts/CB-Workspace/astro-sites`

---

## 🚨 CRITICAL RULES

### Scope Restrictions
- ✅ **CAN MODIFY:** Only files within `astro-sites/` directory
- ❌ **CANNOT MODIFY:** cb-requestdesk, cb-shopify, cb-wordpress, or other projects
- ❌ **CANNOT COMMIT:** To other project repositories

---

## 🌐 Sites Overview

| Site | Directory | Domain | Status |
|------|-----------|--------|--------|
| **requestdesk-ai** | `requestdesk-ai/` | requestdesk.ai | ✅ Active |
| **contentbasis-io** | `contentbasis-io/` | contentbasis.io | 🚧 Development |
| **contentbasis-ai** | `contentbasis-ai/` | contentbasis.ai | 📋 Planned |
| **magento-masters-com** | `magento-masters-com/` | magento-masters.com | 🧪 Test |

---

## 🚨 ARM64/AMD64 ARCHITECTURE - CRITICAL

### ⚠️ Apple Silicon builds ARM64 by default - AWS requires AMD64

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

## 🛠️ Local Development

### Individual Site Development
```bash
# RequestDesk.ai
cd requestdesk-ai && npm run dev

# ContentBasis.io
cd contentbasis-io && npm run dev

# Any site
cd [site-directory] && npm run dev
```

### Container Testing (.test domains)
```bash
# Build all sites
./deployment/build-all.sh

# Build and run container
docker build -f deployment/Dockerfile -t astro-sites .
docker run -d -p 8080:80 --name test astro-sites

# Add to /etc/hosts:
# 127.0.0.1 requestdesk.ai.test
# 127.0.0.1 contentbasis.io.test

# Test: http://requestdesk.ai.test:8080
```

---

## 🚀 Deployment

### RequestDesk.ai (Most Common)
```bash
# 1. Make changes to requestdesk-ai/
# 2. Build static site
cd requestdesk-ai && npm run build

# 3. Commit changes
git add -A && git commit -m "Description of changes"

# 4. Deploy via git tag
git tag main-site-v1.x.x-description
git push origin main-site-v1.x.x-description

# 5. Verify (4-6 minutes)
# Check https://requestdesk.ai
```

### Deployment Checklist Location
`requestdesk-ai/DEPLOYMENT-CHECKLIST.md`

---

## 📁 Project Structure

```
astro-sites/
├── README.md                    # Project overview
├── documentation/               # Universal guides
│   ├── deployment-guide.md
│   ├── local-development.md
│   ├── container-management.md
│   ├── aws-infrastructure.md
│   └── troubleshooting.md
├── deployment/                  # Docker & nginx config
│   ├── Dockerfile
│   ├── nginx.conf
│   └── build-all.sh
├── requestdesk-ai/              # RequestDesk.ai site
│   ├── src/
│   │   ├── components/
│   │   ├── layouts/
│   │   └── pages/
│   ├── public/
│   ├── astro.config.mjs
│   └── package.json
├── contentbasis-io/             # ContentBasis.io site
├── contentbasis-ai/             # ContentBasis.ai site
├── magento-masters-com/         # Test site
├── shared/                      # Shared resources
└── todo/                        # Task tracking
```

---

## 🔧 Technology Stack

| Component | Technology |
|-----------|------------|
| Framework | Astro 4.x |
| Styling | Tailwind CSS |
| Deployment | Docker → AWS ECS/Fargate |
| Web Server | nginx (multi-site routing) |
| CI/CD | Git tags trigger deployment |

---

## 🐳 Docker Configuration

### Multi-Site nginx Routing
The nginx configuration routes requests to the correct site based on domain:
- `requestdesk.ai` → `/usr/share/nginx/html/requestdesk-ai/`
- `contentbasis.io` → `/usr/share/nginx/html/contentbasis-io/`

### Build Script
```bash
./deployment/build-all.sh
# Builds all sites into dist/ directories
```

### Dockerfile Location
`deployment/Dockerfile`

---

## 📋 Adding a New Site

1. Create site directory: `[site-name]/`
2. Initialize Astro: `npm create astro@latest`
3. Add to `deployment/build-all.sh`
4. Add nginx routing in `deployment/nginx.conf`
5. Update `README.md` sites table

See: `documentation/container-management.md`

---

## 🔗 Cross-Domain API Calls

Sites may call RequestDesk API. See:
- `requestdesk-ai/CROSS-DOMAIN-API-CALLS.md`

### API URL Configuration
Use environment variables, never hardcode:
```javascript
const apiUrl = import.meta.env.PUBLIC_API_URL || 'https://app.requestdesk.ai'
```

---

## 📚 Required Documentation

Before working on astro-sites, read:
1. `documentation/deployment-guide.md`
2. `documentation/local-development.md`
3. Site-specific README (e.g., `requestdesk-ai/README.md`)

---

## ⚠️ Forbidden Actions

1. **Never build for AWS without `--platform linux/amd64`**
2. **Never deploy untested changes**
3. **Never hardcode API URLs** - use environment variables
4. **Never modify other CB projects**
5. **Never skip container testing** before AWS deployment

---

## 🚨 Emergency Rollback

If production fails:
1. Identify last working git tag
2. Deploy previous version:
   ```bash
   git checkout main-site-v1.x.x-previous
   git tag main-site-v1.x.x-rollback
   git push origin main-site-v1.x.x-rollback
   ```
3. Verify site is restored

---

## 🆘 Troubleshooting

See: `documentation/troubleshooting.md`

Common issues:
- **nginx 404s:** Check domain routing in nginx.conf
- **Build failures:** Verify npm dependencies
- **AWS deploy fails:** Check ARM64/AMD64 architecture
