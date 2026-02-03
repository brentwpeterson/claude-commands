# Claude Communication: S3 Retro Action Items - Remaining Work

**Started:** 2026-02-02 12:20
**From:** Claude-Nightingale
**To:** (New session - pick a name)

---

## 2026-02-02 12:20 Claude-Nightingale

We're working on S3 sprint backlog item `16163e` (2 pts): "Implement S2 retro action items." There are 7 sub-items. I completed some, you need to finish the rest.

### COMPLETED (by Nightingale)

- **#4** Updated sprint skill (`/Users/brent/scripts/CB-Workspace/.claude/skills/sprint-management/SKILL.md`) with S2 history, carryover stats, and 8 applied learnings
- **#5** Added "Sprint Skill Improvement Proposals" mechanism to same file (real-time proposal flow for Claude to flag gaps during sprint execution)
- **#7** Verification pass started (this handoff is part of it)
- **Also fixed:** `brent-start.md` line 612 changed `CURRENT_SPRINT="S2"` to `"S3"` and `CURRENT_WEEK="W2"` to `"W1"`

### REMAINING (for VanGogh)

**#1 - Create daily punch list for /brent-start**
- The S2 retro said: "No agreed-upon daily checklist. Need a punch list to start each day."
- Current `/brent-start` (`/Users/brent/scripts/CB-Workspace/.claude-local/commands/brent-start.md`) has a massive multi-step flow. The punch list should be a SHORT, non-negotiable checklist (5-6 items max) that runs every morning regardless of day.
- **Ask Brent** what the non-negotiable items are. Propose something based on the existing routine and let him edit.
- Implement as a new section in brent-start or a standalone file in the brent-workspace skill.

**#3 - Build or implement burndown chart**
- Sprint plan (`/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/2026/Q1/S3/sprint-plan.md`) already has a burndown table (lines 158-166) with planned remaining by day.
- Need a process to auto-update the "Actual Remaining" column. Best place is probably `/brent-finish` so it updates at end of each working day.
- Query the backlog API for S3 open items, sum remaining points, write to the burndown table.

**#6 - Establish file discipline rules**
- S2 retro said: "Claude created chaotic files in random places (no file discipline)."
- Need to define WHERE Claude can and cannot create files. Ask Brent for his rules.
- Implement as a section in CLAUDE.md or a standalone rules file.
- Common patterns to address: temp files, debug logs, draft content, branch context files.

**#2 - Mon-Fri recurring schedule**
- Day-specific routine files already exist at `/Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/routines/` (monday.md through friday.md + weekend.md).
- May already be sufficient. Review them with Brent to confirm they're complete and accurate. If so, mark this done.

### CONTEXT

- **Sprint:** S3 (Feb 2-13), Day 1 of 4 working days (Feb 2, 6, 9, 13)
- **This task is 2 pts.** Don't over-engineer it.
- **Sprint skill file:** `/Users/brent/scripts/CB-Workspace/.claude/skills/sprint-management/SKILL.md`
- **S2 retro (full text):** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/Sprints/2026/Q1/S2/sprint-plan.md` lines 209-249
- **Backlog API:** `https://app.requestdesk.ai/api/backlog?sprint_name=S3` with `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`
- **When all 7 items are done,** mark `16163e` as completed via PATCH to backlog API.

**Action Requested:** Pick up where I left off. Ask Brent for input on #1, #3, #6. Review #2 with him. Then mark the parent task done.

---
