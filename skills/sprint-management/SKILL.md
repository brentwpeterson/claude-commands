# Sprint Management - Development Velocity Tracking

**Skill Description:** Complete sprint management system for tracking development velocity, planning capacity, and measuring hours per point across sprints.

## 🚨 SPRINT RULES: Single Source of Truth 🚨

**Canonical sprint rules live in:** `Dashboard/Sprints/README.md`
That file defines item types, point scale, lifecycle, and all sprint rules. This skill file covers API mechanics and how-to. If there's a conflict, the README wins.

---

## 🚨 CRITICAL: API IS SOURCE OF TRUTH 🚨

**NEVER read sprint ticket status from markdown files (sprint-plan.md, context files, etc.).**
**ALWAYS query the Backlog API for current ticket status.**

The `sprint-plan.md` file is a static planning artifact. It has NO status column and is NEVER updated when tickets are completed. If you read it, every ticket looks open, even if most are done. This has caused repeated frustration.

**When asked about sprint tickets, open tickets, or sprint status:**
```bash
# Get real status from API
curl -s "https://app.requestdesk.ai/api/backlog?sprint_name=S2" \
  -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg"
```
Then filter by `status` field: `completed`, `backlog`, `in_progress`, `archived`.

---

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Sprints API** | `https://app.requestdesk.ai/api/sprints` |
| **Backlog API** | `https://app.requestdesk.ai/api/backlog` |
| **Sprint Directory** | `brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/2026/Q1/S[N]/` |
| **Current Sprint** | `brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/current/` |

**Base path:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/2026/Q1/`

**API Authentication:**
```
Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg
```
(Same key for both backlog and sprints APIs)

---

## 🚨 SPRINT DIRECTORY STANDARD 🚨

**The single source of truth for sprint process is the Planning SOP:**
`brent-workspace/ob-notes/Brent Notes/Dashboard/SOPs/000-planning-sop.md`

**Key rule:** Every sprint directory has 4 files (sprint-plan, scorecard, retro, retro-notes). All created at planning time. Sprint is not planned until all 4 exist. Daily work logging goes to the centralized `Dashboard/Daily/WORK-LOG.md` (not a sprint-level file). See the SOP for the full checklist.

---

## SPRINT SCHEDULE RULES

**Sprints run Monday-Friday only. Never start on weekends.**

| Rule | Description |
|------|-------------|
| **Duration** | 2 weeks (10 working days) |
| **Start Day** | Always Monday |
| **End Day** | Always Friday |
| **Week 1** | Mon-Fri = 5 working days |
| **Week 2** | Mon-Thu = 4 working days, **Fri = Retro + Planning** |

**2nd Friday Ceremony:**
- Morning: Sprint retrospective (current sprint)
- Afternoon: Sprint planning (next sprint)
- This day counts toward current sprint

**Example Sprint Dates:**
| Sprint | Start (Mon) | End (Fri) |
|--------|-------------|-----------|
| S1 | Jan 6 | Jan 17 |
| S2 | Jan 20 | Jan 31 |
| S3 | Feb 3 | Feb 14 |
| S4 | Feb 17 | Feb 28 |

**When creating sprints:** Always verify start date is a Monday and end date is a Friday.

---

## TASK SIZING RULE

**Maximum task size: 3 points (4 hours). No 5-point tasks in sprints.**

| Rule | Description |
|------|-------------|
| **Max Points** | 3 points per task |
| **Max Duration** | 4 hours of work |
| **If > 3 pts** | Break into smaller tasks during grooming |

**During sprint planning, if a task is estimated at 5+ points:**
1. Break it into 2-3 smaller tasks (each 1-3 pts)
2. Each sub-task must be independently completable
3. Add all sub-tasks to the sprint instead of the parent

**Why this matters:**
- 5-point tasks never get done in one session
- They stall the sprint and become carryover
- Smaller tasks show daily progress and maintain momentum
- Easier to identify what's actually blocked vs just too big

**Example:**
```
BAD:  "Rock 1 Milestone: Ad creative + Buzz.ai sequences" (5 pts)
GOOD: "Create LinkedIn ad creative set" (2 pts)
      "Configure Buzz.ai outreach sequence" (2 pts)
      "Launch and verify ad + sequence live" (1 pt)
