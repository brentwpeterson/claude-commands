# Resume Instructions: Brent's Operating System

**Saved:** December 31, 2025
**Project:** brent-writing
**Session Focus:** Building Brent's personal operating system for daily planning, content, and sales tracking

---

## WHAT WE BUILT TODAY

### 1. Daily Operating System Structure

Created a complete goal hierarchy aligned with EOS:
- Quarterly Rocks → Weekly Scorecard → Daily Tasks
- Integrated with HubSpot, planned for Fireflies, Buzz.ai

### 2. Files Created/Updated

| File | Location | Purpose |
|------|----------|---------|
| `QUARTERLY-ROCKS.md` | `brent-writing/ob-notes/Brent Notes/` | Q1 2026 rocks with Rock #1 defined |
| `WEEKLY-SCORECARD.md` | `brent-writing/ob-notes/Brent Notes/` | Weekly metrics tracking |
| `CONTENT-TODO.md` | `brent-writing/ob-notes/Brent Notes/` | Content-specific tasks |
| `INTEGRATION-SETUP.md` | `brent-writing/ob-notes/Brent Notes/` | Integration status checklist |
| `CONTENT-CUCUMBER-VTO.md` | `brent-writing/ob-notes/Brent Notes/` | Full VTO + SWOT + goals |
| `LINKEDIN-ADS-PLAYBOOK.md` | `brent-writing/ob-notes/Brent Notes/` | Step-by-step LinkedIn Ads guide |

### 3. Commands Created/Updated

| Command | Location | Purpose |
|---------|----------|---------|
| `/brent-start` | `.claude/commands/brent-start.md` | Daily session kickoff |
| `/daily-content` | `.claude/commands/daily-content.md` | Content planning |

### 4. Integrations

| Integration | Status | Details |
|-------------|--------|---------|
| **HubSpot** | 🟢 Connected | Token in `.mcp.json`, 620 open tasks found |
| Fireflies | 🔴 Pending | Need API key |
| Buzz.ai | 🔴 Pending | Need to check API access |
| LinkedIn Ads | 🔴 Manual | Using playbook for manual tracking |

---

## ROCK #1: LinkedIn Lead Generation

**Goal:** 30 meetings booked in Q1 2026 (10 new clients needed)

**Two Channels:**
1. LinkedIn Paid Ads - Using LINKEDIN-ADS-PLAYBOOK.md
2. Buzz.ai Direct Outreach - Pending integration

**5 Ad Angles Ready:**
1. Scale Without Hiring
2. E-commerce Expertise
3. AI + Human (Counter Commoditization)
4. Fractional Marketing
5. Agency White Label

---

## NEXT STEPS (Priority Order)

1. **RESTART CLAUDE CODE** - Activate HubSpot MCP
2. **Choose LinkedIn Ads offer** - Content Audit, Strategy Session, or Case Study?
3. **Fill in Q1 rocks** - User needs to add remaining rocks beyond Rock #1
4. **Connect Fireflies** - Just need API key
5. **Launch first LinkedIn campaign** - Follow playbook

---

## KEY CONTEXT

### Content Cucumber VTO Summary

- **Core Focus:** Make the internet a better place through data-driven storytelling
- **3 Uniques:** Proprietary AI Tools, Human Writing Team that Scales, Ecommerce Specialization
- **Q1 2026 Target:** 10 new clients, $120K revenue
- **Weakness being addressed:** "Sales are not systemized" → Rock #1 fixes this

### The Math

```
Q1 Goal: 10 new clients
Rock #1: 30 meetings
Close rate needed: 33%
Weekly target: 2-3 meetings/week
```

---

## FILES TO READ ON RESUME

```bash
# 1. VTO (full business context)
cat "/Users/brent/scripts/CB-Workspace/brent-writing/ob-notes/Brent Notes/CONTENT-CUCUMBER-VTO.md"

# 2. Quarterly Rocks
cat "/Users/brent/scripts/CB-Workspace/brent-writing/ob-notes/Brent Notes/QUARTERLY-ROCKS.md"

# 3. LinkedIn Ads Playbook
cat "/Users/brent/scripts/CB-Workspace/brent-writing/ob-notes/Brent Notes/LINKEDIN-ADS-PLAYBOOK.md"

# 4. Integration Status
cat "/Users/brent/scripts/CB-Workspace/brent-writing/ob-notes/Brent Notes/INTEGRATION-SETUP.md"
```

---

## MCP CONFIG STATUS

`.mcp.json` now includes:
- memory (working)
- hubspot (added today - restart needed)

---

## HUBSPOT FINDINGS

- 620 open tasks
- Many HIGH priority tasks from May 2025
- Tasks include: Follow-ups, proposals, content creation, outreach

---

## TO CONTINUE THIS WORK

1. Run `/brent-start` to get daily dashboard
2. Or ask about specific areas:
   - "Let's work on LinkedIn Ads"
   - "Show me HubSpot tasks" (after restart)
   - "Help me fill in Q1 rocks"
   - "Let's set up Fireflies"
