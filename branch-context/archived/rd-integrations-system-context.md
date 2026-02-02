# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `master`
3. **Last Commit:** `a698dd58 Add integrations system: integration_types + agent_integrations collections`

## SESSION SUMMARY
Built scalable integrations architecture for RequestDesk - two new collections to handle 30-50+ integrations.

## WHAT WAS COMPLETED

### 1. Integration System Architecture (Option B - User Approved)
- **integration_types** collection: System-level registry of available integrations
- **agent_integrations** collection: Per-agent instances with credentials/config

### 2. Migrations Created & Run Successfully
| Migration | Description |
|-----------|-------------|
| `v0_39_0` | Create both collections with indexes |
| `v0_39_1` | Seed 15 integration types across 7 categories |
| `v0_39_2` | Migrate existing WordPress/Shopify/RequestDesk Blog configs |

### 3. Integration Types Seeded (15 total)
| Category | Integrations |
|----------|--------------|
| publish | WordPress, Shopify, Adobe AEM, RequestDesk Blog |
| analytics | Google Analytics, Google Search Console |
| social | Vista Social, LinkedIn |
| crm | HubSpot |
| email | Mailchimp |
| ai | OpenAI, Anthropic |
| storage | AWS S3, Google Drive |
| ecommerce | Magento |

### 4. Key Architecture Decisions
- **API key inheritance:** `agent.api_key` stays on agent, NOT duplicated to integrations
- **Config storage:** Platform-specific config in `agent_integrations.config`
- **Auth types supported:** api_key, oauth2, service_account, basic_auth
- **config_schema:** Each integration type defines required/optional fields with types (string, url, secret, select, boolean)

## MIGRATION RESULTS (Verified)
```
integration_types: 15 documents
agent_integrations: 2 documents
  - wordpress: Content Cucumber (site_url: https://contentcucumber.local)
  - requestdesk_blog: RequestDesk Writer
```

## UNCOMMITTED CHANGES
- `PostsEdit.tsx` - 2-column Tailwind layout with sidebar
- `PostsShow.tsx` - Full SEO/Social display in sidebar

(These are from earlier session work on posts UI - not related to integrations)

## TODO LIST STATE
- ✅ COMPLETED: Design integration_types collection schema and migration
- ✅ COMPLETED: Design agent_integrations collection schema and migration
- ✅ COMPLETED: Create migration to seed initial integration_types
- ✅ COMPLETED: Create migration to move existing configs to agent_integrations
- ✅ COMPLETED: Test migrations locally
- ⏳ PENDING: Update AgentIntegrationService to use new collections
- ⏳ PENDING: FUTURE - Re-examine if each integration needs its own API credentials

## NEXT ACTIONS (PRIORITY ORDER)
1. **Update AgentIntegrationService** - Switch `_get_wordpress_config()` and `_get_shopify_config()` to read from `agent_integrations` collection instead of flat agent fields
2. **Test publish flows** - Verify WordPress/Shopify publishing still works after service update
3. **Build integrations UI** - Admin interface to manage integration types and agent integrations
4. **Commit PostsEdit/PostsShow changes** - The Tailwind sidebar work from earlier

## KEY FILES FOR NEXT SESSION
- `backend/app/services/agents/agent_integration_service.py` - Main service to update
- `backend/app/migrations/versions/v0_39_*.py` - The 3 new migrations
- `frontend/src/components/posts/PostsEdit.tsx` - Uncommitted Tailwind work
- `frontend/src/components/posts/PostsShow.tsx` - Uncommitted Tailwind work

## MCP MEMORY ENTITY
`Session-2026-01-14-rd-integrations-architecture`

## ASTRO DEV SERVER
Was running on port 3003 for testing RequestDesk blog - may need restart on resume.
