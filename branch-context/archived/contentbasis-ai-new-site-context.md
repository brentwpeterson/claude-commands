# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Verify branch:** `git checkout feature/contentbasis-ai-new-site`
3. **Check Docker:** `docker ps | grep astro-sites-local` (expect: running on port 9090)
4. **Test locally:** `curl -s -H "Host: contentbasis.ai" http://localhost:9090/ | head -5`

## SESSION METADATA
**Last Commit:** `45f01bd Add agency-template to contentbasis-ai`
**Branch:** `feature/contentbasis-ai-new-site`
**Saved:** 2025-12-14 06:50

## CURRENT TODO FILE
**Path:** file:/Users/brent/scripts/CB-Workspace/astro-sites/todo/current/feature/contentbasis-ai-new-site/README.md
**Status:** Local testing complete, ready for content customization
**Directory Structure:** ⚠️ Lightweight 4-file structure (not standard 7-file)

## WHAT WAS ACCOMPLISHED THIS SESSION

### AWS Infrastructure for contentbasis.ai
- ✅ Route53 hosted zone confirmed (Z0883862BGJC7W1O5QCS)
- ✅ SSL certificate provisioned (*.contentbasis.ai) - ARN: `arn:aws:acm:us-east-1:973753295447:certificate/b569c67a-ef01-47f2-b48a-b1e34bfdf54d`
- ✅ DNS A record pointing to ALB (cb-app-alb)
- ✅ ALB routing rule added (priority 52) for contentbasis.ai and www.contentbasis.ai
- ✅ Site verified live at https://contentbasis.ai

### Multi-Site Deployment System
- ✅ Updated GitHub Actions workflow (`deploy-main-site.yml`) for multi-site builds
- ✅ All 4 sites built into single container (cost optimization)
- ✅ Tag patterns: `contentbasis-ai-v*`, `requestdesk-ai-v*`, etc.
- ✅ Created `/deploy-astro-site` slash command

### Agency Template Integration
- ✅ Cloned vbartalis/agency-template into contentbasis-ai directory
- ✅ Updated Dockerfile to Node 20
- ✅ Configured astro.config.mjs for contentbasis.ai
- ✅ Build passes locally and in Docker
- ✅ Template includes: Tailwind CSS, TypeScript, light/dark theme

### Local Testing Setup
- ✅ Docker container running: `astro-sites-local` on port 9090
- ✅ User has .test domains in /etc/hosts (contentbasis.ai.test, etc.)
- ✅ Template verified working via curl with Host header

## CURRENT STATE
- **Docker container:** `astro-sites-local` running on port 9090
- **Template status:** Agency template with default social media content
- **Next step:** Customize content for Content Basis branding

## TODO LIST STATE
- ✅ COMPLETED: Create feature branch (USER APPROVED: implicit)
- ✅ COMPLETED: Clone agency-template (USER APPROVED: implicit)
- ✅ COMPLETED: Update branding and configuration (USER APPROVED: implicit)
- 🔄 IN PROGRESS: Test locally or deploy to verify
- ⏳ PENDING: Customize content for Content Basis
- ⏳ PENDING: Full content customization

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User to test in browser - either:
   - Access http://localhost:9090 directly
   - Or configure local nginx proxy
   - Or stop local nginx: `sudo nginx -s stop`
2. **THEN:** Customize content for Content Basis:
   - Update Hero section messaging
   - Replace "SocialMediaAgency" with Content Basis branding
   - Update features, FAQ, footer
3. **DEPLOY:** When ready: `/deploy-astro-site contentbasis-ai new-site-launch`

## KEY FILES TO MODIFY FOR CUSTOMIZATION
- `contentbasis-ai/src/components/sections/Hero.astro` - Main hero section
- `contentbasis-ai/src/utils/data.ts` - Contains FAQ, features data
- `contentbasis-ai/src/layouts/Navbar.astro` - Logo and navigation
- `contentbasis-ai/src/layouts/Footer.astro` - Footer content

## VERIFICATION COMMANDS
```bash
# Test container is running
docker ps | grep astro-sites-local

# Test site content
curl -s -H "Host: contentbasis.ai" http://localhost:9090/ | grep -o "SocialMediaAgency\|Content Basis"

# Stop container when done testing
docker stop astro-sites-local
```

## IMPORTANT CONTEXT
- **Port 80 is in use** by local nginx - container mapped to 9090
- **Platform warning** is expected (amd64 image on arm64 Mac)
- **Production site** is live at https://contentbasis.ai (currently showing agency template)
- **All changes committed** to feature/contentbasis-ai-new-site branch
