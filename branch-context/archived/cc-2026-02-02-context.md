# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/.claude`
2. **Branch:** `git checkout main`
3. **Last Commit:** `888df3e Add canva-design skill with prompt patterns and workflows`
5. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| `cc` | Created canva-design skill (3 files), upgraded /canva command |
| `brent` | Created workshop booklet HTML in Obsidian vault (MMFL26 folder) |
| `astro` | Read Shopify integration content for one-pager |

## CURRENT TODO
**Sprint Task:** `6965527f8ec76c1a0ce36525` - "Need Shopify one pager as a PDF for downloads"
**Sprint:** S3
**Status:** Ready to generate, blocked by Canva MCP auth

## WHAT YOU WERE WORKING ON
1. Created canva-design skill with brand mapping, workflows, prompt patterns (DONE, committed)
2. Started Shopify one-pager task from S3 sprint
3. Gathered all content from astro-sites Shopify integration pages
4. Attempted to generate flyer in Canva but got "Access token is invalid" error

## CURRENT STATE
- **Canva skill:** Created and committed (3 files, 632 lines)
- **Canva command:** Upgraded in `.claude-local/commands/canva.md` (not in git)
- **Shopify one-pager:** Content gathered, prompt ready, blocked by Canva auth

## SHOPIFY ONE-PAGER CONTENT (READY TO USE)
**Design type:** `flyer`
**Brand kit:** RequestDesk (`kAGxHGjjgl0`)

**Content gathered from astro-sites:**
- Headline: "Turn Your Products Into Blog Content"
- Subheadline: "AI-powered content that knows your inventory"
- Problem: Competitors have blogs ranking for product keywords
- Features: Product descriptions, blog publishing, collection pages, featured images, brand voice
- How it works: Sync > Generate > Publish
- Result: "Average 105% traffic increase within 6 months"
- Modes: DIY or Managed
- CTA: "Start Your Free Beta" - requestdesk.ai/integrations/shopify

## NEXT ACTIONS
1. **FIRST:** Re-authenticate Canva MCP (restart Claude Code or re-auth in MCP settings)
2. **THEN:** Run the generate-design call with the prepared prompt
3. **THEN:** Save candidate, export as PDF
4. **THEN:** Update sprint task status to completed

## CONTEXT NOTES
- Canva MCP error: "Access token is invalid (Request ID: 9c7f97e73017ed38)"
- The full prompt for Canva is in conversation history, ready to re-run
- Sprint task ID for backlog update: `6965527f8ec76c1a0ce36525`
- Content source files in astro-sites:
  - `/sites/requestdesk-ai/src/pages/integrations/shopify.astro`
  - `/sites/requestdesk-ai/src/content/integrations/shopify.md`
  - `/sites/contentbasis-ai/src/pages/shopify.astro`
