# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/wordpress-sites`
2. **Plugin location:** Symlinked at `requestdesk-connector/` → LocalWP site
3. **LocalWP Admin:** `http://localhost:10013/wp-admin/`
4. **Template Importer:** RequestDesk → Template Importer

## SESSION METADATA
**wordpress-sites repo:** `92ad1f8 Initial commit - WordPress Sites workspace`
**contentcucumber repo:** `ced7c27 Add dynamic parent/child landing page system (v2.5.0)`
**Plugin Version:** 2.5.0
**Saved:** 2025-12-27

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Dynamic Parent/Child Landing Page System (v2.5.0)
- **Parent page dropdown** added to Template Importer UI
- **`[requestdesk_child_grid]` shortcode** created - dynamically queries children
- **Auto parent assignment** - child pages get `post_parent` set on import
- **ItemList schema** auto-generated from child pages
- Replaced 225 lines of hardcoded grid with 15-line dynamic shortcode

### 2. Created `/cucumber-writer` Skill
- AI content creation with Content Cucumber brand voice
- Uses RequestDesk API for brand persona
- Supports: blog, service, landing-child, landing-parent, social, email, meta
- Located: `.claude-local/commands/cucumber-writer.md`

### 3. WordPress Sites Repo Created
- Initialized git repo for `/Users/brent/scripts/CB-Workspace/wordpress-sites/`
- Excludes symlinks (contentcucumber, requestdesk-connector, talk-commerce)
- Excludes test-data folder
- Tracks: README.md, todo/, .gitignore

## CURRENT DISCUSSION: Services Parent Page Design

**User wants to create REAL services page for Content Cucumber**

**Key requirement:** Mixed grid with:
- **3 External links** → HubSpot landing pages (HubSpot, Flywheel, Case Studies)
- **6+ Internal links** → WordPress child pages (Blog, SEO, Website, Email, Social, AEO)

**Three options discussed:**
1. **Option A:** Hardcode Featured section, dynamic grid below
2. **Option B:** All in one grid with external URL field
3. **Option C:** All WordPress pages, some with redirects to HubSpot ← User asked for explanation

**Option C explained:**
- Create WP child pages for HubSpot/Flywheel/Cases that redirect to HubSpot LPs
- Single unified grid (no two sections)
- Dynamic shortcode works unchanged
- Easy to convert redirect → full page later

**User was about to choose an option when save was requested**

## TODO LIST STATE
- ✅ COMPLETED: Add parent page dropdown to importer UI
- ✅ COMPLETED: Rebuild parent template with dynamic child query
- ✅ COMPLETED: Update child import function to use selected parent ID
- ⏳ PENDING: Test full workflow: parent import → child import → verify linking
- ⏳ PENDING: Create real services page CSV for Content Cucumber
- ⏳ PENDING: Decide on Option A/B/C for HubSpot integration

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Get user decision on Option A, B, or C
2. **THEN:** Use `/cucumber-writer landing-parent` to create parent page content
3. **THEN:** Use `/cucumber-writer landing-child` for each service
4. **CREATE:** CSV files for import
5. **TEST:** Import on LocalWP at localhost:10013

## KEY FILES MODIFIED THIS SESSION
- `requestdesk-connector/requestdesk-connector.php` - v2.5.0, added shortcode
- `requestdesk-connector/admin/aeo-template-importer.php` - parent dropdown
- `requestdesk-connector/admin/aeo-template-landing-parent.php` - dynamic grid
- `.claude-local/commands/cucumber-writer.md` - new skill

## API REFERENCE
- **Content Cucumber API Key:** `spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`
- **Endpoint:** `https://app.requestdesk.ai/api/agent/content`

## VERIFICATION COMMANDS
- Check plugin: `ls -la wordpress-sites/requestdesk-connector/`
- Check LocalWP: Open `http://localhost:10013/wp-admin/`
- Test API: `curl -s -X POST "https://app.requestdesk.ai/api/agent/content" -H "Authorization: Bearer spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8"`
