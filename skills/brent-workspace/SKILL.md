# Brent Workspace - Complete Operating System

**Skill Description:** Brent's complete day-to-day operating system covering planning, content creation, priorities, delegation, and all recurring work across the CB-Workspace ecosystem.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Backlog (Source of Truth)** | [RequestDesk Backlog](https://app.requestdesk.ai/api/backlog) via `/add-backlog` |
| **Free Joke Project** | `.claude/local/free-joke-project.csv` |
| **Q1 Rocks** | `Dashboard/Planning/Q1-2026/ROCKS.md` |
| **Sprint Plan** | `Dashboard/Planning/2026/Q1/S[N]/sprint-plan.md` |
| **Work Log** | `Dashboard/Daily/WORK-LOG.md` (current sprint) |
| **Sprint Archive** | `Dashboard/Sprints/S[N]/` (completed sprints) |
| **Weekly Scorecard** | `Dashboard/Daily/WEEKLY-SCORECARD.md` |
| **Workflows** | `Dashboard/Planning/WORKFLOWS.md` |
| **Weekend Projects** | `Dashboard/WEEKEND-PROJECTS.md` |
| **LinkedIn Newsletter (Calendar)** | `LinkedIn Articles/README.md` |
| **LinkedIn Article Promotion** | `.claude/skills/brent-workspace/linkedin-article-promotion.md` |
| **HubSpot Contact Workflow** | `.claude/skills/brent-workspace/hubspot-contact-workflow.md` |

**Base Path:** `/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/`

**Backlog API:**
- Endpoint: `https://app.requestdesk.ai/api/backlog`
- Auth: `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`
- Add items: `/add-backlog <description> --priority N --tags tag1,tag2`

---

## WEEKLY CONTENT SCHEDULE (TWO SEPARATE ARTICLES)

**CRITICAL:** Tuesdays with Claude and LinkedIn Newsletter are COMPLETELY DIFFERENT content pieces.

| Day | Content | Platform | Type | Deadline Strategy |
|-----|---------|----------|------|-------------------|
| **Tuesday** | Tuesdays with Claude | Medium | Technical article | Ideally done Friday before |
| **Wednesday** | LinkedIn Newsletter | LinkedIn | Professional insights | Finish Monday for Wednesday |

### Content Rhythm by Day

| Day | Focus |
|-----|-------|
| **Monday** | Finish Wednesday's LinkedIn Newsletter, plan week |
| **Tuesday** | Tuesdays with Claude publishes (should be done already) |
| **Wednesday** | LinkedIn Newsletter publishes, rock work |
| **Thursday** | Rock work, Content in Commerce (bi-weekly noon) |
| **Friday** | Write NEXT Tuesday's article, capture ideas |

### Lead Time Goals

| Content | Ideal Lead Time | Why |
|---------|-----------------|-----|
| Tuesdays with Claude | Done Friday before | Buffer for edits, no Monday panic |
| LinkedIn Newsletter | Done Monday | Publishes Wednesday |
| Quarter planning | Full quarter outlined | Know all topics in advance |

---

## CONTENT LOCATIONS

| Content Type | Location |
|-------------|----------|
| Tuesdays with Claude | `Tuesdays with Claude/tuesdays-with-claude-[topic].md` |
| LinkedIn Newsletter | `LinkedIn Articles/[topic].md` |
| LinkedIn Posts | `Tuesdays with Claude/social-posts/linkedin-post-[topic].md` |
| Ideas | `idea-stash/` |
| Saved Prompts | `Saved Prompts/` |
| Content TODO | `Dashboard/CONTENT-TODO.md` |

---

## When Claude Should Apply This Skill

Apply this skill automatically when Brent:
- Asks about priorities, planning, or "what should I work on"
- Mentions Q1/Q2/Q3/Q4 planning, quarterly rocks, or OKRs
- Asks about content, articles, writing, or newsletters
- Mentions Tuesdays with Claude or LinkedIn Newsletter
- Asks about delegation or who can do what
- Mentions being stuck, overwhelmed, or having too many tasks
- Asks about weekend projects or optional work
- References HubSpot tasks, inbox, or daily non-negotiables
- Wants to capture an idea or add something to backlog

