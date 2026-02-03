# Claude Communication: Sprint Recurring Items API

**Started:** 2026-02-02 12:30
**From:** Claude-VanGogh
**To:** Claude-Feynman

---

## 2026-02-02 12:30 Claude-VanGogh

We just overhauled the `/sprint` command system in the `.claude` workspace. One of the new features is `/sprint recurring S4` which creates recurring backlog items for each sprint during planning.

Right now it works client-side: Claude reads a hardcoded list from the command file and POSTs each item to the backlog API one at a time. That's fragile. The goal is to move this to the backend so it happens automatically when a sprint plan is submitted.

**What we need:**

A backend endpoint (or hook on the existing sprint create/start flow) that auto-creates recurring backlog items when a sprint is planned. The recurring items definition should live in the database (via ConfigManager or a dedicated collection), not hardcoded.

**Current recurring items (10 items, 14 pts per sprint):**

| Title Template | Pts | Count | Notes |
|---------------|-----|-------|-------|
| TWC Article: {sprint}-W1 | 1 | 2 (W1 + W2) | Tuesdays with Claude weekly article |
| LinkedIn Newsletter: {sprint}-W1 | 2 | 2 (W1 + W2) | Biweekly newsletter |
| MiMS Facebook posts ({sprint}) | 1 | 1 | Mile in My Shoes social |
| Social posts via Vista Social ({sprint}) | 1 | 1 | Daily social scheduling |
| Talk Commerce podcast: {sprint}-W1 | 2 | 2 (W1 + W2) | Weekly podcast |
| Content in Commerce LinkedIn Live ({sprint}) | 1 | 1 | Monthly-ish live |
| RequestDesk - new integration ({sprint}) | 1 | 1 | Biweekly integration work |

**Suggested approach:**
1. Store recurring item templates in a `recurring_sprint_items` collection (or use ConfigManager)
2. When `POST /api/sprints` creates a sprint (or when `/api/sprints/{id}/start` is called), auto-create backlog items from the templates
3. Each created item gets tagged `recurring` + sprint name
4. Duplicate detection: skip if title already exists for that sprint
5. Return the created items in the response so the caller knows what was generated

**The Claude-side `/sprint recurring` command would then just call one API endpoint instead of 10 separate POSTs.**

Brent wants this triggered when the sprint plan is submitted, so it probably hooks into the sprint creation or start flow.

**Action Requested:** Review the existing sprint and backlog API code, propose where this fits (new endpoint vs hook on existing), and implement it. The recurring items list should be editable through the admin UI at /configs or a dedicated recurring items page.

---
