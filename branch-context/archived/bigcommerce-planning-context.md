# Resume Instructions for Claude - BigCommerce App Planning

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-shopify` (reference only - new project will be cb-bigcommerce)
2. **Plan File:** `/Users/brent/.claude/plans/merry-munching-muffin.md`
3. **Status:** Planning complete, ready for implementation

## SESSION METADATA
**Saved:** 2026-01-08
**Branch:** main (cb-shopify - for reference)
**Project:** NEW - cb-bigcommerce (not yet created)

## WHAT WAS ACCOMPLISHED

### Shopify App Completion
- Completed infrastructure/shopify-api-upgrade branch
- Fixed shopifyProductImage deprecation → shopifyProductMedia
- Merged to main, deleted branch, archived to todo/completed/

### BigCommerce App Planning
- Researched Gadget BigCommerce support (confirmed available)
- Researched BigCommerce APIs (Blog Posts, Products, GraphQL)
- Created comprehensive implementation plan
- Decisions made:
  - NEW separate Gadget app (contentbasis-bigcommerce)
  - API-only (no BigCommerce admin UI needed)
  - Same RequestDesk API keys work for both platforms
  - RequestDesk → BigCommerce only (no blog import needed)
  - RAG sync is critical feature

## PLAN LOCATION
**Full Plan:** `/Users/brent/.claude/plans/merry-munching-muffin.md`

## KEY DECISIONS
1. **App Structure:** New Gadget app `contentbasis-bigcommerce`
2. **Features:** Blog creation + RAG sync (products → RequestDesk)
3. **API Keys:** Same keys work for Shopify AND BigCommerce
4. **UI:** None needed - all API-to-API operations
5. **Blog Direction:** RequestDesk → BigCommerce only

## BACKLOG ITEM TO ADD
**BigCommerce Gadget App (cb-bigcommerce)**
- Create BigCommerce developer store
- Create Gadget app with BigCommerce connection
- Implement blog creation endpoint
- Implement RAG sync for products
- Priority: After current work, when ready to expand platforms

## NEXT ACTIONS
1. User needs to create BigCommerce developer store first
2. Then create new Gadget app
3. Follow implementation plan in merry-munching-muffin.md

## TODO LIST STATE (for BigCommerce)
- ⏳ PENDING: Create BigCommerce developer/sandbox store
- ⏳ PENDING: Create new Gadget app (contentbasis-bigcommerce)
- ⏳ PENDING: Set up cb-bigcommerce local directory
- ⏳ PENDING: Enable BigCommerce product/category models
- ⏳ PENDING: Create requestDeskAccount model
- ⏳ PENDING: Implement blog creation endpoint
- ⏳ PENDING: Implement RAG sync action
