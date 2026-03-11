# Evrig Sales Collaboration Skill

**Skill Description:** CommerceKing x Evrig partnership management. Daily communication, action plan tracking, launch coordination, and joint sales workflow for the LoopStack product launch.

---

## When Claude Should Apply This Skill

Apply automatically when:
- Drafting or reviewing Evrig daily status emails
- Working on CommerceKing or LoopStack tasks
- User mentions Vijay, Sanjay, Rushi, David Arago, or Evrig
- Updating the action plan or launch timeline
- Preparing for Thursday weekly sales sync
- Working on client reactivation or joint outreach
- Any `/brent-start` or `/brent-finish` Evrig email step

---

## Team Roster

| Name | Company | Role | Email | Notes |
|------|---------|------|-------|-------|
| **Brent Peterson** | CommerceKing | Sales, Strategy, Brand, PM | brent@contentbasis.io | Counterpart to Vijay |
| **Vijay** | Evrig | Leader, Dev Delivery, Strategy | vijay@evrig.com | Brent's partner since 2013 |
| **Sanjay** | Evrig | Technology, Architecture | sanjay@evrig.com | Technical lead |
| **Rushi** | Evrig | Sales Support | TBD | Helping Brent with sales outreach |
| **David Arago** | CommerceKing | Sales | TBD | Spain/England summer sales |
| **Isaac** | Content Cucumber | Content | - | Content Flywheel, email sequences |

---

## Source of Truth

### Shared Vault (Evrig-Cucumber)

Shared Obsidian vault synced via Google Shared Drive. Both teams have access.

**Vault path:** `/Users/brent/Library/CloudStorage/GoogleDrive-brent@contentbasis.io/Shared drives/Evrig-Cucumber`

| Folder | Contents |
|--------|----------|
| `Action Plans/` | Strategic plans, launch timelines, phase tracking |
| `Sales Meetings/` | Weekly sync agendas, notes, action items |
| `Cold Email Outbound/` | Sequences, ICP targeting, Instantly campaigns |
| `ICPs & Prospects/` | Ideal customer profiles, prospect lists, segmentation |
| `CommerceKing Brand/` | LoopStack positioning, brand bible, pitch decks |
| `Meeting Notes/` | Ad-hoc meeting notes, call summaries, Fireflies transcripts |

### Brent-Only (Private)

Files that stay in Brent's personal vault (not shared with Evrig):

**Brand bible:** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/brands/commerceking.md`
**ICPs (internal):** `brent-workspace/ob-notes/Brent Notes/Sales and Marketing/ICPs/commerceking/`

**Always read the action plan before any Evrig-related work.** Status lives there, not in context files.

---

## LoopStack Product Reference

**LoopStack** is CommerceKing's core product. One integrated offering, four pillars.

| Pillar | What | Who Delivers |
|--------|------|-------------|
| **Build** (Development) | Platform builds, migrations, integrations | Evrig (Vijay/Sanjay) |
| **Fill** (Content) | Product descriptions, blogs, case studies | Content Cucumber (Isaac) |
| **Grow** (Growth Marketing) | Outbound campaigns, HubSpot, lead gen | Brent + Rushi |
| **Automate** (AI Automation) | AI workflows, content automation, Claude Code | Brent + Sanjay |

**Tagline:** "LoopStack. Build. Fill. Grow. Automate."

**Elevator pitch:** "LoopStack is CommerceKing's full-stack commerce service. We build your store, fill it with content, grow your traffic, and automate the whole thing. One team, one invoice, four capabilities. The loop never stops."

**Pricing:** Build as we go. No fixed packages. Discovery call determines scope. Base rate: $200/hr.

---

## Daily Email Workflow

### Morning (brent-start punch list)

**When triggered:** User picks "Draft Evrig daily email" from punch list.

1. **Read action plan** to get current item statuses
2. **Calculate launch countdown:** Days until March 22, 2026
3. **Check Gmail for Evrig responses:**
   ```
   mcp__gmail__gmail_search
     query: "from:evrig.com"
     maxResults: 10
   ```
4. **Identify items due today or overdue** from action plan phase tables
5. **Draft email** (NEVER send):
   ```
   mcp__gmail__gmail_create_draft
     to: ["vijay@evrig.com"]
     subject: "LoopStack Launch - Day [X] of 17 - [Key Topic]"
     body: [use template below]
   ```
6. **Report:** "Evrig daily email drafted. Review and send when ready."

### Evening (brent-finish)

1. **Check Gmail for Evrig responses received today:**
   ```
   mcp__gmail__gmail_search
     query: "from:evrig.com newer_than:1d"
     maxResults: 10
   ```
2. **Summarize any responses** to Brent
3. **Update action plan** if any items were answered/completed
4. **Flag unanswered items** that are overdue

### Email Template

```
Hi Vijay / Team,