```

---

## STORIES VS TASKS

**Rule: Stories are containers. Only tasks go in sprints.**

| Type | In Sprint? | Purpose |
|------|------------|---------|
| **Story** | NO | Parent container that tracks progress across multiple sprints |
| **Task** | YES | Actual work item that gets committed and completed |

**How it works:**
- Stories live in the backlog as ongoing/recurring themes (e.g., "RequestDesk - new integration every 2 weeks")
- Tasks are created under stories for specific sprint work (e.g., "Add Klaviyo integration - S2")
- Tasks roll up to stories for progress tracking
- Sprint metrics only count tasks, not stories

**Why this matters:**
- Prevents double-counting points
- Keeps sprints focused on actionable work
- Stories provide continuity across sprints without cluttering sprint commitments

**Example:**
```
Story: "RequestDesk - new integration every 2 weeks" (NOT in sprint)
  └── Task: "Add Klaviyo integration" (S2, 2 pts) ← THIS goes in sprint
  └── Task: "Add Mailchimp integration" (S3, 2 pts)
  └── Task: "Add Drip integration" (S4, 2 pts)
```

---

## AUTOMATIC RECURRING ITEMS

**WARNING: When a sprint is created, all `is_recurring: true` backlog items are automatically cloned into the new sprint. If recurring items were already added manually (e.g., during planning before the sprint record was created), the auto-clones are DUPLICATES and must be deleted immediately after sprint creation. Check for items sharing the sprint's creation hash.**

**When a sprint is created, all `is_recurring: true` backlog items are automatically cloned into the new sprint.**

| What happens | Details |
|--------------|---------|
| **Query** | Finds all backlog items with `is_recurring: true` for the user |
| **Clone** | Creates a copy of each recurring item in the new sprint |
| **Title** | Appends sprint name (e.g., "TWC Article" becomes "TWC Article (S3)") |
| **Link** | Sets `parent_id` to original, marks clone as `is_child: true` |
| **Duplicate check** | Skips if clone already exists for that sprint+parent combo |

**Response includes:**
```json
{
  "recurring_items": {
    "items_created": 2,
    "total_points": 3,
    "titles": ["TWC Article (S3)", "Weekly content review (S3)"]
  }
}
```

**To create recurring items:** Set `is_recurring: true` on a backlog item. It will be cloned into every new sprint automatically.

---

## SPRINT LIFECYCLE

```
1. PLAN (status: planned)
   - Set dates, capacity, goals
   - Assign backlog items to sprint
   - Update committed_points and committed_items
   - Recurring items auto-created on sprint creation

1.5 ESTIMATE (mandatory gate between PLAN and COMMIT)
   - Run /planning-poker for ALL non-recurring candidate items
   - Present items to Brent for estimation discussion
   - Update estimated_points based on poker results
   - Items CANNOT be committed without going through planning poker
   - This was skipped for S5, S6, and S7. Not optional.

2. COMMIT (mandatory gate between PLAN and COMMIT → START)
   - SEE "SPRINT COMMIT & VERIFY GATE" SECTION BELOW
   - PATCH sprint_name on EVERY committed backlog item
   - Create any missing items (recurring, new tasks)
   - Run verification query
   - Sprint is NOT ready until verify passes

3. START (status: active)
   POST /api/sprints/{id}/start
   - Timestamps all items as committed
   - Sets sprint_committed_at on backlog items

4. EXECUTE (during sprint)
   PATCH /api/sprints/{id}
   - Track total_hours_worked daily
   - Note scope changes (added_items, removed_points)
   - Update backlog item statuses

5. CLOSE (status: completed)
   POST /api/sprints/{id}/close
   - Auto-calculates velocity and hours_per_point
   - Identifies carryover items
   - Optional: assigns carryover to next sprint

