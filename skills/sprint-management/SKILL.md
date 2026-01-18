# Sprint Management - Development Velocity Tracking

**Skill Description:** Complete sprint management system for tracking development velocity, planning capacity, and measuring hours per point across sprints.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Sprints API** | `https://app.requestdesk.ai/api/sprints` |
| **Backlog API** | `https://app.requestdesk.ai/api/backlog` |
| **Sprint Plans** | `brent-workspace/ob-notes/Brent Notes/Projects/ContentBasis/Sprints/S[N]/sprint-plan.md` |
| **Retrospectives** | `brent-workspace/ob-notes/Brent Notes/Projects/ContentBasis/Sprints/S[N]/S[N]-retrospective.md` |
| **Work Log** | `brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/WORK-LOG.md` |

**API Authentication:**
```
Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc
```

---

## SPRINT LIFECYCLE

```
1. PLAN (status: planned)
   - Set dates, capacity, goals
   - Assign backlog items to sprint
   - Update committed_points and committed_items

2. START (status: active)
   POST /api/sprints/{id}/start
   - Timestamps all items as committed
   - Sets sprint_committed_at on backlog items

3. EXECUTE (during sprint)
   PATCH /api/sprints/{id}
   - Track total_hours_worked daily
   - Note scope changes (added_items, removed_points)
   - Update backlog item statuses

4. CLOSE (status: completed)
   POST /api/sprints/{id}/close
   - Auto-calculates velocity and hours_per_point
   - Identifies carryover items
   - Optional: assigns carryover to next sprint

5. ASSESS (post-sprint)
   PATCH /api/sprints/{id}
   - Set rating (1-5)
   - Link retrospective_file
```

---

## KEY METRICS

| Metric | Formula | Target |
|--------|---------|--------|
| **Velocity** | completed_points / capacity_points | 0.80+ (80%+) |
| **Hours/Point** | total_hours_worked / completed_points | ~1.0 (calibrate from history) |
| **Commitment Rate** | completed_points / committed_points | 0.90+ |
| **Carryover Rate** | carryover_items / committed_items | < 0.15 (15%) |

---

## When Claude Should Apply This Skill

Apply this skill automatically when Brent:
- Asks about sprint status, velocity, or burndown
- Mentions planning a new sprint or closing current sprint
- Asks "how are we tracking" or "are we on pace"
- Wants to see sprint metrics or hours per point
- Mentions carryover or items that didn't get done
- Asks about capacity planning for next sprint
- References S1, S2, S3 or sprint numbers

---

## Quick Commands

| Action | Command |
|--------|---------|
| List all sprints | `curl -s https://app.requestdesk.ai/api/sprints -H "Authorization: Bearer $KEY"` |
| Get sprint details | `curl -s https://app.requestdesk.ai/api/sprints/S2 -H "Authorization: Bearer $KEY"` |
| Get sprint metrics | `curl -s https://app.requestdesk.ai/api/sprints/S2/summary -H "Authorization: Bearer $KEY"` |
| Get sprint items | `curl -s https://app.requestdesk.ai/api/sprints/S2/items -H "Authorization: Bearer $KEY"` |
| Update hours worked | `curl -X PATCH .../sprints/S2 -d '{"total_hours_worked": 52.5}'` |
| Close sprint | `curl -X POST .../sprints/S2/close?next_sprint_id=S3` |

---

## Current Sprint Data (S1 Baseline)

From S1 (completed):
- **Velocity:** 0.84 (84%)
- **Hours/Point:** 1.16
- **Capacity:** 50 points
- **Completed:** 42 points
- **Total Hours:** 48.88

Use these as baseline for S2+ planning.

---

## Supporting Files

- `api-reference.md` - Complete API endpoint documentation
- `schema.md` - Full sprint and backlog item field definitions
- `workflows.md` - Detailed sprint ceremonies and processes

---

## Integration with Commands

- `/sprint` - Quick sprint status and operations (command file)
- `/add-backlog` - Add items to backlog with sprint assignment
- `/brent-start` - Daily kickoff includes sprint status check
- `/brent-finish` - End of day updates hours worked
