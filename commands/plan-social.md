Plan Social Campaign - Multi-platform drip campaign planning, drafting, and scheduling

**SKILL:** This command is backed by the `social-campaign` skill at `.claude/skills/social-campaign/SKILL.md`

**USAGE:**
- `/plan-social` - Start a new social campaign (interactive discovery)
- `/plan-social [topic]` - Start with a topic in mind
- `/plan-social review [file]` - Review and revise an existing campaign draft

**PURPOSE:**
Plan and execute multi-platform social media drip campaigns. Handles the full workflow from idea to scheduled posts across LinkedIn, X, Bluesky, and Threads.

**WORKFLOW:**

1. **Discovery** - Ask complexity level (1-4), topic, audience, post count, cadence, platforms
2. **Arc** - Design the narrative arc, present to Brent for approval
3. **Draft** - Write LinkedIn versions first, then tailored versions for each platform
4. **Review** - Show all posts to Brent, handle revisions
5. **Schedule** - Schedule all approved posts via Vista Social API
6. **Save** - Save campaign file with all content and tracking tables

**COMPLEXITY LEVELS:**

| Level | Name | Posts | Description |
|-------|------|-------|-------------|
| 1 | Awareness | 3-5 | Informational, no landing page, soft/no CTA |
| 2 | Engagement | 5-8 | Drive conversation, links to existing content |
| 3 | Lead Gen | 8-12 | Traffic to landing page, hard CTAs, tracking |
| 4 | Full Funnel | 12-20 | Multi-stage with email/ads coordination |

**FIRST QUESTION IS ALWAYS COMPLEXITY LEVEL.** This determines everything else.

**CRITICAL RULES:**
- Load brand persona before writing anything
- No em dashes, no emojis in content
- Each platform gets a TAILORED version (not copy-paste)
- Never schedule without explicit "schedule" confirmation from Brent
- Write campaign file immediately as decisions are made
- Links go in Vista Social `comments` parameter, not message body

**REFERENCES:**
- Full skill docs: `.claude/skills/social-campaign/SKILL.md`
- Vista Social API: `.claude/skills/brent-workspace/vista-social.md`
- Single post scheduling: `/create-social`
