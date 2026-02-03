# Learning Moments Log

Running log of expectation gaps between what Claude did and what Brent wanted. Not violations (those go in `.claude/violations/`). These are calibration moments.

**Total Moments:** 1

---

## 2026-02-02 - Commands Need --help (#1)

**Severity:** Always
**Trigger:** Ran `/sprint list-backlog` (unknown subcommand), Claude guessed instead of showing help. Ran `/sprint --help`, got 256-line raw prompt dump.
**Expected:** Clean help output listing available subcommands. Unknown commands point to `--help`.
**Resolution:** Global CLAUDE.md rule added. All 56 commands now support `--help`. Explicit handler added to `/sprint`.

---
