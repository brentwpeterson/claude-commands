# Resume Instructions for Claude - Sprint PWA

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/sprint-pwa`
2. **Branch:** `master`
3. **Start dev server:** `npm run dev` (runs on localhost:3002)

## SESSION METADATA
**Last Commit:** `8535fa7 Add sprint-pwa backlog items from ROADMAP phases 2-4`
**Saved:** 2026-01-19

## WORKSPACES TOUCHED THIS SESSION
| Shortcode | Workspace | What was done |
|-----------|-----------|---------------|
| `sprint-pwa` | sprint-pwa | Created 8 backlog items from ROADMAP phases 2-4 |

## WHAT WAS ACCOMPLISHED THIS SESSION

### Previous Session (from MCP memory Session-2026-01-19-sprint-pwa-start-work)
- Created S1 sprint record (Jan 5-16, completed, 73% velocity)
- Created S2 sprint record (Jan 20-31, planned, 51 pts)
- Added full todo structure to sprint-pwa project
- Created /start-work command replacing /create-branch
- Created new-work-standards skill (mandatory acceptance criteria)
- Created project-todo-init skill (auto-scaffold todo structure)
- PWA now shows sprints via API

### This Session
- Created 8 backlog items from ROADMAP.md phases 2-4:
  - **infrastructure/daily-snapshot-system.md** (P1, 5pts) - Phase 2.1
  - **infrastructure/offline-support.md** (P3, 5pts) - Phase 4.2
  - **enhancement/full-burndown-chart.md** (P1, 3pts) - Phase 2.2
  - **enhancement/pwa-icons.md** (P3, 1pt) - Phase 4.1
  - **features/item-status-updates.md** (P1, 3pts) - Phase 3.1
  - **features/drag-drop-board.md** (P1, 5pts) - Phase 3.2
  - **features/quick-add-items.md** (P2, 3pts) - Phase 3.3
  - **features/notifications.md** (P3, 5pts) - Phase 4.3
- Total: 30 points in backlog

## BACKLOG STRUCTURE
```
todo/backlog/
├── enhancement/
│   ├── full-burndown-chart.md (P1, 3pts)
│   └── pwa-icons.md (P3, 1pt)
├── features/
│   ├── drag-drop-board.md (P1, 5pts)
│   ├── item-status-updates.md (P1, 3pts)
│   ├── notifications.md (P3, 5pts)
│   └── quick-add-items.md (P2, 3pts)
├── infrastructure/
│   ├── daily-snapshot-system.md (P1, 5pts)
│   └── offline-support.md (P3, 5pts)
├── refactoring/
└── research/
```

## DEPENDENCY CHAIN
```
daily-snapshot-system (2.1)
    └── full-burndown-chart (2.2)
    └── notifications (4.3)

item-status-updates (3.1)
    └── drag-drop-board (3.2)
    └── offline-support (4.2)
```

## API ACCESS
**Agent API Key:** `MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`
**Base URLs:**
- Sprints: `https://app.requestdesk.ai/api/sprints`
- Backlog: `https://app.requestdesk.ai/api/backlog`

## NEXT ACTIONS (PRIORITY ORDER)
1. **Run /start-work** to test the new command and create first task
2. **Pick a P1 backlog item** to work on (suggest item-status-updates as foundation)
3. **Start dev server** and verify PWA shows S1/S2 sprints

## VERIFICATION COMMANDS
```bash
# Check sprints exist
curl -s https://app.requestdesk.ai/api/sprints -H "Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg" | jq '.sprints[] | {id, status}'

# List backlog items
ls -la todo/backlog/*/

# Check dev server
lsof -i :3002
```
