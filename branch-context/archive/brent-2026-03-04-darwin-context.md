# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Darwin
**Status:** SAVED
**Last Saved:** 2026-03-04 14:05
**Last Started:** 2026-03-04 07:20

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Branch:** N/A (workspace root, not a git repo)
3. **Verify:** HubSpot landing page API + proposal publishing workflow

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| cc | HubSpot landing page API testing: template selection, layoutSections structure, publish workflow discovery |
| brent | Created proposal SOP and HubSpot template setup guide in Obsidian |

## CURRENT TODO
**Path:** None (feature work, no branch/todo structure)
**Status:** Discovered HubSpot publish workflow. Created documentation. Waiting on Brent to create custom HubSpot template.

## WHAT YOU WERE WORKING ON

### 1. Proposal Skill Enhancement (DONE - prev session)
Created 3 files: proposal-template.html, SKILL.md, create-proposal.md

### 2. EasiHair Pro Proposal (DONE - prev session)
- HubSpot deal: "EasiHair Pro - Magento Content Pilot" (ID: 57487388059)
- Generated HTML proposal: `proposals/2026-03-easihair-pro-custom.html`
- 7 pricing placeholders ($X,XXX) for Brent to fill

### 3. HubSpot Landing Page API (IN PROGRESS)

**Key discoveries this session:**

1. **`state: "PUBLISHED"` on create does NOT actually publish.** Pages serve 404 despite API saying PUBLISHED.
2. **Correct publish workflow:**
   - `POST /cms/v3/pages/landing-pages` (create page with layoutSections + headHtml)
   - `PATCH .../{id}` to set `htmlTitle` (REQUIRED for publish)
   - `POST /cms/v3/pages/landing-pages/schedule` with `{"id": "...", "publishDate": "[future ISO]"}`
   - `publishDate` must be in the future (even 1 min works). Returns 204 on success.
3. **Rich text module structure:** `module_id: 1155639`, `type: "custom_widget"`, HTML in `params.html`
4. **Blank template doesn't work.** Use `@marketplace/Juice_Tactics_Snacks/Krazy/templates/features.html` or a custom template.
5. **CSS injection via `headHtml` works.** Scope with `.proposal-wrap` prefix.
6. **No `design_manager` scope exists.** There IS a `cms.templates` scope (not yet added to private app).

### 4. Documentation Created (prev session)
- **HubSpot template setup guide:** `Brent Notes/Sales and Marketing/Company Websites/Content Cucumber/New Feature Plans/hubspot-proposal-template-setup.md`
  - Step-by-step for creating the template in Design Manager
  - Includes coded template option (HubL with single dnd_area)
  - Checklist for the whole setup process
- **Proposal creation SOP:** `Brent Notes/Sales and Marketing/proposals/SOP-proposal-creation.md`
  - Full workflow: gather info, choose path, discovery, review, pricing, publish, send
  - Quick reference table for all command variants
  - Troubleshooting section

## CURRENT STATE
- **Files created prev sessions:** hubspot-proposal-template-setup.md, SOP-proposal-creation.md
- **Test pages on HubSpot:** 208712421479 (blank template, serves 404, DELETE), 208712422734 (Krazy template, was scheduled to publish at ~16:23 UTC 2026-03-04, CHECK IF IT RENDERED)
- **Issues:** Need custom template for chrome-free proposal pages
- **This session:** Resumed but no new work done. Saving for tomorrow.

## TODO LIST STATE
- Completed: Proposal skill enhancement (prev session)
- Completed: EasiHair Pro proposal generated + HubSpot deal created (prev session)
- Completed: HubSpot template setup guide + proposal SOP written
- In Progress: HubSpot landing page integration (blocked on custom template creation)
- Pending: Verify darwin-test-krazy rendered after scheduled publish
- Pending: Brent creates custom HubSpot template in Design Manager
- Pending: Wire API to push content into custom template
- Pending: `/create-proposal --publish` flag
- Pending: HubSpot personalizations (contact name, company from deal)
- Pending: Brent fills pricing + sends proposal to Dennis
- Pending: Delete test page 208712421479

## NEXT ACTIONS
1. **FIRST:** Check if `get.contentcucumber.com/darwin-test-krazy` rendered (scheduled publish was ~16:23 UTC 2026-03-04)
2. **BRENT ACTION:** Create custom HubSpot template (follow guide in New Feature Plans/hubspot-proposal-template-setup.md)
3. **THEN:** Wire API to custom template + test full publish workflow
4. **THEN:** Build `--publish` flag into `/create-proposal` skill
5. **ALSO:** Fill pricing placeholders and send Dennis the proposal

## CONTEXT NOTES
- HubSpot portal ID: 39487190
- `get.contentcucumber.com` is the primary landing page domain
- Proposal URLs: `get.contentcucumber.com/[client]-[hash]` (8-char hex for unguessability)
- HubSpot CMS token = same private app as MCP integration, with `content` scope
- Dennis Dalangin asked for proposal within 1-2 days (as of 2026-03-03)
- EasiHair Pro is on Adobe Commerce, uses VJ as dev partner. AEM is a sore subject.
- `cms.templates` scope exists but not added to private app yet (may need for custom template creation via API)
- Module IDs: 1155639 (rich_text), 1155826 (heading), 1155231 (image), 8243667 (button)

## DEFERRED QUESTIONS
1. **Pricing:** Brent needs to fill in all $X,XXX placeholders
2. **Template chrome:** Krazy template includes full site nav/footer. OK for proposals, or need chrome-free?
3. **Test page:** Did darwin-test-krazy render after the scheduled publish at 16:23 UTC?
