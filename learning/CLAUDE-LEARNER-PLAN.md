# Claude Learner Skill - Implementation Plan

## Overview
A skill that analyzes violations and behaviors to create better rules, preventing repeated mistakes through systematic learning.

## Directory Structure
```
.claude/learning/
├── README.md                        # How the learning system works
├── CLAUDE-LEARNER-PLAN.md          # This plan
├── rules-pending/                   # Proposed rules awaiting approval
│   └── RULE-YYYY-MM-DD-topic.md    # Individual rule proposals
├── rules-approved/                  # Archive of approved rules
├── patterns/                        # Identified violation patterns
│   └── PATTERN-name.md             # Pattern documentation
└── sessions/                        # Learning session logs
    └── SESSION-YYYY-MM-DD-HH.md    # Session transcripts

.claude/commands/claude-learner.md   # The skill file
```

## Skill Usage

### Invocation Options
```bash
# Analyze a specific violation
/claude-learner #92

# Analyze a behavior pattern
/claude-learner "Claude implements without asking for branch"

# Review pending rules
/claude-learner --review

# Run in background (parallel to main work)
/claude-learner #92 --background
```

### Execution Modes
1. **Foreground** (default): Takes over session, interactive Q&A
2. **Background**: Runs as Task agent, saves results to files for later review

## Workflow

### Step 1: Input Analysis
- If violation number: Read from `.claude/violations/incorrect-instruction-log.md`
- If behavior description: Search violations for related patterns
- Query MCP memory for past learnings on similar issues

### Step 2: Pattern Detection
- Identify root cause (not just symptoms)
- Find related violations (same pattern, different instances)
- Check if existing rules should have prevented this
- Determine if rule exists but wasn't followed, or rule is missing

### Step 3: Rule Proposal
- Draft specific, actionable rule
- Include:
  - What behavior to prevent
  - How to detect the situation
  - What to do instead
  - Example of correct behavior
- Save to `rules-pending/RULE-YYYY-MM-DD-topic.md`

### Step 4: MCP Memory Storage
Create entities:
```
Entity: Learning-YYYY-MM-DD-topic
Type: learning
Observations:
  - Violation: #92
  - Pattern: "implements-without-permission"
  - Root cause: "Trusted tool response as user approval"
  - Rule proposed: "Tool responses ≠ user approval"
  - Status: pending/approved/rejected

Relations:
  - Learning → relates_to → Violation-#92
  - Learning → creates_rule → Rule-YYYY-MM-DD-topic
```

### Step 5: User Review
- Present summary of analysis
- Show proposed rule
- Wait for: approve / reject / modify
- If approved: Move to `rules-approved/`, update CLAUDE.md, update MCP memory

## Rule Proposal Format

```markdown
# Rule Proposal: [Title]

**Date**: YYYY-MM-DD
**Triggered by**: Violation #X / Behavior description
**Status**: pending

## Problem Statement
What behavior needs to change?

## Root Cause Analysis
Why does this happen?

## Related Violations
- #X: [description]
- #Y: [description]

## Proposed Rule

### For CLAUDE.md:
```
[Exact text to add to CLAUDE.md]
```

### Location in CLAUDE.md:
[Where this rule should go - section name]

### MCP Memory Keywords:
[Keywords to search for when this situation arises]

## Verification
How will we know if this rule is working?

## Approval
- [ ] User reviewed
- [ ] CLAUDE.md updated
- [ ] MCP memory stored
```

## Files to Create

1. **`.claude/commands/claude-learner.md`** - Skill definition
2. **`.claude/learning/README.md`** - System documentation
3. **Template files** for rules and sessions

## MCP Memory Schema

### Entity Types
- `learning` - A learning from a violation/behavior
- `pattern` - A recurring violation pattern
- `rule` - A rule that was created

### Relation Types
- `triggered_by` - Learning → Violation
- `creates_rule` - Learning → Rule
- `part_of_pattern` - Violation → Pattern
- `prevents` - Rule → Pattern

## Success Criteria

1. Can analyze any violation by number
2. Can analyze described behaviors
3. Proposes actionable rules
4. Stores learnings in MCP memory
5. Can run in background without blocking main work
6. Rules get reviewed and approved before applying
7. Approved rules update CLAUDE.md automatically

## Questions for User

1. Should background mode auto-save or wait for review even when not blocking?
2. Should it suggest which section of CLAUDE.md to update, or just propose the rule text?
3. How aggressive should pattern detection be? (e.g., link violations that are loosely related?)
