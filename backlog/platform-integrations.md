# Platform Integrations Backlog

## BigCommerce Gadget App (cb-bigcommerce)
**Added:** 2026-01-08
**Priority:** Medium
**Status:** Planned - awaiting implementation

### Overview
Create new Gadget app for BigCommerce integration with RequestDesk, mirroring cb-shopify architecture but API-only.

### Prerequisites
- [ ] Create BigCommerce developer store at https://developer.bigcommerce.com/
- [ ] Get store hash and API credentials

### Features
- Blog creation: RequestDesk → BigCommerce
- RAG sync: BigCommerce products → RequestDesk
- No embedded UI needed (all API-to-API)

### Technical Notes
- Same RequestDesk API keys work for both Shopify and BigCommerce
- Gadget supports BigCommerce with dedicated connection
- Plan file: `/Users/brent/.claude/plans/merry-munching-muffin.md`

### Implementation Estimate
- Setup: 1 day
- Core features: 2-3 days
- Testing: 1 day
