# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Identity:** Claude-Curie
3. **Plan Mode Active:** YES - Plan file at `/Users/brent/.claude/plans/greedy-gliding-prism.md`

## SESSION METADATA
**Date:** 2026-01-21 (Wednesday)
**Sprint:** S2 (Jan 19-30)
**Saved:** 2026-01-21 afternoon/evening session

## WORKSPACES TOUCHED
- `brent` (brent-workspace) - Main workspace for this session

## WHAT WAS ACCOMPLISHED THIS SESSION

### 1. MiMS Fundraising Campaign (COMPLETED)
- Created fundraising team page note: `ob-notes/Brent Notes/MiMS/A Note From Brent - Fundraising.md`
- Saved fundraising link: https://secure.givelively.org/donate/mile-in-my-shoes/2026-grandma-s-fundracing-team-for-mile-in-my-shoes/brent-peterson-2
- Created LinkedIn launch post: `ob-notes/Brent Notes/MiMS/LinkedIn Post - Fundraising Launch.md`
- Created full content plan: `ob-notes/Brent Notes/MiMS/Content Plan - 2026 Fundraising.md`
- Created MiMS skill: `.claude/skills/mims/SKILL.md`
- Created Instagram posts:
  - Launch post: `Instagram Post - Launch.md`
  - Vegas run: `Instagram Post - Vegas Run.md`
  - Hawaii marathon: `Instagram Post - Hawaii Marathon.md`
  - Test image post: `Instagram Post - Test Image.md`

### 2. Route53 Setup
- Added brent.run domain to AWS Route53
- Hosted Zone ID: Z06093052V1SRF60R2OGX
- Nameservers configured, user updated at Namecheap

### 3. Vista Social + File Upload Integration (IN PROGRESS - PLAN MODE)
- User wanted to test posting image via Vista Social API
- Discovered gap: `/api/files/upload` requires JWT auth, not agent API key
- User pointed out this should work same as content APIs
- Entered PLAN MODE to design `/api/public/files/upload` endpoint

## KEY LEARNING FROM THIS SESSION
**User taught critical lesson:** File uploads should use the SAME authentication pattern as other content APIs (agent API key), not special handling. The existing files router has the upload logic - just needs an agent-authenticated endpoint following the pattern in `/api/agent/content`.

## PLAN MODE STATUS
**Plan file:** `/Users/brent/.claude/plans/greedy-gliding-prism.md`
**Status:** Draft plan created for adding agent API key auth to file uploads
**Recommendation:** Create `/api/public/files/upload` endpoint following existing agent auth pattern

## KEY FILES CREATED/MODIFIED
- `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/MiMS/` - New folder with 6 files
- `/Users/brent/scripts/CB-Workspace/.claude/skills/mims/SKILL.md` - New skill
- `/Users/brent/.claude/plans/greedy-gliding-prism.md` - Plan for file upload API

## PENDING WORK

### Vista Social File Upload Test
User attached a running selfie image (Run Aloha visor, Chicago Marathon shirt) to test Vista Social posting with images. Need to:
1. Exit plan mode (or user decision on plan)
2. Implement `/api/public/files/upload` endpoint
3. Upload image via new endpoint
4. Get S3 URL
5. Post to Instagram via Vista Social API with image URL

### Post Content Ready
```
Every mile counts.

I'm raising money for @mileinmyshoes as I train for Grandma's Marathon in June. MiMS helps people in recovery programs, shelters, and veterans services transform their lives through running.

Forward is a direction.

Link in bio to support.

#MileInMyShoes #GrandmasMarathon #RunForACause #RunningCommunity #Fundraising #MarathonTraining
```

## TODO LIST STATE
- ✅ Process Gmail inbox
- ✅ Review Google Tasks
- ✅ Review sprint backlog
- ✅ Planning: Mile in My Shoes video campaign
- ✅ MiMS fundraising note draft
- 🔄 Complete remaining Gmail responses (paused)

## NEXT ACTIONS ON RESUME
1. Check plan mode status - decide if continuing with file upload API plan
2. If proceeding: implement `/api/public/files/upload` following agent auth pattern
3. Test file upload with agent API key
4. Complete Vista Social image post test
5. Or: User may choose different direction

## REFERENCE INFO

### Vista Social Profile IDs
| Platform | ID |
|----------|-----|
| LinkedIn Personal | 22469 |
| X/Twitter | 23232 |
| Bluesky | 457112 |
| Threads | 399179 |
| Instagram | (newly added - get ID from Vista Social)

### MiMS Fundraising Link
https://secure.givelively.org/donate/mile-in-my-shoes/2026-grandma-s-fundracing-team-for-mile-in-my-shoes/brent-peterson-2

### Route53 brent.run
- Hosted Zone ID: Z06093052V1SRF60R2OGX
- Nameservers: ns-373.awsdns-46.com, ns-1405.awsdns-47.org, ns-2002.awsdns-58.co.uk, ns-777.awsdns-33.net
