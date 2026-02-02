# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/mcp-servers/gmail`
2. **Project:** Gmail MCP Server (not a git repo, standalone MCP server project)
3. **Related article:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md`

## SESSION METADATA
**Saved:** 2026-01-16 12:40
**Project Type:** MCP Server Development

## WHAT YOU WERE WORKING ON
Testing and fixing the Gmail MCP server to properly include:
1. Sender display name ("Brent Peterson" not just "brent@contentbasis.io")
2. Email signature (fetched from Gmail settings via sendAs.list())
3. Proper threading (In-Reply-To and References headers)

## CURRENT STATE

### What's Working
- **Signature:** Full HTML signature renders perfectly with photo, name, title, social icons, banner, and "Book a Meeting" button
- **Threading:** In-Reply-To and References headers implemented for proper reply threading
- **HTML emails:** Body converted to HTML with signature appended

### What's NOT Working
- **Sender display name:** Shows `brent@contentbasis.io` instead of `Brent Peterson <brent@contentbasis.io>`
- The From header code at line 216-218 is correct but `sender.displayName` is coming back empty from Gmail API

### Debug Logging Added
Added debug logging to `getSenderSettings()` function (lines 78-84 in index.ts):
```typescript
console.error("SendAs settings found:", JSON.stringify({
  displayName: primary?.displayName,
  email: primary?.sendAsEmail,
  isDefault: primary?.isDefault,
  hasSignature: !!primary?.signature,
}, null, 2));
```

### Build Status
- MCP server rebuilt with debug logging
- User needs to restart Claude Code to reload MCP server
- Then send test email to see what `displayName` the Gmail API returns

## KEY FILES
- **Main source:** `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/index.ts`
- **Auth script:** `/Users/brent/scripts/CB-Workspace/mcp-servers/gmail/src/auth.ts`
- **Article:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md`

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** User restarts Claude Code to reload MCP server with debug logging
2. **THEN:** Send another test email to `creativedata@gmail.com`
3. **CHECK:** Look at Claude Code logs to see what `displayName` value is being returned
4. **IF EMPTY:** User needs to check Gmail settings:
   - Gmail web → Settings → See all settings → Accounts and Import → Send mail as
   - Verify "Brent Peterson" is set as the name for the email address
5. **AFTER FIX:** Document findings in article under "Post-Launch Discoveries" section

## TEST EMAIL DETAILS
- **Last test sent:** 2026-01-16 12:34 PM
- **To:** creativedata@gmail.com
- **Subject:** "Signature Format Test"
- **Result:** Signature perfect, sender name blank

## VERIFICATION COMMANDS
```bash
# Rebuild MCP server
cd /Users/brent/scripts/CB-Workspace/mcp-servers/gmail && npm run build

# Check source file
cat src/index.ts | grep -A 10 "getSenderSettings"
```

## CONTEXT NOTES
- The Gmail sendAs.list() API returns the display name from Gmail's "Send mail as" settings
- If displayName is empty in API response, it means the setting isn't configured in Gmail
- The signature IS working (from same API call), so the API connection is fine
- Issue is likely user configuration in Gmail settings, not code

## ARTICLE UPDATE NEEDED
When issue is resolved, add to `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-21-gmail-mcp.md` under "Post-Launch Discoveries":

Format: `[Feature name]. [One sentence problem]. [One sentence solution].`
