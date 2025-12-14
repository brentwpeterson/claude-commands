Deploy a specific Astro site from the shared multi-site container

**Usage**: `/deploy-astro-site <site-name> [description]`

**Valid site names**:
- `contentbasis-ai` - contentbasis.ai
- `contentbasis-io` - contentbasis.io
- `requestdesk-ai` - requestdesk.ai
- `magento-masters` - magento-masters.com
- `all` - Deploy without site-specific tag

**Examples**:
```
/deploy-astro-site contentbasis-ai homepage-update
/deploy-astro-site requestdesk-ai new-pricing-page
/deploy-astro-site all general-updates
```

---

## Deployment Process

**IMPORTANT**: This deploys ALL sites in a shared container. The site name indicates which site triggered the deployment for tracking purposes.

### Phase 1: Validate Arguments

1. **Parse arguments**: `$ARGUMENTS`
   - First word = site name (required)
   - Remaining words = description (optional, defaults to "update")

2. **Validate site name**:
   ```
   Valid sites: contentbasis-ai, contentbasis-io, requestdesk-ai, magento-masters, all
   ```
   - If invalid, show error and list valid options
   - If missing, ask user which site to deploy

### Phase 2: Navigate to astro-sites

1. **Navigate to astro-sites directory**:
   ```bash
   cd /Users/brent/scripts/CB-Workspace/astro-sites
   ```

2. **Verify on correct branch**:
   ```bash
   git branch --show-current
   ```
   - If not on `main`, ask if user wants to switch or deploy from current branch

3. **Check for uncommitted changes**:
   ```bash
   git status --porcelain
   ```
   - If changes exist, auto-commit with descriptive message
   - Push to remote

### Phase 3: Create and Push Deployment Tag

1. **Generate tag name**:
   - Site-specific: `[site-name]-v1.0.0-[description]`
   - All sites: `astro-sites-v1.0.0-[description]`

   **Tag format examples**:
   - `contentbasis-ai-v1.0.0-homepage-update`
   - `requestdesk-ai-v1.0.0-new-pricing`
   - `astro-sites-v1.0.0-general-updates`

2. **Check if tag exists**:
   ```bash
   git tag | grep "[tag-name]"
   ```
   - If exists, append timestamp: `[tag]-$(date +%H%M)`

3. **Create and push tag**:
   ```bash
   git tag [final-tag]
   git push origin [final-tag]
   ```

### Phase 4: Monitor Deployment

1. **Show deployment info**:
   ```
   🚀 ASTRO SITES DEPLOYMENT INITIATED
   ===================================

   📍 Triggered by: [site-name]
   🏷️  Tag: [final-tag]
   📦 Container: Multi-site (all 4 sites)

   🌐 Sites being deployed:
      - contentbasis.ai
      - contentbasis.io
      - requestdesk.ai
      - magento-masters.com

   ⏱️  Estimated time: ~10-15 minutes

   📋 Monitor deployment:
      https://github.com/brentwpeterson/astro-sites/actions

   🔍 After deployment, verify:
      - https://contentbasis.ai
      - https://contentbasis.io
      - https://requestdesk.ai
      - https://magento-masters.com
   ```

2. **Optionally watch GitHub Actions**:
   ```bash
   gh run list --repo brentwpeterson/astro-sites --limit 1
   ```

---

## Architecture Notes

**Why all sites deploy together**:
- Single nginx container serves all domains
- Cost optimization: One ECS service, one task
- Domains routed by `server_name` in nginx.conf

**Sites in container**:
| Directory | Domain | nginx root |
|-----------|--------|------------|
| contentbasis-ai | contentbasis.ai | /usr/share/nginx/html/contentbasis-ai |
| contentbasis-io | contentbasis.io | /usr/share/nginx/html/contentbasis-io |
| requestdesk-ai | requestdesk.ai | /usr/share/nginx/html/requestdesk-ai |
| magento-masters-com | magento-masters.com | /usr/share/nginx/html/magento-masters-com |

**Tag patterns that trigger deployment**:
- `astro-sites-v*` - Generic multi-site
- `contentbasis-ai-v*` - Triggered by contentbasis.ai changes
- `contentbasis-io-v*` - Triggered by contentbasis.io changes
- `requestdesk-ai-v*` - Triggered by requestdesk.ai changes
- `magento-masters-v*` - Triggered by magento-masters.com changes
- `main-site-v*`, `site-v*`, `release-v*` - Legacy compatibility