---

## Core Philosophy

1. **RequestDesk backlog = Source of truth** for all work items
2. **Every hour worked = backlog item** with points (velocity calibration)
3. **Two articles per week** - completely different content
4. **Lead time matters** - write ahead, not day-of
5. **Sprint-based work logs** - archived at sprint end with summary calculations

---

## Writing Voice Rules

**RULE: Include "AI would object" elements**

Brent's writing must contain elements that AI would typically smooth over, hedge, or remove. These are authenticity signals that prove a human wrote it.

**Include:**
- Snarky asides and parenthetical jabs
- Opinionated statements about vendors/trends
- Light humor that breaks polished tone
- Bold claims without excessive hedging
- Industry inside jokes

**Example (keep this):**
> "(unless you are Shopify then you specialize in every area)"

**Why this matters:** AI-generated content is too polished. It hedges everything, avoids opinions, and optimizes out personality. Human content has rough edges, takes sides, and includes the occasional zinger. These "flaws" are features.

**Terms to AVOID (AI tells on itself):**
- "actually"
- "Here's the thing" / "And here's what" / "Here's something"
- "The Real [X]" (e.g., "The Real Cost", "The Real Problem")
- "Here's Why It Matters"
- "The Reality Check"
- "The Contrarian Bet"
- "leverage" / "utilize"
- "game-changer" / "deep dive"
- "unpack" / "robust"
- "Nobody's Talking About"
- "Worth Watching"
- "I worked with..." (most overused AI phrase of 2025)
- Excessive hedging ("it might be worth considering...")
- Colons before explanations (use periods instead)

---

## Priority Framework (Quick Reference)

| Priority | Meaning | Action |
|----------|---------|--------|
| **P0** | Hard deadline exists | Must complete by date - no negotiation |
| **P1** | Q1 Rock / Critical | Weekly progress required |
| **P2** | Important but flexible | Schedule when P0/P1 clear |
| **P3** | Backlog / Nice-to-have | Only if time permits |

See `priority-framework.md` for full decision tree.

---

## Team & Delegation

| Person | Role | Can Handle |
|--------|------|------------|
| **Susan** | Execution | Documented processes, follow templates |
| **Vijay** | Lead Finding | Seamless.ai (1000/day), list building |
| **Writers** | Content | Article drafts with clear briefs |
| **Evrig** | Development | Dev work (has credit balance) |

See `delegation-rules.md` for what can be delegated.

---

## Critical Dates (Q1 2026)

| Date | Event | Priority |
|------|-------|----------|
| Feb 4 | MM26FL Workshop | P0 |
| Feb 23-26 | eTail Palm Springs | P0 |
| Mar 22 | Evrig "open selling" unlocks | P1 |
| Mar 24-26 | Shoptalk Spring | P0 |

---

## Supporting Files

- `accountability-mode.md` - How Claude keeps Brent on task
- `priority-framework.md` - Full P0/P1/P2/P3 decision framework
- `delegation-rules.md` - What can be delegated and to whom
- `weekend-mode.md` - Saturday/Sunday handling
- `content-schedule.md` - Detailed content expectations
- `media-properties.md` - Podcasts & LinkedIn Live shows

---

## Integration with Commands

- `/brent-start` - Daily kickoff ritual (loads this skill's full context)
- `/brent-finish` - End of day closeout
- `/brand-brent` - Load personal brand voice for content
- `/daily-content` - Quick content TODO review

---

## Accountability Mode (Always Active)

When Brent asks for something NEW while tasks are in progress, Claude MUST ask:

> "You have [X] task(s) in progress. If you switch to [NEW THING], you won't finish these today. Is [NEW THING] more important?"

See `accountability-mode.md` for full enforcement rules.
