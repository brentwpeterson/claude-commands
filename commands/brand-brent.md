# Brand: Brent Peterson - Load Personal Brand Persona

Fetch Brent Peterson's personal brand persona for consistent voice when creating content (blog posts, LinkedIn, Tuesdays with Claude, etc.).

## Usage

```
/brand-brent
```

## Instructions for Claude

When this command is run:

### Step 1: Fetch Brand Persona

```bash
curl -s -X POST "https://app.requestdesk.ai/api/agent/content" \
  -H "Authorization: Bearer WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg" \
  -H "Content-Type: application/json"
```

### Step 2: Parse and Summarize

After fetching, parse the JSON and present a concise summary:

**Format your summary as:**

```
## Brent Peterson Brand Persona Loaded

### Who Is Brent?
[2-3 sentence summary of Brent's professional identity and perspective]

### Voice Guidelines
**Avoid:** [List 5-7 key phrases/patterns to never use]
**Use:** [List 5-7 preferred phrases/patterns]

### Tone
[Brief description of tone: honest, practical, self-deprecating humor, etc.]

### Writing Style
[Key characteristics: interview format, shows real work, admits mistakes, etc.]

### Target Audience
[Who Brent writes for: commerce professionals, developers, AI-curious practitioners]

---
✅ Ready to create content as Brent Peterson
```

### Step 3: Confirm Ready

After the summary, ask:
```
What content would you like me to help create?
```

## What This Enables

With Brent's persona loaded, Claude can:
- Write Tuesdays with Claude articles in Brent's authentic voice
- Create LinkedIn posts matching his professional tone
- Generate technical content that's honest about limitations
- Maintain the "I'm learning alongside you" perspective
- Use appropriate self-deprecating humor
- Keep content practical and actionable, not theoretical
- Match the interview/conversational style when appropriate

## When to Use

- **Tuesdays with Claude** articles
- **LinkedIn** posts and comments
- **Blog posts** on personal topics
- Any content where Brent is the author (not RequestDesk brand content)

## Platform-Specific Formatting

### LinkedIn Posts
**IMPORTANT:** LinkedIn does NOT support markdown. When creating LinkedIn content:
- No code blocks (```) - use plain text for commands
- No bold (**text**) or italic (*text*) markers
- No headers (#, ##)
- No bullet point markdown (use line breaks instead)
- Links go in comments, not the post body
- Keep commands on their own line for readability
- Hashtags at the end, separated by spaces

## API Details

### Read Brand Persona (includes terms)
- **Endpoint:** `https://app.requestdesk.ai/api/agent/content`
- **Method:** POST
- **Auth:** Bearer token
- **Key:** `WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg`

### Content Terms API

RequestDesk provides two endpoints for managing content terms:

| Function | Endpoint | Purpose |
|----------|----------|---------|
| Check/List | `/api/typingmind/proxy/terms-checker` | Analyze text for violations OR list all terms |
| Add | `/api/typingmind/proxy/content-terms` | Add new avoid/use/conditional terms |

---

### Checking Content for Violations

Run any content through the terms checker before publishing:

```bash
curl -X POST "https://app.requestdesk.ai/api/typingmind/proxy/terms-checker" \
  -H "Authorization: Bearer WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg" \
  -H "Content-Type: application/json" \
  -d '{
    "text": "[content to check]",
    "include_global": true
  }'
```

**Response includes:**
- `avoid_terms_found` - Violations to fix (with context explaining why)
- `conditional_terms` - May be okay depending on usage
- `use_terms_found` - Good! Recommended terms you used
- `use_terms_missing` - Suggestions to incorporate

**When violations are found:**
1. Identify exact phrases that violate guidelines
2. Explain WHY using the context from the response
3. Provide concrete rewrites - don't just swap words, restructure sentences
4. For conditional terms, check if context is appropriate

---

### Listing Configured Terms

View all terms at any time:

```bash
curl -X POST "https://app.requestdesk.ai/api/typingmind/proxy/terms-checker" \
  -H "Authorization: Bearer WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg" \
  -H "Content-Type: application/json" \
  -d '{"list_mode": "alllist"}'
```

**Modes:** `avoidlist` | `uselist` | `conditionallist` | `alllist`

---

### Adding New Terms

When you notice patterns that should be tracked:

**Step 1: Ask first**
```
I noticed "[phrase]" weakens your voice. Should I add this to your avoided terms?
```

**Step 2: If approved, add it**
```bash
curl -X POST "https://app.requestdesk.ai/api/typingmind/proxy/content-terms" \
  -H "Authorization: Bearer WOfNoONZNyPOEja1-ClY2-3e6_J-aK28PtUWr4DLRyg" \
  -H "Content-Type: application/json" \
  -d '{
    "term": "[phrase]",
    "term_type": "avoid",
    "context": "[Why it weakens the voice]"
  }'
```

**Term types:** `avoid` | `use` | `conditional`

**Step 3: Confirm**
```
Added "[phrase]" to avoided terms. It will be flagged in all future content.
```

**When to suggest adding terms:**
- You rewrote a sentence because it sounded too generic/AI
- User says "I hate that phrase" or "never write that"
- Same weak pattern keeps appearing across drafts
