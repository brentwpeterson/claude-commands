# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/documentation`
2. **Branch:** `main`
3. **Note:** This is a standalone documentation consolidation project (workspace-level)

## SESSION METADATA
**Last Commit:** `49d48b7 Add Hyva Themes to paid resources inventory`
**Saved:** 2025-12-29
**MCP Entity:** `Session-2025-12-29-documentation-cleanup`

## WHAT WE ACCOMPLISHED THIS SESSION

### Documentation Cleanup (COMPLETED)
1. **Archived removed services:**
   - `cb-app-documentation-service` docs → `archive/deprecated-services/`
   - Updated DEPLOYMENT-TAGS.md to remove Redis service references
   - Updated service lists to reflect current 3 services:
     - cb-app-service (backend)
     - cb-app-frontend-service (frontend)
     - cb-app-main-site-service (Astro site)

2. **Created resources/ folder for paid assets:**
   - `resources/ui-kits/catalyst-ui-kit/` - Tailwind Plus (React components)
   - `resources/magento-themes/hyva-themes-README.md` - Hyva reference doc

3. **MCP Memory Updated:**
   - `CB-Paid-Resources` - Master inventory
   - `Catalyst-UI-Kit` - React component details
   - `Hyva-Themes` - Magento theme details

## CURRENT STATE

**Documentation Structure:**
```
documentation/ (665 files)
├── archive/               # Completed todos, deprecated services, bugs
├── integrations/          # WordPress, Shopify, Sentry, Google, etc.
├── platform/              # Admin, features, user-guides, brand
├── release-log/           # 2025 changelogs
├── resources/             # NEW - Paid/licensed assets
│   ├── ui-kits/catalyst-ui-kit/
│   └── magento-themes/
├── technical/             # Architecture, database, deployment, guides
└── websites/              # Astro site docs
```

**Git Log (Recent):**
```
49d48b7 Add Hyva Themes to paid resources inventory
577a893 Documentation cleanup: archive removed services, create resources folder
4a91a5b Phase 5.9: Final migration audit - capture all remaining files
```

## TODO LIST STATE
- ✅ COMPLETED: Phase 1-5 Documentation consolidation
- ✅ COMPLETED: Service documentation cleanup (Redis, Docs service removed)
- ✅ COMPLETED: Resources folder creation + MCP memory
- ⏳ PENDING: **Phase 6 - RAG integration (ingest docs into knowledge base)**

## NEXT ACTIONS (PRIORITY ORDER)

### Phase 6: RAG Integration (Requires cb-requestdesk work)
1. Create documentation ingestion endpoint
2. Define metadata schema (category, version, date, tags)
3. Create "documentation" knowledge base collection
4. Ingest all approved documentation
5. Test agent retrieval from docs

## KEY FILES
- **Consolidation plan:** `DOCUMENTATION-CONSOLIDATION-PLAN.md`
- **Resources index:** `resources/README.md`
- **Paid resources in MCP:** Search "CB-Paid-Resources" or "catalyst"

## CONTEXT NOTES
- This is a WORKSPACE-LEVEL project, not inside cb-requestdesk
- cb-requestdesk/documentation REMAINS the live MkDocs source for deployed docs site
- Phase 6 requires switching to cb-requestdesk for backend work
- All 3 ECS services documented: backend, frontend, main-site
- Removed services archived: Redis, documentation-service, mongodb8-efs
