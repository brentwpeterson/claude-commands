# CC Partners - Technology Partner Management on contentcucumber.com

**Skill Description:** Workflow and data model for managing Content Cucumber's technology partners (Shopify, HubSpot, Mailchimp, Gorgias, Hyva, etc.) as the `cc_partner` custom post type. Covers adding new partners, the bulk-import flow, required and optional fields, display surfaces, and post-launch cross-linking.

---

## CRITICAL DISTINCTION

| Skill | Purpose | Context |
|-------|---------|---------|
| **cc-partners** (THIS) | Technology/platform partners listed on contentcucumber.com | `cc_partner` CPT, site-facing partner pages |
| **hubspot-partner** | CC's service offerings as a HubSpot Solutions Partner | What CC sells to HubSpot customers |
| **hubspot-sales** | CC's own HubSpot CRM | Internal sales outreach |

This skill is about managing the PARTNER LIST on the website, not about what CC sells.

---

## When Claude Should Apply This Skill

Apply when:
- Adding a new technology partner to contentcucumber.com
- User says "add partner", "new partner page", or names a specific platform to feature (Mailchimp, Gorgias, Shopify, etc.)
- Editing existing partner posts (fields, content, featured flag, cross-links)
- Reviewing or refreshing the `/partners/` archive or individual partner pages
- Troubleshooting partner display on the homepage

Do NOT apply when:
- Working on HubSpot service pages (use `hubspot-partner`)
- Working on CC's HubSpot CRM (use `hubspot-sales`)

---

## Data Model

**Custom Post Type:** `cc_partner`
**Registered in:** `wp-content/plugins/requestdesk-connector/includes/class-requestdesk-partner.php`
**Templates:**
- `archive-cc_partner.php` (the `/partners/` listing)
- `single-cc_partner.php` (individual partner page)
- `template-parts/homepage-json-renderer.php` (featured partners on homepage)

### Fields

| Field | Storage | Source | Required |
|---|---|---|---|
| Title | `post_title` | Partner name (e.g. "Mailchimp") | Yes |
| Slug | `post_name` | Auto from title | Yes |
| Excerpt | `post_excerpt` | Short tagline ~30 words | Yes |
| Body | `post_content` | HTML content with `<h2>` sections | Yes |
| Website | `_requestdesk_partner_website` | URL | Yes |
| Tagline | `_requestdesk_partner_tagline` | Short phrase | Recommended |
| Logo | `_requestdesk_partner_logo` | Media Library attachment ID | Recommended |
| Tier | `_requestdesk_partner_tier` | e.g. "Technology", "Gold", etc. | Check existing values |
| Hero image | `_requestdesk_partner_hero_image` | Attachment ID | Optional |
| Hero overlay | `_requestdesk_partner_hero_overlay` | Hex color | Optional |
| CTA text | `_requestdesk_partner_cta_text` | Button label | Optional |
| CTA URL | `_requestdesk_partner_cta_url` | Link target | Optional |
| Featured | `_requestdesk_partner_featured` | Bool — controls homepage inclusion | Optional |
| HubSpot company ID | `_requestdesk_partner_hubspot_company_id` | HubSpot record ID | Optional |
| HubSpot form ID | `_requestdesk_partner_hubspot_form_id` | Per-partner form for leads | Optional |

---

## Existing Partners (as of 2026-04)

Astro, Adobe, HubSpot, Hyva, Run Free Project, Evrig Solutions, AraGrow, Shopify, WooCommerce, eStreamly, Psyberware, Shopware, Contentful, ButterCMS, BigCommerce.

Query the DB to get the current list:
```sql
SELECT ID, post_title, post_name, post_status
FROM wp_83rxila95v_posts
WHERE post_type='cc_partner' AND post_status='publish'
ORDER BY post_title;
```

---

## Adding a New Partner

### Path A: Bulk import via plugin (preferred for multiple partners)

1. **Edit** `wp-content/plugins/requestdesk-connector/includes/data/partners-import.json`
   - Append a new object to the array with fields: `name`, `website`, `linkedin`, `excerpt`, `logo_file`, `content`
   - Match voice/format of existing entries (see Hyva in the DB for reference)
   - Use factual positioning only. Do not fabricate numbers, customer counts, or quotes.

2. **Drop logo file** into `wp-content/plugins/requestdesk-connector/includes/data/logos/`
   - Filename must match the `logo_file` value in the JSON
   - Prefer SVG or transparent PNG
   - If no logo ready at import time, leave `logo_file: ""` and upload via Media Library later

3. **Bump plugin version** in `requestdesk-connector.php` (PATCH for import JSON changes, per memory rule)

4. **Run the importer** in WP admin: `CC Partners → Import Partners` (URL: `edit.php?post_type=cc_partner&page=requestdesk-partner-import`)
   - Existing partners with matching names are automatically skipped
   - Partners import as **drafts** (never published directly)

5. **Complete remaining fields via WP post editor** (the importer only sets: title, slug, excerpt, content, website, tagline, hero overlay, logo):
   - Tier
   - Hero image
   - CTA text + URL
   - Featured flag
   - HubSpot company ID
   - HubSpot form ID

6. **Preview and publish**

### Path B: Single partner via WP admin

1. WP admin → `CC Partners → Add New`
2. Fill title, body, excerpt
3. Fill all meta fields (sidebar meta box)
4. Upload logo to Media Library, select for logo field
5. Publish

---

## Display Surfaces (cross-link checklist)

After publishing a new partner, verify it shows up correctly:

| Surface | Check |
|---|---|
| `/partners/` archive | New card appears in the grid |
| `/partners/{slug}/` single page | Hero, logo, body content render |
| Homepage featured partners section | Shows only if `featured` flag is true |
| Menus (Appearance → Menus) | Consider adding to any relevant sub-menu |
| `llms.txt` | Add partner under Partners section if needed |
| Relevant blog posts / case studies | Cross-link where the partnership is mentioned |
| HubSpot company record | Company ID filled on partner post if applicable |

---

## Voice and Content Rules

Follow `brand-brent` voice rules when writing partner copy:

- No em dashes (use periods, commas, or parentheses)
- No "should" or prescriptive language
- No emojis
- No fabricated stats or customer counts. Cite only publicly verifiable facts.
- Excerpt: ~30 words, factual, lead with what the platform does + one differentiator
- Body: use `<h2>Key benefits of the offering:</h2>` followed by `<ul>` with `<strong>` labels, then `<h2>Why partner together?</h2>` closing paragraph

Reference the existing Hyva and Shopify partner posts for voice/format match before writing new content.

---

## Supporting Files

None yet. Add sub-files as patterns emerge (e.g., `partner-content-template.md` with the exact HTML skeleton, `partner-launch-checklist.md` with the publish/announce workflow).

---

## Related

- Plugin source: `wp-content/plugins/requestdesk-connector/includes/class-requestdesk-partner.php`
- Import JSON: `wp-content/plugins/requestdesk-connector/includes/data/partners-import.json`
- Logo dir: `wp-content/plugins/requestdesk-connector/includes/data/logos/`
- Memory: [Plugin Version Bump Rule](../../../memory/feedback_bump_plugin_version.md) — every RD plugin edit bumps patch version
- Memory: [Brand: Brent Peterson](../../skills/brand-brent/) — voice rules for all CC-authored copy
