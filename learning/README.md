# Claude Learning System

A systematic approach to learning from violations and improving Claude's behavior over time.

## Purpose

Instead of just logging violations, this system:
1. **Analyzes** why violations happen (root cause)
2. **Identifies patterns** across multiple violations
3. **Proposes rules** to prevent recurrence
4. **Stores learnings** in MCP memory for cross-session persistence
5. **Tracks effectiveness** of rules over time

## Quick Start

```bash
# Analyze a violation
/claude-learner #92

# Analyze in background while you work
/claude-learner #92 --background

# Review pending rules
/claude-learner --review
```

## Directory Structure

```
.claude/learning/
├── README.md                 # This file
├── rules-pending/            # Rules awaiting approval
├── rules-approved/           # Archive of approved rules
├── patterns/                 # Documented violation patterns
└── sessions/                 # Learning session logs
```

## Workflow

### 1. Violation Occurs
- User runs `/violation-log` to document it
- Violation is logged in `.claude/violations/`

### 2. Learning Session
- User runs `/claude-learner #[number]`
- System analyzes root cause
- Checks MCP memory for related learnings
- Drafts rule proposal

### 3. Review & Approval
- User runs `/claude-learner --review`
- Reviews proposed rules
- Approves, rejects, or modifies
- Approved rules are applied to CLAUDE.md

### 4. MCP Memory
- Learnings stored as entities
- Patterns linked to violations
- Rules linked to patterns they prevent
- Persists across sessions

## File Formats

### Rule Proposal (rules-pending/)
```markdown
# Rule Proposal: [Title]

**Date**: YYYY-MM-DD
**Triggered by**: Violation #X
**Status**: pending

## Problem Statement
## Root Cause
## Related Violations
## Proposed Rule
## Verification
```

### Pattern Documentation (patterns/)
```markdown
# Pattern: [Name]

**First seen**: Violation #X
**Occurrences**: #X, #Y, #Z

## Description
## Root Cause
## Prevention Rule
## Status
```

## MCP Memory Entities

### Learning Entity
```
Name: Learning-2026-01-09-tool-approval
Type: learning
Observations:
  - Violation: #92
  - Root cause: Trusted tool response as user approval
  - Pattern: implements-without-permission
  - Status: pending
```

### Pattern Entity
```
Name: Pattern-implements-without-permission
Type: pattern
Observations:
  - Violations: #87, #89, #92
  - Description: Claude starts implementing without explicit user permission
  - Rule created: Yes
```

## Best Practices

1. **Run after violations** - Don't just log, learn
2. **Use background mode** - Analyze without blocking work
3. **Review weekly** - Approve pending rules regularly
4. **Check patterns** - Same violation 3x = pattern needs stronger rule
5. **Update rules** - If violation recurs, rule wasn't strong enough

## Metrics (Future)

- Violations per pattern
- Days since last occurrence
- Rule effectiveness (violations before/after)
