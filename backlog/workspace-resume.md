# Workspace Resume Queue

Prioritized items to resume across all workspaces. Use `--backlog` flag with `/claude-save` to add items here.

**Priority Levels:**
- **P0** - Interrupted mid-task, resume ASAP
- **P1** - Planned work, ready to start
- **P2** - Ideas/future work

---

## [P0] BigCommerce Gadget App Planning - RESUME PENDING
**Added:** 2026-01-08 16:45
**Project:** shopify (reference) → NEW: cb-bigcommerce
**Context:** `.claude/branch-context/bigcommerce-planning-context.md`
**Plan:** `/Users/brent/.claude/plans/merry-munching-muffin.md`
**Branch:** N/A (new project, not yet created)

### Current State
Planning complete. Ready for implementation. User needs to:
1. Create BigCommerce developer store first
2. Then create new Gadget app

### Pending Todos
- [ ] Create BigCommerce developer/sandbox store
- [ ] Create new Gadget app (contentbasis-bigcommerce)
- [ ] Set up cb-bigcommerce local directory
- [ ] Enable BigCommerce product/category models
- [ ] Create requestDeskAccount model for API keys
- [ ] Implement blog creation endpoint
- [ ] Implement RAG sync action

### Key Decisions Made
- NEW separate Gadget app (not extending cb-shopify)
- API-only (no BigCommerce admin UI needed)
- Same RequestDesk API keys work for both platforms
- RequestDesk → BigCommerce only (no blog import)
- RAG sync is critical feature

### To Resume
```bash
/claude-start shopify
# Then reference the plan file and context
```

---

## [P1] Dynamic Blog Sitemap - astro-sites
**Added:** 2026-01-09
**Project:** astro-sites / requestdesk-ai
**Plan:** `astro-sites/todo/current/feature/dynamic-blog-sitemap-plan.md`
**Branch:** master (no feature branch yet)

### Problem
Blog posts are fetched dynamically from RequestDesk API - not included in sitemap.xml at build time. SEO gap.

### Solution
Custom Astro integration that fetches posts at build time and appends them to sitemap.

### Pending Questions
- [ ] Get company_id for RequestDesk blog posts
- [ ] Confirm API auth requirements for build-time access
- [ ] Verify post field names (slug, updated_at)

### To Resume
```bash
cd /Users/brent/scripts/CB-Workspace/astro-sites
cat todo/current/feature/dynamic-blog-sitemap-plan.md
```

---
