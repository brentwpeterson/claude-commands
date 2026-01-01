# Resume Instructions for Claude - Feature/Brand-Builder

## IMMEDIATE SETUP
1. **Change directory:** `cd /Users/brent/scripts/CB-Workspace/cb-requestdesk`
2. **Verify branch:** `git branch --show-current` (should be: `feature/brand-builder`)
3. **Check Docker:** `docker ps` (expect: cbtextapp-backend-1, cbtextapp-frontend-1 running)
4. **Start if needed:** `docker-compose up -d`

## SESSION METADATA
**Branch:** `feature/brand-builder`
**Last Commit:** `26716a3c Add Phase 2 Conversational Brand Builder`
**Saved:** 2025-12-09

---

## CURRENT WORK: Phase 2 Conversational Brand Builder

Transform the 20-question brand builder from a structured questionnaire into a fluid, AI-driven conversation.

### TODO FILE
**Path:** `/Users/brent/scripts/CB-Workspace/cb-requestdesk/todo/current/feature/conversational-brand-building/`

### Current Bug Being Fixed
The dimension pills at the top of the conversational builder are ALL showing as blue/gray (clickable but not complete) even though the persona has 10+ saved answers. The progress bar shows "10 of 20 (50%)" but the pills don't turn green with checkmarks.

**Root Cause Identified:**
- API returns answers keyed by MongoDB ObjectId (e.g., `6925a5da59be7b22ee7b5408`)
- Frontend's `BRAND_DIMENSIONS` array uses names like `target_audience`
- The mapping between section_type IDs and dimension names isn't working correctly

**Last Fix Applied (needs testing):**
Updated `loadPersonaData()` in `ConversationalBrandBuilder.tsx` (lines 108-170) to:
1. First load section types to build ID → name mapping
2. Normalize names (lowercase, replace spaces with underscores)
3. Try to match to BRAND_DIMENSIONS array
4. Added console.log statements to debug the mapping

### Other Issue Found
Tool calls from Groq are being output as plain text like:
```
Save_brand_answer={"dimension": "voice_tone", "confidence": 0.9, "answer": "..."}
```
Instead of using the tools API properly. Added frontend parsing to extract these and show in sidebar (not message content).

---

## PENDING DEPLOYMENT: Sentry Fixes (Dec 6)

Three fixes committed locally but **NOT YET DEPLOYED**:

### a) 403 Access Denied on Collection Assignment
- **File:** `backend/app/services/agents/agent_service.py`
- **Bug:** `_check_agent_access()` used uninitialized `self.user_company_id` (always None)
- **Fix:** Now calls `await self._get_user_company_id()` to populate it first

### b) N+1 Query on Knowledge Base Collections List
- **File:** `backend/app/routers/knowledge_base_collections.py`
- **Bug:** Made 2 queries per collection (count + distinct) = 21 queries for 10 collections
- **Fix:** Single aggregation pipeline for all collections = 2 queries total (~90% reduction)

### c) AgentChatTab Wrong Endpoint
- **File:** `frontend/src/components/agents/AgentChatTab.tsx`
- **Bug:** Called `/api/agents/{id}/content` which requires `prompt` field
- **Fix:** Now calls `/api/agent/content` (public endpoint) with agent's API key
- This is the same working endpoint used by TypingMind

**Deploy Command (after testing):**
```bash
git checkout master && git pull origin master
git merge feature/brand-builder
git push origin master
git tag matrix-v0.33.0-sentry-fixes && git push origin matrix-v0.33.0-sentry-fixes
```

---

## FILES CREATED/MODIFIED

### New Files:
- `backend/app/routers/conversational_brand_builder.py` - Backend streaming chat endpoint with tool support
- `frontend/src/components/personas/ConversationalBrandBuilder.tsx` - Chat UI component

