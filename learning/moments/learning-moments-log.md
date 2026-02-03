# Learning Moments Log

Running log of expectation gaps between what Claude did and what Brent wanted. Not violations (those go in `.claude/violations/`). These are calibration moments.

**Total Moments:** 2

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
