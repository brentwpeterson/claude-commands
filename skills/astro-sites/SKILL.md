# Astro Sites Skill

## Overview
Multi-site Astro monorepo deployed to AWS ECS as a single nginx container.

**Hosting:** AWS (ECS, ALB, Route53, ACM)
**Forms:** HubSpot embedded forms (no server-side processing needed)
**Email:** SES available but requires domain verification per site

## Directory
`/Users/brent/scripts/CB-Workspace/astro-sites`

## Sites & Local Dev Ports

| Site | Domain | Local Port | Directory |
|------|--------|------------|-----------|
| RequestDesk | requestdesk.ai | 3003 | `requestdesk-ai/` |
| brent.run | brent.run | 3010 | `brent-run/` |
| Content Basis AI | contentbasis.ai | 4321 (default) | `contentbasis-ai/` |
| Content Basis IO | contentbasis.io | 4321 (default) | `contentbasis-io/` |
| Magento Masters | magento-masters.com | 4321 (default) | `magento-masters-com/` |

## Running Local Dev

```bash
# Start a specific site
cd astro-sites/brent-run
npm run dev
# Opens at http://localhost:3010

cd astro-sites/requestdesk-ai
npm run dev
# Opens at http://localhost:3003
```

## Production Deployment

All sites deploy to a single Docker container running nginx on port 3003.
Nginx routes requests by hostname to the correct site's files.

### Deployment Steps
1. Push to master
2. Tag with pattern: `[site]-v[version]-[description]`
3. Push tag to trigger GitHub Actions

```bash
# Example deployment
git tag brent-run-v1.1.0-content-update
git push origin brent-run-v1.1.0-content-update
```

### ALB Routing
Each domain needs an ALB listener rule routing to `cb-app-main-site-tg-3003`.

**Current rules (priority order):**
- requestdesk.ai, www.requestdesk.ai
- contentbasis.ai
- docs.requestdesk.ai
- magento-masters.com
- brent.run, www.brent.run

### Adding a New Site

1. Create directory: `astro-sites/[site-name]/`
2. Configure `astro.config.mjs` with unique port and site URL
3. Update `deployment/build-all.sh` - add build step
4. Update `deployment/Dockerfile` - add build and COPY steps
5. Update `deployment/nginx.conf` - add server block
6. Add Route53 DNS records pointing to ALB
7. Add ACM certificate (or add domain to existing cert)
8. Add ALB listener rules for the domain

## Key Files

- `deployment/Dockerfile` - Multi-site build
- `deployment/nginx.conf` - Virtual host routing
- `deployment/build-all.sh` - Build script
- `.github/workflows/deploy.yml` - GitHub Actions

## Contact Forms

Astro sites are static - no server-side form processing. Options:

1. **HubSpot Embed (preferred)** - requestdesk.ai uses this
   - Create form in HubSpot
   - Embed script in contact page
   - Submissions go to HubSpot CRM

2. **SES** - Requires domain verification + API endpoint (more work)

3. **Third-party** - Formspree, Web3Forms, etc.

## Troubleshooting

### Site showing wrong content
1. Check ALB listener rules: `aws elbv2 describe-rules --listener-arn [ARN]`
2. Verify domain has a rule routing to `cb-app-main-site-tg-3003`
3. Check nginx server block exists in nginx.conf

### Build failing
1. Check Dockerfile has build step for the site
2. Verify package-lock.json is committed (not in .gitignore)
3. Check COPY step exists in Dockerfile
