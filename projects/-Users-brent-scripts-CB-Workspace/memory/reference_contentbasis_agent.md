---
name: ContentBasis Agent API Key
description: API key for ContentBasis Agent in RequestDesk - used for CC blog posts, public-posts endpoint
type: reference
---

ContentBasis Agent API key is stored in workspace.env as `CONTENTBASIS_AGENT_API_KEY`.

**Agent name:** ContentBasis Agent (shown as "Cucumber Writer" with the other key)
**Endpoint:** `https://app.requestdesk.ai/api/public-posts/`
**Auth header:** `X-API-Key: $CONTENTBASIS_AGENT_API_KEY`
**Total posts:** ~175 (as of 2026-03-27)

This is the agent that holds the Content Cucumber blog posts (contentcucumber.com/blog/).
The "Cucumber Writer" key (`spF-vAD3uzTiEYyaxF9TD0zQ01zUny5DK4eVjIMPuB8`) only has 3 test posts.
