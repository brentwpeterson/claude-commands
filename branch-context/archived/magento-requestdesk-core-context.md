# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-magento-integration/requestdesk-core`
2. **Verify structure:** `ls -la` (expect: Api, Block, Controller, etc, Helper, Model, view directories)
3. **Check astro-sites:** `cd /Users/brent/scripts/CB-Workspace/astro-sites && git log --oneline -3`

## SESSION METADATA
**Last Commit (astro-sites):** `b948900 Update Magento package name to requestdesk/magento-blog`
**Saved:** 2024-12-29
**Project:** cb-magento-integration (requestdesk-core module scaffolding)

## WHAT WE COMPLETED THIS SESSION

### 1. Astro-Sites Updates (DEPLOYED)
- **Magento page AEO repositioning** - Complete rewrite with new value prop:
  - Hero: "AI Can't Find Your Products" + "How many words?" hook
  - Primary value: Brand Score + JSON-LD (COMING SOON badges)
  - Blog positioned as LIVE bonus
  - Updated all sections, FAQs, comparison table, meta tags
- **Integrations dropdown in nav** - Like Industries dropdown
  - Shows Magento (LIVE), WordPress (LIVE), Shopify (BETA)
  - Links to individual integration pages
- **Deployed:** `main-site-v1.10.2-integrations-dropdown`

### 2. RequestDesk Core Module (IN PROGRESS)
**Location:** `/Users/brent/scripts/CB-Workspace/cb-magento-integration/requestdesk-core/`

**Files Created:**
```
requestdesk-core/
├── registration.php           ✅ Created
├── composer.json              ✅ Created (requestdesk/magento-core)
├── Api/
│   └── ApiClientInterface.php ✅ Created
├── Model/
│   └── ApiClient.php          ✅ Created
├── Helper/
│   └── Config.php             ✅ Created
├── Block/
│   └── Adminhtml/System/Config/
│       └── TestConnection.php ✅ Created
├── Controller/
│   └── Adminhtml/System/      (empty - needs TestConnection controller)
├── view/
│   └── adminhtml/templates/system/config/
│       └── test_connection.phtml ✅ Created
└── etc/
    ├── module.xml             ✅ Created
    ├── config.xml             ✅ Created
    ├── di.xml                 ✅ Created
    ├── acl.xml                ✅ Created
    └── adminhtml/
        ├── system.xml         ✅ Created
        └── routes.xml         ✅ Created
```

## PENDING WORK

### Still Needed for requestdesk-core:
1. **TestConnection Controller** - `Controller/Adminhtml/System/TestConnection.php`
   - Handles AJAX request from admin config
   - Calls ApiClient->testConnection()
   - Returns JSON response

2. **Test the module** - Install in base-magento and verify:
   - Admin config appears under RequestDesk tab
   - API key saves/encrypts properly
   - Test connection button works

### Architecture Decision (CONFIRMED)
```
cb-magento-integration/
├── requestdesk-core/           ← SHARED (API auth, config)
├── requestdesk-blog/           ← LIVE (refactor to depend on core)
├── requestdesk-brand-score/    ← NEW (analysis, scoring)
└── requestdesk-schema/         ← NEW (JSON-LD for products)
```

## TODO LIST STATE
- ✅ COMPLETED: Create requestdesk-core module structure
- ✅ COMPLETED: Add module registration and composer.json
- ✅ COMPLETED: Add admin configuration section
- 🔄 IN PROGRESS: Create API client (interface + implementation done, controller pending)
- ⏳ PENDING: Test module in base-magento

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Create TestConnection controller:
   ```php
   // Controller/Adminhtml/System/TestConnection.php
   // Handle POST from test_connection.phtml
   // Return JSON with success/message
   ```

2. **THEN:** Update requestdesk-blog to depend on requestdesk-core
   - Add dependency in composer.json
   - Remove duplicate API/config code
   - Use Core's ApiClient

3. **LATER:** Scaffold requestdesk-brand-score module

## KEY CONTEXT
- cb-magento-integration is NOT a git repo (individual modules may have their own repos)
- base-magento is running on localhost:8000 for testing
- Docker containers: base-magento-* are up
- Composer package names follow pattern: requestdesk/magento-[module]

## VERIFICATION COMMANDS
```bash
# Check module structure
ls -la /Users/brent/scripts/CB-Workspace/cb-magento-integration/requestdesk-core/

# Check base-magento is running
docker ps | grep base-magento

# View Magento page live
open https://requestdesk.ai/integrations/magento
```
