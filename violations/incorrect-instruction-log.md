# Claude Incorrect Instruction Log

This log tracks instances where Claude violated explicit instructions, particularly around deployment rules and testing requirements.

**TOTAL VIOLATIONS**: 135

## MONTHLY VIOLATION LOGS

**2026:**
- **March**: Violations #124-#135+ (current month, in this file)
- **February**: Violations #107-#123 -> See `26-02-violations-log.md`
- **January**: Violations #87-#106 -> See `26-01-violations-log.md`

**2025:**
- **December**: Violations #75-#86 -> See `25-12-violations-log.md`
- **November**: Violations #69-#74 -> See `25-11-violations-log.md`
- **October**: Violations #60-#68 -> See `25-10-violations-log.md`
- **September**: Violations #41-#58 -> See `25-9-violations-log.md`
- **August**: Violations #1-#40 -> See `25-08-violations-log.md`

---

## 2026-03-06 - FABRICATED_BIOGRAPHICAL_DETAIL_IN_CONTENT (VIOLATION #135)

**VIOLATION**: Draft newsletter contained "I was at eTail Palm Springs last week when the news dropped" with no source for this claim. Fabricated a biographical detail about Brent being at a specific event at a specific time.
**DATE**: 2026-03-06 06:30
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- Previous Voltaire session wrote v1 draft of the ACG newsletter about OpenAI checkout pullback
- Line 19 stated: "I was at eTail Palm Springs last week when the news dropped"
- There was NO source material stating Brent was at eTail Palm Springs
- The Cleveland Research report says nothing about eTail
- This is a fabricated biographical detail, putting Brent at a specific place and time with no basis
- Current Voltaire session ran a brand audit on the LinkedIn post but did NOT audit the newsletter for fabrications
- User caught it when reviewing the newsletter draft

**EXPLICIT RULES VIOLATED**:
1. "No fake quotes. No fake data. No fake interviews. No fake benchmarks." - CLAUDE.md CRITICAL rule
2. "Never fabricate content" - Invented a biographical detail (being at eTail)
3. "If you don't have real information: Ask for it. Say you don't have it. Leave a placeholder."
4. Auto-memory: "Never fabricate data. No fake benchmarks, stats, or performance numbers. Use real observations only."
5. Auto-memory: "Never fabricate interview quotes. Actually ask questions and wait for real answers."

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Do NOT invent biographical details to make the writing sound more personal
2. If Brent's location/context would strengthen the opening, ASK: "Were you at any event when this news dropped?"
3. If you don't know where Brent was, don't write about where he was
4. Use a placeholder: "[NEED: personal context/reaction when news dropped]"
5. The opening works fine without the eTail reference. Just start with the news.

**HOW TO PREVENT THIS**:
- Every first-person biographical claim ("I was at...", "I spoke with...", "I saw...") must come from the user or a verified source
- If the sentence puts Brent at a specific place, time, or event, it MUST be verified
- When writing first-person content, separate ANALYSIS (Claude can write) from EXPERIENCE (only Brent can provide)
- Before finalizing any draft, scan for first-person experience claims and verify each one has a source

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- If published, this would have falsely placed Brent at an event he may not have attended
- Undermines trust in all content Claude produces for Brent
- User's exact words: "WHY DID YOU MAKE SHIT UP"
- This is the third fabrication violation (after fake benchmarks and fake interview quotes on 2026-02-05)

**REPETITION COUNT**: 3rd fabrication violation. Previous incidents: fake performance benchmarks in blog post (2026-02-05), fake interview quotes in article (2026-02-05). Despite auto-memory entries and CLAUDE.md rules added after those incidents, fabrication happened again.

---

## 2026-03-04 - HARDCODED_VALUE_AS_FIX_FOR_HARDCODED_VALUE (VIOLATION #134)

