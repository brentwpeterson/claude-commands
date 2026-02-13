# Commerce Reporting - eCommerce Industry Analysis for LinkedIn

**Skill Description:** Create LinkedIn posts that analyze eCommerce earnings, industry news, platform shifts, and commerce trends with Brent's hot take angle.

## CRITICAL RESOURCES

| Resource | Location |
|----------|----------|
| **Industry Network** | `.claude/skills/industry-network/SKILL.md` |
| **Brand Voice (Brent)** | `.claude/skills/brand-brent/SKILL.md` |
| **Content Terms API** | `GET https://app.requestdesk.ai/api/public/content-terms` |
| **Brand Persona API** | `POST https://app.requestdesk.ai/api/agent/content` |
| **Vista Social Skill** | `.claude/skills/brent-workspace/vista-social.md` |
| **Create Social Command** | `.claude/commands/create-social.md` |
| **Example Post** | `ob-notes/Brent Notes/Brent Social Posts/Linkedin/` |
| **Save Location** | `ob-notes/Brent Notes/Brent Social Posts/Linkedin/` |

---

## Report Types

### 1. Earnings Recap
Quarterly/annual results from commerce platforms (Shopify, Adobe, BigCommerce, Salesforce Commerce, etc.)

**Sources:** Earnings calls, investor decks, analyst recaps (Cleveland Research, Forrester, etc.), SEC filings, press releases

**What to include:**
- Revenue, GMV, growth rate YoY
- Comparison to competitors (put numbers in context)
- Enterprise wins (named brands if public)
- AI/tech initiatives
- Headcount changes (efficiency story)
- What it means for agencies/merchants

### 2. Industry News
Acquisitions, partnerships, product launches, platform shifts.

**Sources:** Press releases, TechCrunch, Practical Ecommerce, Digital Commerce 360, company blogs

**What to include:**
- What happened (facts first)
- Why it matters for merchants
- Who wins and who loses
- What agencies/brands should do about it

### 3. Trend Analysis
Data-driven observations about where commerce is heading.

**Sources:** Industry reports, GMV data, adoption curves, survey data, conference takeaways

**What to include:**
- The trend with supporting data
- Why now (what changed)
- Who's ahead and who's behind
- Practical implications

### 4. Platform Comparison
Head-to-head analysis of commerce platforms on specific dimensions.

**Sources:** Feature matrices, pricing, market share data, migration patterns

**What to include:**
- Specific comparison criteria (not vague)
- Actual numbers where possible
- Acknowledge bias honestly (Brent's Magento background)
- Practical recommendation

---

## Brent's Commerce Reporting Voice

### The Formula

1. **Personal hook** - Connect to something Brent has said, written, or experienced. Callback to a previous post if relevant. Ground the reader in why Brent is writing this.

2. **The numbers** - State facts clearly. Revenue, growth rate, GMV, market share. No hedging. No "approximately." Use the real numbers.

3. **Context** - Put the numbers next to something meaningful. Compare to competitors, compare to previous quarters, compare to industry benchmarks. Raw numbers mean nothing without context.

4. **"Here's what [audience] needs to pay attention to"** - Pivot from data to insight. This is where the hot take starts. Tell agency owners, merchants, or developers what the numbers actually mean for their business.

5. **Specific proof points** - Named brands, specific percentages, concrete data. Not "many enterprises are choosing Shopify." Instead: "GM, L'Oreal, Keurig Dr. Pepper, Sonos, and Benetton all joined this quarter."

6. **The hot take** - Strong, direct opinion. Not rude, not clickbait, but clear. "If your agency isn't building Shopify capabilities right now, you're watching the train leave the station." Brent earns the right to say this because of the data above it.

7. **Source credit** - Parenthetical at end: "(Q4 analysis sourced from [Source], [Date])"

8. **Hashtags** - 3-5 relevant hashtags at the end

### Voice Rules (from brand-brent)

- First person, always
- No em dashes (use periods, commas, parentheses)
- No emojis
- No "delve," "game-changing," "revolutionary," "groundbreaking"
- Short paragraphs (LinkedIn formatting)
- Direct and confident, not preachy
- Acknowledge Brent's history honestly (Magento background, open source roots)
- Never trash a platform without data to back it up
- The hot take must be EARNED by the analysis above it

### What Makes a Bad Commerce Report Post

- Starting with "Exciting news!" or "Big announcement!"
- Regurgitating a press release without adding perspective
- Being negative for engagement (doom posting)
- Vague takeaways ("this is going to change everything")
- No source attribution
- Making up numbers or extrapolating without saying so
- Burying the take in corporate language

---

## LinkedIn Formatting

- LinkedIn does NOT support markdown
- No bold/italic markers, no headers, no code blocks
- Use line breaks for paragraph separation
- Links go in first comment (LinkedIn suppresses reach for posts with links in body)
- Hashtags at end, separated by spaces
- Character limit: 3,000
- Ideal length: 1,500-2,500 characters (long enough for depth, short enough to hold attention)
- First 2-3 lines must hook (LinkedIn truncates after ~210 chars with "see more")

---

## Research Workflow

When the user provides a topic but no source:

1. **Web search** for the latest data (earnings, news, reports)
2. **Verify numbers** from multiple sources when possible
3. **Check date** - only use current/recent data
4. **Flag uncertainty** - if a number can't be verified, say so: "[NEED: verified Q4 GMV number]"
5. **NEVER fabricate data** - if you can't find the number, leave a placeholder

When the user provides a URL:

1. **Fetch and read** the source
2. **Extract key numbers** and facts
3. **Cross-reference** with web search if data seems off
4. **Credit the source** in the post

When the user provides talking points:

1. **Use their points** as the backbone
2. **Research supporting data** to strengthen the take
3. **Don't overwrite their angle** - they know the industry

---

## File Naming Convention

Save all commerce reports to:
```
ob-notes/Brent Notes/Brent Social Posts/Linkedin/linkedin-[company-or-topic]-[detail].md
```

Examples:
- `linkedin-shopify-q4-2025-earnings.md`
- `linkedin-adobe-commerce-acquisition.md`
- `linkedin-headless-commerce-trend-2026.md`

---

## Post File Template

```markdown
# LinkedIn Post - [Title]

**Status:** Draft
**Date:** [Target post date]
**Platform:** LinkedIn
**Source:** [Source name and date]
**Type:** [Earnings / News / Trend / Comparison]

---

[Full post text here]

[hashtags]

---

## Notes

- [Source credit for first comment]
- [Any images or charts to include]
- [Context or callbacks to previous posts]
```

---

## When Claude Should Apply This Skill

Apply this skill automatically when:
- User mentions earnings, quarterly results, or financial reports for eCommerce companies
- User asks to write about Shopify, Adobe Commerce, BigCommerce, Salesforce Commerce, WooCommerce, or other platform news
- User shares an earnings report, analyst recap, or industry news link
- User says "commerce report" or "commerce reporting"
- User wants to analyze eCommerce industry data for LinkedIn
- User mentions platform comparisons or commerce trends

Do NOT apply this skill for:
- General LinkedIn posts (use `/create-social`)
- Multi-platform campaigns (use `/plan-social`)
- Non-commerce industry analysis
- Newsletter content (use `/newsletter-planner`)

---

## Integration with Commands

- `/commerce-report` - Explicit command to create a commerce report post
- `/create-social` - Used for scheduling the final post
- `/brand-brent` - Voice guidelines (auto-loaded)
- `/check-terms` - Content terms validation (auto-run)
