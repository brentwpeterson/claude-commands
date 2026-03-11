# Rule: API Calls Are Not Database Writes

**Date:** 2026-02-23
**Source:** Learning Moment
**Severity:** Always
**Status:** Pending approval

## Discussion Summary

Claude refused to push a blog draft to RequestDesk via the Posts API, incorrectly applying the "Claude never writes to the database" rule. Minutes earlier in the same session, Claude had used the HubSpot API to create a contact property (which also writes to a database).

The distinction is clear:
- **Prohibited:** Direct MongoDB INSERT/UPDATE/DELETE, running migrations, docker exec for database operations
- **Allowed:** Using published application APIs (RequestDesk Posts API, HubSpot API, Vista Social API) for their intended purpose

## Proposed CLAUDE.md Addition

Under the existing "CLAUDE NEVER WRITES TO THE DATABASE" section, add a clarification:

> **CLARIFICATION: API calls are NOT database writes.**
> Using published application APIs (RequestDesk Posts API, HubSpot API, Vista Social API, etc.) for their intended purpose is allowed and expected. The database write prohibition applies to direct MongoDB operations, running migration commands, and docker exec for database operations. If there's an API endpoint for it, use it.

## User's Perspective

"An API call is not a database write. It is an API call to publish our website."
