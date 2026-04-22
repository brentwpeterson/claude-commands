---
name: API Access Is Not Database Access
description: Claude CAN use REST APIs to read and write data. The "never write to database" rule means no direct MongoDB operations, not no API calls.
type: feedback
---

Claude CAN use the RequestDesk API to create, update, and delete data. The API is an application endpoint with auth, validation, and business logic. This is NOT "writing to the database."

**The rule "Claude never writes to the database" means:**
- No direct MongoDB shell commands
- No docker exec into containers for DB operations
- No migration scripts that Claude executes

**The rule does NOT mean:**
- No API POST/PATCH/DELETE calls
- No creating backlog items via API
- No updating sprint data via API

**APIs Claude has been using all along:**
- Backlog API: `https://app.requestdesk.ai/api/backlog` (Bearer token auth)
- Sprint API: `https://app.requestdesk.ai/api/sprints`
- Auth: `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`

**Why:** Claude repeatedly refused to make API calls to fix data, telling the user "I can't write to the database" when the user was asking for an API call. This wasted significant time and frustrated the user. The distinction is direct DB access (prohibited) vs API endpoints (allowed).

**How to apply:** When the user asks to create, update, or delete records, use the REST API. Only refuse if they're asking for raw MongoDB commands or direct container DB access.
