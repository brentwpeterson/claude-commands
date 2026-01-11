# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: `feature/email-otp-term-submission`)
3. **Check Docker:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1, cbtextapp-mailhog-1 running)

## SESSION METADATA
**Last Commit:** `4bb936db Fix favicon - resize from 2MB to 2KB`
**Branch:** `feature/email-otp-term-submission`
**Saved:** 2025-12-13
**Deployment Tag:** `matrix-v0.33.3-otp-submit-term`

## CURRENT TODO FILE
**Path:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/email-otp-term-submission/README.md`
**Status:** ✅ DEPLOYED TO PRODUCTION - Awaiting production testing
**Directory Structure:** ✅ Complete (7/7 files)

---

## WHAT WAS COMPLETED THIS SESSION

**Email OTP Login & Public Term Submission Feature - DEPLOYED**

### All Phases Complete and Deployed:
| Phase | Description | Status |
|-------|-------------|--------|
| 1 | User Model Updates | ✅ DEPLOYED |
| 2 | OTP Infrastructure | ✅ DEPLOYED |
| 3 | OTP Endpoints | ✅ DEPLOYED |
| 4 | Rate Limiting | ✅ DEPLOYED |
| 5 | GeoIP Service | ✅ DEPLOYED |
| 6 | Term Submission | ✅ DEPLOYED |
| 7 | Frontend UI | ✅ DEPLOYED |

### Additional Fixes Deployed:
- ✅ OTP code email - removed space for easy copy/paste (was "130 504", now "130504")
- ✅ Submit term page at `/submit-term` with auth check and redirect
- ✅ "Continue with Email" button - OTP handles both new/existing users
- ✅ Login redirect param support for post-login return
- ✅ Policy links updated to RequestDesk.ai (privacy, terms, cookies)
- ✅ Favicon fixed (2MB → 2KB proper ICO format)

---

## PRODUCTION URLS TO TEST

1. **Login page with OTP button:** https://app.requestdesk.ai/login
2. **Direct OTP login:** https://app.requestdesk.ai/otp-login
3. **Term submission page:** https://app.requestdesk.ai/submit-term
4. **Favicon:** https://app.requestdesk.ai/favicon.ico (should be ~2KB now)

---

## NEXT ACTIONS

1. **Wait for deployment to complete** (~25 min matrix build)
2. **Test production:**
   - Go to https://app.requestdesk.ai/login
   - Click "Login with Email Code"
   - Complete OTP flow
   - Test /submit-term page
3. **If all works:** Run `/claude-complete` to archive the branch

---

## API ENDPOINTS CREATED

- `POST /auth/otp/request` - Request OTP code (rate limited: 3/email/hr, 10/IP/hr)
- `POST /auth/otp/verify` - Verify OTP, login/create user, return JWT
- `POST /api/public/submit-term` - Submit term to avoid (authenticated)

## CONTEXT NOTES

- MailHog available at http://localhost:8025 for local email testing
- Rate limiting: 3 OTP requests per email per hour, 10 per IP per hour
- New users get auto-created with `registration_method: "otp"`
- Term submissions start with `pending_review` moderation status