6. ASSESS (post-sprint)
   PATCH /api/sprints/{id}
   - Set rating (1-5)
   - Link retrospective_file
```

---

## LOCAL SPRINT BOARD (CRITICAL - replaces API-dependent daily reads)

**The sprint board lives in a local file. The API is the source of truth for planning and closing. The local file is the source of truth for daily work.**

**File location:** `brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/current/sprint-board.md`

### When to write the local file
- **At sprint planning** (after commit gate passes): Pull all committed items from API, write to local file
- **At sprint close** (retro): Reconcile local file back to API, archive

### File format
```markdown
# S[N] Sprint Board

**Sprint:** S[N] | [start] to [end]
**Goals:** [goal 1], [goal 2], [goal 3]
**Capacity:** [X] pts | **Committed:** [Y] pts

## Open

| Hash | Pts | Item | Status | Notes |
|------|-----|------|--------|-------|
| abc123 | 2 | LinkedIn Campaign #1 | backlog | Carryover from S7 |
| def456 | 1 | TWC Article W1 (S8) | backlog | Recurring |

## Completed

| Hash | Pts | Item | Completed |
|------|-----|------|-----------|
| ghi789 | 2 | Define ICP profiles | 2026-04-14 |
```

### Daily workflow
1. **At /brent-start:** Read `sprint-board.md` (instant, no API call). Present the Open table.
2. **Brent picks an item:** Write a claude-comms file for a new Claude session (see below).
3. **When item is done:** Move row from Open to Completed in the local file. Update API status.

### Handing off sprint items to new Claude windows

**When Brent picks a sprint item to work on, write a claude-comms file:**

File: `.claude/claude-comms/sprint-[hash]-[short-title].md`

```markdown
# Sprint Item Handoff

**From:** Claude-[CurrentName] (brent-start session)
**To:** New Claude session
**Date:** [today]

## Task
**Backlog Item:** [full title]
**Hash:** [backlog item ID]
**Points:** [X]
**Sprint:** S[N]
**Acceptance Criteria:** [from backlog item]

## Instructions
1. Run /start-work with branch: feature/[short-title]
2. [Specific instructions for what needs to be done]
3. When complete, update the sprint board:
   - Move this item from Open to Completed in `Sprints/current/sprint-board.md`
   - PATCH status to "completed" in API: `curl -X PATCH "https://app.requestdesk.ai/api/backlog/[hash]" -H "Authorization: Bearer [KEY]" -H "Content-Type: application/json" -d '{"status": "completed"}'`
4. Send claude-comms back to brent-start session confirming completion

## Context
[Any relevant context, related files, dependencies]
```

**Brent opens a new terminal, runs /claude-start, and that Claude picks up the comms file.**

This means:
- brent-start session stays as the controller (daily ops, routing work)
- Each sprint item gets focused attention in its own window
- No API latency during the morning ritual
- Sprint board is always visible and up to date

---

## SPRINT COMMIT & VERIFY GATE

**Full checklist:** See `000-planning-sop.md` Steps 9-10 in `Dashboard/SOPs/` (single source of truth)

**Summary:** After planning, PATCH every committed item with `sprint_name` and `committed=true`, remove sprint_name from non-committed items, then verify API counts match the plan. Claude CANNOT say "sprint is ready" until the verify gate passes.

---

## CAPACITY MODEL (Calibrated from S1-S5 Actuals)

**The old formula (`working days x 6`) was wrong.** It assumed all hours go to sprint items. In reality, 2-3 hours/day consistently go to meetings, inbox, daily ops, ad-hoc requests, and strategic work.

**Starting S6, all work gets a backlog item** (see `/claude-start` Step 6.5 and `/brent-finish` Step 5.7b). This means sprint velocity will reflect total output, not just pre-planned items.

### Historical Velocity (pts/day of PLANNED sprint work)

| Sprint | Days | Committed | Completed | Pts/Day |
|--------|------|-----------|-----------|---------|
| S1 | 10 | 50 | 42 | 4.2 |
| S2 | 10 | 51 | 49 | 4.9 |
| S3 | 4 | 24 | 14 | 3.5 |
| S4 | 6 | 33 | 27 | 4.5 |
| S5 | 9 | 54 | 33 | 3.7 |
| **Avg** | | | | **4.0** |

### Capacity Formula

```
Gross hours/day:              ~9 hrs
Non-sprint overhead:          ~2-3 hrs (meetings, inbox, ops, social)
Net sprint-planned capacity:  ~4 pts/day

