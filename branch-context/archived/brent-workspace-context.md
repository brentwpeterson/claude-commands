# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Branch:** CB-Workspace root (multi-project session)
3. **Last Activity:** 2026-01-09

## WORKSPACES TOUCHED THIS SESSION
**Started in:** rd (requestdesk)
**Current workspace:** bw (brent-workspace)

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| bw | brent-workspace | Daily routine, HubSpot work, backlog management |
| cc | claude-commands | Updated workspace.env with backlog API config |

## SESSION METADATA
**Saved:** 2026-01-09 ~13:30 PST

## WHAT WE DID THIS SESSION

### 1. Morning Routine (/brent-start)
- Posted 3 daily jokes to X, Bluesky, Threads via Vista Social
- Presented daily dashboard with Q1 2026 ROCKS progress
- User announced Rock #1 milestone done (Sales Navigator search - 985 contacts)

### 2. Backlog System Verification & Configuration
- Verified backlog migration: 84 items in production
- CRITICAL FIX: Updated workspace.env with explicit production backlog config
- Moved backlog-api-access.md to .claude/local/ with validation rules
- Added safety check: Production count = 84+, Local = 0 (STOP signal)

### 3. HubSpot Property Consolidation
- Migrated Platform to Commerce Platform (target_platform):
  - 4 Shopify contacts
  - 4 BigCommerce contacts
  - 3 Magento to Magneto/Adobe contacts
- Renamed "Target Platform" to "Commerce Platform" with clearer description
- Hidden old "platform" property (archived)
- Synced Company Platform for all 11 companies

### 4. HubSpot Enrichment Check
- User ran enrichment on "Shopify ALL" list
- Found personalization_paragraph populated for some contacts

### 5. Backlog Items Added
- Joint campaign with Chris Sanchez (Google Doc linked)
- Add recurring fields to backlog items (is_recurring, due_date, recurring_increment)

## PENDING TASKS
- Reconcile yesterday's completed items - User was about to tell us what was completed
- Recurring items feature - Design and implement for backlog system
- Continue HubSpot tasks (2 due today: Ken Shenkman, Eric sample output)
- Rock #1 next milestone: Start first outreach wave

## CRITICAL STATE TO PRESERVE

**Backlog API (PRODUCTION ONLY):**
- URL: https://app.requestdesk.ai/api/backlog
- Key: MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg
- Current count: 84+ items
- NEVER use localhost for backlog

**HubSpot:**
- userId: 50871775, hubId: 39487190, ownerId: 378618219

**Vista Social Profile IDs:**
- X: 23232, Bluesky: 457112, Threads: 399179

## NEXT ACTIONS
1. FIRST: Ask user what items they completed yesterday
2. THEN: Mark those items as completed in backlog
3. THEN: Set up recurring items (Tuesdays with Claude due Jan 13)

## DEFERRED QUESTIONS (Ask on /claude-start)
1. Reconciliation: What backlog items did you complete yesterday?
2. Time tracking: How long did you work on HubSpot/backlog tasks today?
