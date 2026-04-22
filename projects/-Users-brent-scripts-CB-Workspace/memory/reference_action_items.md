---
name: Action Items Tracker
description: Persistent ACTION-ITEMS.md file in Obsidian Daily folder tracks all non-dev action items from meetings, emails, and follow-ups. Quarterly archive cycle.
type: reference
---

**Location:** `brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/ACTION-ITEMS.md`

**Purpose:** Single persistent file for all non-dev action items (meeting follow-ups, emails to send, content to create, calls to schedule). Dev/sprint work stays in the backlog API.

**Structure:**
- **Active** section at top, grouped by source (meeting name + date)
- **Completed** section below, grouped by date completed
- Items include context: who they're for, what's due, rough timing

**Quarterly archive:** Every quarter, move completed items to `ACTION-ITEMS-Q1-2026.md` (or Q2, etc.) in the same folder to keep the active file lean.

**When to update:**
- After `/get-fireflies` sync: add Brent's action items from new meetings
- After completing items during any session: check them off
- After `/brent-finish`: review and update status

**What goes here vs backlog API:**
- ACTION-ITEMS.md: follow-ups, emails, content, calls, event prep, anything non-code
- Backlog API: dev tickets, sprint work, code tasks

**How to apply:** Any Claude session that processes meetings or completes action items should update this file. It's visible in Obsidian so Brent can check it on his phone.