Sprint capacity = working_days x 4 pts/day (planned work)
Daily ops buffer = working_days x 2 pts/day (emergent, will be captured via bulk items)
```

**At planning time:**
1. Count working days (subtract travel, PTO, conferences)
2. Calculate planned capacity: `working_days x 4`
3. Subtract recurring items
4. Subtract carryover items
5. Remaining = available for new planned work
6. Do NOT plan the daily-ops buffer. It fills itself via `/claude-start` and `/brent-finish`

**Example (9-day sprint):**
```
Planned capacity:    9 x 4 = 36 pts
Recurring items:     -12 pts
Carryover:           -8 pts
Available for new:   16 pts
Daily ops (emergent): ~18 pts (captured after the fact, not pre-planned)
Expected total:      ~54 pts in sprint at retro time
```

### Tracking the Split

At retro time, filter backlog items by tag:
- **No `emergent` or `daily-ops` tag** = planned work (measures planning accuracy)
- **`emergent` tag** = work created at `/claude-start` that wasn't in the plan
- **`daily-ops` tag** = bulk items from `/brent-finish` (meetings, inbox, overhead)

Over time this data calibrates the split and tells us if the 4/2 ratio is accurate.

---

## KEY METRICS

| Metric | Formula | Target |
|--------|---------|--------|
| **Velocity (total)** | all completed_points / capacity_points | Informational (includes emergent) |
| **Velocity (planned)** | planned completed_points / planned committed_points | 0.80+ (80%+) |
| **Hours/Point** | total_hours_worked / completed_points | ~1.0 (calibrate from history) |
| **Commitment Rate** | planned completed / planned committed | 0.90+ |
| **Carryover Rate** | carryover_items / committed_items | < 0.15 (15%) |
| **Emergent %** | emergent+daily-ops pts / total pts | Track trend (lower = better planning) |

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
- Asks about "tickets", "open tickets", or "sprint tickets"
- Says "give me my tickets" or "what's left in the sprint"

**REMINDER: Always query the API. Never read sprint-plan.md for status.**

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

## Sprint History

### S1 (Jan 6-17, 2026)
- **Velocity:** 0.84 (84%)
- **Hours/Point:** 1.16
- **Capacity:** 50 points
- **Completed:** 42 points
- **Total Hours:** 48.88
- **Note:** Uncalibrated points (not 1pt=1hr). Use as directional baseline only.

### S2 (Jan 19-31, 2026)
- **Capacity:** 51 points committed, 34 items
- **Completed:** 27 items (including 15 bonus items not in original plan)
- **Carryover:** 6 items (11 pts) carried to S3
- **Key learnings:**
  - Points were tracked in sprint-plan.md only, not in backlog API. Broke velocity tracking.
  - Rock 1 (LinkedIn Lead Gen) stalled entirely. Campaign and ad creative never started.
  - 15 bonus items completed shows good emergent work handling but also scope creep risk.
  - No burndown, no daily checklist, no file discipline rules led to drift.
  - Morning /brent-start was inconsistent. Things got missed.

### S3 (Feb 2-13, 2026)
- **Capacity:** 24 points, 16 items
- **Completed:** 14.5 pts, 60% completion rate
- **Working Days:** 4 (Feb 2, 6, 9, 13) - conference travel limits availability
- **New rules:** 1pt=1hr, max 2pts per task, stories carry 0pts in sprint
- **Goals:** Launch paid acquisition, keep content engine running, clear S2 carryover
- **Key issue:** Sprint items not tagged with sprint_name in backlog API (same as S2). Led to commit/verify gate being added to skill.

### S4 (Feb 16-27, 2026)
- **Capacity:** 36 points (6 working days x 6 pts/day)
- **Committed:** 23 items, 34 pts
- **Completed:** 27 pts (79%), 19 items
- **Working Days:** 6 (Feb 16-20 + Feb 23 at eTail)
- **Goals:** Activate Rock 1 (ICPs + campaigns), ship eTail prep, keep content engine running
- **Key changes from S4 retro:** Sprint folder standardized to 4 files (removed work-log.md, centralized daily log is source of truth). New daily log format with session stamps and work item tracking.

---

## RETRO: UNPLANNED WORK IS REAL WORK (CRITICAL)

**Every sprint has significant work that happens outside the sprint board.** Client requests, sales opportunities, CRM cleanup, content that wasn't planned, tool fixes. This work is real, valuable, and often more urgent than planned items.

**At retro time, BEFORE scoring the sprint, Claude MUST:**

1. **Scan the entire work log** for the sprint period (every day's "Accomplished" section)
2. **Identify all work that wasn't on the sprint board** (look for days with 8+ hours worked but 0 sprint points moved)
3. **Summarize unplanned work by category** (sales, content, CRM, client work, infrastructure, etc.)
4. **Estimate unplanned points delivered** using the 1pt = 1hr rule
5. **Present BOTH numbers:**
   - Sprint board completion: X/Y pts (Z%)
   - Total work delivered: sprint pts + unplanned pts
   - Unplanned work breakdown by category

**Example retro opening:**
```
S7 Sprint Board: 26/28 pts (93%)
Unplanned Work:  ~35 pts (VTEX research 10, CRM cleanup 8, landing pages 6, email sequences 5, SEO 3, case study ICP 3)
Total Delivered:  ~61 pts across 70+ hours

