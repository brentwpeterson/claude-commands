# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Identity:** Claude-Earhart
3. **Branch:** main

## SESSION METADATA
**Date:** 2026-01-21 (Wednesday)
**Sprint:** S2 (Jan 19-30)
**Saved:** 2026-01-21 evening session

## WORKSPACES TOUCHED
- `brent` (brent-workspace) - Main workspace
- `rd` (requestdesk) - Claude-Beethoven working there on file upload

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. Inter-Claude Communication Protocol
- Established `.claude/claude-comms/` directory for Claude-to-Claude handoffs
- Created shortcut commands: go, back, sync, decide, done, you're up, status, park it
- Successfully coordinated with Claude-Beethoven on file upload architecture
- Decision made: Unified `files` collection with `file_category` field

### 2. TWC Article Written
- Completed: `tuesdays-with-claude-inter-claude-handoff.md`
- LinkedIn post: `social-posts/linkedin-post-inter-claude-handoff.md`
- Publish date: January 28, 2026
- Both Beethoven and Earhart contributed perspectives

### 3. Beethoven's Deployment
- `matrix-v0.40.2-unified-post-image-endpoint` deployed successfully
- Unified `files` collection architecture is LIVE
- Blog post images now use `file_category: "post_image"`

## WHAT'S STILL NEEDED

### `/api/public/files/upload` Endpoint (BLOCKING)
Beethoven needs to build this endpoint for agent API key authentication.

**Specs given to Beethoven:**
- Location: `/backend/app/routers/public/files.py`
- Auth: Same pattern as `/api/agent/content`
- Accept: `Authorization: Bearer {AGENT_API_KEY}`
- Form fields: `file`, `file_category`, `description`
- Response: `{ status, file_id, url, file_category }`

**Once deployed, Earhart can:**
1. Upload image via agent API key
2. Get S3 URL
3. Post to Vista Social with image

## CLAUDE-COMMS FILES
- `beethoven-to-earhart-media-coordination.md` - Original handoff
- `earhart-to-beethoven-response.md` - Architecture recommendation
- `earhart-to-beethoven-agent-upload.md` - Request for agent auth endpoint

## TODO LIST STATE
- ✅ TWC article for inter-Claude handoff (complete, ready for Jan 28)
- 🔄 Vista Social image posting (blocked on agent upload endpoint)
- ⏳ MiMS Instagram posts (waiting for image upload capability)

## NEXT ACTIONS ON RESUME
1. Check if Beethoven deployed `/api/public/files/upload`
2. If yes: Test with image upload, then post to Vista Social
3. If no: Wait or help Beethoven complete it

## REFERENCE INFO

### Vista Social Profile IDs
| Platform | ID |
|----------|-----|
| LinkedIn Personal | 22469 |
| X/Twitter | 23232 |
| Bluesky | 457112 |
| Threads | 399179 |

### MiMS Fundraising Link
https://secure.givelively.org/donate/mile-in-my-shoes/2026-grandma-s-fundracing-team-for-mile-in-my-shoes/brent-peterson-2

## DEFERRED QUESTIONS (Ask on /brent-start)
1. **Time tracking:** "How long did you work today?"
2. **Task status:** "Is the TWC article ready to publish on Jan 28?"
