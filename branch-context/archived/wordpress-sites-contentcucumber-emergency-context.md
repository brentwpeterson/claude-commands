# EMERGENCY CONTEXT SAVE - 2025-12-29

## CRITICAL: LOW CONTEXT SAVE
This save was triggered with <8% context remaining. Minimal validation performed.

## BRANCH
master

## DIRECTORY
/Users/brent/scripts/CB-Workspace/wordpress-sites

## WHAT WE WERE DOING
**Fixing Flywheel WAF blocking page saves due to `<script type="application/ld+json">` in page content**

The issue: Flywheel's WAF was returning 403 Forbidden when trying to save pages via REST API because the page content contained embedded JSON-LD script tags. Posts worked fine, only pages failed.

**Root cause identified:** The `<script type="application/ld+json">` schema markup embedded in page content triggered Flywheel's WAF security rules.

**Solution implemented:**
1. Remove JSON-LD scripts from page content templates
2. Store schema as post_meta instead
3. Output schema via `wp_head` hook (proper location)
4. Add sidebar meta box for per-page schema management via CSV

## PENDING TODOS
- [COMPLETED] Remove JSON-LD script tags from hub template
- [COMPLETED] Remove JSON-LD script tags from parent template
- [COMPLETED] Remove JSON-LD script tags from child template
- [COMPLETED] Create schema meta box for page sidebar (in aeo-meta-boxes.php)
- [COMPLETED] Add wp_head hook to output schema from post_meta
- [IN PROGRESS] Add `requestdesk_generate_and_save_schema()` function to importer

## KEY FILES MODIFIED THIS SESSION
1. `admin/aeo-template-landing-hub.php` - Removed JSON-LD script blocks (lines 16-69)
2. `admin/aeo-template-landing-parent.php` - Removed JSON-LD script blocks
3. `admin/aeo-template-landing-child.php` - Removed 5 JSON-LD script blocks
4. `admin/aeo-meta-boxes.php` - Added Schema meta box, save handler, and wp_head output (lines 518-856)
5. `admin/aeo-template-importer.php` - Added schema generation calls at lines 1448, 1544, 1664

## CRITICAL STATE TO PRESERVE
- Plugin version: 2.5.1
- Local WP site: http://contentcucumber.local/wp-admin/
- Live site: https://www.contentcucumber.com (Flywheel hosting with Fastly CDN)
- The 403 error was from Flywheel's Varnish/Fastly WAF blocking `<script>` tags in page content

## NEXT STEPS
1. **FINISH** - Add `requestdesk_generate_and_save_schema()` function to end of aeo-template-importer.php
   - The function was written but file wasn't read before edit attempt
   - Read the end of the file first: `tail -30 admin/aeo-template-importer.php`
   - Then add the function before the closing `?>`

2. **PUSH** plugin updates to live site

3. **TEST** - Re-import pages via Template Importer and verify saves work

4. **VERIFY** - Check schema appears in page source via View Source (should be in `<head>`)

## FUNCTION TO ADD (was interrupted)
The `requestdesk_generate_and_save_schema($page_id, $csv_data, $page_type)` function needs to be added to the end of aeo-template-importer.php. It generates:
- Organization schema for hub/parent pages
- Service schema for child pages
- BreadcrumbList schema for all pages
- FAQ schema if faq columns exist
- HowTo schema if step columns exist

All stored as post_meta (`_requestdesk_schema_org`, `_requestdesk_schema_breadcrumb`, etc.) and output via the `requestdesk_output_schema_jsonld()` function in aeo-meta-boxes.php on `wp_head` hook.