The sprint wasn't 93% done. It was 93% of planned work done PLUS a full sprint's worth of unplanned work on top.
```

**Why this matters:** Without this step, every retro looks at the sprint board and asks "why didn't X ship?" when the answer is "because 35 points of real work happened that wasn't on the board." Six sprints ran without capturing this. The retro should celebrate what got done, not just audit what didn't.

**For S8 planning:** Use the unplanned work data to calibrate how much buffer to leave. If unplanned work consistently runs 30-50% of total output, plan accordingly.

---

## RETRO LEARNINGS (Applied to skill)

1. **Points must live in the backlog API.** Sprint-plan.md is a planning artifact, not a tracking tool.
2. **Max 2 points per task.** Large tasks stall and become carryover. Break them down.
3. **Stories are containers, not sprint items.** Only tasks (with points) go in sprints.
4. **Sprint plan must declare working day count and day map** at planning time.
5. **Work log uses day counter** (Day 1, Day 2) so Claude knows sprint position.
6. **Retro must be a conversation.** Ask Brent directly, wait for answers. No checkbox retros.
7. **First /brent-start after retro: verify every action item is implemented.** Documentation without implementation is waste.
8. **Always include hash IDs** when presenting backlog items to the user.
9. **Reconcile sprint item status with Brent BEFORE scoring.** Present all open items as a batch and ask which are actually done. Never make Brent correct items one at a time. (S7 retro: API showed 61% but actual was 93% because reconciliation wasn't run.)
10. **Sprint board must be presented every morning at /brent-start.** Don't wait for Brent to ask. Show open items, points remaining, days left, and % complete as part of the daily dashboard. Brent should never have to request sprint status. (S7 retro: "I always have to ask for it.")
11. **Planning poker is mandatory before committing items.** Run /planning-poker for all non-recurring candidate items. Skipped for S5, S6, and S7. Not optional going forward.

---

## Supporting Files

- `api-reference.md` - Complete API endpoint documentation
- `schema.md` - Full sprint and backlog item field definitions
- `workflows.md` - Detailed sprint ceremonies and processes

---

## COMBINING DUPLICATE/RELATED TASKS

When two or more backlog items cover the same work or should be done together:

**Procedure:**
1. **Choose the primary task** - pick the one with more context or the earlier ID
2. **Update primary task:**
   - New combined title
   - Sum the points (or re-estimate)
   - Add notes listing what was combined and when
3. **Archive the duplicate(s):**
   - Set `status: "archived"`
   - Add note referencing the primary task ID
4. **Verify sprint assignment** - ensure combined task is in correct sprint

**API Pattern:**
```bash
# 1. Update primary task
curl -X PATCH "https://app.requestdesk.ai/api/backlog/PRIMARY_ID" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Combined task title",
    "estimated_points": SUMMED_POINTS,
    "notes": "Combined from:\n- Task 1 title\n- Task 2 title\n\nCombined: YYYY-MM-DD"
  }'

