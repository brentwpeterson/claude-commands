# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/brent-workspace`
2. **Verify branch:** `git branch --show-current` (should be: main)
3. **Load skill:** Read `.claude/skills/brent-workspace/SKILL.md` for complete workspace context

## SESSION METADATA
**Last Commit:** `f985f24 Q1 Planning System - SOPs, Story Points, Delegate & Elevate`
**Saved:** 2026-01-02
**Project:** brent-workspace (Obsidian vault + planning system)

## WHAT YOU WERE WORKING ON
**Q1 2026 Planning System Build-out** - Major session establishing planning infrastructure.

## MAJOR ACCOMPLISHMENTS THIS SESSION

### 1. Created `brent-workspace` Skill (7 files)
**Location:** `/Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/`
- `SKILL.md` - Core overview, Claude auto-discovers planning context
- `accountability-mode.md` - Focus enforcement rules
- `priority-framework.md` - P0-P5 decision framework
- `delegation-rules.md` - Team & what can be delegated
- `weekend-mode.md` - Saturday/Sunday handling
- `content-schedule.md` - Day-of-week content rhythm
- `media-properties.md` - Podcasts, LinkedIn Live, Meet Magento India

### 2. Created SOPs Folder
**Location:** `Dashboard/SOPs/`
- `000-planning-sop.md` - **Master SOP** with:
  - Sprint cycle (Retro → Plan → Sprint → Review → Improve)
  - Story point scale (1-13)
  - Task assessment flow (check for SOP)
  - **Delegate and Elevate exercise** (added this session)
  - SOP creation SOP
- `README.md` - Index of all SOPs by category

### 3. Google Sheet Enhancements
**Sheet:** https://app.requestdesk.ai (DELETED - now use RequestDesk backlog)

**Columns Added:**
- Est Points (D) - Story point estimates
- Frequency (E) - Daily/Weekly/Bi-weekly/2x-week
- Subcategory (G) - Maps to SOP
- SOP Status (H) - Needed/Working/Done
- Property (I) - ContentBasis/Content Cucumber/RequestDesk/Talk Commerce/EO Visionary Voices/ALL

**Dropdowns Created:**
- Category (F) - All categories
- Property (I) - All properties + ALL

**Data Updated:**
- All P0 items have story points
- Recurring tasks have Frequency set
- Subcategories mapped for P0 items

### 4. Priority List Updates
**Location:** `Dashboard/Planning/PRIORITY-LIST.md`
- Added MEDIA PROPERTIES section (M1-M7)
- Added DELEGATED TO SUSAN section (D1)
- Combined E2+E3, W5-W7, M2+M3
- Updated totals

### 5. Content Captured
- `idea-stash/llm-pdp-optimization-article.md` - Source for L1 white paper
- `Delegated/susan-eovoices-fix-images.md` - Task doc for Susan

## KEY METRICS FROM SESSION

**P0 Summary:**
- 19 items, 50 total story points
- Recurring weekly commitment: 37.5 points
- One-time P0 backlog: 36 points

**Total Recurring Weekly:**
- P0: 37.5 pts/week
- P1: 7 pts/week
- P2: 22 pts/week
- **Total: ~66.5 pts/week** (capacity concern!)

## WHERE WE LEFT OFF

**About to run Delegate and Elevate exercise** on recurring tasks.

The matrix:
```
                GREAT AT IT          NOT GREAT AT IT
            ┌─────────────────────┬─────────────────────┐
 LOVE IT    │      KEEP           │      LEARN          │
            ├─────────────────────┼─────────────────────┤
 DON'T      │     DELEGATE        │     ELIMINATE       │
 LOVE IT    │                     │                     │
            └─────────────────────┴─────────────────────┘
```

**Tasks to evaluate:**
| Task | Pts/Wk | Love? | Great? |
|------|--------|-------|--------|
| C3: CC Blog posts (daily) | 15 | ? | ? |
| C5: Social posts (daily) | 15 | ? | ? |
| C1: Tuesdays w/ Claude | 3 | ? | ? |
| C2: LinkedIn Newsletter | 3 | ? | ? |
| C4: Help Videos (2x/wk) | 16 | ? | ? |
| M1: Talk Commerce | 1 | ? | ? |
| M2: EO Visionary Voices | 5 | ? | ? |
| M4: Content in Commerce | 0.5 | ? | ? |
| + others... | | | |

## NEXT ACTIONS (PRIORITY ORDER)
1. **Run Delegate and Elevate** - Go through each recurring task with Brent
2. **Identify delegation candidates** - Tasks in "Don't Love + Great At" quadrant
3. **Create SOPs for delegation** - Each SOP unlocks delegation
4. **Recalculate capacity** - After delegation, what's realistic?

## KEY RESOURCES

### Planning Infrastructure:
- **Google Sheet:** https://app.requestdesk.ai (DELETED - now use RequestDesk backlog)
- **Planning SOP:** `Dashboard/SOPs/000-planning-sop.md`
- **Priority List:** `Dashboard/Planning/PRIORITY-LIST.md`
- **Skill:** `.claude/skills/brent-workspace/`

### Google Sheets API (working):
```bash
# venv with gspread installed
/tmp/gsheets-venv/bin/python3

# Auth configured with Sheets + Drive scopes
# Project: requestdesk-gdrive-integration
```

### Critical Dates:
| Date | Event |
|------|-------|
| Feb 4 | MM26FL Workshop |
| Feb 23-26 | eTail Palm Springs |
| Mar 24-26 | Shoptalk Spring |

## CONTEXT NOTES

1. **Capacity Problem Identified:** 66.5 recurring pts/week vs ~40-80 capacity means little room for one-time tasks

2. **SOP = Delegation Unlock:** No SOP = No delegation. Creating SOPs is the path to getting recurring work off Brent's plate

3. **Story Points Calibration:** First time using points - track actual time to calibrate estimates

4. **Property Column Added:** Can now filter tasks by ContentBasis, Content Cucumber, RequestDesk, Talk Commerce, EO Visionary Voices, or ALL

## VERIFICATION COMMANDS
```bash
# Check workspace skill
ls -la /Users/brent/scripts/CB-Workspace/.claude/skills/brent-workspace/

# Check SOPs folder
ls -la "/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/Dashboard/SOPs/"

# Pull sheet data
/tmp/gsheets-venv/bin/python3 -c "
import gspread
from google.auth import default
creds, _ = default(scopes=['https://www.googleapis.com/auth/spreadsheets'])
gc = gspread.authorize(creds)
sheet = gc.open_by_key('1yw2gUt-vHdQgDLHr3HVKf0IkPzLwgsDrnQURhy9vFBo')
print(f'Sheet has {len(sheet.sheet1.get_all_values())} rows')
"
```
