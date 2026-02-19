# Ongoing Issues Log

---

## ISS-001: Duplicate Claude session names

**Status:** open
**First seen:** 2026-02-18
**Impact:** Confusing when multiple windows are open. Can't tell sessions apart.

**Occurrences:**
- 2026-02-18: Two sessions both named "Hemingway" running simultaneously

**Root cause:** Session names are chosen independently by each Claude instance. No registry, no lock, no check against running sessions.

**Proposed fix:** Session start should read active-session.json (or a list of active sessions) and pick a name not already in use. Requires a naming registry or lock file.

---

## ISS-002: Sprint backlog API data doesn't match plan every morning

**Status:** in-progress
**First seen:** 2026-01-20 (S2)
**Impact:** 15-30 min wasted every /brent-start debugging sprint data. Happened across S2, S3, S4.

**Occurrences:**
- S2: Points only in markdown, not in API
- S3: Items not tagged with sprint_name
- S4: 100 items tagged instead of 22, only 7 committed=True, points wrong
- 2026-02-18: Dry-run verify gate caught TWC Article #1 missing, S2 retro wrong points

**Root cause:** Multiple layers. (1) API filter ?sprint_name= is broken at backend level. (2) Commit/verify gate wasn't in the process until today. (3) Recurring clones sometimes missed.

**Proposed fix:**
1. Added commit/verify gate to SOP Steps 9-10 (done 2026-02-18)
2. Added recurring item check to verify gate (done 2026-02-18)
3. Backend fix needed: API filter ?sprint_name= returns all items (code fix in requestdesk-app)
4. /brent-start needs to filter on committed=True

---

## ISS-003: Backlog API list endpoint has item limit

**Status:** open
**First seen:** 2026-02-18
**Impact:** Newly created items may not appear in list queries. Verify gate can show wrong counts.

**Occurrences:**
- 2026-02-18: Created TWC Article #1 (S4), direct ID lookup works but list endpoint (244 items) doesn't include it

**Root cause:** Backlog list endpoint returns a limited number of items (appears to be ~244). No pagination parameter documented.

**Proposed fix:** Backend fix needed. Either increase default limit, add pagination support, or add proper ?sprint_name= filtering so the full list isn't needed.

---

## ISS-004: API filter ?sprint_name= is broken

**Status:** open
**First seen:** 2026-02-18 (Earhart audit)
**Impact:** Every query for sprint items returns the entire backlog. Forces client-side filtering with jq.

**Occurrences:**
- 2026-02-18: Earhart confirmed ?sprint_name=S4 returns all 239 items

**Root cause:** Backend query parameter not implemented or broken in the backlog endpoint.

**Proposed fix:** Fix the backend filter in requestdesk-app. This is a code change.

---
