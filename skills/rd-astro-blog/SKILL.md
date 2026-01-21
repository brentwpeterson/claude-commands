# RequestDesk Astro Blog - SSR Architecture

**Skill Description:** Managing the RequestDesk.ai blog which uses Astro SSR with Node.js to fetch content from the RequestDesk API with secure server-side authentication.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    ECS Container                            │
│  ┌─────────────────────────────────────────────────────┐   │
│  │                   Supervisord                        │   │
│  │  ┌─────────────┐          ┌─────────────────────┐   │   │
│  │  │   Nginx     │  proxy   │   Node.js (Astro)   │   │   │
│  │  │  Port 3003  │ ──────►  │     Port 4321       │   │   │
│  │  │             │  /blog/* │                     │   │   │
│  │  └─────────────┘          └─────────────────────┘   │   │
│  └─────────────────────────────────────────────────────┘   │
│                              │                              │
│                              │ AGENT_API_KEY                │
│                              ▼                              │
│              AWS Secrets Manager (cb-app/astro-agent)       │
└─────────────────────────────────────────────────────────────┘
                               │
                               │ Authorization: Bearer [key]
                               ▼
                    ┌─────────────────────┐
                    │  RequestDesk API    │
                    │  /api/astro-proxy/  │
                    │    blog-posts       │
                    └─────────────────────┘
```

## Key Components

| Component | Location | Purpose |
|-----------|----------|---------|
| **Blog Index** | `requestdesk-ai/src/pages/blog/index.astro` | Lists all published posts |
| **Single Post** | `requestdesk-ai/src/pages/blog/[slug].astro` | Displays individual post |
| **Nginx Config** | `deployment/nginx.conf` | Proxies /blog/* to SSR |
| **Dockerfile** | `deployment/Dockerfile` | Builds nginx + Node.js container |
| **Supervisord** | `deployment/supervisord.conf` | Manages both processes |
| **Task Definition** | `docker/main-site-task-definition.json` | ECS config with secrets |

---

## API Endpoints

### Backend (RequestDesk API)

| Endpoint | Method | Auth | Purpose |
|----------|--------|------|---------|
| `/api/astro-proxy/blog-posts` | GET | Bearer token | List published posts |
| `/api/astro-proxy/blog-posts/{slug}` | GET | Bearer token | Get single post by slug |

**Query Parameters (list endpoint):**
- `page` - Page number (default: 1)
- `per_page` - Posts per page (default: 12)

**Response Format:**
```json
{
  "data": {
    "posts": [...],
    "pagination": {
      "total": 10,
      "page": 1,
      "per_page": 12,
      "has_more": false
    }
  }
}
```

### Backend Code Location

- Router: `backend/app/routers/public/astro_proxy.py`
- Registered in: `backend/app/main.py`

---

## Environment Variables

| Variable | Source | Used By | Purpose |
|----------|--------|---------|---------|
| `AGENT_API_KEY` | AWS Secrets Manager | Astro SSR | Auth token for API calls |
| `BACKEND_URL` | Supervisord config | Astro SSR | API base URL (default: https://app.requestdesk.ai) |
| `HOST` | Supervisord config | Astro SSR | Bind address (127.0.0.1) |
| `PORT` | Supervisord config | Astro SSR | SSR server port (4321) |

### AWS Secret

- **Name:** `cb-app/astro-agent`
- **ARN:** `arn:aws:secretsmanager:us-east-1:973753295447:secret:cb-app/astro-agent-SYNVNP`
- **Key:** `AGENT_API_KEY`
- **Value:** `ZNgUN47QKeykN8voMmRbuyRT1G3edDxo`

---

## Adding Blog Posts

Blog posts are created in the RequestDesk app, not in Astro code.

### Via RequestDesk App

1. Go to: https://app.requestdesk.ai
2. Navigate to Content section
3. Create a new post with:
   - Title
   - Slug (URL-friendly)
   - Content (HTML)
   - Featured image (optional)
   - Categories/tags (optional)
   - Status: **Published** (required to appear on blog)

### Post Requirements

| Field | Required | Notes |
|-------|----------|-------|
| `title` | Yes | Display title |
| `slug` | Yes | URL path (e.g., `my-first-post`) |
| `content` | Yes | HTML content |
| `status` | Yes | Must be "published" to show |
| `published_at` | Yes | Publication date |
| `featured_image` | No | Full URL to image |
| `excerpt` | No | Short summary |
| `categories` | No | Array of category names |
| `tags` | No | Array of tag names |
| `word_count` | No | For read time calculation |

---

## Deployment

### Tag Pattern

```
main-site-v[MAJOR].[MINOR].[PATCH]-[description]
```

**Examples:**
- `main-site-v1.16.0-blog-ssr-node` - Major architecture change
- `main-site-v1.16.1-ssr-env-fix` - Bug fix

### Deployment Steps

1. Commit changes to master
2. Create and push tag:
   ```bash
   git tag main-site-v1.X.X-description
   git push origin main-site-v1.X.X-description
   ```
3. GitHub Actions builds and deploys to ECS
4. Verify at https://requestdesk.ai/blog/

### Build Process

1. **Builder stage:** Builds all Astro sites
2. **Production stage:**
   - Base: `node:20-alpine`
   - Installs nginx + supervisor
   - Copies static files to nginx html
   - Copies SSR server files
   - Starts supervisord (manages nginx + node)

---

## Troubleshooting

### Blog shows "Unable to load posts"

**Cause:** SSR server can't reach the API or API key is invalid.

**Check:**
1. Verify API works directly:
   ```bash
   curl -s "https://app.requestdesk.ai/api/astro-proxy/blog-posts" \
     -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" | jq
   ```
2. Check ECS task logs in CloudWatch
3. Verify AWS secret exists and is correct

### Blog shows 403 Forbidden

**Cause:** Nginx can't find the file/route.

**Check:**
1. Verify nginx config has `/blog` proxy rule
2. Check if SSR server is running (supervisord)
3. Look for nginx error logs

### Single post shows "Post Not Found"

**Cause:** Post doesn't exist, isn't published, or API call failed.

**Check:**
1. Verify post exists and is published in RequestDesk
2. Test single post endpoint:
   ```bash
   curl -s "https://app.requestdesk.ai/api/astro-proxy/blog-posts/[slug]" \
     -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" | jq
   ```

### Environment variables not working

**Cause:** Using `import.meta.env` instead of `process.env`.

**Fix:** In Astro SSR with Node adapter, use `process.env` for runtime variables:
```javascript
// WRONG (build-time only)
const API_KEY = import.meta.env.AGENT_API_KEY;

// RIGHT (runtime)
const API_KEY = process.env.AGENT_API_KEY;
```

---

## Creating a Blog for Another Astro Site

To add an SSR blog to another Astro site (e.g., contentbasis.io), follow these steps:

### Step 1: Create the Astro Blog Pages

1. **Create blog directory:**
   ```
   [site]/src/pages/blog/
   ```

2. **Create index.astro** (list page):
   ```astro
   ---
   export const prerender = false;

   const API_KEY = process.env.AGENT_API_KEY;
   const BACKEND_URL = process.env.BACKEND_URL || 'https://app.requestdesk.ai';

   const response = await fetch(`${BACKEND_URL}/api/astro-proxy/blog-posts`, {
     headers: { 'Authorization': `Bearer ${API_KEY}` }
   });
   const data = await response.json();
   const posts = data.data?.posts || [];
   ---
   <!-- Render posts -->
   ```

3. **Create [slug].astro** (single post page):
   ```astro
   ---
   export const prerender = false;
   const { slug } = Astro.params;

   const API_KEY = process.env.AGENT_API_KEY;
   const BACKEND_URL = process.env.BACKEND_URL || 'https://app.requestdesk.ai';

   const response = await fetch(`${BACKEND_URL}/api/astro-proxy/blog-posts/${slug}`, {
     headers: { 'Authorization': `Bearer ${API_KEY}` }
   });
   const data = await response.json();
   const post = data.data?.post;
   ---
   <!-- Render post -->
   ```

### Step 2: Configure Astro for Hybrid Mode

In `astro.config.mjs`:
```javascript
import node from '@astrojs/node';

export default defineConfig({
  output: 'hybrid',  // Static by default, SSR for prerender: false
  adapter: node({ mode: 'standalone' })
});
```

### Step 3: Update Nginx Config

Add proxy rule for the new site in `deployment/nginx.conf`:
```nginx
# [site-name] server
server {
    listen 3003;
    server_name [domain];
    root /usr/share/nginx/html/[site-name];

    # Blog routes - proxy to Astro SSR server
    location /blog {
        proxy_pass http://astro_ssr;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_buffering off;
    }

    # Other routes...
}
```

### Step 4: Update Dockerfile

If the site is new to SSR, add to `deployment/Dockerfile`:
```dockerfile
# Copy SSR server for new site
COPY --from=builder /app/[site-name]/dist/server /app/[site-name]/server
COPY --from=builder /app/[site-name]/node_modules /app/[site-name]/node_modules
```

### Step 5: Create/Reuse API Key

Either use the existing `cb-app/astro-agent` secret or create a new one (see "Updating the API Key" section below).

### Step 6: Deploy

```bash
git commit -am "Add SSR blog to [site-name]"
git tag main-site-v[X.X.X]-[site]-blog
git push origin main-site-v[X.X.X]-[site]-blog
```

---

## Updating the API Key

If the API key needs to be rotated or changed:

### Step 1: Generate New Key in RequestDesk

1. Go to https://app.requestdesk.ai
2. Navigate to Settings > API Keys
3. Create a new agent API key
4. Copy the new key value

### Step 2: Update AWS Secrets Manager

**Via AWS Console:**
1. Go to AWS Secrets Manager: https://console.aws.amazon.com/secretsmanager
2. Find secret: `cb-app/astro-agent`
3. Click "Retrieve secret value" > "Edit"
4. Update `AGENT_API_KEY` value
5. Save

**Via AWS CLI:**
```bash
aws secretsmanager update-secret \
  --secret-id cb-app/astro-agent \
  --secret-string '{"AGENT_API_KEY":"NEW_KEY_VALUE_HERE"}'
```

### Step 3: Restart ECS Tasks

The new secret value is pulled when tasks start. Force a new deployment:

**Via AWS Console:**
1. Go to ECS > Clusters > cb-app-cluster
2. Find service: cb-app-main-site
3. Click "Update service"
4. Check "Force new deployment"
5. Click "Update service"

**Via AWS CLI:**
```bash
aws ecs update-service \
  --cluster cb-app-cluster \
  --service cb-app-main-site \
  --force-new-deployment
```

### Step 4: Verify

Wait for new tasks to be running, then test:
```bash
curl -s "https://requestdesk.ai/blog/" | grep -o "Unable to load\|Hello World"
```

### Creating a New Secret (for different sites)

If you need a separate API key for another site:

1. **Create secret in AWS:**
   ```bash
   aws secretsmanager create-secret \
     --name cb-app/[site-name]-agent \
     --secret-string '{"AGENT_API_KEY":"YOUR_KEY_HERE"}'
   ```

2. **Update task definition** (`docker/main-site-task-definition.json`):
   ```json
   "secrets": [
     {
       "name": "AGENT_API_KEY",
       "valueFrom": "arn:aws:secretsmanager:us-east-1:973753295447:secret:cb-app/[site-name]-agent-XXXXXX:AGENT_API_KEY::"
     }
   ]
   ```

3. **Update supervisord** if multiple SSR servers need different keys.

---

## When Claude Should Apply This Skill

Apply this skill automatically when:
- User mentions "RequestDesk blog" or "Astro blog"
- User asks about blog posts on requestdesk.ai
- User wants to add/modify blog content
- User encounters blog-related errors
- User asks about SSR or server-side rendering for the marketing site
- Deploying changes to astro-sites that affect the blog

---

## Related Projects

| Project | Purpose |
|---------|---------|
| `astro-sites` | Contains the Astro blog code |
| `requestdesk-app` | Backend API for blog posts |
| `cb-app/astro-agent` | AWS secret for API authentication |

---

## Quick Reference

**Test blog locally:**
```bash
cd astro-sites/requestdesk-ai
npm run dev
# Visit http://localhost:4321/blog/
```

**Test API endpoint:**
```bash
curl -s "https://app.requestdesk.ai/api/astro-proxy/blog-posts" \
  -H "Authorization: Bearer ZNgUN47QKeykN8voMmRbuyRT1G3edDxo" | jq
```

**Deploy blog changes:**
```bash
git tag main-site-v1.X.X-description
git push origin main-site-v1.X.X-description
```

**View live blog:**
- Index: https://requestdesk.ai/blog/
- Post: https://requestdesk.ai/blog/[slug]
