# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/mcp-servers/gmail`
2. **Project:** Gmail MCP Server (new project, no git repo yet)
3. **Status:** MCP server built, tested, and working

## SESSION METADATA
**Saved:** 2026-01-16 (afternoon session - merged from two windows)
**Project Type:** MCP Server Development + TWC Article

## WHAT WAS ACCOMPLISHED THIS SESSION

### Gmail MCP Server Built
- Created `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/` project structure
- Built TypeScript MCP server with 7+ tools:
  - `gmail_list_emails` (with folder parameter: inbox, sent, unread, starred, etc.)
  - `gmail_get_email`
  - `gmail_send_email` (with signature, proper From header, threading)
  - `gmail_search`
  - `gmail_get_thread`
  - `gmail_modify_labels`
  - `gmail_list_labels`

### Google Cloud Setup
- Created new project: `brent-mcp-tools` (separate from production RequestDesk OAuth)
- Enabled Gmail API
- Configured OAuth consent screen (Internal user type - skips verification)
- OAuth credentials saved to `~/.mcp-gmail/credentials.json`
- Auth tokens saved to `~/.mcp-gmail/token.json`

### Enhancements Added (by other Claude session)
- Email signatures auto-fetched from Gmail sendAs settings
- Proper `From: Brent Peterson <email>` header
- Thread replies with `In-Reply-To` and `References` headers
- New `replyToMessageId` parameter for proper threading

### MCP Configuration
- Added to `/Users/brent/scripts/CB-Workspace/.mcp.json`
- Server verified working: `claude mcp list` shows `gmail: ✓ Connected`

### Sender Display Name Fix
- **Issue:** Emails showed only email address, not "Brent Peterson <email>"
- **Root Cause:** Gmail "Send mail as" settings had inherited name (first radio), API only returns explicit names
- **Solution:** User changed to second radio button and typed "Brent Peterson" explicitly
- **Status:** Fixed and working

### Tuesdays with Claude Article (Week 18)
- **Draft:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md`
- **Title:** "My Gmail MCP in 30 Minutes"
- **Publish Date:** January 21, 2026 (Tuesday)
- **Status:** Ready for final review
- Includes: intro (ties to Sprint Planning article), 5-step tutorial, folder parameter table, post-launch discoveries section, LinkedIn post draft

### CLAUDE.md Updated
- Added "BRENT'S WRITING STYLE" critical rule to workspace CLAUDE.md
- No em dashes (ever), no emojis (unless requested)
- Use periods, commas, parentheses instead

## KEY FILES

### MCP Server Code
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/index.ts` - Main server
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/auth.ts` - OAuth flow
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/package.json`
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/README.md`

### Config Files
- `/Users/brent/scripts/CB-Workspace/.mcp.json` - MCP server config (gmail added)
- `~/.mcp-gmail/credentials.json` - OAuth credentials (DO NOT COMMIT)
- `~/.mcp-gmail/token.json` - Auth tokens (DO NOT COMMIT)

### Article Files
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md` - Main article
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-capture-gmail-mcp.md` - Raw capture notes
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/TWC-ARTICLE-INVENTORY.md` - Updated Week 18

## LINKEDIN TEASER (Ready to post manually)
```
Next week on Tuesdays with Claude.

I built a Gmail MCP server in 30 minutes.

My morning routine happens in Claude Code.
Check HubSpot for new leads.
Scan inbox for urgent emails.
Reply without switching tabs.
Review sprint tasks.

No context switching. No browser tabs. One terminal.

The how-to drops Tuesday.

Have a great weekend.

#ClaudeCode #MCP #DeveloperTools #BuildInPublic
```

## OPEN ITEMS / NEXT STEPS

1. **Post LinkedIn teaser manually** - Vista Social API didn't work from CLI
2. **Final article review** - User to review before publishing Tuesday
3. **Future MCP ideas:**
   - Vista Social MCP (for posting)
   - LinkedIn MCP
   - Calendar MCP
   - Google Drive MCP

## DEFERRED QUESTIONS (Ask on /claude-start)
1. **Time tracking:** "How long did you work on Gmail MCP today?"
2. **Task status:** "Is the Gmail MCP article ready to publish or needs more edits?"

## CONTEXT NOTES
- Brand persona loaded (`/brand-brent`) - no em dashes, no emojis, direct voice
- User had TWO Claude windows - this session merged context from other session
- Vista Social API key exists (`VISTA_SOCIAL_API_KEY`) but correct endpoint unknown
- MCP server caches sender settings in memory, cleared on restart
