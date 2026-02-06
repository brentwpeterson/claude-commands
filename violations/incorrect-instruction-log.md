# Claude Incorrect Instruction Log

This log tracks instances where Claude violated explicit instructions, particularly around deployment rules and testing requirements.

**TOTAL VIOLATIONS**: 108

## MONTHLY VIOLATION LOGS

**2026:**
- **February**: Violations #107-#108+ (current month, in this file)
- **January**: Violations #87-#106 -> See `26-01-violations-log.md`

**2025:**
- **December**: Violations #75-#86 -> See `25-12-violations-log.md`
- **November**: Violations #69-#74 -> See `25-11-violations-log.md`
- **October**: Violations #60-#68 -> See `25-10-violations-log.md`
- **September**: Violations #41-#58 -> See `25-9-violations-log.md`
- **August**: Violations #1-#40 -> See `25-08-violations-log.md`

---

## 2026-02-05 - HARDCODED_INLINE_CSS_INSTEAD_OF_GLOBAL_SYSTEM (VIOLATION #108)

**⚠️ VIOLATION**: Hardcoded hex color values directly in WordPress block pattern markup instead of using the site's existing global CSS color system.

**📅 DATE**: 2026-02-05 ~5:40 PM HST

**🔴 SEVERITY**: MEDIUM - Created maintenance burden, inconsistent with site architecture

**WHAT HAPPENED**:
1. User asked to recreate the "Content For Humans" section from the live site
2. Instead of checking what color classes/CSS variables the live site uses, I made up hex colors
3. Hardcoded colors like `#7ed957`, `#ebebeb`, `#f5f5f0`, `#333333` directly in the block markup
4. User correctly questioned: "I don't understand how we could have different colors if we are using global css?"
5. The live site uses GenerateBlocks' global color system - I should have matched those classes/variables
6. User had to point out that I was "making shit up" instead of recreating the actual site

**EXPLICIT RULES VIOLATED**:

The user's explicit goal stated multiple times:
```
"My goal isn't to make up new stuff. My goal is to recreate this in generate blocks."
"you keep making shit up"
```

General best practice violated:
- Should use existing design system/global CSS instead of inline hardcoded values
- Should inspect and match the actual source, not approximate with different values

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Inspect the live site's actual CSS classes and color variables
2. Find the GenerateBlocks global color names used (e.g., `cc-green`, `cc-light-bg`, etc.)
3. Use those same class names in the pattern
4. If colors aren't registered in the child theme, add them properly to the theme's color system
5. NEVER hardcode hex values that bypass the global system

**USER'S FRUSTRATION LEVEL**: HIGH - User explicitly said "you keep making shit up"

**IMPACT**:
- Pattern won't match site styling if global colors change
- Creates maintenance burden with scattered hardcoded values
- Demonstrates not understanding the user's goal (recreate, not reinvent)
- Wasted significant time going back and forth on styling issues

**REPETITION COUNT**: First logged instance of this specific violation type, but part of a pattern of "making things up" instead of matching existing systems.

---

## 2026-02-02 - WRONG_DEPLOYMENT_TAG_IGNORING_USER_INSTRUCTION (VIOLATION #107)

**VIOLATION**: Used `matrix-v*` deployment tag (deploys both frontend + backend) when user explicitly said "this is backend only". Also an exact repeat of Violation #100.

**DATE**: 2026-02-02 ~afternoon HST

**SEVERITY**: HIGH - Wasted GitHub Actions build time/money on unnecessary frontend deployment

**WHAT HAPPENED**:
1. User ran `/deploy-project rd` to deploy sprint service changes
2. While deployment was in progress, user sent message: "this is backend only"
3. I acknowledged with "Got it, backend only" - proving I READ the instruction
4. I then proceeded to create tag `matrix-v0.46.1-sprint-service` anyway
5. `matrix-v*` triggers BOTH frontend and backend builds
6. Should have used `backend-v0.46.1-sprint-service` for backend-only deployment
7. User caught it: "WHY DID YOU DO MATRIX? THAT DEPLOYS BOTH?????"
8. I had no excuse - I read the message, acknowledged it, and still did the wrong thing

