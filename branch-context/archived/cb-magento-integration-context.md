# Resume Instructions for Claude - CB Magento Integration

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/cb-magento-integration`
2. **Branch:** `main`
3. **Saved:** 2025-12-23

## PROJECT OVERVIEW - NEW MAGENTO BLOG EXTENSION

### Goal: Create RequestDesk Magento Blog Extension
Build a **native Magento 2 module** that:
- Provides full blog functionality (Magento has NO built-in blog like Shopify)
- Connects directly to RequestDesk via REST API (NO middleware like Gadget)
- Supports bidirectional sync (push AND pull)
- Reuses patterns from Shopify blog integration

### Phase 1 Scope
- Connect from RequestDesk to Magento and publish a blog
- Get functionality working first
- Test with Evrig's sandbox deployment

## CONFIRMED DECISIONS

| Decision | Answer |
|----------|--------|
| **Vendor Namespace** | `RequestDesk` → `app/code/RequestDesk/Blog/` |
| **Product-Blog Linking** | YES - Create index table `requestdesk_blog_product` (blog_id + product_id) - CRITICAL for Magento |
| **Admin UI** | Option A: Minimal - Just configuration (API key, endpoint URL), all blog management via RequestDesk |
| **Frontend Routes** | `/blog`, `/blog/category/{url_key}`, `/blog/{url_key}` |
| **Deployment** | Build → Hand to Evrig → Deploy to sandbox → Real-world testing |

## FOLDER STRUCTURE

```
cb-magento-integration/
├── base-magento/           # Docker dev environment (Mark Shust v52.0.1)
│   ├── compose.yaml        # Docker services
│   ├── src/                # Magento 2.4.7-p3 installation
│   └── README.md           # Setup instructions
├── cb-blog-magento/
│   └── old-blog/           # Amasty modules (REFERENCE ONLY - proprietary)
├── cb-evrig-main-site/     # Evrig's working Hyva site
└── [NEW] requestdesk-blog/ # NEW EXTENSION (needs git repo)
```

## DOCKER DEV ENVIRONMENT

**Location:** `/Users/brent/scripts/CB-Workspace/cb-magento-integration/base-magento/`
- **Magento:** 2.4.7-p3
- **URL:** https://evrig.test:8443 (or https://localhost:8443)
- **Theme:** Hyva ready
- **Services:** nginx, PHP-FPM 8.3, MariaDB 10.6, Redis (Valkey), OpenSearch, RabbitMQ
- **DB:** localhost:3307, user: magento, pass: magento

## SHOPIFY INTEGRATION TO MIRROR

**Key files to reference:**
- `/cb-requestdesk/backend/app/services/shopify_blog_service.py` - Service layer patterns
- `/cb-requestdesk/backend/app/routers/shopify_blog.py` - API endpoint patterns
- `/cb-shopify/` - Gadget.dev app (external API approach)

**Features to replicate:**
- Topic-based blog generation
- Product-based blog (with embed)
- SEO metadata (meta_title, meta_description)
- FAQ accordion generation
- Featured image support
- Persona/brand voice
- Content terms to avoid
- Product sync to RAG
- Bidirectional sync

## DATABASE SCHEMA (PLANNED)

### requestdesk_blog_post
- `post_id` (PK)
- `title`, `content`, `url_key`
- `meta_title`, `meta_description`
- `featured_image`
- `status` (draft/published)
- `author`
- `requestdesk_post_id` (sync link)
- `requestdesk_sync_status` (synced/pending/failed)
- `requestdesk_last_sync`
- `created_at`, `updated_at`

### requestdesk_blog_category
- `category_id` (PK)
- `name`, `url_key`, `status`

### requestdesk_blog_post_category (M2M)
- `post_id`, `category_id`

### requestdesk_blog_product (CRITICAL - Product linking)
- `id` (PK)
- `post_id` (FK)
- `product_id` (FK to Magento catalog_product_entity)

## NEXT ACTIONS (PRIORITY ORDER)

1. **CREATE CLEAN EXTENSION FOLDER:**
   ```bash
   mkdir -p /Users/brent/scripts/CB-Workspace/cb-magento-integration/requestdesk-blog
   cd /Users/brent/scripts/CB-Workspace/cb-magento-integration/requestdesk-blog
   git init
   ```

2. **CREATE MODULE SKELETON:**
   - `registration.php`
   - `etc/module.xml`
   - `composer.json`

3. **CREATE DATABASE SCHEMA:**
   - `etc/db_schema.xml`
   - `etc/db_schema_whitelist.json`

4. **CREATE REST API ENDPOINTS:**
   - `etc/webapi.xml`
   - `Api/` interfaces
   - `Model/` implementations

5. **THEN BUILD REQUESTDESK SIDE:**
   - Create `magento_blog_service.py` (mirror shopify_blog_service.py)
   - Create `magento_blog.py` router
   - Add agent integration for Magento

## KEY CONTEXT

- User: Brent (Magento expert, created Mark Shust Docker setup reference)
- Evrig is the client who will test on their sandbox
- This is Phase 1 - functionality first, UX improvements later
- Phase 2 will be distributed Marketplace extension
- ALWAYS tie products to blog posts (Magento complexity requires index table)

## FILES EXAMINED THIS SESSION

- `/cb-magento-integration/base-magento/compose.yaml` - Docker setup
- `/cb-magento-integration/base-magento/README.md` - Dev instructions
- `/cb-magento-integration/cb-blog-magento/old-blog/` - Amasty reference
- `/cb-magento-integration/cb-evrig-main-site/` - Evrig Hyva site
- `/cb-requestdesk/backend/app/services/shopify_blog_service.py` - Service patterns
- `/cb-requestdesk/backend/app/routers/shopify_blog.py` - API patterns
- `/cb-shopify/CLAUDE.md` - Shopify integration overview