# 2. Archive duplicate
curl -X PATCH "https://app.requestdesk.ai/api/backlog/DUPLICATE_ID" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "status": "archived",
    "notes": "Archived: Combined into task PRIMARY_ID on YYYY-MM-DD"
  }'
```

**When to combine:**
- Same deliverable described differently
- Sequential tasks that make sense as one unit
- Tasks that would be done in the same work session
- Duplicate entries from different capture sources

**When NOT to combine:**
- Different deliverables that happen to be related
- Tasks for different sprints
- Items with different owners/assignees

---

## SPRINT SKILL IMPROVEMENT PROPOSALS

**Claude should actively propose improvements to this skill during sprint execution.**

When Claude notices a gap, inconsistency, or repeated friction during sprint work, it should:

1. **Flag it in the moment:**
   ```
   SPRINT SKILL GAP: [description of what's missing or broken]
   Proposed fix: [what should be added/changed in the skill]
   Want me to update the skill now? (y/n)
   ```

2. **If user approves:** Update the relevant skill file immediately and note the change.

3. **If user says "later":** Add to the sprint plan's Notes section for retro discussion.

**Examples of what to flag:**
- A process that's documented but doesn't match how we actually work
- Missing instructions that caused confusion or wasted time
- Rules that conflict with each other
- API patterns that changed but skill docs weren't updated
- Repeated questions from Claude that should be answered in the skill

**This mechanism replaces ad-hoc skill updates.** Changes are proposed, approved, and applied in real-time rather than waiting for retro.

---

## Integration with Commands

- `/sprint` - Quick sprint status and operations (command file)
- `/add-backlog` - Add items to backlog with sprint assignment
- `/brent-start` - Daily kickoff includes sprint status check
- `/brent-finish` - End of day updates hours worked

---

## TUTORIAL: Sprint & Backlog API Access

**For other Claude instances learning this system.**

### Step 1: Authentication

The APIs support **dual authentication**:

| Method | Use Case | Header |
|--------|----------|--------|
| **Agent API Key** | Claude/automated tools | `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg` |
| **JWT Token** | User sessions / PWA | `Authorization: Bearer <jwt_from_login>` |

**For Claude, always use the Agent API Key:**
```bash
KEY="MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg"
```

This key is tied to Brent's user account and has access to his sprints/backlog.

### Available Endpoints

| Method | Endpoint | Status | Description |
|--------|----------|--------|-------------|
| GET | `/api/sprints` | Verified | List all sprints |
| GET | `/api/sprints/{id}` | Verified | Get specific sprint (e.g., S1, S2) |
| POST | `/api/sprints` | Verified | Create new sprint |
| PATCH | `/api/sprints/{id}` | Verified | Update sprint |
| POST | `/api/sprints/{id}/start` | Documented | Start sprint (sets status to active) |
| POST | `/api/sprints/{id}/close` | Documented | Close sprint (calculates velocity) |
| GET | `/api/backlog` | Verified | List all backlog items |
| PATCH | `/api/backlog/{id}` | Verified | Update backlog item |

**Note:** Sprint IDs like "S1", "S2" are string identifiers (not ObjectIds).

### Step 2: Check if Sprints Exist

```bash
# List all sprints
curl -s "https://app.requestdesk.ai/api/sprints" \
  -H "Authorization: Bearer $KEY" | jq '.'

# Response when empty:
# { "sprints": [], "total": 0, "average_velocity": null }

# Response when sprints exist:
# { "sprints": [...], "total": 1, "average_velocity": 0.84 }
```

### Step 3: Query Specific Sprint

```bash
# By sprint ID (e.g., "S2")
curl -s "https://app.requestdesk.ai/api/sprints/S2" \
  -H "Authorization: Bearer $KEY" | jq '.'

# If not found: { "detail": "Sprint S2 not found" }
```

### Step 4: Query Backlog Items

```bash
# Get all backlog items
curl -s "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer $KEY" | jq '.total'

# Count items assigned to a sprint (filter locally)
curl -s "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer $KEY" | \
  jq '[.items[] | select(.sprint_name == "S2")] | length'

# Sum points for a sprint
curl -s "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer $KEY" | \
  jq '[.items[] | select(.sprint_name == "S2")] | map(.estimated_points // 0) | add'
```

### Step 5: Create a Sprint (if missing)

**IMPORTANT GOTCHAS:**
1. `id` field is REQUIRED (not auto-generated)
2. Dates must be full datetime format: `2026-01-20T00:00:00`
3. Date-only strings like `2026-01-20` will FAIL

```bash
curl -s -X POST "https://app.requestdesk.ai/api/sprints" \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "id": "S2",
    "name": "S2",
    "start_date": "2026-01-20T00:00:00",
    "end_date": "2026-01-31T23:59:59",
    "capacity_points": 51,
    "committed_points": 51,
    "committed_items": 34,
    "status": "planned",
    "goals": ["Goal 1", "Goal 2"]
  }'
