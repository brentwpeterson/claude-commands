# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Identity:** Claude-Nightingale
3. **Branch:** main
4. **Sprint:** S3 (Feb 2-13, 2026) - Day 1 of 4 working days (Feb 2, 6, 9, 13)

## SESSION METADATA
**Saved:** 2026-02-02 (Session 3 - Claude-Nightingale)
**Workspace:** brent

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| brent | Sprint backlog management, retro items work, recurring ticket creation |
| cc | Updated sprint skill (S2 learnings, improvement proposals), workflows.md (recurring items step), brent-start.md (S3 sprint ref), monday.md and friday.md routines (Strety todos) |

## WHAT WE WERE DOING

### LinkedIn Newsletter - ButterCMS Article (IN PROGRESS)
Sprint ticket `698100c0642d21ece8e047b3` (S3: LinkedIn Newsletter, 2 pts)
- Brent wants a LinkedIn Newsletter article about ButterCMS
- Research done: ButterCMS is headless CMS, API-first, $79-399/mo, no seat limits, composable
- Format: What/So What Framework, 800-1500 words, publish Wednesday Feb 5
- Previous articles in `Newsletters and Blogs/LinkedIn Content/Newsletter/`
- Q1 calendar shows Feb 5 (Week 5) as TBD - ButterCMS fills this slot
- Style: No colons in titles, no em dashes, no H3 headers, short paragraphs
- File naming: `2026-02-05-buttercms-headless-content.md` (or similar)
- NO DRAFT WRITTEN YET - research gathered, article not started

### S3 Sprint Backlog Cleanup (COMPLETED this session)
- Created 6 recurring S3 tickets (9 pts) - recurring items weren't generating new tickets per sprint
- Updated sprint workflows.md with mandatory recurring ticket creation step on sprint create
- Sprint now shows 14 items / 20 pts via `/sprint S3 items`
- Still 4 pts gap (2 carryover items visible in backlog API but not /items endpoint - possible API bug)

### S2 Retro Action Items (PARTIALLY DONE, handed to other Claude)
Parent ticket: `697e82b9b2c257332616163e` (2 pts)
- #4 DONE: Sprint skill updated with S2 history + 8 applied learnings
- #5 DONE: Added sprint skill improvement proposal mechanism
- #7 IN PROGRESS: Verification pass (this session did sprint data fixes)
- Fixed brent-start.md: CURRENT_SPRINT S2->S3, CURRENT_WEEK W2->W1
- Added Strety todos review to friday.md and monday.md routines
- #1, #2, #3, #6 handed to other Claude via comms file
- Other Claude session also added daily punch list to brent-start.md (Step 2.6)

## COMPLETED THIS SESSION (Claude-Nightingale)

1. **Sprint backlog audit** - Discovered S3 only had 8/16 items, 11/24 pts in API
2. **Created 6 recurring S3 tickets:**
   - `698100bf642d21ece8e047b2` - S3: TWC article (2 pts)
   - `698100c0642d21ece8e047b3` - S3: LinkedIn Newsletter (2 pts)
   - `698100c0642d21ece8e047b4` - S3: Talk Commerce podcast (2 pts) - COMPLETED
   - `698100c1642d21ece8e047b5` - S3: Content in Commerce LinkedIn Live (1 pt) - COMPLETED
   - `698100c1642d21ece8e047b6` - S3: MiMS Facebook posts (1 pt)
   - `698100c2642d21ece8e047b7` - S3: Social posts Vista Social (1 pt)
3. **Marked 4 items completed:**
   - `697d5574b2c257332616162f` - Confirm all CTAs on WordPress pages (1 pt)
   - `696bb175fe826600fe551434` - TWC Article: Feb 3 (1 pt)
   - `698100c0642d21ece8e047b4` - S3: Talk Commerce podcast (2 pts)
   - `698100c1642d21ece8e047b5` - S3: Content in Commerce LinkedIn Live (1 pt)
4. **Updated sprint skill** with S2 history, learnings, improvement proposal mechanism
5. **Updated workflows.md** - mandatory recurring ticket creation step in sprint planning
6. **Updated routines** - friday.md and monday.md with Strety todos review/confirmation
7. **Fixed brent-start.md** - S2->S3, W2->W1
8. **Sent comms to other Claude** for retro items remaining work + active names cleanup
9. **Added --help rule to CLAUDE.md** (done by another session, noted)

## NOT COMPLETED

1. **ButterCMS LinkedIn Newsletter article** - Research done, no draft written
2. **S2 sprint not closed in API** - status still "planned", no velocity calculated
3. **S3 sprint not started in API** - status still "planned", should be "active"
4. **2 carryover items not showing in /items endpoint** - LinkedIn Campaign #1 + Newsletter Quarterly Plan
5. **53 items tagged S3 need cleanup** - uncommitted items should be untagged

## KEY FILES MODIFIED
- `/Users/brent/scripts/CB-Workspace/.claude/skills/sprint-management/SKILL.md` (S2 history + learnings + improvement proposals)
- `/Users/brent/scripts/CB-Workspace/.claude/skills/sprint-management/workflows.md` (mandatory recurring step)
- `/Users/brent/scripts/CB-Workspace/.claude-local/commands/brent-start.md` (S3 sprint ref)
- `/Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/routines/friday.md` (Strety todos)
- `/Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/routines/monday.md` (Strety todos)
- `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/nightingale-to-vangogh-s3-retro-items.md` (NEW)
- `/Users/brent/scripts/CB-Workspace/.claude/claude-comms/nightingale-to-vangogh-cleanup-active-names.md` (NEW)

## NEXT ACTIONS
1. **FIRST:** Write ButterCMS LinkedIn Newsletter article (draft to `Newsletters and Blogs/LinkedIn Content/Newsletter/2026-02-05-buttercms-headless-content.md`)
2. **THEN:** Close S2 sprint in API and start S3 (`POST /sprints/S2/close`, `POST /sprints/S3/start`)
3. **THEN:** Clean up S3 backlog - remove uncommitted items from S3 tag
4. **THEN:** Continue with remaining sprint items

## S3 BURNDOWN
Day 1: 24 committed -> 5 pts completed -> 19 pts remaining (target was 18)

## DEFERRED QUESTIONS (Handled by /brent-start, NOT /claude-start)
1. **Time tracking:** "How long did you work today?"
2. **Task status:** "Is the ButterCMS article ready for review?"
