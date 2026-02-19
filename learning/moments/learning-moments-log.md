# Learning Moments Log

Running log of expectation gaps between what Claude did and what Brent wanted. Not violations (those go in `.claude/violations/`). These are calibration moments.

**Total Moments:** 7

---

## 2026-02-18 - Sprint API Must Match Plan File After Planning (#7)

**Severity:** Always
**Trigger:** Every morning for 3 sprints (S2, S3, S4), /brent-start pulls sprint data from the backlog API and it's broken in a different way. S4: 100 items tagged instead of 22 committed, only 7 have committed=True (wrong ones), points show 0, file paths wrong. An entire planning day was wasted because the API was never reconciled with the plan file.
**Expected:** After sprint planning, the backlog API is reconciled with the plan file before the session ends. committed=True set on actual items, points correct, non-committed items un-tagged. /brent-start reads the API and shows correct committed items every morning without debugging.
**Resolution:** Pending. Communicated to next Claude session via claude-comms. Needs: (1) S4 data fix, (2) permanent fix to sprint planning workflow and /brent-start. Draft CLAUDE.md rule: "After sprint planning, always reconcile the backlog API with the sprint plan file before the planning session ends."

---

## 2026-02-16 - Todo Directory Must Match Branch and Exist Before Code (#6)

**Severity:** Always
**Trigger:** RAG centralization work completed Phases 0 and 1 (deployed to production) with no todo directory. When Claude finally created one at Phase 2, it used a made-up name (`rag-vector-centralization`) instead of matching the branch (`feature/feed-aggregator`). Testing checklist (8th standard file) was also missing from the standard todo structure.
**Expected:** Todo directory created at `/start-work` time, named to match the branch name exactly. All 8 standard files created before any code work: README.md, [branch]-plan.md, progress.log, debug.log, notes.md, architecture-map.md, user-documentation.md, and testing-checklist.md.
**Resolution:** CLAUDE.md rule added. Folder renamed to `feed-aggregator`. All 8 standard files created.

---

## 2026-02-07 - Claude Comms Must Be One Copy-Paste Block (#5)

**Severity:** Always
**Trigger:** User ran `/claude-comms start` to message another Claude about using the wrong directory. Claude asked which recipient, required multiple rounds of back-and-forth, and took 10 minutes for what should have been 30 seconds.
**Expected:** Immediately produce one copy-paste block containing: Claude's own name, the message, and the reply file path. Never ask user to guess recipient names. One block, one paste, done.
**Resolution:** Pending CLAUDE.md rule for /claude-comms skill update.

---

## 2026-02-05 - Never Fabricate Interview Quotes (#4)

**Severity:** Always
**Trigger:** User asked for interview format article about Claude Code agents. Claude wrote a complete fake interview with fabricated Brent quotes instead of actually asking questions and waiting for real answers. Second fabrication incident today.
**Expected:** When user requests interview/dialogue/Q&A format, ACTUALLY conduct the interview. Ask questions one at a time, wait for real answers, use their actual words. Never put words in user's mouth.
**Resolution:** CLAUDE.md rule added: "NEVER FABRICATE CONTENT" section. Covers fake quotes, fake data, fake interviews. Pattern: #3 and #4 are both fabrication - same root issue, now one rule.

---

## 2026-02-05 - Never Fabricate Data (#3)

**Severity:** Always
**Trigger:** Blog draft for WordPress Headless API included specific performance benchmarks ("500+ posts", "45ms", "30ms", "100ms") that were completely fabricated. The feature was built 2 hours prior and only tested locally.
**Expected:** Only state what we actually did and observed. The honest story (we built it today, tested locally, it works) is enough.
**Resolution:** Removed fake "Real Numbers" section from blog draft. CLAUDE.md rule added (see #4).

---

## 2026-02-03 - Document Core Systems Before Using (#2)

**Severity:** Always
**Trigger:** WordPress wizard failed with "Name or service not known". Claude immediately claimed "no LLM providers configured" and started investigating wrong database, when Chat was working fine with same providers. This pattern has happened repeatedly.
**Expected:** Before claiming something is broken, check how the working implementation does it. Document core systems (like LLMService) so they can be reused correctly across features.
**Resolution:** Created `/documentation/docs/technical/api/LLM-SERVICE-USAGE.md` with full usage guide. Pending CLAUDE.md rule.

---

## 2026-02-02 - Commands Need --help (#1)

**Severity:** Always
**Trigger:** Ran `/sprint list-backlog` (unknown subcommand), Claude guessed instead of showing help. Ran `/sprint --help`, got 256-line raw prompt dump.
**Expected:** Clean help output listing available subcommands. Unknown commands point to `--help`.
**Resolution:** Global CLAUDE.md rule added. All 56 commands now support `--help`. Explicit handler added to `/sprint`.

---
