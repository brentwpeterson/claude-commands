# Improvement: /claude-start Name Duplication Safeguards

**Logged:** 2026-02-12
**Reporter:** Brent
**Severity:** Medium (causes confusion)

## Problem
Agents are taking existing names and context files. Multiple Claude instances end up as "Claude-Earhart" creating overlapping context files.

## Proposed Safeguards for /claude-start

1. **Ask how many open sessions there are** - before picking a name, verify with user how many windows are actually open
2. **Strict name uniqueness** - if a name is in `active-claude-names.json`, it is BLOCKED. No exceptions.
3. **If no existing context file, MUST create new name** - an agent without a context file should never adopt an existing identity
4. **Session count validation** - compare `active-claude-names.json` count to user-reported window count. If mismatch, clean up stale names first.
5. **On startup, show active names** - "Currently registered: Claude-Darwin, Claude-Earhart. How many windows do you actually have open?"

## Implementation Location
- `.claude/skills/communicate-claude/SKILL.md` - name registration logic
- `.claude/commands/claude-start.md` - startup sequence
- `.claude/commands/brent-start.md` - daily startup (Step 0.5)

## Status
Logged for next skill update
