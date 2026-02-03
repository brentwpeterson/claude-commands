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

3. **🚨 MANDATORY: Create Recurring Item Tickets:**
   Before assigning any other items, generate fresh tickets for ALL recurring items.
   ```bash
   # Query all recurring parent stories
   curl -s "https://app.requestdesk.ai/api/backlog" \
     -H "Authorization: Bearer $KEY" | \
     jq '[.items[] | select(.is_recurring == true and .type == "story" and .is_parent == true)]'
   ```
   For EACH recurring story, create a new child task for this sprint:
   ```bash
   curl -X POST "https://app.requestdesk.ai/api/backlog" \
     -H "Authorization: Bearer $KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "title": "S[N]: [deliverable]",
       "type": "task",
       "parent_id": "[parent_story_id]",
       "is_child": true,
       "is_recurring": true,
       "recurring_period": "month",
       "sprint_name": "S[N]",
       "estimated_points": [pts],
       "category": "Content",
       "status": "backlog"
     }'
   ```
   **This is non-negotiable. Recurring items that don't get fresh tickets don't show up in the sprint.**

4. **Assign Backlog Items:**
   - Pull from P0/P1 items in backlog
   - Set `sprint_name: "S3"` and `committed: true`
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

## 1b. Recurring Stories

**What:** A story that spawns a concrete task each sprint (e.g., "New integration every 2 weeks")

**When:** During sprint planning, after calculating capacity

### Identifying Recurring Stories

A backlog item is a recurring story when:
- `type: "story"` (not task)
- `is_recurring: true`
- `is_parent: true`
- Has a defined `recurring_period` (e.g., "sprint", "2-weeks", "monthly")

### Parent Story Setup

Mark the parent story once:
```bash
curl -X PATCH "https://app.requestdesk.ai/api/backlog/{parent_id}" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "type": "story",
    "is_recurring": true,
    "is_parent": true,
    "recurring_period": "sprint",
    "notes": "Spawns one concrete task per sprint"
  }'
```

### Spawning Child Tasks

During each sprint planning, create a child task from the parent:

```bash
curl -X POST "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "S2: Add Magento integration",
    "type": "task",
    "parent_id": "{parent_story_id}",
    "is_child": true,
    "sprint": "S2",
    "estimated_points": 2,
    "priority": 0,
    "committed": true
  }'
```

### Sprint Planning Checklist for Recurring Stories

1. **Query recurring stories:**
   ```bash
   curl -s "https://app.requestdesk.ai/api/backlog?is_recurring=true&is_parent=true" \
     -H "Authorization: Bearer $KEY" | jq '.items[] | {id, title, recurring_period}'
   ```

2. **For each recurring story, ASK the user:**
   - "What is the specific deliverable for [story title] this sprint?"
   - Example prompt: "New integration every 2 weeks - which integration for S3?"
   - User might say: "Magento" or "Skip this sprint" or "TBD"

3. **Create child task with specific scope:**
   - Title format: `S[N]: [specific deliverable from user]`
   - If user says "TBD": `S[N]: [parent title] (TBD)`
   - If user says "Skip": Don't create child, note in sprint plan

4. **Parent story stays in backlog** (never completed, never assigned to sprint)

5. **Child task gets completed** each sprint

### Frequency Reference

| Recurring Period | Child Tasks Per Sprint | Per Month |
|------------------|------------------------|-----------|
| sprint | 1 | 2 |
| 2-weeks | 1 | 2 |
| weekly | 2 (W1 + W2) | 4 |
| monthly | 0.5 (every other sprint) | 1 |
| quarterly | Plan ahead, 1 per quarter | ~0.33 |

### Naming Convention for Child Tasks

**Sprint-level (one per sprint):**
```
S2: [Specific deliverable]
S2: New RequestDesk integration
S2: TWC Article - Commands vs Skills
```

**Weekly (two per sprint):**
```
S2-W1: [Task] (Day)
S2-W2: [Task] (Day)

S2-W1: My EO Journey post (Thursday)
S2-W2: My EO Journey post (Thursday)
```

**W1 = first week of sprint, W2 = second week of sprint**

### Example: "New integration every 2 weeks"

**Parent Story (d95d45):**
- Title: "RequestDesk - new integration every 2 weeks"
- Type: story
- is_recurring: true
- is_parent: true
- Status: backlog (always)

**Child Tasks (one per sprint):**
| Sprint | Child Task | Points | Status |
|--------|------------|--------|--------|
| S2 | S2: Add Magento integration | 2 | in_progress |
| S3 | S3: Add BigCommerce integration | 2 | pending |
| S4 | S4: Add Shopware integration | 2 | pending |

### Benefits

- Parent story captures the commitment ("we ship an integration every sprint")
- Child tasks are specific and completable
- Velocity tracking works correctly (child points count)
- Clear audit trail of what shipped when

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
