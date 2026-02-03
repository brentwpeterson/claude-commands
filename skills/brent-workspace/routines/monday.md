# Monday Routine

**Day Focus:** Clear weekend backlog, finish LinkedIn Newsletter, schedule TWC LinkedIn post, plan week

---

## Morning Checklist (EXTENDED - 75 min)

Weekend backlog is real. Give yourself extra time.

| # | Task | Tool | Time |
|---|------|------|------|
| 1 | Clear inbox (HEAVY) | Gmail MCP | 25 min |
| 2 | Scan Slack channels | Slack | 10 min |
| 3 | Clear HubSpot tasks | HubSpot MCP | 15 min |
| 4 | Review HubSpot deals | HubSpot MCP | 10 min |
| 5 | Review/respond to LinkedIn | LinkedIn | 15 min |

**75 MIN MONDAY EXTENDED. Then move to content/rocks.**

---

## Content Tasks

### 1. Finish Wednesday's LinkedIn Newsletter

**Status check:** Is the LinkedIn Newsletter for Wednesday DONE?

- If not done: This is priority #1 after morning checklist
- If done: Move to TWC LinkedIn scheduling

### 2. Schedule TWC LinkedIn Post for Tuesday

**Every Monday, schedule the LinkedIn post for Tuesday's Tuesdays with Claude article.**

1. Read the TWC LinkedIn process doc:
   ```bash
   cat /Users/brent/scripts/CB-Workspace/.claude/local/tuesdays-with-claude-linkedin.md
   ```

2. Find this week's article:
   ```bash
   ls -la "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Tuesdays with Claude/"
   ```

3. Draft LinkedIn post using format from process doc

4. Ask user for Substack/Medium link (article should be scheduled already)

5. Schedule via Vista Social for Tuesday 9:00 AM:
   ```bash
   source /Users/brent/scripts/CB-Workspace/.claude/local/workspace.env

   curl -s -X POST "https://vistasocial.com/api/integration/posts?api_key=$VISTA_SOCIAL_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "profile_id": [22469],
       "message": "[POST TEXT]\n\n[ARTICLE LINK]\n\n#TuesdaysWithClaude #ClaudeCode #AI",
       "media_url": ["https://dc4ifv9abstiv.cloudfront.net/media/1ea8acf0-263f-11ee-8a13-97d069d939b8/695c212e3902c1f1a6ff6b47.png?v=1767645488227"],
       "publish_at": "YYYY-MM-DD 09:00"
     }'
   ```

6. Report: "TWC LinkedIn post scheduled for Tuesday 9:00 AM"

---

## Mid-Sprint Review (Week 2 Only)

**Trigger:** If this is days 6-9 of the current sprint (second Monday), run mid-sprint review.

**Check:**
```bash
# Sprint start date is in sprint-plan.md
# Calculate if we're in week 2
```

**If Week 2 Monday:**
- Calculate velocity so far (pts completed / days elapsed)
- Calculate remaining velocity needed
- Flag at-risk stories (remaining > 1.5x current velocity)
- Recommend carry-overs to next sprint
- Ask: "Should we officially carry [X] to next sprint?"

---

## Strety Todos Confirmation (Due Today)

**Strety todos are due Monday. Confirm they're done.**

1. Pull open Strety todos:
   ```
   mcp__strety__strety_list_todos
     assignee: "Brent"
     showCompleted: false
   ```
2. Any still open? Flag them immediately. These are overdue now.
3. If something was missed from Friday's review, address it first before moving to planning.

---

## Planning

- Review sprint-plan.md status
- Identify top 3 priorities for the week
- Check Q1 Rocks progress

---

## Routine Feedback

**After completing this routine, Claude should ask:**

> "Monday routine complete. Anything to add or remove from this routine for future Mondays?"

If user suggests changes, update this file.
