# Resume Instructions for Claude

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/astro-sites`
2. **Verify branch:** `git branch --show-current` (should be: `feature/integration-voting`)
3. **Check backend:** Also check cb-requestdesk for backend code

## SESSION METADATA
**Last Commit (astro-sites):** `5b9bbfb Add voting system UI with OTP authentication for RequestDesk.ai`
**Last Commit (cb-requestdesk):** `99147191 Add vote-features system with OTP authentication for marketing site voting`
**Backend Deployed:** `matrix-v0.35.0-vote-features-system`
**Saved:** 2026-01-03

## WHAT WAS BUILT THIS SESSION

### Backend (cb-requestdesk) - DEPLOYED ✅
- **Migration:** `v0_36_0_create_vote_features.py` - Creates `vote_features` collection
- **Model:** `vote_feature.py` - VoteType enum (integration, feature, documentation)
- **Router:** `vote_features.py` - Public/authenticated endpoints at `/api/vote-features/`
- **Config:** Added `ADMIN_NOTIFICATION_EMAIL` for vote alerts (default: brent@contentbasis.io)
- **Email:** Sends notification to admin when votes are cast

### Frontend (astro-sites) - NEEDS DEPLOYMENT ⚠️
- **OTPAuthModal.astro:** 3-step email OTP auth flow
  - Step 1: Enter email
  - Step 2: Enter 6-digit code
  - Step 3: Success confirmation
  - Calls `/auth/otp/request` and `/auth/otp/verify`
  - Stores JWT in localStorage

- **VoteButton.astro:** Voting UI component
  - Greyed out (opacity-50, grayscale) when not logged in
  - Clicking greyed button opens OTP modal
  - Full color when authenticated
  - Shows vote count badge
  - Optimistic UI updates

## CURRENT STATE
- **Backend:** Deployed to production, migration will run on startup
- **Frontend:** Committed but NOT deployed yet
- **User tested locally:** Vote button greyed state works, OTP modal opens
- **User tested OTP flow:** Fixed endpoint paths from `/otp/request` to `/auth/otp/request`

## PENDING WORK
1. **Deploy astro-sites main-site** to get voting UI live on requestdesk.ai
2. **Test full production flow** - OTP auth + voting + email notification

## KEY FILES

### cb-requestdesk (backend)
- `backend/app/migrations/versions/v0_36_0_create_vote_features.py`
- `backend/app/models/vote_feature.py`
- `backend/app/routers/vote_features.py`
- `backend/app/config.py` (ADMIN_NOTIFICATION_EMAIL)

### astro-sites (frontend)
- `requestdesk-ai/src/components/OTPAuthModal.astro`
- `requestdesk-ai/src/components/VoteButton.astro`
- `requestdesk-ai/src/pages/integrations/[slug].astro` (includes VoteButton)

## API ENDPOINTS
- `POST /auth/otp/request` - Request OTP code
- `POST /auth/otp/verify` - Verify OTP and get JWT
- `POST /api/vote-features/` - Cast vote (auth required)
- `DELETE /api/vote-features/{vote_type}/{slug}` - Remove vote (auth required)
- `GET /api/vote-features/counts/{vote_type}/{slug}` - Get vote count (public)

## NEXT ACTIONS
1. **Deploy main-site:**
   ```bash
   cd /Users/brent/scripts/CB-Workspace/astro-sites
   git checkout master && git merge feature/integration-voting
   git push origin master
   git tag main-site-v0.35.0-voting-system
   git push origin main-site-v0.35.0-voting-system
   ```
2. **Test in production:** Visit integrations page, click vote, complete OTP flow
3. **Check email:** Verify admin notification received at brent@contentbasis.io

## CONTEXT NOTES
- Vote types: `integration`, `feature`, `documentation`
- Votes stored in `vote_features` collection with unique constraint on (vote_type, feature_slug, user_id)
- OTP router has double prefix: main.py `/auth` + router `/otp` = `/auth/otp/*`
