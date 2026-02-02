# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Branch:** `master`
3. **Last Commit:** `a7979ba4 Add WordPress parity: post scheduling, TanStack posts list, clean show page`

## SESSION SUMMARY
Converted PostsEdit and PostsShow pages to 2-column layout with sidebar. Discussed scalable integrations architecture.

## WHAT WAS COMPLETED THIS SESSION

### 1. PostsEdit - 2-Column Layout with Sidebar
- Converted from MUI to Tailwind CSS
- Main content (left): Title, Content, Excerpt, Images
- Sidebar (right): Status/Type, Scheduling, Publish Settings, Publish Buttons, SEO, Social Sharing
- Removed all MUI components (Box, Card, Typography, Collapse, etc.)

### 2. PostsShow - Added Full SEO/Social Display
- Expanded sidebar to show ALL fields (not hidden behind Edit)
- SEO Settings: seo_title, meta_description, focus_keyphrase, canonical_url, noindex/nofollow
- Social Sharing: OG title/description/image, Twitter title/description/image
- RequestDesk Blog status indicator
- Updated button styling (cyan Back to Posts, blue Edit)

### 3. Architecture Discussion - INTEGRATIONS SYSTEM
**⚠️ CRITICAL: User wants scalable integrations before continuing**

User has 30-50 integration points coming. Discussed two options:

**Option B (USER PREFERRED):**
```python
# integration_types collection (system-level registry)
{
  "_id": "wordpress",
  "name": "WordPress",
  "category": "publish",  # publish | analytics | social | email | ecommerce
  "config_schema": {...},  # Required fields, validation
  "icon": "wordpress-icon",
  "enabled": True,
  "sort_order": 1
}

# agent_integrations collection (per-agent instances)
{
  "_id": "...",
  "agent_id": "agent_123",
  "integration_type_id": "wordpress",
  "name": "Client Blog",
  "config": {...},
  "enabled": True
}
```

**Categories discussed:**
| Category | Examples |
|----------|----------|
| `publish` | WordPress, Shopify, Astro, Magento |
| `analytics` | Google Analytics, Search Console |
| `social` | Vista Social, Buffer, LinkedIn |
| `email` | Mailchimp, HubSpot |
| `ai` | OpenAI, Anthropic, Perplexity |
| `storage` | S3, Google Drive |

**Migration plan discussed:**
- Move existing `wordpress_config`/`shopify_config` into new system
- Posts inherit from agent's integrations
- No more hardcoded "RequestDesk.ai Blog" - pull from integration name

## VIOLATION LOGGED
**#94** - Hardcoded "RequestDesk.ai Blog" instead of making dynamic. User reminded: "this entire system built to be scalable"

## KEY FILES MODIFIED
| File | Change |
|------|--------|
| `PostsEdit.tsx` | 2-column layout, Tailwind sidebar components |
| `PostsShow.tsx` | Full SEO/Social display in sidebar, button styling |

## NEXT STEPS (USER TO DECIDE)
1. **Design integrations migration** - Create `integration_types` and `agent_integrations` collections
2. **Migrate existing configs** - Move wordpress_config/shopify_config to new system
3. **Update UI** - Pull publish destination names from agent's integrations
4. **Test current changes** - Verify PostsEdit/PostsShow work before integrations work

## IMPORTANT CONTEXT
- User explicitly chose Option B (two collections: types + instances)
- Scalability is paramount - no more hardcoded values
- 30-50 integrations coming - design must handle this
- Current `publish_to_requestdesk_blog` boolean is a violation - needs to be dynamic

## DATABASE VERSION
- Current: v0.38.1