### Modified Files:
- `backend/app/main.py` - Router registration
- `backend/app/database.py` - Added brand_conversations collection
- `frontend/src/routes/index.tsx` - Added route `/personas/:id/conversational-builder`
- `frontend/src/components/personas/CategorizedPersonaBuilder.tsx` - Added toggle button (line 1676)

---

## TODO LIST STATE
- ✅ Plan Phase 2 architecture
- ✅ Create ConversationalBrandBuilder.tsx chat UI
- ✅ Build backend streaming endpoint with tool-based answer capture
- ✅ Create dimension mapping
- ✅ Implement conversation state persistence (MongoDB brand_conversations)
- ✅ Add progress bar showing 20/20 dimensions
- ✅ Create pending answer confirmation UI
- ✅ Implement resume functionality
- ✅ Add toggle in CategorizedPersonaBuilder
- ✅ Fix Anthropic system message handling (DEPLOYED as matrix-v0.33.0-anthropic-fix-retry)
- ✅ Fix 403 Access Denied (committed, not deployed)
- ✅ Fix N+1 query (committed, not deployed)
- ✅ Fix AgentChatTab endpoint (committed, not deployed)
- 🔄 **IN PROGRESS:** Fix dimension pills not showing green checkmarks
- ⏳ Test Sentry fixes locally
- ⏳ Deploy Sentry fixes

---

## NEXT ACTIONS (PRIORITY ORDER)

### Priority 1: Fix Dimension Pills
1. Start Docker: `docker-compose up -d`
2. Refresh the conversational builder page and check browser console for mapping logs
3. Look for console output like `Mapping 6925a5da59be7b22ee7b5408 -> target_audience -> target_audience`
4. If pills still gray, adjust dimension name matching logic
5. Verify savedAnswers object has keys matching BRAND_DIMENSIONS array

### Priority 2: Test & Deploy Sentry Fixes
1. Test collection assignment (403 fix)
2. Test knowledge base collections list performance (N+1 fix)
3. Test AgentChatTab persona loading (endpoint fix)
4. Deploy once testing confirmed

---

## KEY CODE LOCATIONS

### Backend Tool Definition
`backend/app/routers/conversational_brand_builder.py:86-111`
- OpenAI/Groq compatible tool format with `type: "function"`

### Frontend Dimension Pills
`frontend/src/components/personas/ConversationalBrandBuilder.tsx:509-536`
- Maps BRAND_DIMENSIONS to pills, checks savedAnswers for green/gray styling

### Saved Answers Loading
`frontend/src/components/personas/ConversationalBrandBuilder.tsx:108-170`
- Loads section types, builds mapping, converts API response to savedAnswers state

---

## VERIFICATION COMMANDS
```bash
# Check Docker containers running
docker ps

# Test conversational builder
# http://localhost:3001/personas/6931794c32c8c206858fa47c/conversational-builder

# Test knowledge base collections list (N+1 fix)
# http://localhost:3001/knowledge-base-collections

# Test agent chat tab persona loading (endpoint fix)
# http://localhost:3001/agents → Any agent → Chat tab

# Check section types API
curl -s "http://localhost:3000/api/section-types?status=active&_end=50" \
  -H "Authorization: Bearer $(curl -s -X POST 'http://localhost:3000/auth/token' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=cucumber&password=test1234' | jq -r '.access_token')" | jq '.[0:3]'
```

## CONTEXT NOTES
- User cucumber/test1234 has persona ID `6931794c32c8c206858fa47c` with 10+ saved sections
- Internal LLM provider is Groq (outputs tool calls as text, not actual tool_calls)
- Frontend parses `Save_brand_answer={...}` text pattern and extracts to pending answers
- The 20 BRAND_DIMENSIONS are hardcoded in frontend and backend (lines 12-33 in both files)
- Blog creation IS working (deployed earlier as matrix-v0.33.0-anthropic-fix-retry)
- Production has fallback system - failed deployments roll back automatically
- Frontend hot-reloads, backend auto-restarts on file changes
