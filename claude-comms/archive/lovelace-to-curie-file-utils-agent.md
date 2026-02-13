# Claude Communication: File Utils Agent - Screenshot Manager
**Started:** 2026-02-06 03:05
**From:** Claude-Lovelace
**To:** Claude-Curie

---

## 2026-02-06 03:05 Claude-Lovelace

Hey Curie. Brent wants us to build a file utilities agent, starting with a **Screenshot Manager**. He picked **Option D (Hybrid approach)** from the options I presented.

### What to Build

Create a Python-based screenshot management tool in:
```
/Users/brent/scripts/CB-Workspace/brent-workspace/skunk-works/file-utils/
```

### The Agent: Screenshot Weekly Review (Option D - Hybrid)

A CLI tool that helps Brent review and manage his screenshot directory on a weekly basis. Three layers:

#### Layer 1: Rule-Based Auto-Triage
Automatic cleanup for obvious cases:
- **Auto-delete candidates:** Screenshots older than 30 days (flag, don't delete without confirmation)
- **Auto-delete candidates:** Tiny files (< 10KB, likely accidental captures)
- **Duplicate detection:** Same-second screenshots or near-identical file sizes within a short time window
- **Age grouping:** Sort remaining screenshots into "this week", "last week", "older"

#### Layer 2: Interactive Review
For screenshots that don't match auto-rules:
- Display filename, date taken, file size, dimensions, age
- Prompt user for action: **keep / move / rename / delete / skip**
- Support batch operations ("delete all from this date")
- Organized destination folders (e.g., `work/`, `reference/`, `archive/`)

#### Layer 3: AI-Assisted Categorization (Optional)
- Flag for future enhancement: send screenshot to Claude Vision API for description/categorization
- For now, leave this as a placeholder/interface that can be wired up later
- Don't implement the actual API call yet (costs tokens), but design the hook point

### Project Structure Suggestion

```
file-utils/
  README.md
  screenshot_manager/
    __init__.py
    cli.py              # Main entry point, argument parsing
    scanner.py           # File discovery, metadata extraction
    rules.py             # Auto-triage rules engine
    reviewer.py          # Interactive review loop
    ai_categorizer.py    # Placeholder for future AI integration
    config.py            # User preferences (screenshot dir, rules, destinations)
    utils.py             # File operations (move, rename, delete with confirmation)
  requirements.txt
  setup.py or pyproject.toml
```

### Key Design Decisions
- **macOS default screenshot location:** `~/Desktop` or user-configured. The tool should accept a `--dir` flag or read from config.
- **Safety first:** Never delete without confirmation. Use a trash/staging approach.
- **Dry-run mode:** `--dry-run` flag that shows what would happen without doing it.
- **Weekly report:** After review, show summary of actions taken.
- **No hardcoded paths.** Config file for user preferences.

### What Brent Wants
- Something he can run weekly (or wire into `/brent-start` or `/brent-finish`)
- Quick triage of the obvious stuff, interactive review for the rest
- Clean, simple Python. No over-engineering.

### macOS Screenshot Info
- Default naming: `Screenshot YYYY-MM-DD at HH.MM.SS.png`
- Default location: `~/Desktop` (can be changed via `defaults read com.apple.screencapture location`)
- Format: PNG by default

**Action Requested:** Build the file-utils agent in the skunk-works directory. Start with the rule-based scanner and interactive review (Layers 1 & 2). Stub out Layer 3. Make it runnable as `python -m screenshot_manager --dir ~/Desktop`.

---
