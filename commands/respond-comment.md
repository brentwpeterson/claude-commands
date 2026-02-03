# Respond Comment Command

Draft a LinkedIn comment on someone else's post using Brent's voice, with HubSpot relationship context and Obsidian tracking.

## Usage

```
/respond-comment
```

User pastes a LinkedIn post (or provides author name + post text). This command walks through a 10-step workflow to craft a high-quality comment.

## Instructions for Claude

### Step 1: Parse Input

The user will paste a LinkedIn post or provide the author's name and post content.

Extract:
- **Author name** (the person who wrote the post)
- **Post content** (full text of the post)

If the input is ambiguous, ask the user to clarify who wrote the post and paste the full text.

Display:
```
### POST TO COMMENT ON

**Author:** [name]

[post content]
```

### Step 2: Load Engagement Patterns

Read the LinkedIn patterns file:
```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/LinkedIn Content/_linkedin-patterns.md
```

Load:
- Comment approach preferences (ranked by selection frequency)
- Phrases That Work
- Phrases Rejected/Edited
- Voice Consistency rules
- Post Type Response Patterns
- Edits & Refinements Log (for recent learnings)

Do NOT display the full file. Just confirm: "Loaded engagement patterns."

### Step 3: Check HubSpot for Relationship Context

Search HubSpot contacts by the author's name:
```
mcp__hubspot__hubspot-search-objects
  objectType: "contacts"
  query: "[author name]"
```

**If contact found:**
- Pull name, company, role/title
- Check for recent notes or engagements
- Check for deal history
- Check for any LinkedIn-specific notes

Display what was found:
```
### HUBSPOT CONTEXT

**Contact:** [name]
**Company:** [company]
**Role:** [title]
**Notes:** [relevant notes summary]
**Deals:** [any deal history]
```

**If not found:**
```
### HUBSPOT CONTEXT

No contact found for "[author name]" in HubSpot.
```

### Step 4: Ask for Additional Context

Show the HubSpot results (or "not found") and ask:

```
Any history with this person I should know?

Examples: work history together, personal connection, shared events,
mutual contacts, previous interactions, industry context, etc.

Type "none" to skip.
```

Wait for user response. This context is what elevates comments from generic to great (ref: JuanMa example where Wagento history transformed the comment).

### Step 5: Categorize the Post Situation

Based on the post content, categorize into one of:

| Situation | Signals |
|-----------|---------|
| **Career transition** | Layoff, new role, promotion, retirement |
| **Thought leadership** | Opinion, framework, advice, hot take |
| **Achievement celebration** | Award, milestone, launch, win |
| **Asking for advice** | Question, poll, seeking recommendations |
| **Controversial take** | Debate, pushback, unpopular opinion |
| **Industry news** | Company news, market shift, acquisition |
| **Personal milestone** | Birthday, anniversary, life event |
| **Other** | Doesn't fit above categories |

Display:
```
**Post type:** [situation]
```

If the categorization seems wrong, the user can correct it. Otherwise proceed.

### Step 6: Draft 3-4 Comment Options

Generate 3-4 comment options using:

**Inputs:**
- Patterns file preferences (weight toward more frequently selected approaches)
- Brand voice rules (from CLAUDE.md + patterns file)
- Rejected phrases list (hard avoid)
- Relationship context from Steps 3-4
- Situation-appropriate approach from patterns file

**Voice rules (non-negotiable):**
- No em dashes
- No emojis
- No restating/paraphrasing what the poster said (they know what they said)
- No "Actually" filler
- No parallel structure reversals ("weren't because of X, were despite X")
- No "That's not X. That's Y." AI pattern
- Lead with specific, not generic
- Concrete offers over vague helpfulness
- Short, punchy replies that make one sharp point
- If quoting the poster, use their exact words in quotes and credit them

**Format each option:**
```
### Option 1: [Approach Type] (~[character count] chars)

[comment text]

### Option 2: [Approach Type] (~[character count] chars)

[comment text]

### Option 3: [Approach Type] (~[character count] chars)

[comment text]
```

**Approach types to draw from** (weight by selection frequency in patterns file):
- Personal + Direct
- Respectful Challenge
- Add Perspective
- Ask Questions
- Share Resources
- Personal Support

Vary the options: different approaches, different lengths, different angles. At least one shorter option (~150 chars) and one medium option (~250-350 chars).

### Step 7: User Selects or Revises

Display:
```
**Options:**
1-[N]. Pick a comment option
E. Edit one of the options
R. Regenerate all options
C. Cancel
```

**If user picks a number:** Move to Step 8 with that option.

**If "Edit" (E):** Ask which option and what to change. Show revised version. Return to selection.

**If "Regenerate" (R):** Ask what direction to take, then generate new options. Return to selection.

**If "Cancel" (C):** "Comment cancelled." Stop.

### Step 8: Save to Obsidian

Save the comment to Obsidian automatically.

**File path:**
```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/LinkedIn Content/Comments/YYYY-MM-DD-{person-name-slug}-{topic-slug}.md
```

Where:
- `YYYY-MM-DD` is today's date
- `{person-name-slug}` is the author's name, lowercased, spaces replaced with hyphens
- `{topic-slug}` is a short (2-3 word) slug for the post topic

**File content:**
```markdown
---
title: "Comment on [Person]'s [Topic]"
type: linkedin-comment
date: YYYY-MM-DD
author: "[Person Full Name]"
status: draft
---

## Original Post

[full post text]

---

## My Comment

[selected comment text]

---

## Other Options Considered

### [Approach Type 1]
[option text]

### [Approach Type 2]
[option text]

[etc.]

---

## Notes

[HubSpot context if found]
[User-provided context from Step 4]
[Any other relevant notes]
```

### Step 9: Update Patterns File

Update the patterns file at:
```
/Users/brent/scripts/CB-Workspace/brent-workspace/ob-notes/Brent Notes/LinkedIn Content/_linkedin-patterns.md
```

**Updates to make:**

1. **Increment approach count:** In the "Comment Preferences > Approach Preferences" table, increment the "Times Selected" count for the approach type that was chosen.

2. **Add phrases that worked:** If the selected comment used a particularly good phrase or pattern, add it to "Phrases That Work."

3. **Update situation patterns:** In "Post Type Response Patterns," if this situation type has a "TBD" entry, update it with the approach used and reference this comment.

4. **Log edits:** If the user edited the draft (Step 7), add an entry to "Edits & Refinements Log" with:
   - Date
   - Type: Comment
   - What was changed and why
   - Learning for next time

### Step 10: Confirm

Display:
```
### FINAL COMMENT (copy and paste to LinkedIn)

---
[final comment text]
---

Saved to: [obsidian file path]
Patterns file updated.

Copy the comment above and paste it on LinkedIn.
```

---

## What This Command Does NOT Do

- Does not post to LinkedIn (no API available)
- Does not handle replies to comments on Brent's own posts (future scope)
- Does not handle DMs (future scope)

---

*Command created: 2026-01-28*
