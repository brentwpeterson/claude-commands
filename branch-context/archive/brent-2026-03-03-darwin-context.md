# Resume Instructions for Claude

## SESSION STATUS
**Identity:** Claude-Darwin
**Status:** ACTIVE
**Last Saved:** 2026-03-03 16:20
**Last Started:** 2026-03-04 05:17

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Branch:** N/A (workspace root, not a git repo)
3. **Verify:** Proposal skill enhancement + EasiHair Pro proposal + HubSpot landing page API

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| cc | Proposal skill enhancement: HTML template, SKILL.md (Phase 0 Fireflies, --html, custom type), create-proposal.md (new flags) |
| brent | EasiHair Pro branded HTML proposal generated from Fireflies transcript |

## CURRENT TODO
**Path:** None (feature work, no branch/todo structure)
**Status:** Proposal skill enhanced. HubSpot landing page API partially working (content injection into body still needs template work).

## WHAT YOU WERE WORKING ON

### 1. Proposal Skill Enhancement (DONE)
Created 3 files per plan:
- **`.claude/skills/proposal-creation/proposal-template.html`** - New branded HTML template with CC design system (navy/green), print-ready CSS, token-based
- **`.claude/skills/proposal-creation/SKILL.md`** - Added Phase 0 (Fireflies transcript import), `--html` output, `custom` proposal type, HTML generation rules
- **`.claude-local/commands/create-proposal.md`** - Added `--from-meeting` and `--html` flags, updated help text, argument parsing, validation

### 2. EasiHair Pro Proposal (DONE)
- Pulled Fireflies transcript from today's call (ID: 01KJNG5YDCJ5HEBRY84ZGC6S58, "PR HHH -- BP Content Basis")
- Participants: Brent, Paul Reynolds (CEO), Dennis Dalangin (VP Corp Dev), Paige
- Extracted meeting details: 6-month pilot, Magento extension, content creation, no cost to client
- Created HubSpot deal: "EasiHair Pro - Magento Content Pilot" (ID: 57487388059)
  - Associated with company (34497355919), Paul (96955432212), Dennis (118574797617), Rachelle (118574797616)
  - Pipeline: default, Stage: appointmentscheduled
- Generated branded HTML proposal: `proposals/2026-03-easihair-pro-custom.html`
- 7 pricing placeholders ($X,XXX) for Brent to fill

### 3. HubSpot Landing Page API (IN PROGRESS)
- **Goal:** Host proposals on `get.contentcucumber.com` as HubSpot landing pages
- **API confirmed working:** `POST /cms/v3/pages/landing-pages` with private app token
- **Token stored:** `HUBSPOT_CMS_TOKEN` in workspace.env (`content` scope added to existing private app)
- **What works:** `headHtml` (CSS injection) and `footerHtml` render correctly
- **What doesn't work yet:** `layoutSections` body content doesn't render with `@hubspot/growth/templates/blank.html` - the dnd_area module structure needs a custom HubSpot template
- **Test page created and deleted.** No live pages remain.
- **Brent will create a custom HubSpot template** in Design Manager with a single full-width rich text/HTML module tomorrow

### Communication
- Received comms from Claude-Turing about HubSpot landing page API research
- Replied in `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/turing-to-darwin-hubspot-landing-page-api.md`

## CURRENT STATE
- **Files created:** proposal-template.html, 2026-03-easihair-pro-custom.html
- **Files modified:** SKILL.md, create-proposal.md, workspace.env (HubSpot token), claude-comms file
- **Tests run:** Proposal HTML opens correctly in Chrome. HubSpot API creates/publishes/deletes pages. Content injection needs template work.
- **Issues found:** HubSpot blank template doesn't expose dnd_area body content properly. Need custom template.

## TODO LIST STATE
- Completed: Proposal skill enhancement (HTML template, SKILL.md, command file)
- Completed: EasiHair Pro proposal generated + HubSpot deal created
- In Progress: HubSpot landing page integration (blocked on custom template)
- Pending: `/create-proposal --publish` flag (after template is ready)
- Pending: HubSpot personalizations (contact name, company from deal)
- Pending: Send Dennis the proposal (Brent needs to fill pricing first)

## NEXT ACTIONS
1. **BRENT ACTION:** Create a custom HubSpot template in Design Manager with a single full-width HTML/rich text module (no nav/footer chrome, or minimal proposal-specific chrome)
2. **THEN:** Wire up the API to push content into the custom template's module
3. **THEN:** Add HubSpot personalizations (contact tokens)
4. **THEN:** Add `--publish` flag to `/create-proposal` skill
5. **ALSO:** Brent fills in $X,XXX pricing placeholders and sends proposal to Dennis (follow-up in ~10 days)

## CONTEXT NOTES
- HubSpot portal ID: 39487190
- `get.contentcucumber.com` is the primary landing page domain (already resolving)
- Existing pages use `@marketplace/Juice_Tactics_Snacks/Krazy/templates/features.html` template
- Proposal URLs should have random 8-char hex hash for unguessability: `get.contentcucumber.com/[client]-[hash]`
- The HubSpot CMS token is the same private app as the MCP integration, just with `content` scope added
- Dennis Dalangin asked for proposal today/tomorrow, follow-up in 10 days
- Dennis is 9-10 months into his role, evaluating multiple AI vendors for 2026 AOP plan
- EasiHair Pro is on Adobe Commerce, uses VJ as dev partner. AEM is a sore subject (do not mention).

## DEFERRED QUESTIONS
1. **Pricing:** Brent needs to fill in all $X,XXX placeholders before sending to Dennis
2. **Blog post frequency:** How many posts/month for the pilot? (currently shows $X,XXX posts/month)
3. **Template design:** Does Brent want proposals completely chrome-free (no CC nav/footer) or with minimal branding?