```

### Step 6: Common Data Inconsistency

Backlog items may have `sprint_name` and `sprint_id` fields set, but the sprint record itself may not exist. This happens when items are assigned to a sprint before the sprint is created.

**How to detect:**
```bash
# Check if backlog items reference a sprint
curl -s "https://app.requestdesk.ai/api/backlog" \
  -H "Authorization: Bearer $KEY" | \
  jq '[.items[] | select(.sprint_name != null)] | .[0] | {sprint_name, sprint_id}'

# Then verify that sprint exists
curl -s "https://app.requestdesk.ai/api/sprints/S2" \
  -H "Authorization: Bearer $KEY" | jq '.id // "NOT FOUND"'
```

**Resolution:** Create the sprint record using Step 5.

### Step 7: Verify Everything Works

```bash
# Sprint exists and is queryable
curl -s "https://app.requestdesk.ai/api/sprints/S2" \
  -H "Authorization: Bearer $KEY" | \
  jq '{id, name, status, capacity_points, committed_items}'

# Expected output:
# {
#   "id": "S2",
#   "name": "S2",
#   "status": "planned",
#   "capacity_points": 51,
#   "committed_items": 34
# }
```

### Quick Troubleshooting

| Issue | Cause | Fix |
|-------|-------|-----|
| `401 Unauthorized` | Wrong API key | Use `MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg` |
| `Sprint not found` | Sprint record doesn't exist | Create it with POST |
| `invalid datetime format` | Used date-only string | Use full datetime `2026-01-20T00:00:00` |
| `field required: id` | Missing id in POST | Add `"id": "S2"` to request body |
| Items have sprint_id but sprint missing | Data inconsistency | Create sprint record |

### JWT Login Flow (for PWA testing only)

If you need to test the user login flow:

```bash
# Step 1: Login to get JWT
curl -X POST "https://app.requestdesk.ai/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"email": "user@example.com", "password": "password"}'

# Response includes access_token (the JWT)

# Step 2: Use JWT in requests
curl -X GET "https://app.requestdesk.ai/api/sprints" \
  -H "Authorization: Bearer <jwt_token_here>"
```

**Note:** For Claude/automated tools, always use the Agent API Key instead.
