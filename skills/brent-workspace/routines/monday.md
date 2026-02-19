# Monday Routine

**Day Focus:** Clear weekend backlog, finish LinkedIn Newsletter, schedule TWC LinkedIn post, plan week

---

## Date Conditionals

Evaluate these using the date from preflight step 5. Only show items that apply today.

```
IF: Sprint day 6-9 (second Monday) → Add "Mid-sprint review" to punch list
IF: P0 event within 7 days → Add "Event prep: [event name]" to punch list
```

**How to calculate sprint day:**
```bash
# Get sprint start date from API, calculate days elapsed
KEY="MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg"
SPRINT_DATA=$(curl -s "https://app.requestdesk.ai/api/sprints" -H "Authorization: Bearer $KEY")
# Parse start_date from active sprint, calculate business days elapsed
```

---

## Punch List

| # | Task | Tool | Time | Pull data? |
|---|------|------|------|------------|
| 1 | Clear inbox (HEAVY - weekend backlog) | Gmail MCP | 25 min | On demand |
| 2 | Scan Slack channels | Slack MCP | 10 min | On demand |
| 3 | Clear HubSpot tasks | HubSpot MCP | 15 min | On demand |
| 4 | Review HubSpot deals | HubSpot MCP | 10 min | On demand |
| 5 | Review/respond to LinkedIn | LinkedIn | 15 min | Manual |
| 6 | Strety todos confirmation (due today) | Strety MCP | 5 min | On demand |

**75 MIN MAX for morning checklist. Then move to content/rocks.**

---

## Content Tasks

### 1. Finish Wednesday's LinkedIn Newsletter

**Status check:** Is the LinkedIn Newsletter for Wednesday DONE?

- If not done: This is priority #1 after morning checklist
- If done: Move to TWC LinkedIn scheduling

### 2. Schedule TWC LinkedIn Post for Tuesday

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

---

## Conditional: Mid-Sprint Review (Week 2 Only)

**Only run if sprint day 6-9.**

- Calculate velocity so far (pts completed / days elapsed)
- Calculate remaining velocity needed
- Flag at-risk stories (remaining > 1.5x current velocity)
- Recommend carry-overs to next sprint
- Ask: "Should we officially carry [X] to next sprint?"

---

## Planning

- Review sprint board from API (already loaded at startup)
- Identify top 3 priorities for the week
- Check Q1 Rocks progress

---

## Routine Feedback

**After completing this routine, Claude should ask:**

> "Monday routine complete. Anything to add or remove from this routine for future Mondays?"

If user suggests changes, update this file.
