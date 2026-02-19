# Handoff: LinkedIn Post - eCommerce Invisible to LLMs

## SESSION STATUS
**Identity:** Claude-Lovelace
**Status:** ACTIVE
**Last Saved:** 2026-02-18 11:20
**Handed Off By:** Claude-Hemingway from brent session

## TASK
**Sprint:** S4 (Feb 16-27, 2026)
**Points:** 1pt
**Priority:** P2
**Workspace:** brent (`/Users/brent/scripts/CB-Workspace/brent-workspace`)

## OBJECTIVE

Write and publish a LinkedIn post about how eCommerce is invisible to LLMs. This is a thought leadership post for Brent Peterson's LinkedIn profile.

The core idea: most eCommerce product catalogs, shopping experiences, and transactional content are invisible to large language models. LLMs can't see dynamic product pages, JavaScript-rendered content, gated catalogs, or session-dependent pricing. This is a problem as AI agents and LLM-powered search (ChatGPT, Perplexity, etc.) become how people discover and buy products.

## CONTEXT GATHERED SO FAR

No investigation done yet. Start from scratch.

Brent is the CEO of Content Basis (contentbasis.ai) which focuses on AI-optimized content for eCommerce. He also runs Talk Commerce podcast and has deep expertise in Magento/Adobe Commerce, Shopify, and eCommerce platforms. This post aligns with his brand positioning around AI + eCommerce.

## BRAND GUIDELINES (CRITICAL)

Before writing, load Brent's brand persona:
- Run `/brand-brent` to get full voice, tone, and style guidelines
- **NEVER use em dashes** (use periods or commas instead)
- **NEVER use emojis** unless explicitly requested
- Keep it authentic to Brent's voice (conversational, expert, not corporate)

## INVESTIGATION STEPS

1. Run `/brand-brent` to load Brent's writing persona
2. Research current state of LLM visibility for eCommerce:
   - How do ChatGPT, Perplexity, Google AI Overviews handle product searches?
   - What eCommerce content is crawlable vs invisible?
   - Any recent articles or data on this topic?
3. Check Brent's recent LinkedIn posts for tone/format consistency:
   - Look at `/Users/brent/scripts/CB-Workspace/brent-workspace/` for any post drafts or history
   - Check Vista Social or any social post CSV files for recent examples
4. Draft the post

## IMPLEMENTATION APPROACH

Use `/create-social` to draft, review, and schedule the post. This skill handles:
- Platform selection (LinkedIn)
- Draft creation with brand voice
- Review cycle
- Scheduling via Vista Social

## KEY FILES AND PATHS

- Brand persona: Run `/brand-brent` (skill, not a file)
- Social post skill: `/create-social`
- Vista Social API key: `/Users/brent/scripts/CB-Workspace/.claude/local/workspace.env`
- Brent's workspace: `/Users/brent/scripts/CB-Workspace/brent-workspace/`

## CONSTRAINTS

- Do NOT post without Brent's explicit approval of the draft
- Follow Brent's writing style (no em dashes, no emojis)
- Keep the post to LinkedIn optimal length (1000-1300 characters, or longer if the content warrants it)
- ASK BRENT after 2 failed attempts at anything
- Follow all CLAUDE.md rules

## ACCEPTANCE CRITERIA

- [ ] Post drafted in Brent's authentic voice
- [ ] No em dashes or emojis
- [ ] Brent has reviewed and approved the draft
- [ ] Post scheduled or published on LinkedIn

## NEXT ACTIONS

1. Run `/brand-brent` to load persona
2. Research the topic (web search for current state of LLM + eCommerce visibility)
3. Draft the post using `/create-social`
4. Present draft to Brent for review
5. Schedule/publish after approval
