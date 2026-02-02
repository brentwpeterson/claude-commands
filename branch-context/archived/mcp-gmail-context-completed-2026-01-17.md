# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/mcp-servers/gmail`
2. **Project:** Gmail MCP Server (standalone project, no git repo)
3. **Status:** MCP server built and fully working

## SESSION METADATA
**Saved:** 2026-01-16 13:15
**Project Type:** MCP Server Development

## WHAT WAS ACCOMPLISHED

### Gmail MCP Server - WORKING
- 7 tools: list_emails, get_email, send_email, search, get_thread, modify_labels, list_labels
- Signature auto-fetched from Gmail sendAs settings
- Proper `From: Brent Peterson <email>` header
- Thread replies with In-Reply-To and References headers
- Folder parameter for list_emails (inbox, sent, unread, starred, etc.)

### Sender Display Name Fix
- **Issue:** Emails showed only email address, not "Brent Peterson <email>"
- **Root Cause:** Gmail "Send mail as" settings had inherited name (first radio button). Gmail API only returns EXPLICIT names, not inherited ones.
- **Solution:** User selected second radio button and typed "Brent Peterson" explicitly
- **Verified Working:** Test emails now show correct sender display name

### Key Discovery
- Gmail API's `sendAs.list()` returns empty `displayName` when using inherited workspace name
- Must explicitly set name (second radio option) for API to return it
- MCP server caches sender settings in memory - restart Claude Code to clear cache after Gmail settings change

## KEY FILES

### MCP Server
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/index.ts` - Main server
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/auth.ts` - OAuth flow
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/test-sendas.ts` - Debug script (can delete)
- `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/test-send-debug.ts` - Debug script (can delete)

### Config
- `/Users/brent/scripts/CB-Workspace/.mcp.json` - MCP server config
- `~/.mcp-gmail/credentials.json` - OAuth credentials
- `~/.mcp-gmail/token.json` - Auth tokens

### Article
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md`

## NEXT ACTIONS
1. **VERIFY:** User confirms final test email has both display name AND signature
2. **CLEANUP:** Delete test-sendas.ts and test-send-debug.ts debug scripts
3. **ARTICLE:** Add display name fix to "Post-Launch Discoveries" section if not already there

## CONTEXT NOTES
- Cache clears on MCP server restart (Claude Code restart)
- Debug logging in getSenderSettings() outputs to stderr (not visible in normal use)
- LinkedIn teaser ready to post manually (Vista Social API didn't work from CLI)
