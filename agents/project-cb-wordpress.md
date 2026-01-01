# Project Agent: cb-wordpress

**Project Type:** WordPress Plugin (RequestDesk Connector)
**Directory:** `/Users/brent/scripts/CB-Workspace/cb-wordpress`

---

## 🚨 CRITICAL RULES

### Scope Restrictions
- ✅ **CAN MODIFY:** Only files within `cb-wordpress/` directory
- ❌ **CANNOT MODIFY:** cb-requestdesk, cb-shopify, astro-sites, or other projects
- ❌ **CANNOT COMMIT:** To other project repositories

---

## 🚨 DIRECTORY & ZIP NAMING - NEVER CHANGE

### ⚠️ THIS IS THE #1 CAUSE OF PRODUCTION FAILURES

**CORRECT Structure (NEVER DEVIATE):**
```
requestdesk-connector/              ← EXACT NAME - NEVER CHANGE
├── requestdesk-connector.php       ← EXACT NAME - NEVER CHANGE
├── includes/
├── admin/
├── assets/
└── readme.txt
```

**ZIP File Name (ALWAYS):**
```bash
requestdesk-connector.zip           # For deployment to WordPress
requestdesk-connector-v2.3.10.zip   # For version archive ONLY
```

### ❌ WRONG - CAUSES DUPLICATES
```
requestdesk-connector-v2.3.6/       # WRONG - Creates duplicates
requestdesk-connector-FIXED/        # WRONG - Creates duplicates
plugin-name-v2.3.9.zip             # WRONG for deployment
```

### Version Changes - ONLY These 2 Places
```php
// 1. Plugin header comment
* Version: 2.3.10

// 2. PHP constant
define('REQUESTDESK_VERSION', '2.3.10');
```

---

## 🖥️ Development Environment: LocalWP

### Setup
- **Application:** LocalWP (https://localwp.com/)
- **Plugin Path:** `~/Local Sites/[site-name]/app/public/wp-content/plugins/`
- **Admin URL:** `http://[site-name].local/wp-admin/`

### Why LocalWP (NOT Docker)
- ✅ Native macOS performance
- ✅ One-click WordPress installation
- ✅ Easy PHP version switching
- ✅ Built-in SSL

---

## 📦 Build & Package Process

### Step 1: Prepare Package
```bash
cd /Users/brent/scripts/CB-Workspace/cb-wordpress
mkdir -p plugin-releases
rm -rf plugin-releases/requestdesk-connector
cp -r . plugin-releases/requestdesk-connector
```

### Step 2: Clean Unwanted Files
```bash
rm -rf plugin-releases/requestdesk-connector/.claude
rm -rf plugin-releases/requestdesk-connector/todo
rm -rf plugin-releases/requestdesk-connector/logs
rm -rf plugin-releases/requestdesk-connector/plugin-releases
rm -rf plugin-releases/requestdesk-connector/.git
rm -f plugin-releases/requestdesk-connector/debug.log
rm -f plugin-releases/requestdesk-connector/.DS_Store
rm -f plugin-releases/requestdesk-connector/WORDPRESS-PLUGIN-DEVELOPMENT-SOP.md
rm -f plugin-releases/requestdesk-connector/CRITICAL-WORDPRESS-PLUGIN-STRUCTURE-STANDARDS.md
```

### Step 3: Create ZIP
```bash
cd plugin-releases
zip -r requestdesk-connector-v[VERSION].zip requestdesk-connector/ -x "*.DS_Store"
```

### Final Location
```
/Users/brent/scripts/CB-Workspace/cb-wordpress/plugin-releases/requestdesk-connector-v[VERSION].zip
```

---

## 🧪 MANDATORY Local Testing (BEFORE Production)

### Step 1: Upload to LocalWP
1. Access: `http://[site-name].local/wp-admin/`
2. Plugins → Add New → Upload Plugin
3. Upload ZIP from `plugin-releases/`

### Step 2: Verify
- [ ] Clean activation (no errors)
- [ ] No duplicate plugins appear
- [ ] All functionality works
- [ ] Settings pages accessible
- [ ] Deactivation/reactivation works

### ⚠️ If ANY test fails, DO NOT deploy to production

---

## 🚀 Production Deployment

### Pre-Deployment
- [ ] All local tests passed
- [ ] Production backup completed
- [ ] Same ZIP used in local testing

### Deploy
1. Access production WordPress admin
2. Plugins → Add New → Upload Plugin
3. Upload exact same ZIP from local testing
4. Activate and verify

### Success Indicators
- Shows "Plugin updated successfully" (not "Plugin activated")
- Only ONE instance of plugin exists
- Version number correct in plugin list

---

## 📁 Key Directories

```
cb-wordpress/
├── requestdesk-connector.php    # Main plugin file
├── includes/                    # PHP classes and functions
├── admin/                       # Admin UI components
├── assets/                      # CSS, JS, images
├── plugin-releases/             # Built ZIP packages
│   ├── requestdesk-connector/   # Build directory
│   └── requestdesk-connector-v*.zip  # Versioned archives
├── readme.txt                   # WordPress.org readme
└── todo/                        # Task tracking
```

---

## 🔧 Technology Stack

| Component | Technology |
|-----------|------------|
| Language | PHP 7.4+ |
| Framework | WordPress Plugin API |
| Testing | LocalWP |
| Deployment | Manual ZIP upload |

---

## 🤝 RequestDesk Integration

### API Endpoints Used
The plugin connects to RequestDesk API for:
- Content synchronization
- Authentication
- Knowledge base updates

### Configuration
- API keys stored in WordPress options
- Connection settings in plugin admin

---

## ⚠️ Forbidden Actions

1. **Never change directory name** from `requestdesk-connector/`
2. **Never change main file name** from `requestdesk-connector.php`
3. **Never deploy version-named ZIPs** to WordPress (causes duplicates)
4. **Never skip local testing** before production
5. **Never modify other CB projects**

---

## 📋 Required Reading Before Plugin Work

1. `WORDPRESS-PLUGIN-DEVELOPMENT-SOP.md` - Full development process
2. `CRITICAL-WORDPRESS-PLUGIN-STRUCTURE-STANDARDS.md` - Naming rules

---

## 🚨 Emergency Rollback

If production fails:
1. Deactivate failing plugin immediately
2. Delete plugin from WordPress
3. Upload previous working version from `plugin-releases/`
4. Activate and verify

### Version History Location
```
plugin-releases/
├── requestdesk-connector-v2.3.8.zip   # Previous
├── requestdesk-connector-v2.3.9.zip   # Previous
└── requestdesk-connector-v2.3.10.zip  # Current
```

Keep last 5 versions for rollback capability.
