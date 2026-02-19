# Handoff: LinkedIn Post - AI Agents Making Product Decisions

## SESSION STATUS
**Identity:** Claude-Austen
**Status:** ACTIVE
**Last Started:** 2026-02-18 11:22
**Handed Off By:** Claude-Hemingway from brent session

## TASK
**Sprint:** S4 (Feb 16-27, 2026)
**Points:** 1pt
**Priority:** P2
**Workspace:** brent (`/Users/brent/scripts/CB-Workspace/brent-workspace`)

## OBJECTIVE

Write and publish a LinkedIn post about AI agents making product decisions for Brent Peterson's LinkedIn profile.

The core idea: AI agents are increasingly making purchasing and product selection decisions on behalf of consumers and businesses. This shifts power from traditional search/browse UX to structured data, reviews, and machine-readable content. If your product catalog isn't optimized for AI agents, you're invisible to this new buying channel.

This connects to the broader trend of agentic commerce: AI agents that research, compare, and buy products autonomously. Think ChatGPT plugins, custom GPTs with shopping capabilities, Perplexity shopping, and enterprise procurement bots.

## CONTEXT GATHERED SO FAR

No investigation done yet. Start from scratch. Research angles:
- Current state of AI agents in commerce (ChatGPT shopping, Perplexity product search, Amazon Rufus)
- How are AI agents evaluating products? (structured data, reviews, specs, pricing APIs)
- What does this mean for merchants? (optimize for agents, not just humans)
- Brent's angle: Content Basis helps make eCommerce content AI-readable

## BRAND GUIDELINES (CRITICAL)

Before writing, load Brent's brand persona:
- Run `/brand-brent` to get full voice, tone, and style guidelines
- **NEVER use em dashes** (use periods or commas instead)
- **NEVER use emojis** unless explicitly requested
- Keep it authentic to Brent's voice (conversational, expert, not corporate)

## INVESTIGATION STEPS

1. Run `/brand-brent` to load persona
2. Web search for AI agents in eCommerce, agentic commerce, AI product decisions
3. Find recent examples or announcements (OpenAI shopping, Perplexity, etc.)
4. Check Brent's recent LinkedIn posts for tone/format
5. Draft the post

## IMPLEMENTATION APPROACH

Use `/create-social` to draft, review, and schedule the post.

## KEY FILES AND PATHS

- Brand persona: Run `/brand-brent` (skill, not a file)
- Social post skill: `/create-social`
- Vista Social API key: `/Users/brent/scripts/CB-Workspace/.claude/local/workspace.env`
- Brent's workspace: `/Users/brent/scripts/CB-Workspace/brent-workspace/`

## CONSTRAINTS

- Do NOT post without Brent's explicit approval of the draft
- Follow Brent's writing style (no em dashes, no emojis)
- ASK BRENT after 2 failed attempts at anything
- Follow all CLAUDE.md rules

## ACCEPTANCE CRITERIA

- [ ] Research on AI agents in product decisions completed
- [ ] Post drafted in Brent's authentic voice
- [ ] No em dashes or emojis
- [ ] Brent has reviewed and approved the draft
- [ ] Post scheduled or published on LinkedIn

## NEXT ACTIONS

1. Run `/brand-brent` to load persona
2. Research the topic (web search for AI agents + eCommerce purchasing)
3. Draft the post using `/create-social`
4. Present draft to Brent for review
5. Schedule/publish after approval
