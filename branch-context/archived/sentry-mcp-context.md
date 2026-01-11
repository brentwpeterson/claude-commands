# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace`
2. **Verify git status:** `git status` (expect: clean working tree or minor changes)
3. **Check processes:** `docker ps` (expect: cbtextapp services running)
4. **Verify branch:** `git branch --show-current` (should be: feature/brand-builder)

## CURRENT TODO FILE
**Path:** No formal todo directory - this is standalone Sentry MCP integration work
**Status:** Documentation complete, authentication pending
**Directory Structure:** N/A - no todo directory for this task
**Architecture Map:** External integration (Sentry MCP) - no CB internal architecture validation needed

## WHAT YOU WERE WORKING ON
Setting up Sentry MCP (Model Context Protocol) integration with Claude Code for direct access to cb-requestdesk Sentry data without leaving Claude Code interface. The goal is to enable real-time error analysis, AI-powered debugging insights, and performance monitoring directly in the development workflow.

## CURRENT STATE
- **Last command executed:** `claude mcp get sentry`
- **Files modified:**
  - Created: `docs/sentry-mcp-integration.md` (complete integration guide)
  - Created: `docs/sentry-mcp-quick-reference.md` (command reference card)
- **CB Flow Impact:** External integration - no direct CB architecture changes
- **Tests run:** `claude mcp list` - confirmed Sentry server installed but "⚠ Needs authentication"
- **Issues found:** OAuth authentication flow not yet completed

## TODO LIST STATE
- ✅ COMPLETED: Set up Sentry MCP integration with Claude Code (USER APPROVED: No - needs confirmation)
- 🔄 IN PROGRESS: Test MCP integration with cb-requestdesk Sentry data
- ✅ COMPLETED: Document MCP commands and workflow (USER APPROVED: No - needs confirmation)
- ⏳ PENDING: Trigger Sentry MCP OAuth authentication

## COMPLETION APPROVAL STATUS
**🚨 CRITICAL RULE**: NEVER mark tasks as completed until user explicitly approves

### Completion Trigger Protocol
**🚫 CLAUDE CAN NEVER DECLARE TASKS COMPLETE - ONLY HUMANS CAN**

**Documentation Status:**
- **Integration Guide**: Created comprehensive guide with authentication methods, troubleshooting
- **Quick Reference**: Created command reference for daily workflows
- **NOT YET USER APPROVED**: Need to ask "Does this documentation appear ready for you to mark as complete?"

**Authentication Status:**
- **MCP Server**: ✅ Installed and configured at https://mcp.sentry.dev/mcp
- **Authentication**: ⚠ Still shows "Needs authentication"
- **OAuth Flow**: Not yet triggered - this is the main blocking task

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Trigger Sentry OAuth authentication flow
   - Try: `@sentry list organizations` (in Claude Code CLI if available)
   - Or: Visit https://sentry.io/settings/account/api/auth-tokens/ for manual token
2. **THEN:** `claude mcp list` (should show "✓ Connected" after auth)
3. **VERIFY:** `@sentry list projects` (should show cb-requestdesk project)

## VERIFICATION COMMANDS
- Check MCP status: `claude mcp list`
- Check MCP details: `claude mcp get sentry`
- Test basic function: `@sentry list organizations`
- Test project access: `@sentry list projects`
- Test error access: `@sentry list issues --limit 5`

## MCP AUTHENTICATION METHODS TO TRY
**Method 1: Automatic OAuth (Preferred)**
- Use `@sentry` commands in Claude Code CLI - should auto-trigger browser OAuth
- Complete OAuth flow with Sentry organization containing cb-requestdesk

**Method 2: Manual Token (Fallback)**
- Go to: https://sentry.io/settings/account/api/auth-tokens/
- Create token with org:read, project:read, event:read permissions
- Configure with MCP server (method to be determined)

**Method 3: Claude Code CLI Direct**
- Exit this session: `exit`
- Start new Claude Code session: `claude`
- Try: `@sentry list organizations` - should trigger auth

## CONTEXT NOTES
- **OpenMemory Server**: Running at http://localhost:8080 (confirmed)
- **Current Branch**: feature/brand-builder (documentation committed)
- **MCP Integration**: Server configured correctly, just needs OAuth completion
- **No Todo Directory**: This work is standalone, not part of formal CB task structure
- **Documentation**: Complete and ready for use once authentication works
- **Expected Outcome**: Direct Sentry error analysis within Claude Code without context switching

## AUTHENTICATION TROUBLESHOOTING
If authentication fails:
1. Check Sentry service status: https://status.sentry.io/
2. Verify you have access to cb-requestdesk Sentry organization
3. Try removing and re-adding MCP server: `claude mcp remove sentry`, then reinstall
4. Check browser popup blockers if OAuth window doesn't appear
5. Verify MCP server URL: https://mcp.sentry.dev/mcp (currently configured correctly)

## BENEFITS ONCE WORKING
- **Direct Error Querying**: `@sentry list errors cb-requestdesk --recent`
- **AI Analysis**: `@sentry analyze error [id] --with-seer`
- **Performance Insights**: `@sentry performance-overview cb-requestdesk`
- **Deployment Monitoring**: `@sentry releases cb-requestdesk`
- **Workflow Integration**: Debug errors while reviewing code in Claude Code

**🔑 KEY SUCCESS CRITERIA:**
- `claude mcp list` shows "✓ Connected" for sentry
- `@sentry list projects` returns cb-requestdesk
- Can query recent errors without leaving Claude Code
- Documentation confirms all commands work as expected