# Priority Framework

## Priority Levels

| Priority | Name | Definition | Action Required |
|----------|------|------------|-----------------|
| **P0** | Critical | Hard deadline exists | Must complete by date - no negotiation |
| **P1** | Rock | Q1 Rock or critical path | Weekly progress required |
| **P2** | Important | Should do this quarter | Schedule when P0/P1 clear |
| **P3** | Backlog | Nice-to-have | Only if time permits |

## Decision Tree

```
Does this have a hard deadline?
├─ YES → What's the date?
│   ├─ Within 2 weeks → P0
│   └─ More than 2 weeks → P1 (monitor)
└─ NO → Is this a Q1 Rock?
    ├─ YES → P1
    └─ NO → Does blocking this block a P0/P1?
        ├─ YES → P1
        └─ NO → Is this important for Q1 goals?
            ├─ YES → P2
            └─ NO → P3
```

## P0 Rules (Hard Deadlines)

- **Never miss a P0** - these have external consequences
- P0s get worked on first, every day
- If a P0 is at risk, escalate immediately
- Examples: MM26FL (Feb 4), eTail (Feb 23), Shoptalk (Mar 24)

## P1 Rules (Rocks)

- Weekly progress is mandatory
- Check progress every Monday
- If no progress in 2 weeks, either:
  - Escalate to P0 with deadline
  - Demote to P2/P3 (not actually important)

## P2 Rules (Important)

- Work on these when P0/P1 are clear for the day
- Review weekly - promote to P1 if becoming urgent
- Don't let P2s sit for > 4 weeks without action

## P3 Rules (Backlog)

- Review monthly - delete stale items
- Only work on if P0/P1/P2 clear AND energy permits
- Great for capturing ideas without commitment

## Google Sheet Columns

| Column | Purpose |
|--------|---------|
| ID | Unique identifier (TASK-001) |
| Item | Task description |
| Category | Business area (Sales, Content, Product, Admin) |
| Priority | P0 / P1 / P2 / P3 |
| Due Date | Hard deadline (P0) or target (P1) |
| Status | Not Started / In Progress / Blocked / Complete |
| Owner | Brent / Susan / Vijay / Writer / Evrig |
| Delegatable? | Yes / No / Partial |
| Delegate To | Who can do this |
| Asset Needed | Doc / Video / Template / Checklist / None |
| Asset Status | Not Started / In Progress / Done |
| Notes | Context, blockers, links |

## Weekly Review Process

Every Monday:
1. Review all P0s - are they on track?
2. Review all P1s - any progress?
3. Promote P2s that became urgent
4. Archive completed items
5. Delete stale P3s (> 4 weeks untouched)
