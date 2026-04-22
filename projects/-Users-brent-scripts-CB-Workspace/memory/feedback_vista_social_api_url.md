---
name: Vista Social API URL and Parameters
description: Correct Vista Social API endpoint, auth, and parameter format - has been wrong multiple times, causing failed social post scheduling
type: feedback
---

Vista Social API base: `https://vistasocial.com/api/`

**Post Endpoint:** `POST https://vistasocial.com/api/integration/posts?api_key=KEY`

**NEVER use `api.vistasocial.com`** - that domain does not exist. Claude fabricated it.

**Parameters:**
- `message` - Post message (required if no media url)
- `profile_id` - Array of profile IDs (required, MUST be an array e.g. `[23232]`)
- `publish_at` - Publish date in **ETC timezone** (required). Values:
  - `"now"` - publish immediately
  - `"queue_next"` - add to queue next
  - `"queue_last"` - add to queue last
  - ISO 8601 date: `"2025-02-08 09:30"` (ETC timezone)
  - Unix timestamp

**Profile IDs:**
- LinkedIn Personal: 22469
- X/Twitter: 23232
- BlueSky: 457112
- Threads: 399179
- TikTok: 22468
- Instagram: 43335

**Why:** Claude repeatedly fabricated the wrong API URL and parameter format. Always read this memory or `/Users/brent/scripts/CB-Workspace/.claude-local/commands/create-social.md` before making Vista Social API calls.

**How to apply:** Use exact endpoint, array for profile_id, and ETC timezone for publish_at. For immediate posts use `"now"`.
