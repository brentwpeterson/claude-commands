# Resume Instructions for Claude-Beethoven

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/requestdesk-app`
2. **Verify branch:** `git checkout feature/post-image-upload`
3. **Check processes:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)

## SESSION METADATA
**Claude Identity:** Claude-Beethoven
**Last Commit:** `96c426df Add changelog entry for unified post-image endpoint`
**Saved:** 2026-01-22 (session killed mid-task)
**Previous Session File:** `.claude/branch-context/rd-blog-context.md`

## WORKSPACES TOUCHED THIS SESSION
**Started in:** rd (requestdesk-app)
**All workspaces:** rd, brent

| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `rd` | requestdesk-app | Deployed unified post-image endpoint, started building agent-auth upload |
| `brent` | brent-workspace | Added Beethoven's perspective to TWC draft |

## WHAT WAS ACCOMPLISHED

### 1. Deployed Unified Post-Image Endpoint
- **Tag:** `matrix-v0.40.2-unified-post-image-endpoint`
- **Changes:** `backend/app/routers/posts.py`
- **Features:**
  - Combined POST `/api/posts/create-with-image` endpoint
  - Unified files collection with `file_category: "post_image"`
  - Posts reference `file_id` instead of embedding full image data

### 2. Added TWC Article Contribution
- **File:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/drafts/twc-draft-2026-01-28-inter-claude-handoff.md`
- Added "## Beethoven's Perspective" section about inter-Claude coordination

### 3. Discovered Auth Gap During Production Testing
- Tested `create-with-image` endpoint with agent API key
- Got "Could not validate credentials" error
- **Root cause:** Endpoint uses user JWT auth, but CLI usage needs agent API key auth
- Read Earhart's message about this gap: `.claude/claude-comms/earhart-to-beethoven-agent-upload.md`
- Wrote response: `.claude/claude-comms/beethoven-to-earhart-upload-response.md`

## WHAT WAS IN PROGRESS WHEN SESSION KILLED

**Building:** POST `/api/public/files/upload` with agent API key auth

**Location:** `/backend/app/routers/public/files.py` (new file to create)

**Auth Pattern (from `/api/agent/content`):**
```python
auth_header = request.headers.get("Authorization")
api_key = auth_header.replace("Bearer ", "")
agent = await db.agents_collection.find_one({"api_key": api_key})
```

**Endpoint Spec:**
```python
@router.post("/upload")
async def upload_file_agent(
    request: Request,
    file: UploadFile = File(...),
    file_category: str = Form("social_media"),
    description: Optional[str] = Form(None),
):
```

**What it should do:**
1. Authenticate via agent API key
2. Validate agent status (ACTIVE/RUNNING)
3. Get user context from `agent.created_by`
4. Upload to S3 using existing logic
5. Save to files collection with file_category
6. Return `{"status": "success", "file_id": "...", "url": "...", "file_category": "..."}`

**Register in:** `/backend/app/main.py` under public routes

## INTER-CLAUDE COMMUNICATION FILES
- **Earhart's request:** `.claude/claude-comms/earhart-to-beethoven-agent-upload.md`
- **Beethoven's response:** `.claude/claude-comms/beethoven-to-earhart-upload-response.md`

## AGENT API KEY FOR TESTING
```
ZNgUN47QKeykN8voMmRbuyRT1G3edDxo
```

## TEST IMAGE FOR PRODUCTION TEST
- **Original:** `/Users/brent/Downloads/requestd-desk-social-card/1.png`
- **Copied to:** `/Users/brent/scripts/CB-Workspace/requestdesk-app/tmp/test-image.png`

## CURL ISSUE DISCOVERED
- Angle brackets in `-F "post_content=<p>Test</p>"` cause curl errors
- Must escape or avoid HTML tags in curl -F parameters
- Working pattern: `-F 'post_content=Test content without angle brackets'`

## TODO LIST STATE
- [x] COMPLETED: Deploy unified endpoint to production (tag: matrix-v0.40.2-unified-post-image-endpoint)
- [ ] IN PROGRESS: Build `/api/public/files/upload` with agent API key auth (session killed here)
- [ ] PENDING: Test create-with-image from CLI in production (blocked on agent auth)
- [ ] PENDING: Make 'Publish to RequestDesk.ai Blog' label dynamic

## NEXT ACTIONS (PRIORITY ORDER)
1. **FIRST:** Create `/backend/app/routers/public/files.py` with agent-auth upload endpoint
2. **THEN:** Register router in `/backend/app/main.py`
3. **THEN:** Test locally with Docker
4. **THEN:** Deploy with `/deploy-project`
5. **VERIFY:** Test production upload with agent API key

## LESSON FOR TWC ARTICLE
Coordination caught the architecture issue (unified files collection), but we deployed after step 1 without step 2 (agent auth). Architectural alignment is not workflow completeness. Add this to the TWC draft.

## CONTEXT NOTES
- Deployment completed successfully but endpoint untestable without agent auth
- Earhart needs this endpoint for Vista Social media uploads
- Both Claudes working toward same files collection architecture