STATUS:
- [What was completed since last email]
- [What's in progress]

ACTION ITEMS (your team):
- [Item] - [Owner] - Due [Date]
- [Item] - [Owner] - Due [Date]

DECISIONS NEEDED:
- [Question that needs an answer]

NEXT SYNC: Thursday 10am CST

- Brent
```

### Email Rules

- ALWAYS create draft. NEVER send without explicit "send it" from Brent.
- Only include Evrig team action items (Vijay, Sanjay, Rushi, David). Brent's items are internal.
- If no updates since yesterday, still draft: "No changes. Staying on track for [next milestone]."
- After launch (March 22+), shift to weekly cadence instead of daily.
- Apply `/brand-brent` voice: no em dashes, no emojis, direct and professional.

---

## Weekly Sales Sync (Thursdays 10am CST)

**Attendees:** Brent, Vijay, Isaac, David (and others as needed)
**Fireflies:** Meeting is recorded. Transcript syncs via `/brent-start` Fireflies step.

### Pre-Meeting Prep (Thursday morning)

When Thursday routine runs:

1. Read action plan for current status across all phases
2. Compile list of open/overdue items by owner
3. Check if any open questions from Q-table have been answered
4. Review last week's meeting notes for unresolved items
5. Draft a 1-page agenda:

```
WEEKLY SALES SYNC - [DATE]
LoopStack Launch: Day [X] of 17

LAST WEEK:
- [Completed items]

THIS WEEK:
- [Items due this week]

BLOCKED/OVERDUE:
- [Items past due, by owner]

DECISIONS NEEDED:
- [Open questions requiring group input]

AGENDA:
1. [Topic from action plan]
2. [Topic from action plan]
3. Open floor
```

Save agenda to: `Evrig-Cucumber/Sales Meetings/[DATE]-weekly-sales-agenda.md`

### Post-Meeting

After Fireflies transcript is available:
1. Download and save via standard Fireflies workflow
2. Extract action items, update action plan
3. Log decisions in the Decision Log table
4. Update team roster if new people join

---

## Action Plan Management

### Updating Item Status

When Brent confirms an item is done:
1. Change status from `pending` to `done` in the action plan table
2. Add completion date to Notes column
3. Log in Changelog table at bottom of action plan

### Adding New Items

When new items come from meetings or emails:
1. Add to the appropriate phase table
2. Assign owner and due date
3. Number sequentially within the phase (e.g., 2.9 for Phase 1 Week 2)

### Phase Tracking

| Phase | Dates | Goal |
|-------|-------|------|
| 1: Pre-Launch Foundation | Mar 5-14 | Building blocks in place |
| 2: Pre-Launch Polish | Mar 17-21 | Everything tested and ready |
| 3: Launch | Mar 22 | Go live |
| 4: Shoptalk + Post-Launch | Mar 24+ | Work the floor, follow up |

---

## Client Reactivation Campaign

**Target:** ~1,000 lapsed Content Cucumber and Evrig clients.

**Approach:**
- Cross-reference CC client list + Evrig client list + Guillermo's 4,500 contact list + Wagento network
- Build combined prospect list in HubSpot
- Free trial offer to re-engage
- Use HubSpot sequences for outreach cadence

**HubSpot Setup:**
- CommerceKing contact properties (to be created)
- Smart lists for CK prospects vs CC-only vs Evrig-only
- Pipeline stages for CK deals

**Owner:** Rushi + Brent (Build list), Brent (HubSpot setup), Isaac (Email sequences)

---

## Communication Preferences

| Channel | Use For |
|---------|---------|
| **Email** (vijay@evrig.com) | Daily updates, action items, formal communication |
| **Thursday Sync Call** | Strategy, decisions, blockers |
| **TBD** | Vijay to confirm: Slack, WhatsApp, or email-only (Open Question Q7) |

---

## MCP Tools Reference

### Instantly (Cold Email Campaigns)

Use for managing outbound campaigns, leads, and sending accounts.

| Tool | When to Use |
|------|-------------|
| `mcp__instantly__instantly_list_campaigns` | See all active/paused campaigns |
| `mcp__instantly__instantly_get_campaign` | Get campaign details (sequences, settings) |
| `mcp__instantly__instantly_get_campaign_status` | Check sends, opens, replies for a campaign |
| `mcp__instantly__instantly_launch_campaign` | Launch a campaign (only after Brent approves) |
| `mcp__instantly__instantly_pause_campaign` | Pause a campaign |
| `mcp__instantly__instantly_list_leads` | List leads in a campaign |
| `mcp__instantly__instantly_add_lead` | Add a lead to a campaign (Rushi stages, Brent approves) |
| `mcp__instantly__instantly_get_lead` | Check lead status |
| `mcp__instantly__instantly_update_lead` | Update lead info |
| `mcp__instantly__instantly_delete_lead` | Remove a lead |
| `mcp__instantly__instantly_list_accounts` | List sending accounts |
| `mcp__instantly__instantly_get_account` | Get account details |
| `mcp__instantly__instantly_get_account_status` | Check account health/warmup |
| `mcp__instantly__instantly_get_analytics` | Campaign analytics (opens, clicks, replies) |
| `mcp__instantly__instantly_get_analytics_summary` | High-level analytics overview |

**Workflow:**
1. Rushi sources contacts and stages in Google Sheets
2. Brent/Isaac approve email sequences
3. Rushi loads leads into Instantly (`instantly_add_lead`)
4. Brent launches campaign (`instantly_launch_campaign`)
5. Rushi monitors replies, Brent handles qualified leads

### Fireflies (Meeting Transcripts)

Use for pulling transcripts from weekly sales syncs and ad-hoc calls.

| Tool | When to Use |
|------|-------------|
| `mcp__fireflies__fireflies_list_transcripts` | Find recent meeting transcripts |
| `mcp__fireflies__fireflies_get_transcript` | Pull full transcript text |
| `mcp__fireflies__fireflies_get_summary` | Get AI summary of a meeting |
| `mcp__fireflies__fireflies_search_transcripts` | Search across all transcripts by keyword |
| `mcp__fireflies__fireflies_delete_transcript` | Remove a transcript |

**Workflow:**
1. After Thursday sales sync, search for the transcript
2. Pull summary and extract action items
3. Update action plan in shared vault
4. Save meeting notes to `Evrig-Cucumber/Sales Meetings/`

### Gmail (Daily Communication)

Already documented in Daily Email Workflow section above. Key tools:

| Tool | When to Use |
|------|-------------|
| `mcp__gmail__gmail_search` | Find Evrig emails (`from:evrig.com`) |
| `mcp__gmail__gmail_get_email` | Read a specific email |
| `mcp__gmail__gmail_get_thread` | Read full email thread |
| `mcp__gmail__gmail_create_draft` | Draft replies (NEVER send without approval) |
| `mcp__gmail__gmail_send_draft` | Send a draft (ONLY when Brent says "send it") |

### HubSpot (CRM and Pipeline)

| Tool | When to Use |
|------|-------------|
| `mcp__hubspot__hubspot-search-objects` | Search contacts, deals, companies |
| `mcp__hubspot__hubspot-batch-create-objects` | Bulk create contacts from prospect lists |
| `mcp__hubspot__hubspot-list-objects` | List pipeline deals |
| `mcp__hubspot__hubspot-create-engagement` | Log calls, meetings, notes |
| `mcp__hubspot-extended__hubspot_enroll_in_sequence` | Enroll contacts in outreach sequences |
| `mcp__hubspot-extended__hubspot_list_sequences` | View available sequences |

**Workflow:**
- Qualified Instantly replies become HubSpot deals
- Brent + Isaac take discovery meetings
- Log all meetings as engagements
- Track pipeline in CommerceKing deal stages

### Slack (if confirmed as communication channel)

Pending Q7 resolution. If Vijay confirms Slack:

| Tool | When to Use |
|------|-------------|
| `mcp__slack__slack_list_channels` | Find Evrig shared channel |
| `mcp__slack__slack_get_channel_history` | Read recent messages |
| `mcp__slack__slack_post_message` | Post updates (with Brent approval) |
| `mcp__slack__slack_get_thread_replies` | Follow conversation threads |

---

## Integration with Other Skills/Commands

| Skill/Command | When to Use |
|---------------|-------------|
| `/brent-start` | Morning Evrig email draft (punch list item) |
| `/brent-finish` | Evening Evrig response check |
| `/brand-brent` | Before writing ANY client-facing CommerceKing content |
| `/hubspot-sales` | When working CK leads in HubSpot |
| `/send-email` | When Brent approves sending the daily email |
| `hubspot-partner` | Evrig as a services partner reference |

---

## Open Questions (from Action Plan)

Track these until resolved. Check status at each Thursday sync.

| # | Question | For | Status |
|---|----------|-----|--------|
| Q1 | Pricing: hourly only or project-based too? Minimums? | Vijay | open |
| Q2 | Rushi's email address? | Vijay | open |
| Q3 | Is Vijay attending Shoptalk Mar 24-26? | Vijay | open |
| Q4 | What platforms does Evrig NOT support? | Sanjay | open |
| Q5 | Discovery call flow: Vijay/Sanjay join technical calls? | Vijay | open |
| Q6 | Existing Evrig marketing materials? | Vijay | open |
| Q7 | Preferred communication channel? | Vijay | open |

**When a question is answered:** Update both this table AND the action plan's Open Questions table.

---

*Last Updated: 2026-03-09*
