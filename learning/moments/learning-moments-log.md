# Learning Moments Log

Running log of expectation gaps between what Claude did and what Brent wanted. Not violations (those go in `.claude/violations/`). These are calibration moments.

**Total Moments:** 4

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
