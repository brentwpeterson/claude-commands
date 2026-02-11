# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Earhart
**Status:** SAVED
**Last Saved:** 2026-02-11 08:59
**Last Started:** 2026-02-10 19:25

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Branch:** N/A (CB-Workspace root is not a git repo; .claude is on `main`)
3. **Last Commit:** `0ed1ab7 Service catalog: pricing grids, flat fee models, new turnkey platforms`
4. **Verify:** `git status` in .claude directory

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| brent | Work log updates |
| cc | Service catalog pricing grids, new turnkey service types |

## WHAT YOU WERE WORKING ON

### Session 7 (Evening/Night) - Service Catalog Pricing Grids + Canva Auth
- Canva MCP finally authenticated via `/mcp` command inside session
- Imported Shopify one-pager HTML as PDF into Canva (design ID: DAHA-RvI8k4)
- Updated service catalog pricing grids based on Brent's direction:
  - Blog: one-off at $200/3,000 words (not monthly retainer)
  - SEO, website-copy, email, social: converted to flat monthly retainer model (removed per-unit pricing)
  - Merged content-commerce + product-desc + category-pages into single "store-optimization" service
  - Design: project-based at $200/hr
  - wp-turnkey: starting at $1,000 with tiers ($1K/$2.5K/$5K/$10K+)
  - wp-maintenance: monthly hour packages use-or-lose ($200-$1,500/mo)
  - Webinar: flagged as one-off, deliverables need definition
- Ran market research (4 parallel agents) on flat fee pricing for SEO, email, social, website copy
- Proposed competitive pricing tiers based on research
- Added 2 new turnkey site services: astro-turnkey and butter-turnkey
  - Astro: performance-first static sites
  - ButterCMS: headless CMS for non-technical content editors

### Pricing Research Results (for reference)
Proposed flat fee tiers based on market research:

| Service | Starter | Growth | Scale |
|---------|---------|--------|-------|
| SEO | $1,500/mo | $3,000/mo | $5,000/mo |
| Email | $1,000/mo | $2,500/mo | $5,000/mo |
| Social | $1,000/mo | $2,000/mo | $4,000/mo |
| Website Copy | $1,500 | $3,000 | $5,000 |

Email one-time: Drip $1,500, Welcome $1,000, Win-back $1,000, Audit $500.
Brent has NOT yet approved these numbers. They were proposed, awaiting his input.

### Shopify One-Pager in Canva
- PDF imported successfully as Canva design
- Edit URL: https://www.canva.com/d/z47DRUgtV_-ZEVC
- View URL: https://www.canva.com/d/W4PtU_nNDO1YFnH
- Design ID: DAHA-RvI8k4
- Content Cucumber brand kit: kAGk8LegUXI

### Previous sessions today (from work log)
- Newsletter finalized and scheduled for Feb 11
- EO 5% updates imported, /five-percent command created
- Service catalog: brand tags + fee grids for 12 services
- Sprint S3 review, tooling fixes approved
- Canva MCP diagnosed, fixed, and finally authenticated

## CURRENT STATE
- **Files modified:** `.claude/skills/proposal-creation/service-types.md` (major updates)
- **Committed:** Yes, `0ed1ab7`
- **Tests run:** None (content/pricing work)
- **Issues found:** None

## TODO LIST STATE
- Completed: Canva auth, Shopify one-pager import, pricing grid updates for 10+ services, new turnkey services
- Pending: Brent to confirm proposed flat fee pricing (SEO/email/social/website-copy)
- Pending: AEO service definition (Brent wants dedicated session)
- Pending: Competitive intel pricing (no idea yet)
- Pending: Webinar deliverables + one-off pricing
- Pending: Shopify one-pager review in Canva editor

### Open Sprint Items (S3 - ends Feb 13)
1. [in_progress] Shopify one pager as PDF (2pt) - imported to Canva, needs review
2. [in_progress] Implement S2 retro action items (2pt)
3. [backlog] LinkedIn Campaign #1: HubSpot services (2pt)
4. [backlog] Complete Scribe handwritten workflow (2pt)
5. [backlog] Planning: White paper (1pt)
6. [backlog] Run ad for HubSpot audit page (1pt)

### 3 Sprint Tooling Fixes (approved by Brent)
1. Mark 16 committed items as committed=true via API
2. Update sprint planning workflow to auto-set committed=true
3. Add Sprint Board view at /sprints/S3 showing only committed items by status

## NEXT ACTIONS
1. **FIRST:** Get Brent's feedback on proposed flat fee pricing tiers
2. **THEN:** Update service-types.md with approved numbers
3. **THEN:** AEO service definition session with Brent
4. **OR:** Review Shopify one-pager in Canva, export as PDF
5. **OR:** Work on remaining sprint items

## KEY FILES
| File | Purpose |
|------|---------|
| `.claude/skills/proposal-creation/service-types.md` | Service catalog with all 24 service types (was 26, merged 3 into 1) |
| `brent-workspace/ob-notes/.../templates/shopify-one-pager.html` | Shopify one-pager HTML source |

## CONTEXT NOTES
- Canva MCP auth works now. Use `/mcp` inside session to trigger OAuth if it disconnects.
- Service count went from 26 to 24 after merging content-commerce + product-desc + category-pages into store-optimization
- Two new services added: astro-turnkey and butter-turnkey (alongside existing wp-turnkey)
- Sprint S3 ends Friday Feb 13 (2 working days left)

## DEFERRED QUESTIONS
- Time tracking status for this session
- Confirm proposed flat fee pricing for SEO/email/social/website-copy
- Which sprint items to prioritize for final 2 days