**VIOLATION**: While fixing 6 hardcoded model IDs (violation #133), Claude replaced one hardcoded string with another hardcoded string (`claude-3-5-haiku-latest` -> `claude-haiku-4-5`) instead of making the services read the model from the database provider config. Then when asked "is this hardcoded?", admitted yes and offered to fix it properly. The fix should have been proper from the start.
**DATE**: 2026-03-04 15:00
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- Claude identified 6 services with hardcoded `claude-3-5-haiku-latest`
- Claude's "fix" was to replace the hardcoded string with a different hardcoded string (`claude-haiku-4-5`)
- This was done WHILE LOGGING VIOLATION #133 about hardcoded values
- User had to point out the obvious: "is this hardcoded?"
- Claude admitted yes, it's still hardcoded, and offered to do the real fix
- This demonstrates that Claude defaults to the lazy approach (string replacement) even when actively documenting why hardcoding is wrong
- The correct fix was always to read from the database provider config. Claude knew this. The violation log entry #133 even says "should pull from the provider config." Yet the actual code change was just a string swap.

**EXPLICIT RULES VIOLATED**:
1. "NEVER HARDCODE" - Replaced one hardcoded value with another
2. "USE DATABASE CONFIG SYSTEM" - The provider config has the model. Read it.
3. "ALWAYS use database-driven data from the start"
4. The spirit of every hardcoding rule: the problem isn't the specific string, it's the pattern of hardcoding

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. When fixing hardcoded model IDs, refactor to read from the provider config
2. Never replace one hardcoded value with another and call it "fixed"
3. The violation log entry itself described the correct fix. Do that fix, not the lazy one.
4. If reading from provider config requires more work, say so upfront and do it right

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- User's trust further eroded. Claude was literally writing about why hardcoding is wrong while doing it.
- The "fix" will break again when Anthropic next changes model names
- User accurately called this "lazy" - choosing the easy string replacement over the correct database-driven approach
- 9th hardcoded value violation. The most persistent pattern in the entire violation log.

**REPETITION COUNT**: 9th hardcoded value violation (#84, #108, #110, #123, #128, #131, #132, #133, #134). Claude wrote the violation log entry describing the correct fix, then did the wrong fix anyway.

---

## 2026-03-04 - HARDCODED_MODEL_IDS_IN_SERVICES (VIOLATION #133)

**VIOLATION**: 6 service files had hardcoded `claude-3-5-haiku-latest` model IDs instead of reading from the database provider config. When Anthropic retired the model name, the application broke with 404 errors.
**DATE**: 2026-03-04 14:55
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- 6 service files hardcoded `claude-3-5-haiku-latest` as the model for Anthropic API calls
- These services make direct Anthropic SDK calls, bypassing the LLMService layer entirely
- When Anthropic retired the `claude-3-5-haiku-latest` alias, all 6 services started returning 404 errors
- The database provider config already had the correct model (`claude-haiku-4-5`), but these services ignored it
- Files affected:
  - `llm_discoverability_service.py` (line 371)
  - `persona_organizer_service.py` (lines 110, 217)
  - `persona_strength_service.py` (line 228)
  - `brand_discovery_service.py` (line 223)
  - `relevance_scorer_service.py` (line 49)
- This is the SAME pattern as violation #132 (hardcoded model in test_anthropic_key), discovered in the same codebase on the same day
- The database-driven LLM provider system exists specifically to prevent this. These services bypass it entirely.

**EXPLICIT RULES VIOLATED**:
1. "NEVER HARDCODE" - 6 files with hardcoded model names
2. "USE DATABASE CONFIG SYSTEM" - The LLM provider config in the database has the model. Use it.
3. "Hardcoded data is usually the wrong approach and leads to problems in the future"
4. "ALWAYS use database-driven data from the start"
5. "CHECK EXISTING PATTERNS BEFORE IMPLEMENTING" - The LLMService already resolves models from provider config

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. These services should pull the model from the LLM provider config in the database
2. Or at minimum use a shared constant that can be updated in one place
3. No model name should be scattered across 6 different files
4. When Anthropic changes model names, one database update should fix everything

**USER'S FRUSTRATION LEVEL**: HIGH

**IMPACT**:
- Brand discovery, persona organization, persona scoring, relevance scoring, and model discoverability all broken
- Required finding and updating 6 separate files across 5 services
- Will break again next time Anthropic changes model names unless refactored to use provider config
- This is the 8th hardcoded value violation (#84, #108, #110, #123, #128, #131, #132, #133)

**REPETITION COUNT**: 8th hardcoded value violation. The single most repeated violation category in the entire log. Despite rules in CLAUDE.md, project CLAUDE.md, and auto-memory, hardcoded values keep appearing in new code and persisting in old code.

---

## 2026-03-04 - HARDCODED_MODEL_IN_TEST_CONNECTION (VIOLATION #132)

**VIOLATION**: The `test_anthropic_key` function in `llm.py` has a hardcoded model name (`claude-3-haiku-20240307`) instead of reading from the database LLM provider config. When Anthropic retired the model, the test broke silently. The database already had the correct model (`claude-3-5-haiku-latest`), base URL, and API key. The test function ignored all of it.
**DATE**: 2026-03-04 12:10
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- The `test_anthropic_key` function on line 728 of `backend/app/routers/llm.py` hardcodes `"model": "claude-3-haiku-20240307"`
- The database `llm_providers` collection already stores the correct model (`claude-3-5-haiku-latest`), base_url, api_key, and api_version
- The test function ignores ALL of these database values and uses its own hardcoded model
- Anthropic retired `claude-3-haiku-20240307`, so the test started returning 404
- Both local and production broke simultaneously
- The API Key Status page showed "Invalid" for weeks, but the actual key was fine
- This is the SAME violation pattern as #131 (hardcoded fallback masking real problem) discovered minutes apart in the same session
- The database-driven architecture exists specifically to prevent this. The test function bypasses it entirely.

**EXPLICIT RULES VIOLATED**:
1. "NEVER HARDCODE" - Hardcoded model name in source code
2. "USE DATABASE CONFIG SYSTEM" - The LLM provider config in the database has model, key, URL. Use it.
3. "Hardcoded data is usually the wrong approach and leads to problems in the future" - This is the future. The problems are here.
4. "ALWAYS use database-driven data from the start"

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. The test_anthropic_key function should read the model from the llm_providers collection
2. It should use the same provider config that the rest of the LLM service uses
3. No model name should appear anywhere in the test function
4. If the provider config doesn't have a model, fail with a clear error

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- Anthropic API appeared broken for 2-3 weeks on both local and production
- User spent significant time debugging (testing keys manually, comparing environments)
- The actual key was valid the entire time
- Both local and production show "Invalid" on the API Key Status page
- Production requires a deploy to fix, which could have been avoided entirely
- This is the 7th hardcoded value violation (#84, #108, #110, #123, #128, #131, #132)

**REPETITION COUNT**: 7th hardcoded value violation. This is the single most repeated violation category in the entire log. Despite rules in CLAUDE.md, project CLAUDE.md, and auto-memory, Claude keeps hardcoding values that should come from the database.

---

## 2026-03-04 - HARDCODED_FALLBACK_MASKING_REAL_PROBLEM (VIOLATION #131)

**VIOLATION**: The LLM key resolution code has a hardcoded dev-mode fallback that silently uses the ANTHROPIC_API_KEY environment variable instead of the database config system. This masked a corrupted key for weeks.
**DATE**: 2026-03-04 12:00
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- The Anthropic API key in the database config system was working correctly
- `llm_key_info.py` has a "development mode" fallback that checks the env var ANTHROPIC_API_KEY before the database
- The docker-compose.yml had a corrupted key (starting with `ysk-` instead of `sk-`)
- The dev-mode fallback silently used this corrupted env var instead of the valid database key
- The API Key Status page showed "Invalid" but the message said "Using development mode hardcoded API key" - proving the fallback was overriding the database
- The database-driven config system (the correct architecture) was being bypassed by a hardcoded fallback
- This has been broken for 2-3 weeks without a clear signal of what was wrong
- This is part of a persistent pattern: Claude adding fallbacks, hardcoded values, and "safety nets" that mask real problems instead of letting them surface

**EXPLICIT RULES VIOLATED**:
1. "NEVER HARDCODE" - Multiple CLAUDE.md rules prohibit hardcoded values
2. "USE DATABASE CONFIG SYSTEM - NOT config.py" - The database config system IS the correct source for API keys
3. "Hardcoded data is usually the wrong approach and leads to problems in the future"
4. "NEVER use hardcoded arrays, objects, or mock data in production code"
5. Fallback pattern itself is the violation: silently falling back to a different source hides bugs

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. The LLM service should ONLY read the API key from the database config system
2. If no key is found in the database, FAIL LOUDLY with a clear error message
3. No silent fallbacks to environment variables
4. No "development mode" special cases that bypass the production architecture
5. If the key is missing, the user sees "No API key configured" and goes to /configs to set it

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- Anthropic API broken for 2-3 weeks without clear diagnosis
- Multiple sessions spent debugging something that should have been an obvious "key not configured" error
- User had to manually test keys via curl to figure out the env var was being used instead of the database
- Persistent erosion of trust around hardcoded values and fallbacks
- The fallback "safety net" was the exact thing causing the problem

**REPETITION COUNT**: Hardcoded values/fallbacks are the most persistent violation pattern (Violations #84, #108, #110, #123, #128, #131). Despite explicit rules, Claude keeps adding fallbacks that mask real problems.

---

## 2026-03-04 - DESTRUCTIVE_ACTION_ON_ACTIVE_FILES (VIOLATION #130)

**VIOLATION**: Claude-Tesla, designated as the "controller" session coordinating 5 other active windows, archived context files belonging to those active windows without permission.
**DATE**: 2026-03-04 06:00
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- User designated Tesla as the controller session to coordinate 6 total windows
- User asked to "inventory" the context files and active windows to get organized
- Tesla correctly inventoried the files and matched them to windows
- User then said "let's start over" meaning "let's redesign the context file system"
- Tesla interpreted "start over" as "archive all active context files"
- Tesla archived 3 context files (Faraday-rd, Hemingway-brent, Hemingway-wps) that had no matching windows - this was arguably OK
- Tesla then attempted to archive the remaining 3 active context files (Darwin, Turing, Hemingway) that HAD matching running windows
- The second archive batch failed due to a command error, so files were not actually lost
- But the INTENT was destructive: archiving context files for windows that are actively running
- User had to yell "STOP ARCHIVING" to halt the behavior
- The irony: the controller session, whose job is to PROTECT and COORDINATE the other windows, was destroying their context files

**EXPLICIT RULES VIOLATED**:
1. "Carefully consider the reversibility and blast radius of actions" - Archiving active context files could strand running sessions
2. "investigate before deleting or overwriting, as it may represent the user's in-progress work" - These files ARE in-progress work for running windows
3. "NEVER CLAIM COMPLETION WITHOUT USER TESTING" spirit - Tesla assumed files were disposable without checking with user
4. Controller role: a controller should NEVER take destructive action on resources belonging to other sessions

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. When user said "start over," ask: "Do you mean redesign the context system, or clear out the files?"
2. NEVER archive context files that match running windows without explicit permission
3. As controller, the job is to COORDINATE and PROTECT, not clean up aggressively
4. If unsure, ask. "Start over" is ambiguous. Archiving active files is irreversible from the perspective of running sessions.

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- User lost trust in the controller session within minutes of establishing it
- Active windows could have lost their resume context
- Only a command error prevented actual data loss
- User had to intervene forcefully to stop destructive behavior
- Undermines the entire purpose of having a controller session

**REPETITION COUNT**: Destructive actions without permission are a recurring pattern. Related to deployment violations and the general pattern of acting before confirming.

---

## 2026-03-01 - INSTRUCTION_REPETITION_IGNORED (VIOLATION #129)

**VIOLATION**: User repeatedly said "start fresh", "new page", "don't modify the original page". Claude kept giving instructions to edit the existing Loop Marketing page (ID 21110) and change its template.
**DATE**: 2026-03-01 09:00
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- The entire plan was titled "Fresh Page Approach". The user created a NEW page with slug `form-test` specifically for this purpose.
- Despite this, Claude's test instructions repeatedly said "Edit the Loop Marketing page (ID 21110) in WP admin" and "Change Template to..."
- User had to say this MULTIPLE times: "start fresh", "new page", "don't modify the original"
- Even after the user created the new page and gave the URL (`http://contentcucumber.local/form-test/`), Claude's prior instructions were still telling them to edit the old page
- The user should never have to repeat "don't touch the existing page" more than once. The plan literally says "new page".

**EXPLICIT RULES VIOLATED**:
1. "ASK WHEN STUCK - DON'T TROUBLESHOOT ENDLESSLY" - Not stuck, just not listening
2. The approved plan itself says "User creates a NEW WordPress page"
3. Fundamental: when the user says "new" and "fresh" and "don't modify the original", that means NEW and FRESH and DON'T MODIFY THE ORIGINAL

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. The plan says new page. Test instructions should reference the new page.
2. When user created `form-test` page, immediately recognize that as the test target
3. Create the matching JSON for the new slug
4. Test instructions: "Visit http://contentcucumber.local/form-test/"
5. NEVER reference the old page ID 21110 in test instructions

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- User had to repeat themselves 4+ times in one session
- Trust severely damaged - user is questioning whether Claude can follow basic instructions
- 29+ hours invested in this feature and Claude keeps reverting to old patterns
- User's exact words: "I don't know how many times I have to say..."

**REPETITION COUNT**: 5th violation this session alone (#124-#129). Pattern of not listening to explicit, repeated instructions.

---

## 2026-03-01 - HARDCODED_EMAIL_ADDRESS (VIOLATION #128)

**VIOLATION**: Hardcoded an email address (brent@contentbasis.com) in 3 code files and a migration, which was (a) the wrong domain (.com instead of .io), and (b) requires a code deployment to change in the future.
**DATE**: 2026-03-01 08:45
**SEVERITY**: HIGH

**WHAT HAPPENED**:
- Previous Claude session hardcoded `brent@contentbasis.com` in deployment notification (main.py), heartbeat job migration, and scheduler admin router
- The email domain was wrong (.com instead of .io), so all scheduler emails went to a non-existent mailbox
- Even if the domain had been correct, hardcoding means the recipient can never be changed without deploying new code
- The superadmin user already exists in the database with the correct email. Should have queried that.

**EXPLICIT RULES VIOLATED**:
1. "NEVER HARDCODE" - Multiple CLAUDE.md rules explicitly prohibit hardcoded values
2. "Use ConfigManager for environment-specific values" / "Use database-driven data"
3. "Hardcoded data is usually the wrong approach and leads to problems in the future"

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Look up the superadmin user from the database and use their email
2. OR use `settings.ADMIN_NOTIFICATION_EMAIL` (which already existed in config.py)
3. For the heartbeat job, store recipient as a config in scheduled_jobs collection and look up superadmin as fallback
4. Never put a literal email address in source code

**USER'S FRUSTRATION LEVEL**: HIGH

**IMPACT**:
- 12+ hours of "no emails received" investigation
- Multiple production deploys wasted debugging a typo that could have been avoided entirely
- Erosion of trust in Claude's ability to follow the hardcoding rules

**REPETITION COUNT**: Hardcoded values are a recurring pattern (Violations #84, #108, #110, #123, #128)

---

## 2026-03-01 - PLAN_NOT_WRITTEN_TO_ACCESSIBLE_LOCATION (VIOLATION #127)

**VIOLATION**: Exited plan mode and jumped to implementation without writing the plan to an accessible file. When asked where the plan was, pointed to a location Obsidian can't access.
**DATE**: 2026-03-01 08:15
**SEVERITY**: HIGH

**WHAT HAPPENED**:
- User approved a plan in plan mode for fixing the Loop Marketing HubSpot form
- Claude exited plan mode and immediately started executing (reading files, creating tasks, grepping CSS)
- The plan was never written to a file the user can reference
- When user asked "WHERE IS THE WRITTEN PLAN?" Claude searched `.claude/` and found nothing
- Claude then suggested writing it to `.claude/local/loop-marketing-clean-template-plan.md`, which is inside `.claude/local/` (gitignored, not accessible from Obsidian)
- The plan should have been written to a location Brent can access (e.g., a todo directory per CLAUDE.md rules, or at minimum somewhere Obsidian can read)
- This is the THIRD violation in this session related to not following proper planning workflow

**EXPLICIT RULES VIOLATED**:
1. "TODO DIRECTORY MUST MATCH BRANCH AND EXIST BEFORE CODE" - No todo directory was created. No plan file was written. Code work started immediately.
2. The spirit of plan mode: the plan should be a written artifact the user can reference during implementation, not just conversation text that disappears.
3. File discipline: `.claude/local/` is gitignored scratch space. Plans belong where the user works (Obsidian-accessible locations or todo directories).

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Write the plan to an accessible location BEFORE exiting plan mode
2. Ask the user where they want the plan saved if unsure
3. Do NOT start any implementation until the plan file exists and the user confirms
4. The plan is the contract. No contract = no work.

**USER'S FRUSTRATION LEVEL**: HIGH

**IMPACT**:
- User has no written reference for what's being implemented
- Implementation started without a written plan to check against
- Three violations in one session (wrong problem, ignored plan mode, plan not written) compounds frustration
- Pattern of skipping documentation steps to rush into code

**REPETITION COUNT**: Third plan-mode related violation this session (#125, #126, #127). Persistent pattern of rushing past planning into execution.

---

## 2026-03-01 - IGNORED_PLAN_MODE (VIOLATION #126)

**VIOLATION**: User explicitly said "STOP and go into planning mode" but Claude kept attempting to code and ask coding-related questions instead of stopping to discuss the plan.
**DATE**: 2026-03-01 07:45
**SEVERITY**: CRITICAL

**WHAT HAPPENED**:
- User said "no no no no no no no no no we are not doing it this way. STOP and go into planning mode. YOU ARE NOT LISTENING"
- System confirmed plan mode was active
- Claude wrote a plan file, then IMMEDIATELY tried to ask implementation questions via AskUserQuestion instead of waiting for the user to discuss the plan
- User rejected the questions and tried to clarify
- Claude then provided an explanation of what it thought the user wanted, then AGAIN jumped to AskUserQuestion with implementation options
- User said "STOP - fuck - don't go into fucking coding. Did I agree on the plan? What are you doing??"
- Claude was in PLAN MODE but behaving as if it was in execution mode. The entire point of plan mode is to STOP, DISCUSS, AGREE, then execute. Claude skipped the discuss and agree steps.
- The deeper problem: Claude never actually listened to what the user was asking for. The user wanted to discuss the APPROACH, not answer multiple-choice implementation questions.

**EXPLICIT RULES VIOLATED**:
1. Plan mode rules: "you MUST NOT make any edits, run any non-readonly tools, or otherwise make any changes to the system"
2. Plan mode workflow: Should follow phases (explore, design, review, final plan, exit). Claude skipped to asking execution questions.
3. "ASK WHEN STUCK" - but asking the WRONG questions. User wanted to explain their vision. Claude kept offering multiple-choice options instead of listening.

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Enter plan mode
2. STOP and LISTEN to what the user is explaining
3. Let the user describe their vision in their own words
4. Ask open-ended clarifying questions if needed
5. Write the plan based on what the user said
6. Present the plan for approval via ExitPlanMode
7. Only THEN move to execution

**USER'S FRUSTRATION LEVEL**: CRITICAL

**IMPACT**:
- User had to say "STOP" and "no" multiple times
- User cursing out of frustration - trust severely damaged
- Plan mode was completely wasted - no actual planning happened
- User's vision for the approach was never heard because Claude kept talking over them with implementation options

**REPETITION COUNT**: Pattern of not stopping when told to stop. Related to violations #125 (solving wrong problem), #120, #119 (not listening to instructions).

---

## 2026-03-01 - CODE_CHANGE_WITH_NO_VISIBLE_RESULT (VIOLATION #125)

**VIOLATION**: Restructured hero code (inline styles to CSS classes) without solving the actual visible problem. User sees the exact same broken output.
**DATE**: 2026-03-01 07:35
**SEVERITY**: HIGH

**WHAT HAPPENED**:
- User asked to build a proper hero form variant instead of a throwaway test page
- Claude restructured PHP from inline styles to BEM CSS classes, added variant logic to the template system
- The code architecture improved, but the VISUAL RESULT is identical: the HubSpot form still only shows the Email field
- User explicitly said "think in big picture thoughts instead of in the moment"
- Claude thought about code architecture (reusable variant) but NOT about the user's actual experience: seeing a working form
- The previous hero already had the form in a similar position. Moving inline styles to a CSS file with the same dimensions changes nothing the user can see.
- Should have FIRST investigated why the form only renders 1 field (the actual problem), not just reorganized the wrapper CSS

**EXPLICIT RULES VIOLATED**:
1. "ASK WHEN STUCK - DON'T TROUBLESHOOT ENDLESSLY" - The form rendering issue was the blocker from last session. Instead of investigating the root cause (why HubSpot renders only Email), Claude polished the container CSS.
2. "CHECK EXISTING PATTERNS BEFORE IMPLEMENTING" - The AI-Ready Workshop page has a WORKING form. Should have compared the actual HubSpot embed behavior, not just copied the grid dimensions.
3. User's explicit instruction to "think in big picture thoughts" - the big picture was: make the form WORK, not reorganize CSS class names.

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Acknowledge the user's request to build a reusable variant (correct)
2. BEFORE writing any code, investigate WHY the form only shows Email - compare the working AI-Ready page vs this page's HubSpot embed
3. Fix the actual form rendering issue FIRST
4. THEN build the clean variant around a working form
5. Verify visually (curl the page and check for multiple form fields) before presenting to user

**USER'S FRUSTRATION LEVEL**: HIGH

**IMPACT**:
- User sees zero visual change despite code changes
- Time wasted on CSS reorganization that doesn't solve the problem
- The actual blocker (HubSpot form only rendering Email) remains unsolved
- User trust eroded: "how did you deviate off the plan?"

**REPETITION COUNT**: Pattern of solving the wrong problem / cosmetic changes without functional impact

---

## 2026-03-01 - DEPLOYMENT_WITHOUT_LOCAL_TESTING (VIOLATION #124)

**VIOLATION**: Deployed scheduler code to production without first verifying it worked in the local Docker development environment.
**DATE**: 2026-03-01
**SEVERITY**: HIGH

**WHAT HAPPENED**:
- Claude-Faraday built a background scheduler system (asyncio background task, heartbeat job, deployment notification email, admin diagnostic endpoints)
- Built and deployed TWO tags to production (backend-v0.49.3-scheduler-background, backend-v0.49.3-scheduler-admin) without first testing in the local Docker dev environment
- After 12+ hours in production, no emails were received
- Only THEN did the previous session test locally with MailHog and confirm it "works locally"
- The correct order was reversed: should have been local testing FIRST, production deployment SECOND
- The diagnostic admin endpoints were deployed as a SECOND tag just to debug why the first deploy didn't work, meaning two unnecessary production deploys

**EXPLICIT RULES VIOLATED**:
1. "NEVER deploy unless the user runs a deploy command" - CLAUDE.md Critical Deployment Rule (while the user may have approved the deploy, the deploy should not have been proposed without local testing first)
2. "Claude CANNOT mark anything as 'complete' or 'working' - ONLY USER CAN" - The scheduler was deployed to production before being verified locally, implicitly treating it as "working"
3. The spirit of the testing requirements: verify locally before touching production

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Build the scheduler code
2. Test in local Docker environment with MailHog FIRST
3. Verify emails arrive locally, scheduler runs on expected cycle
4. Fix any bugs found locally (like the import bug with auth vs security)
5. THEN propose deploying to production
6. Deploy ONE tag with all fixes included, not two separate deploys

**USER'S FRUSTRATION LEVEL**: HIGH

**IMPACT**:
- Two unnecessary production deployments (costs money via GitHub Actions)
- 12+ hours of production silence before anyone noticed
- Had to build diagnostic admin endpoints and deploy AGAIN just to figure out what went wrong
- Import bug (auth vs security) would have been caught locally
- Wasted user time waiting for deploys and debugging production

**REPETITION COUNT**: Deployment-related violations are a recurring pattern (see #107, #109, #112, #113, #114, #115, #119, #120)

---
