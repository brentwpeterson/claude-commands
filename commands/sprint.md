Sprint Management - View, create, and manage development sprints

**SKILL:** This command is backed by the `sprint-management` skill in `.claude/skills/sprint-management/`
- See `SKILL.md` for overview and when to apply
- See `api-reference.md` for complete endpoint docs
- See `schema.md` for field definitions
- See `workflows.md` for sprint ceremonies

**USAGE:**
- `/sprint` - Show current/active sprint status
- `/sprint list` - List all sprints with velocity summary
- `/sprint S2` - Show details for specific sprint
- `/sprint create S3` - Create new sprint (interactive)
- `/sprint close S2` - Close sprint and calculate metrics
- `/sprint update S2 --hours 52.5` - Update sprint field

**PURPOSE:**
Manage development sprints via the RequestDesk Sprints API. Track velocity, hours per point, and sprint health.

**API CONFIGURATION:**
```
BASE_URL: https://app.requestdesk.ai/api/sprints
AUTH: Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc
```

**ENDPOINTS:**
| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | /sprints | List all sprints |
| GET | /sprints/{id} | Get sprint details |
| GET | /sprints/{id}/summary | Get metrics/burndown |
| GET | /sprints/{id}/items | Get backlog items in sprint |
| POST | /sprints | Create new sprint |
| PATCH | /sprints/{id} | Update sprint |
| DELETE | /sprints/{id} | Delete sprint |
| POST | /sprints/{id}/start | Start sprint (planned -> active) |
| POST | /sprints/{id}/close | Close sprint, calculate velocity |

**SPRINT SCHEMA:**
```
Identity:
  id: str              # "S1", "S2", etc.
  name: str            # "Sprint 2 (Jan 19-30, 2026)"
  start_date: datetime
  end_date: datetime
  status: enum         # planned | active | completed

Planning (Sprint Start):
  capacity_points: int      # Available points (days * velocity - buffer)
  committed_points: int     # Points committed at start
  committed_items: int      # Item count at start
  planning_hours: float     # Hours spent planning
  planning_file: str        # Path to sprint-plan.md
  goals: List[str]          # Sprint themes/goals

Mid-Sprint Changes:
  added_items: int          # Unplanned items added
  added_hours: float        # Hours on unplanned work
  removed_points: int       # Points pulled out
  removed_items: int        # Items pulled out
  scope_change_notes: str   # Why changes were made

Completion (Sprint End):
  completed_points: int     # Points finished
  completed_items: int      # Items finished
  carryover_points: int     # Points to next sprint
  carryover_items: int      # Items to next sprint

Time Tracking:
  total_hours_worked: float # All hours in sprint
  retrospective_hours: float # Hours on retro

Velocity & Metrics (Calculated):
  velocity: float           # completed_points / capacity_points
  hours_per_point: float    # total_hours / completed_points

Assessment:
  rating: int               # 1-5 (1=disaster, 5=perfect)
  retrospective_file: str   # Path to retrospective.md
  work_log_file: str        # Path to work log
```

**COMMANDS:**

### `/sprint` or `/sprint status`
Show current/active sprint:
```bash
curl -s https://app.requestdesk.ai/api/sprints?status=active \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" | jq '.sprints[0]'
```
Display format:
```
SPRINT S2 - Active
Name: Sprint 2 (Jan 19-30, 2026)
Days: 5/12 elapsed, 7 remaining

Progress:
  Committed: 50 pts (34 items)
  Completed: 22 pts (15 items)
  Remaining: 28 pts

Burn Rate: 4.4 pts/day
Projected: 52.8 pts (ON TRACK)

Goals:
  - Complete sprint API
  - Backlog management UI
```

### `/sprint list`
List all sprints with summary:
```bash
curl -s https://app.requestdesk.ai/api/sprints \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" | jq .
```
Display format:
```
SPRINTS (Average Velocity: 0.84)

| ID | Name | Status | Committed | Completed | Velocity | Hrs/Pt |
|----|------|--------|-----------|-----------|----------|--------|
| S1 | Sprint 1 | completed | 50 | 42 | 0.84 | 1.16 |
| S2 | Sprint 2 | active | 50 | 22 | - | - |
```

### `/sprint {id}`
Show specific sprint details:
```bash
curl -s https://app.requestdesk.ai/api/sprints/S2 \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" | jq .
```

