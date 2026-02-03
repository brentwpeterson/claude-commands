# EO Forum Skill

**Skill Description:** Manage EO (Entrepreneurs' Organization) Forum communications, meeting prep, and resources for Brent's Dreamweavers Forum.

## Quick Reference

| Item | Value |
|------|-------|
| **Forum Name** | Dreamweavers Forum |
| **Forum Email** | `[TO BE CONFIGURED]` |
| **EO Chapter** | Minnesota |
| **Obsidian Folder** | `/brent-workspace/ob-notes/Brent Notes/EO Material/` |
| **MyEO Portal** | https://my.eonetwork.org/ |
| **EO Global** | https://www.eonetwork.org/ |

---

## About EO (Entrepreneurs' Organization)

EO is a global, peer-to-peer network of 18,000+ entrepreneurs across 200+ chapters in 60+ countries. Founded in 1987.

**Membership requirements:**
- Founder, co-founder, owner, or controlling shareholder
- Business must gross $1M+ USD annually
- Under age 50 when joining (legacy members may be older)

**Core EO programs:**
- **Forum** - Small peer groups (6-10 members) for confidential, ongoing support
- **Learning Events** - Chapter and regional educational programs
- **Global Events** - EO University, Global Leadership Conference
- **MyEO Groups** - Online communities by interest/industry

---

## Forum Fundamentals

### What is Forum?

Forum is the heart of EO. A small group (ideally 8 members) that meets monthly for confidential peer support. Forum is NOT:
- A social group
- A networking club
- A friendship circle

Forum IS:
- An organized way to be vulnerable
- A place to talk about things you can't discuss with anyone else
- A commitment to personal and professional growth

### Forum Mindset (Gestalt)

| Element | Description |
|---------|-------------|
| **Peer** | Equal time for every member. All are capable. My answers are within. |
| **Shoshin** | Beginner's mind. Open, non-judgmental, eager curiosity. |
| **Share** | Share experiences, not advice. Resonance over relevance. Authentic and vulnerable. |
| **Humble** | No ego or pretense. No saving/solving/fixing. Not right/smarter/more successful. |
| **Listen** | With head and heart. With empathy to understand. For my own learning. |

### 5% Reflections

The core of every forum meeting. Members share what's in their "5%" - the things they don't typically talk about, even with close friends/family.

**The 3 Whys:** Ask "why is that significant?" 3 times to peel deeper layers.

**Resources:**
- [EO 5% Reflection Coach GPT](https://chatgpt.com/g/g-PoxLtTyMP)
- [5% Reflections Worksheet PDF](https://static1.squarespace.com/static/5f2e0768c214795764de6d9d/t/63e16327e005224118d0ffd1/1675715367962/5-percent+Reflections+Worksheet.pdf)

### Discussion vs Deep Dive

| Type | Focus | Topics | Outcome |
|------|-------|--------|---------|
| **Discussion** (IQ) | WHAT and HOW | Brainstorming, resources, accountability | Learning & new ideas |
| **Deep Dive** (EQ) | WHY | Unresolved, emotional, significant | Clarity, confidence, self-awareness |

Forum focuses on the WHY (EQ), not the What or How (IQ).

---

## Usage

### Send Forum Email

```
/eo-forum email "Subject line here"
```

Claude will:
1. Ask for email content or topic
2. Draft email in Brent's voice
3. Save draft to Obsidian `EO Material/emails-sent/`
4. Send via Gmail MCP (after approval)

### Meeting Prep

```
/eo-forum meeting-prep
```

Claude will help prepare for the next forum meeting:
- Review past meeting notes
- Suggest 5% reflection topics
- Prepare any presentations or deep dives

### Research EO Topics

```
/eo-forum research "topic"
```

Search EO resources, MyEO, and web for forum-related topics.

---

## Email Format

Forum emails should follow this structure:

```markdown
**To:** Dreamweavers Forum Members
**From:** Brent
**Date:** YYYY-MM-DD
**Subject:** [Clear, specific subject]

---

Hey everyone,

[Opening - context/reason for email]

## [Main Topic Heading]

[Content organized with headers, tables, bullet points as needed]

## [Optional: Ideas/Suggestions]

[If proposing something new]

## [Optional: For Discussion]

[Questions to discuss at next meeting]

[Warm closing]

Brent
```

### Email Style (Brent's Voice)

- Casual, collegial tone ("Hey everyone")
- No em dashes (use periods or commas)
- No emojis
- Direct but warm
- Tables for structured information
- Clear action items or discussion questions
- Sign off with just "Brent"

---

## Email Workflow

### Step 1: Draft in Obsidian

Save drafts to:
```
/brent-workspace/ob-notes/Brent Notes/EO Material/emails-sent/YYYY-MM-DD-topic.md
```

Include status tracker at bottom:
```markdown
## Email Status

- [ ] Draft complete
- [ ] Reviewed
- [ ] Sent
- [ ] Date sent: ____

## Notes

*Add any responses or follow-up notes here after sending*
```

### Step 2: Review and Approve

User reviews draft in Obsidian before sending.

### Step 3: Create Gmail Draft

Save to Gmail Drafts (NEVER send directly):

```
Use mcp__gmail__gmail_create_draft tool:
- to: brent@contentbasis.io, msigel@sofiascookies.com, randy@extremesandbox.com, paulj@breezynotes.com, james@boyswaterproducts.com, kathy@windmillstrategy.com, tom@waterfrontrestoration.com
- subject: [from draft]
- body: [plain text email body]
```

**IMPORTANT:** Always create draft. User reviews in Gmail and sends manually.

---

## Dreamweavers Forum Context

### Forum Details

| Item | Value |
|------|-------|
| **Forum Name** | Dreamweavers Forum |
| **Chapter** | EO Minnesota |
| **Size** | ~8 members (optimal) |
| **Meeting Frequency** | Monthly |
| **Brent's Role** | Member, attended 2026 Moderator Summit |

### Recent Activity

- **2026-01-16:** Sent email with Moderator Summit takeaways
- **2026-01:** Attended EO Moderator Summit in Las Vegas

### Ongoing Initiatives

From research queue:
- [ ] Implement One Word Open/Close at meetings
- [ ] Present Discussion vs Deep Dive framework
- [ ] Try Host Appreciation exercise
- [ ] Audit forum constitution for "Mustin language"
- [ ] Conduct forum health survey

---

## Obsidian Resources

| File | Description |
|------|-------------|
| `README.md` | Central hub for EO materials |
| `forum-meeting-guide.md` | How to run forum meetings |
| `eo-research-queue.md` | Questions and action items |
| `Moderator Summit 2026.md` | Raw notes from summit |
| `emails-sent/` | Archived email communications |
| `moderator material/` | PDFs from EO (summit playbook, constitution guide, etc.) |

---

## EO Terminology

| Term | Definition |
|------|------------|
| **5%** | The vulnerable topics members don't typically discuss |
| **Deep Dive** | Structured presentation focused on WHY (emotional) |
| **Discussion** | Group conversation focused on WHAT/HOW (tactical) |
| **Forum Mindset** | The 5 elements: Peer, Shoshin, Share, Humble, Listen |
| **Gestalt** | Another name for Forum Mindset |
| **Parking Lot** | Topics queued for future deep dives |
| **Clear Round** | Exercise for clearing the air / addressing unspoken issues |
| **Resonance** | Emotional connection (preferred over relevance) |
| **Shoshin** | Beginner's mind - open, curious, non-judgmental |
| **TSAR** | Optional role - person who asks probing questions during 5% |

---

## When Claude Should Apply This Skill

Apply this skill when user:
- Says `/eo-forum` or mentions EO/forum
- Wants to send email to Dreamweavers Forum
- Needs help with forum meeting prep
- Asks about EO concepts (5%, deep dive, gestalt, etc.)
- References the EO Material folder in Obsidian

---

## Related Resources

- **EO Global:** https://www.eonetwork.org/
- **MyEO Portal:** https://my.eonetwork.org/
- **EO 5% Coach GPT:** https://chatgpt.com/g/g-PoxLtTyMP
- **EO 360 Podcast:** https://entrepreneursorg.libsyn.com/

---

## Forum Members

| Name | Email | Note |
|------|-------|------|
| Brent Peterson | brent@contentbasis.io | (self) |
| Mark Sigel | msigel@sofiascookies.com | |
| Randy Stenger | randy@extremesandbox.com | |
| Paul Jonas | paulj@breezynotes.com | |
| James Boys | james@boyswaterproducts.com | |
| Kathy Mrozek | kathy@windmillstrategy.com | |
| Tom Suerth | tom@waterfrontrestoration.com | |

**All Recipients (for email):**
```
brent@contentbasis.io, msigel@sofiascookies.com, randy@extremesandbox.com, paulj@breezynotes.com, james@boyswaterproducts.com, kathy@windmillstrategy.com, tom@waterfrontrestoration.com
```
