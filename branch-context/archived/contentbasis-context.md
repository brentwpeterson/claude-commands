# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Verify branch:** `git checkout feature/contentbasis-ai-new-site`
3. **Check Docker:** `docker ps` (expect: astro-sites-brutal running on ports 8080:80, 3003:3003, 8443:443)
4. **Test site:** Open http://contentbasis.ai.test:8080/

## SESSION METADATA
**Last Commit:** `878a2e8 Add ContentBasis logo, favicon, and update branding`
**Branch:** feature/contentbasis-ai-new-site
**Saved:** 2025-12-14

## WHAT WAS COMPLETED THIS SESSION

### Logo & Branding Updates
| Item | File | Description |
|------|------|-------------|
| New Logo | `src/assets/logos/New-CB-LOGO.svg` | Main logo with transparent background |
| Favicon PNG | `public/favicon.png` | Browser tab icon |
| Navbar | `src/layouts/Navbar.astro` | Logo + "Content Basis" text |
| Footer | `src/layouts/Footer.astro` | Logo image |
| Layout | `src/layouts/Layout.astro` | PNG favicon reference |
| Hero | `src/components/sections/Hero.astro` | New headline |

### Logo Variants Created (Previous Commit)
- `contentbasis-white-on-blue.svg` - Original (white logo, blue bg)
- `contentbasis-blue-on-clear.svg` - Light mode (blue logo, transparent bg)
- `contentbasis-white-on-clear.svg` - Dark mode (white logo, transparent bg)

### HubSpot Images Downloaded
Location: `src/assets/hubspot-images/`
- 1745537433830.jpg, Bigcommerce-rebrand.png, ContentBasis-white.png
- i-love-hubspot.png, Is-Shopify-Declining.png, Quandry.png, jack-logo.png

### Headline Updated
**Before:** "AI-Powered Content Creation Platform"
**After:** "AI Enabled Content Platform with Humans in the Loop"

## GIT STATUS
- Branch: `feature/contentbasis-ai-new-site`
- All changes committed
- Not yet pushed to remote
- Not yet deployed

## DOCKER CONTAINER
- **Name:** astro-sites-brutal
- **Ports:** 8080:80, 3003:3003, 8443:443
- **Status:** Running

## TEST URLs (Local)
- http://contentbasis.ai.test:8080/ (homepage with new headline)
- http://contentbasis.ai.test:8080/shopify/
- http://contentbasis.ai.test:8080/services/
- http://contentbasis.ai.test:8080/case-studies/chalet-market/

## NEXT ACTIONS (IF CONTINUING)
1. **User review:** Verify logo, favicon, and headline look correct locally
2. **Push changes:** `git push origin feature/contentbasis-ai-new-site`
3. **Deploy:** Create tag `main-site-v1.3.8-contentbasis-branding` and push
4. **Verify production:** Check https://contentbasis.ai/

## VERIFICATION COMMANDS
```bash
# Rebuild if needed
docker stop astro-sites-brutal && docker rm astro-sites-brutal
docker build -t astro-sites-local -f deployment/Dockerfile .
docker run -d --name astro-sites-brutal -p 8080:80 -p 3003:3003 -p 8443:443 astro-sites-local

# Deploy
git push origin feature/contentbasis-ai-new-site
git tag main-site-v1.3.8-contentbasis-branding
git push origin main-site-v1.3.8-contentbasis-branding
```

## KEY FILES REFERENCE
- **Logo:** `contentbasis-ai/src/assets/logos/New-CB-LOGO.svg`
- **Favicon:** `contentbasis-ai/public/favicon.png`
- **Navbar:** `contentbasis-ai/src/layouts/Navbar.astro`
- **Footer:** `contentbasis-ai/src/layouts/Footer.astro`
- **Hero:** `contentbasis-ai/src/components/sections/Hero.astro`
- **Brand Color:** `#5113E5` (ContentBasis Blue)