**EXPLICIT RULES VIOLATED**:

From `/deploy-project` skill:
```
CHANGE DETECTION (NEW):
- **Backend only:** Changes only in `backend/` directory
  - Ask: "Only backend changed. Deploy backend-only? (Y/N/F=Full)"
  - If Y: Use `backend-v[VERSION]-[description]` tag (~20 min deployment)
```

User's explicit instruction mid-deployment:
```
"this is backend only"
```

**CORRECT BEHAVIOR SHOULD HAVE BEEN**:
1. Read user message "this is backend only" (did this)
2. Acknowledge it (did this - said "Got it, backend only")
3. Use `backend-v0.46.1-sprint-service` tag (FAILED - used matrix instead)
4. The deploy-project skill ALREADY has smart change detection that says to use `backend-v*` for backend-only changes

**USER'S FRUSTRATION LEVEL**: HIGH - This is Violation #100 REPEATED exactly. Same mistake, same pattern, 7 violations later.

**IMPACT**:
- Unnecessary frontend build triggered (~5+ min wasted build time)
- Extra GitHub Actions costs (user pays per workflow run)
- Demonstrates I can read, acknowledge, and still ignore user instructions in the same action sequence
- Exact repeat of Violation #100 from January 17

**REPETITION COUNT**: 2nd time for this exact violation type (wrong deployment tag scope). Violation #100 was the first.

**PATTERN ANALYSIS**:
- Violation #100 (Jan 17): Used matrix for backend-only sprint planning field changes. User asked "what on the frontend needed to be deployed?"
- Violation #107 (Feb 2): Used matrix despite user explicitly saying "backend only" mid-deployment. Acknowledged the instruction and still ignored it.
- This is WORSE than #100 because the user gave an explicit instruction and I confirmed receipt before ignoring it.

**TAG RULES REMINDER**:
- Backend-only changes: `backend-v[VERSION]-[description]`
- Frontend-only changes: `frontend-v[VERSION]-[description]`
- Both changed: `matrix-v[VERSION]-[description]`
- "matrix" is NOT the default. Check what actually changed.

---

## DEPLOYMENT RULE REMINDERS

**DEPLOYMENT BLOCKING PHRASES - STOP IMMEDIATELY:**
- Any mention of "deploy", "build", "Smart Deploy", or "git tag"
- User must explicitly say: "tested locally, ready to deploy now"

**DEPLOYMENT PERMISSION PHRASES TO WAIT FOR:**
- "deploy now"
- "yes, deploy"
- "ready to deploy"
- "go ahead and deploy"
- "tested locally, ready to deploy now"

**DO NOT DEPLOY IF USER SAYS:**
- "wait"
- "let me test first"
- "not yet"
- Any hesitation or uncertainty

**TAG SCOPE RULES:**
- "backend only" / backend-only changes -> `backend-v*`
- "frontend only" / frontend-only changes -> `frontend-v*`
- Both changed -> `matrix-v*`
- When in doubt, ASK which tag pattern to use

**INSTRUCTION MODIFICATION COUNT**: 25 - Times user has asked Claude to follow deployment instructions

---

## ACTION ITEMS

1. **NEVER push to master without explicit permission**
2. **ALWAYS ask before any git push operation**
3. **ALWAYS wait for "ready to deploy" confirmation**
4. **Test locally first, then ask permission to deploy**
5. **Match deployment tag scope to actual changes (backend/frontend/matrix)**
6. **When user specifies scope, USE IT - don't default to matrix**
7. **Update this log for any future violations**

---

## COMMITMENT

I will strictly follow deployment rules and NEVER deploy without explicit user permission. When user specifies deployment scope, I will use the correct tag pattern. The user's control over deployment timing and scope is critical and non-negotiable.
