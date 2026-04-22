---
name: Fireflies Meeting Confusion Prevention
description: After syncing meetings, always show numbered list with Brent's action items inline. Never assume which meeting user is referencing.
type: feedback
---

When multiple meetings exist in a session, always use numbered references and confirm which meeting is being discussed.

**Why:** Session on 2026-03-12 had 5 meetings synced. Claude confused meetings and lost track of which one the user was referencing. User had to say "STOP" to correct.

**How to apply:**
1. After every `/get-fireflies` sync, show a numbered list of all meetings with Brent's action items extracted inline per meeting
2. When user references "that meeting" or "this one", confirm by number before acting
3. Never assume which meeting is being discussed when multiple exist
4. Add action items from each meeting directly to ACTION-ITEMS.md after sync
