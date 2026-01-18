# Sprint Schema Reference

## Sprint Object

### Identity Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Sprint identifier ("S1", "S2", etc.) |
| `name` | string | Yes | Display name ("Sprint 2 (Jan 19-30, 2026)") |
| `start_date` | datetime | Yes | Sprint start date |
| `end_date` | datetime | Yes | Sprint end date |
| `status` | enum | No | `planned` \| `active` \| `completed` (default: planned) |

### Planning Fields (Set at Sprint Start)

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `capacity_points` | int | required | Available points (days * velocity - buffer) |
| `committed_points` | int | 0 | Points committed at sprint start |
| `committed_items` | int | 0 | Item count at sprint start |
| `planning_hours` | float | null | Hours spent on planning session |
| `planning_file` | string | null | Path to sprint-plan.md |
| `goals` | string[] | [] | Sprint themes/goals |

### Mid-Sprint Change Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `added_items` | int | 0 | Unplanned items added mid-sprint |
| `added_hours` | float | 0 | Hours spent on unplanned work |
| `removed_points` | int | 0 | Points pulled out of sprint |
| `removed_items` | int | 0 | Items pulled out of sprint |
| `scope_change_notes` | string | null | Notes on why changes were made |

### Completion Fields (Set at Sprint End)

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `completed_points` | int | null | Points finished from committed |
| `completed_items` | int | null | Items finished (committed + added) |
| `carryover_points` | int | null | Committed points moved to next sprint |
| `carryover_items` | int | null | Items carried over to next sprint |

### Time Tracking Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `total_hours_worked` | float | null | All hours worked in sprint |
| `retrospective_hours` | float | null | Hours spent on retrospective |

### Calculated Metrics (Set at Close)

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `velocity` | float | null | completed_points / capacity_points |
| `hours_per_point` | float | null | total_hours / completed_points |

### Assessment Fields

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `rating` | int | null | Sprint rating 1-5 (1=disaster, 5=perfect) |
| `retrospective_file` | string | null | Path to retrospective markdown |
| `work_log_file` | string | null | Path to work log file |

### Metadata (Auto-set)

| Field | Type | Description |
|-------|------|-------------|
| `_id` | ObjectId | Database ID |
| `user_id` | string | Owner user ID |
| `company_id` | string | Company context |
| `created_at` | datetime | Creation timestamp |
| `updated_at` | datetime | Last update timestamp |

---

## Backlog Item Sprint Fields

These fields exist on backlog items for sprint integration:

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `sprint` | string | null | Current sprint assignment ("S2") |
| `sprint_history` | string[] | [] | Sprints item was in (carryover tracking) |
| `sprint_committed_at` | datetime | null | When item was committed to sprint |
| `planned_points` | int | null | Story-level estimate (vs task estimated_points) |
| `committed` | bool | false | Whether item is committed to sprint |
| `sprint_order` | int | 0 | Order within sprint board |

---

## Sprint Summary Object

Returned by `GET /api/sprints/{id}/summary`:

| Field | Type | Description |
|-------|------|-------------|
| `id` | string | Sprint ID |
| `name` | string | Sprint name |
| `status` | string | Current status |
| `committed_points` | int | Points committed |
| `completed_points` | int | Points completed (from backlog items) |
| `remaining_points` | int | committed - completed |
| `days_total` | int | Total sprint days |
| `days_elapsed` | int | Days since start |
| `days_remaining` | int | Days until end |
| `burn_rate` | float | Points completed per day |
| `projected_completion` | int | Projected total at current burn rate |
| `on_track` | bool | Will projected >= committed? |
| `velocity` | float | Final velocity (if closed) |
| `hours_per_point` | float | Final efficiency (if closed) |

---

## Status Transitions

```
planned  →  active  →  completed
   ↑                      ↓
   └──────────────────────┘
        (new sprint)
```

| From | To | Trigger |
|------|-----|---------|
| planned | active | `POST /sprints/{id}/start` |
| active | completed | `POST /sprints/{id}/close` |

---

## Collection Name

**MongoDB Collection:** `backlog_sprints`

Named for consistency with `backlog_items` collection.
