# Sprint Workflows & Ceremonies

## Sprint Cadence

| Sprint | Dates | Days |
|--------|-------|------|
| S1 | Jan 6-17, 2026 | 12 |
| S2 | Jan 19-30, 2026 | 12 |
| S3 | Jan 31 - Feb 11, 2026 | 12 |

Standard sprint = 2 weeks (12 days excluding weekends)

---

## 1. Sprint Planning

**When:** Friday before sprint starts
**Duration:** 1-2 hours
**Output:** sprint-plan.md

### Steps

1. **Create Sprint in API:**
   ```bash
   curl -X POST https://app.requestdesk.ai/api/sprints \
     -H "Authorization: Bearer $KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "id": "S3",
       "name": "Sprint 3 (Jan 31 - Feb 11, 2026)",
       "start_date": "2026-01-31T00:00:00",
       "end_date": "2026-02-11T23:59:59",
       "status": "planned",
       "capacity_points": 50,
       "goals": ["Primary goal", "Secondary goal"]
     }'
   ```

2. **Calculate Capacity:**
   ```
   working_days = 10 (2 weeks - weekends)
   velocity = 0.84 (from previous sprint)
   points_per_day = 5
   buffer = 20%

   capacity = working_days * points_per_day * (1 - buffer)
            = 10 * 5 * 0.8 = 40-50 points
   ```

3. **Assign Backlog Items:**
   - Pull from P0/P1 items in backlog
   - Set `sprint: "S3"` and `committed: true`
   - Calculate total committed_points

4. **Update Sprint Totals:**
   ```bash
   curl -X PATCH https://app.requestdesk.ai/api/sprints/S3 \
     -H "Authorization: Bearer $KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "committed_points": 48,
       "committed_items": 32,
       "planning_hours": 1.5,
       "planning_file": "Sprints/S3/sprint-plan.md"
     }'
   ```

5. **Create sprint-plan.md** with:
   - Sprint goals
   - Committed items table
   - Risk items
   - Dependencies

---

## 2. Sprint Start

**When:** First day of sprint
**Duration:** 5 minutes

### Steps

1. **Start Sprint:**
   ```bash
   curl -X POST https://app.requestdesk.ai/api/sprints/S3/start \
     -H "Authorization: Bearer $KEY"
   ```

   This:
   - Changes status to `active`
   - Sets `sprint_committed_at` on all items

2. **Verify in WORK-LOG:**
   - Add sprint header to daily log
   - Note starting metrics

---

## 3. Daily Updates

**When:** End of each work day
**Duration:** 2 minutes

### Track Hours

```bash
# Update cumulative hours
curl -X PATCH https://app.requestdesk.ai/api/sprints/S2 \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{"total_hours_worked": 25.5}'
```

### Track Progress

- Update backlog item statuses as completed
- Note any scope changes (added_items, removed_points)

### Check Burn Rate

```bash
curl -s https://app.requestdesk.ai/api/sprints/S2/summary \
  -H "Authorization: Bearer $KEY" | jq '{burn_rate, on_track, remaining_points}'
```

---

## 4. Scope Changes

**When:** Unplanned work enters sprint

### Document Changes

```bash
curl -X PATCH https://app.requestdesk.ai/api/sprints/S2 \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "added_items": 3,
    "added_hours": 8,
    "scope_change_notes": "P0 bug from production required immediate fix"
  }'
```

### When to Remove Items

If adding work, consider removing equal points to maintain commitment:
```bash
curl -X PATCH https://app.requestdesk.ai/api/sprints/S2 \
  -H "Authorization: Bearer $KEY" \
  -d '{"removed_points": 5, "removed_items": 2}'
```

---

## 5. Sprint Close

**When:** Last day of sprint
**Duration:** 15 minutes

### Steps

1. **Mark Incomplete Items:**
   - Update backlog items that aren't done
   - Note blockers in item notes

2. **Close Sprint:**
   ```bash
   curl -X POST "https://app.requestdesk.ai/api/sprints/S2/close?next_sprint_id=S3" \
     -H "Authorization: Bearer $KEY"
   ```

   This:
   - Calculates completed_points from backlog
   - Calculates velocity and hours_per_point
   - Identifies carryover items
   - Assigns carryover to S3

3. **Review Metrics:**
   ```bash
   curl -s https://app.requestdesk.ai/api/sprints/S2 \
     -H "Authorization: Bearer $KEY" | jq '{velocity, hours_per_point, completed_points, carryover_items}'
   ```

---

## 6. Retrospective

**When:** After sprint close
**Duration:** 30-60 minutes

### Steps

1. **Create Retrospective Document:**
   - Location: `Sprints/S2/S2-retrospective.md`
   - Template: What went well, What didn't, Action items

2. **Update Sprint:**
   ```bash
   curl -X PATCH https://app.requestdesk.ai/api/sprints/S2 \
     -H "Authorization: Bearer $KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "rating": 3,
       "retrospective_file": "Sprints/S2/S2-retrospective.md",
       "retrospective_hours": 1.0
     }'
   ```

3. **Archive Sprint Materials:**
   - Move work log section to `Sprints/S2/`
   - Ensure all docs linked

---

## File Locations

| Document | Path |
|----------|------|
| Sprint Plan | `brent-workspace/.../Sprints/S[N]/sprint-plan.md` |
| Retrospective | `brent-workspace/.../Sprints/S[N]/S[N]-retrospective.md` |
| Work Log | `brent-workspace/.../Dashboard/Daily/WORK-LOG.md` |
| Archived Log | `brent-workspace/.../Sprints/S[N]/WORK-LOG-S[N].md` |

Base: `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Projects/ContentBasis/`
