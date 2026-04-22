# Buzz LinkedIn - Inbox Management & Response Skill

## Purpose
Manage Brent's Buzz.ai LinkedIn inbox. Read unread messages, draft responses in Brent's voice, and send after approval.

## Buzz API Details
- **Space ID:** `6447f221ca1ed33383c8765a`
- **Credentials ID:** `644848bf004b24e965e10963`
- **Account:** Brent W Peterson (brent@contentbasis.io)

## Brent's Response Style (LinkedIn Messages)
- Casual, warm, professional. First-name basis.
- Short messages. LinkedIn is not email. 2-4 sentences max.
- No em dashes. No emojis (unless the other person used them first, then sparingly).
- No corporate speak. No "I wanted to reach out" or "Hope this finds you well."
- Sounds like a real person, not a template.
- Reference something specific about them or their company when possible.
- Ask a question to keep the conversation moving.

## Calendly Link
- **URL:** https://calendly.com/contentbasis/chat-with-brent
- **RULE:** Do NOT automatically share this link with everyone.
- **When to share:** Only when Brent explicitly approves sharing it, OR when someone has clearly expressed interest in a call/meeting and the conversation is warm enough.
- **How to share:** Casually, not formally. Example: "Here's my calendar if you want to grab a time: [link]"
- **Never say:** "Please use my scheduling link" or "Book a time at your convenience" (too corporate).

## Workflow for Processing Inbox

### Step 1: Fetch unread messages
```
buzz_get_inbox(space, credentials_id, unread_only=true)
```

### Step 2: Categorize and filter
Before drafting, split into categories:
- **THEM replied** (last message is from them) = needs a draft response
- **ME replied** (last message is from Brent) = no response needed, skip
- **SKIP** = spam, irrelevant pitches, just emoji with no context, phone numbers with no context

### Step 3: Draft all responses at once
Do NOT go one-by-one in conversation. Draft ALL responses and write them to an **Obsidian review file**.

### Step 4: Write review file to Obsidian
**Location:** `brent-workspace/ob-notes/Brent Notes/Dashboard/Daily/buzz-inbox-drafts-YYYY-MM-DD.md`

**Format:** Single grid table with clickable LinkedIn profile links:

```markdown
| # | Name | Company | Their Message | Draft Reply |
|---|------|---------|---------------|-------------|
| 1 | [First Last](https://linkedin.com/in/slug) | Company | Their message summary | Draft reply text |
```

Include sections for:
- **ALREADY SENT** (if any were sent this session)
- **SKIP** (with reason: spam, irrelevant, just emoji, etc.)
- **NO RESPONSE NEEDED** (last message was from Brent)
- **DRAFTS** (the main review grid)

### Step 5: Brent reviews in Obsidian
- Brent reads the grid, clicks LinkedIn profiles to check context
- Edits draft replies directly in the file
- Tells Claude which to send, edit, or skip

### Step 6: Send approved messages
Use curl (MCP server needs restart for credentials_id fix):
```bash
curl -s -X POST "https://api.buzz.ai/public_api/profiles/{profile_id}/send_message?space={space}&credentials_id={credentials_id}" \
  -H "Authorization: Bearer $BUZZ_AI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"text":"message text", "credentials_id":"644848bf004b24e965e10963"}'
```
Note: credentials_id must be in BOTH query params AND body.

### Step 7: Mark skipped/irrelevant messages as read
```
buzz_mark_read(profile_id, space, credentials_id)
```

## API Quirks (learned 2026-03-12)
- `buzz_send_message` requires `credentials_id` in both query params AND request body
- The MCP server was missing credentials_id on send_message (fixed in source, needs server restart to take effect)
- `buzz_get_conversation` returns profile metadata + last_message, NOT full message threads. Work from `last_messages` field.
- Buzz API `statuses=["unread"]` filter does NOT work. MCP server handles this with client-side filtering by `unread_count > 0`.
- Rate limiting exists (got 403 when hitting API too fast). Space out bulk sends.

## What NOT to do
- Do NOT present drafts one-by-one in conversation (too slow for 30+ messages)
- Do NOT send messages without Brent reviewing the full batch first
- Do NOT share Calendly link with everyone automatically
- Do NOT draft responses for messages where Brent sent the last message
- Do NOT respond to obvious spam/book pitches/irrelevant messages
- Do NOT default to sending Calendly. The default is NO Calendly. Only include it when someone has explicitly asked to meet/chat AND the conversation is warm.
- Do NOT re-share an article link. If Brent already shared it and they haven't read it yet, the follow-up is "Did you get a chance to read it? Would love to hear what you think." NOT another link drop.

## What TO do
- Always include LinkedIn profile links so Brent can click through and check context
- Use the grid format in Obsidian for easy scanning
- Group by category (sent, skip, no response needed, drafts)
- Let Brent review the whole batch at once, then bulk send approved ones
- Note vacation/availability context in drafts when scheduling

## Temporary Context (update as needed)
- No current vacation/travel conflicts.

## Active Outreach Campaigns

### Shopify Agency Feedback Campaign (2026-03-25)
**Goal:** Get feedback on RequestDesk Shopify connector from Shopify agency owners/partners. Not a sales pitch.
**Landing page:** requestdesk.ai/integrations/shopify/ (has video walkthrough)
**Placeholders:** Use `{first_name}` format in templates.

**Connection Request (300 char limit):**
> Not a pitch. I built something for Shopify stores and I need agency eyes on it before launch. It generates blog content from product data while keeping brand voice consistent. Would love your feedback.

**Follow-up #1 (after they accept):**
> Thanks for connecting, {first_name}
>
> Here's what I built: requestdesk.ai/integrations/shopify/
>
> There's a video on the page that walks through it.
>
> Short version: it connects to Shopify, pulls product data, and generates blog content that stays on brand. Posts drop as drafts so nothing publishes without approval.
>
> Would love to hear what you think. Happy to do a live demo if you want to see it in action.

**Follow-up #2A (they clicked the link, no reply after 5-7 days):**
> Hey {first_name}, saw you checked out the page. What did you think? Anything jump out, good or bad? Would love to walk you through a live demo if you want to see it in action.

**Follow-up #2B (they didn't click, no reply after 5-7 days):**
> Hey {first_name}, just bumping this. No pressure at all. If you get a chance to watch the video I'd really value your take on it, especially whether it fits how your agency clients think about content.

---

## Response Templates (guidelines, not copy-paste)

**Someone wants to chat:**
> Hey [Name], would love to chat! I'm out next week but here's my calendar if you want to grab a time the week after: [calendly link]

**Positive but vague reply (thumbs up, "sounds good"):**
> Awesome! [Ask a specific question about their work or company to move the conversation forward]

**They mentioned your article/podcast:**
> Glad you enjoyed it! [Reference something specific about them]. Would love to hear your take on [relevant topic].

**New connection, no message yet:**
> Hey [Name], thanks for connecting! [Something specific about their role/company]. [Question to start conversation].

**Someone on vacation / scheduling conflict:**
> No rush! [Match their timeline]. Looking forward to connecting.
