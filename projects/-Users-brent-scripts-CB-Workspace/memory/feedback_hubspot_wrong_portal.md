---
name: HubSpot Wrong Portal (CRITICAL - 2026-04-11)
description: HubSpot MCP token was connected to wrong portal (245699648/Chalet Market). Content Cucumber portal is 39487190. All prior HubSpot operations hit the wrong account.
type: feedback
---

HubSpot MCP token was pointed at portal 245699648 (likely Chalet Market), NOT the Content Cucumber portal 39487190.

**Why:** Private app token in `.mcp.json` (`pat-na2-de...c51f`) authenticates to the wrong HubSpot account. Every search, every operation returned empty or went to the wrong CRM.

**How to apply:**
- When updating the HubSpot token, verify the portal ID matches 39487190
- After any token change, run `mcp__hubspot__hubspot-get-user-details` and confirm `hubId: 39487190`
- If hubId shows anything other than 39487190, STOP and alert the user
- Both `hubspot` and `hubspot-extended` servers in `.mcp.json` use the same token and both need updating