### `/sprint {id} summary`
Show sprint metrics/burndown:
```bash
curl -s https://app.requestdesk.ai/api/sprints/S2/summary \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" | jq .
```

### `/sprint {id} items`
Show backlog items in sprint:
```bash
curl -s https://app.requestdesk.ai/api/sprints/S2/items \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" | jq .
```

### `/sprint create {id}`
Create new sprint interactively. Prompt for:
1. Name (e.g., "Sprint 3 (Jan 31 - Feb 11, 2026)")
2. Start date
3. End date
4. Capacity points
5. Goals (comma-separated)

Then POST:
```bash
curl -s -X POST https://app.requestdesk.ai/api/sprints \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" \
  -H "Content-Type: application/json" \
  -d '{"id":"S3","name":"Sprint 3","start_date":"2026-01-31T00:00:00","end_date":"2026-02-11T23:59:59","status":"planned","capacity_points":50,"goals":["Goal 1","Goal 2"]}'
```

### `/sprint start {id}`
Start a planned sprint:
```bash
curl -s -X POST https://app.requestdesk.ai/api/sprints/S3/start \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc"
```

### `/sprint close {id}`
Close sprint and calculate final metrics:
```bash
curl -s -X POST "https://app.requestdesk.ai/api/sprints/S2/close?next_sprint_id=S3" \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc"
```
This will:
- Calculate completed_points from backlog items
- Calculate velocity (completed/capacity)
- Calculate hours_per_point
- Identify carryover items
- Optionally assign carryover to next sprint

### `/sprint update {id} --field value`
Update sprint fields:
```bash
# Update hours worked
curl -s -X PATCH https://app.requestdesk.ai/api/sprints/S2 \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" \
  -H "Content-Type: application/json" \
  -d '{"total_hours_worked":52.5}'

# Update rating and retrospective
curl -s -X PATCH https://app.requestdesk.ai/api/sprints/S1 \
  -H "Authorization: Bearer wO1lEF5NC3BuCtQSHB5JSFXxTWfw5iwdyTruIEA0Quc" \
  -H "Content-Type: application/json" \
  -d '{"rating":3,"retrospective_file":"Sprints/S1/S1-retrospective.md"}'
```

Common update fields:
- `--hours {float}` - total_hours_worked
- `--rating {1-5}` - Sprint rating
- `--retro {path}` - retrospective_file
- `--planning-hours {float}` - planning_hours
- `--added-items {int}` - Mid-sprint scope additions
- `--scope-notes {text}` - Scope change explanation

**SPRINT LIFECYCLE:**
```
1. CREATE (planned)
   /sprint create S3
   - Set dates, capacity, goals

2. COMMIT ITEMS
   Assign backlog items to sprint via backlog API
   Update committed_points and committed_items

3. START (planned -> active)
   /sprint start S3
   - Sets status to active
   - Timestamps items as committed

4. TRACK (during sprint)
   /sprint update S3 --hours 25.5
   - Track hours worked
   - Note scope changes

5. CLOSE (active -> completed)
   /sprint close S3
   - Auto-calculates velocity
   - Identifies carryover
   - Optional: assign carryover to next sprint

6. ASSESS
   /sprint update S3 --rating 4 --retro "Sprints/S3/S3-retrospective.md"
```

**VELOCITY CALCULATION:**
- velocity = completed_points / capacity_points
- hours_per_point = total_hours_worked / completed_points
- Target velocity: 0.80+ (80%+ of capacity completed)
- Target hours/point: ~1.0 (adjust based on history)

**INTEGRATION WITH BACKLOG:**
Backlog items have sprint-related fields:
- `sprint`: Current sprint assignment (e.g., "S2")
- `sprint_history`: List of sprints item was in (carryover tracking)
- `sprint_committed_at`: When item was committed to sprint
- `planned_points`: Story-level estimate (vs task estimated_points)

**LOCAL FILE REFERENCES:**
Sprint documents are stored locally in:
- `brent-workspace/ob-notes/Brent Notes/Projects/ContentBasis/Sprints/`
- Planning: `S2/sprint-plan.md`
- Retrospective: `S1/S1-retrospective.md`
- Work logs: Referenced from WORK-LOG.md
