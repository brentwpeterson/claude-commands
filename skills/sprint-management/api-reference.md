# Sprint API Reference

## Authentication

All endpoints require agent API key authentication:

```
Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc
```

## Base URL

```
https://app.requestdesk.ai/api/sprints
```

---

## Endpoints

### List Sprints

```http
GET /api/sprints
GET /api/sprints?status=active
GET /api/sprints?limit=10&skip=0
```

**Response:**
```json
{
  "sprints": [...],
  "total": 5,
  "average_velocity": 0.84
}
```

---

### Get Sprint

```http
GET /api/sprints/{id}
```

**Example:** `GET /api/sprints/S2`

**Response:** Full sprint object

---

### Create Sprint

```http
POST /api/sprints
Content-Type: application/json

{
  "id": "S3",
  "name": "Sprint 3 (Jan 31 - Feb 11, 2026)",
  "start_date": "2026-01-31T00:00:00",
  "end_date": "2026-02-11T23:59:59",
  "status": "planned",
  "capacity_points": 50,
  "goals": ["Goal 1", "Goal 2"]
}
```

**Required fields:** `id`, `name`, `start_date`, `end_date`, `capacity_points`

**Response:**
```json
{
  "_id": "...",
  "id": "S3",
  "name": "Sprint 3 (Jan 31 - Feb 11, 2026)",
  "status": "planned",
  "capacity_points": 50,
  "recurring_items": {
    "items_created": 2,
    "total_points": 3,
    "titles": [
      "TWC Article (S3)",
      "Weekly content review (S3)"
    ]
  }
}
```

**Automatic Recurring Items:** When a sprint is created, all backlog items with `is_recurring: true` are automatically cloned into the new sprint. The sprint name is appended to each title (e.g., "TWC Article" becomes "TWC Article (S3)"). Clones are linked to originals via `parent_id` and marked as `is_child: true`. Duplicate detection prevents re-creating items if they already exist for that sprint.

---

### Update Sprint

```http
PATCH /api/sprints/{id}
Content-Type: application/json

{
  "total_hours_worked": 52.5,
  "rating": 4,
  "retrospective_file": "Sprints/S2/S2-retrospective.md"
}
```

Only include fields being updated.

---

### Delete Sprint

```http
DELETE /api/sprints/{id}
```

---

### Get Sprint Items

```http
GET /api/sprints/{id}/items
GET /api/sprints/{id}/items?status=completed
GET /api/sprints/{id}/items?committed=true
```

**Response:**
```json
{
  "sprint_id": "S2",
  "items": [...],
  "total_items": 34,
  "total_points": 50,
  "completed_points": 22
}
```

---

### Get Sprint Summary (Metrics)

```http
GET /api/sprints/{id}/summary
```

**Response:**
```json
{
  "id": "S2",
  "name": "Sprint 2",
  "status": "active",
  "committed_points": 50,
  "completed_points": 22,
  "remaining_points": 28,
  "days_total": 12,
  "days_elapsed": 5,
  "days_remaining": 7,
  "burn_rate": 4.4,
  "projected_completion": 52,
  "on_track": true,
  "velocity": null,
  "hours_per_point": null
}
```

---

### Start Sprint

```http
POST /api/sprints/{id}/start
```

Changes status from `planned` to `active`.
Sets `sprint_committed_at` on all backlog items in sprint.

**Response:**
```json
{
  "message": "Sprint S3 started",
  "items_committed": 34
}
```

---

### Close Sprint

```http
POST /api/sprints/{id}/close
POST /api/sprints/{id}/close?next_sprint_id=S3
```

Calculates final metrics and optionally assigns carryover to next sprint.

**Response:**
```json
{
  "message": "Sprint S2 closed successfully",
  "sprint": {...},
  "metrics": {
    "completed_points": 42,
    "completed_items": 28,
    "carryover_points": 8,
    "carryover_items": 6,
    "velocity": 0.84,
    "hours_per_point": 1.16
  },
  "carryover_assigned_to": "S3"
}
```

---

## Error Responses

| Status | Meaning |
|--------|---------|
| 401 | Invalid or missing API key |
| 404 | Sprint not found |
| 400 | Validation error (e.g., sprint already closed) |

---

## Backlog Integration

Backlog items have sprint-related fields:

```bash
# Assign item to sprint
curl -X PATCH https://app.requestdesk.ai/api/backlog/{item_id} \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" \
  -H "Content-Type: application/json" \
  -d '{"sprint": "S2", "committed": true}'
```

**Sprint fields on backlog items:**
- `sprint` - Current sprint assignment (e.g., "S2")
- `sprint_history` - List of sprints item was in (carryover tracking)
- `sprint_committed_at` - When committed to current sprint
- `planned_points` - Story-level estimate (vs task `estimated_points`)
