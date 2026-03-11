# Resume Instructions for Claude

> **WARNING:** There are TWO Hemingway context files. This one is for ASTRO (Amplify migration).
> The other is rd-2026-03-04-hemingway-context.md (RD chat/agent UX).
> When resuming the SECOND file, use a NEW Claude name (not Hemingway) to avoid collision.

## SESSION STATUS
**Identity:** Claude-Hemingway
**Status:** ACTIVE
**Last Saved:** 2026-03-05 14:00
**Last Started:** 2026-03-05 07:00

## IMMEDIATE SETUP
1. **Directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Branch:** `git checkout master`
3. **Last Commit:** `94ddd3b Move eovoices-com and dreamers-inc to AWS Amplify`
4. **Verify:** `git status`

## WORKSPACES TOUCHED
| Shortcode | What was done |
|-----------|---------------|
| astro | Directory restructure, Amplify migration of 5 static sites, container slimmed to 4 SSR sites |

## WHAT YOU WERE WORKING ON

Completed the full Amplify migration and directory restructure for astro-sites. Container went from 10 sites to 4 SSR-only sites.

### Container (4 SSR sites) - Docker build verified
| Site | Domain |
|------|--------|
| contentbasis-ai | contentbasis.ai |
| requestdesk-ai | requestdesk.ai |
| brent-run | brent.run |
| talk-commerce-com | talk-commerce.com |

### Amplify (5 static sites) - all built and live
| Site | Domain | App ID |
|------|--------|--------|
| magento-masters-com | magento-masters.com | db6twureq0ylz |
| commerceking-ai | commerceking.ai | dzdqx78g03j0u |
| hirepodcast-live | hirepodcast.live | dxwk85ejpknvs |
| eovoices-com | eovoices.com | dgzmx97o4yl4j |
| humans-contentcucumber-com | humans.contentcucumber.com | d18vp9gucetezu |

### Nginx redirects (fallback in container)
- contentbasis.io -> contentbasis.ai (301)
- eovoices.com -> eovoices.com (passthrough to Amplify)
- humans.contentcucumber.com -> humans.contentcucumber.com (passthrough to Amplify)

## CURRENT STATE
- **Container NOT yet deployed** - 6 commits on master ahead of production
- **All 5 Amplify sites built successfully** and serving traffic
- **DNS for humans.contentcucumber.com** - already pointing to Amplify CloudFront (d23921i186wh0i.cloudfront.net)
- **DNS for eovoices.com** - PENDING VERIFICATION. Zone not in this AWS account. Need to add:
  - Verification CNAME: `_afea53fdbc3ba18098c2f70cc4452640.eovoices.com` -> `_61e07dfd4032929d1e176a4108a24c87.jkddzztszm.acm-validations.aws.`
  - A/CNAME: `eovoices.com` -> `d1nsv18cbfx827.cloudfront.net`
- **Submodules with unpushed commits:**
  - eovoices-com has commits from @cb/rss path fix + amplify.yml (already pushed to origin/main)
  - contentbasis-io submodule was removed entirely
- **dreamers-inc renamed** to humans-contentcucumber-com, pushed to new repo brentwpeterson/humans-contentcucumber-com

## COMMITS THIS SESSION (on master)
1. `00e5081` - Restructure sites/ into container/ and amplify/ subdirectories
2. `0a75687` - Fix @cb/rss shared package paths (../../ -> ../../../)
3. `ba5c94c` - Update lock files for path change
4. `2376f05` - Remove contentbasis-io, redirect to contentbasis.ai
5. `94ddd3b` - Move eovoices-com and dreamers-inc to AWS Amplify

## NEXT ACTIONS
1. **DNS:** Add eovoices.com verification CNAME and A record (wherever DNS is managed)
2. **Deploy container:** Push master + create deploy tag (user must run deploy command)
3. **Verify:** After deploy, confirm all 4 SSR sites respond correctly
4. **Verify:** After DNS propagation, confirm eovoices.com serves from Amplify

## CONTEXT NOTES
- The /deploy-amplify command exists at .claude/commands/deploy-amplify.md
- eovoices-com uses TRANSISTOR_API_KEY (set in Amplify env vars from workspace.env)
- @cb/rss was inlined into eovoices-com (src/lib/rss.ts) since Amplify can't access shared/ directory
- magento-masters uses `main` branch, commerceking uses `master`, hirepodcast uses `main`, eovoices uses `main`, humans-cc uses `main`
- The shared/rss package is still used by container sites (talk-commerce-com) via file: reference
- Container Dockerfile no longer needs TRANSISTOR_API_KEY build arg
