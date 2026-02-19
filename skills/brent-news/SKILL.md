# Brent News - Intelligence Briefing Domain Knowledge

Domain knowledge for the news intelligence system. Loaded when user mentions news,
briefings, "what's happening in ecommerce/AI," or asks about industry trends.

## What is "Agentic Commerce"

Brent Peterson positions himself as "the agentic commerce guy." This means the
intersection of AI agents (autonomous software that acts on behalf of users) and
commerce (ecommerce platforms, payments, fulfillment, marketing).

Not just "AI in ecommerce" (which is broad and generic). Specifically: commerce
operations where AI agents make decisions, take actions, and run processes that
humans used to do manually.

## Category Taxonomy

Feed sources are organized into categories that map to Brent's content universe:

| Category | What it covers | Why it matters |
|----------|---------------|----------------|
| ecommerce | Platform updates, merchant tools, commerce trends | Core domain |
| ai | LLM releases, agent frameworks, model capabilities | The "agentic" half |
| llm | Specific to language models and APIs | Technical depth for dev audience |
| agents | Agent frameworks, MCP, SDKs, autonomous systems | The core thesis |
| shopify | Shopify-specific news (major platform for clients) | Client relevance |
| payments | Stripe, payment processing, checkout innovation | Commerce infrastructure |
| infra | Cloud, hosting, developer tooling | Technical foundation |
| strategy | Industry analysis, VC perspectives, market trends | Thought leadership fuel |
| dev | Developer tools, open-source, engineering blogs | Technical credibility |
| industry | Broader retail, commerce, digital transformation | Context and trends |

## Content Angle Generation Rules

When generating content angles for a news item, evaluate through three lenses:

### 1. Agentic Commerce Angle
- How does this relate to AI agents operating in commerce?
- Is there an automation or autonomous decision-making angle?
- Could this enable or disrupt agent-driven commerce workflows?
- Example: "Stripe launches new API" -> "Could enable agents to handle refunds autonomously"

### 2. Newsletter Angle (The Agentic Commerce Guy)
- Would this fit in Brent's newsletter?
- Which of the 7 audience segments would care? (Agencies, Merchants, Experts, Marketing, Developers, Freelancers, Platform Partners)
- Is there an opinion or take, not just news?
- Example: "Shopify releases new checkout API" -> "Agencies can now build agent-powered checkout optimization"

### 3. LinkedIn Angle
- Is there a 2-3 sentence hot take for LinkedIn?
- Does it invite discussion or debate?
- Can Brent position himself as the person connecting AI + commerce dots?
- Example: "OpenAI releases new model" -> "Every new model release makes agent-driven commerce more viable. Here's why merchants should care."

## Relevance Scoring Guide

When evaluating news items for relevance to Brent's positioning:

| Score Range | Meaning | Example |
|-------------|---------|---------|
| 0.9 - 1.0 | Directly about agentic commerce | "Shopify launches AI agent for store management" |
| 0.7 - 0.89 | Strong AI + commerce connection | "Anthropic releases new agent capabilities" |
| 0.5 - 0.69 | Related to AI or commerce, not both | "New Shopify theme framework" |
| 0.3 - 0.49 | Tangentially related | "Cloud infrastructure pricing changes" |
| 0.0 - 0.29 | Low relevance | "Social media algorithm update" |

## API Reference

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/feed-aggregator/briefing` | GET | Unbriefed items grouped by category |
| `/api/feed-aggregator/briefing/mark-briefed` | POST | Mark items as briefed |
| `/api/feed-aggregator/sources` | GET | List all feed sources |
| `/api/feed-aggregator/items` | GET | Query items with filters |
| `/api/feed-aggregator/items/{id}` | GET | Single item detail |
| `/api/feed-aggregator/items/{id}` | PATCH | Update read/starred state |
| `/api/feed-aggregator/items/score` | POST | Trigger relevance scoring |

**Auth:** `Authorization: Bearer MNRcaklW3XF7UpKX4VrxPV7wo2L7xsWg`

## Trigger Phrases

This skill should activate when the user mentions:
- "news briefing" or "morning briefing"
- "what's happening in ecommerce"
- "what's happening in AI"
- "any news today"
- "industry updates"
- "what should I know about"
- "trending in commerce"
- References to specific feed categories (Shopify news, AI news, etc.)

## Usage Notes

- No emojis in output (Brent's writing style)
- No em dashes. Use periods or commas instead.
- Present information in scannable format (tables, bullet lists)
- High-relevance items first, then by category
- Always offer to mark items as briefed after presenting
- For starred items, these are items Brent flagged for follow-up
- Deep mode generates content angles even when scoring data is missing
