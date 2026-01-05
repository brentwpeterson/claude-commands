# Claude Commands, Skills & Agents Reference

**Last Updated:** 2026-01-05
**Maintained by:** Brent Peterson

---

## Overview

This document describes all Claude Code commands available in this workspace, their purposes, skill mappings, and whether they're public (shareable) or local (CB-specific).

---

## Command Locations

| Location | Purpose | Git Status |
|----------|---------|------------|
| `.claude/commands/` | Public commands - generic, shareable | Tracked |
| `.claude-local/commands/` | Private commands - CB-specific, contains tokens | Not tracked |

Commands in `.claude-local/` are symlinked to `.claude/commands/` so they work as slash commands.

---

## Quick Reference

```
Session:     /claude-save, /claude-start, /claude-switch, /claude-clean,
             /claude-commit, /claude-complete, /claude-debug

Branch/Task: /create-branch, /create-bugfix, /finish-todo, /plan-feature,
             /update-architecture, /violation-log

Audit:       /a11y-audit, /analyze-refactor-candidates, /audit-branches,
             /audit-codebase, /check-terms, /lighthouse

Deploy:      /deploy-project

Personal:    /brent-start, /brent-finish, /brent-task, /daily-content (local)

Brand:       /brand-brent, /brand-cucumber, /brand-requestdesk,
             /cucumber-writer, /brent-writing (local)
```

---

## Commands

### Session Management

| Command | Purpose | Location |
|---------|---------|----------|
| `/claude-save` | Save session context for handoff to next Claude session. Use when context is running low or ending work. Supports `--quick` for fast saves and `--close` (TODO) for formal session close. | Public |
| `/claude-start` | Resume from a saved session. Reads context file and restores todos, branch state, and next actions. | Public |
| `/claude-switch` | Switch git branches with context preservation. Saves current branch context, switches, loads new branch context. | Public |
| `/claude-clean` | Save all work to current branch, switch to master for fresh start. Includes security scanning. | Public |
| `/claude-commit` | Enhanced commit with security validation. Scans for API keys, credentials, file size limits. Blocks unsafe commits. | Public |
| `/claude-complete` | Complete a branch - run checklist, merge to master, archive documentation, cleanup. | Public |
| `/claude-debug` | Structured debugging with attempt tracking. Prevents circular debugging by logging what was tried. Auto-numbers attempts. | Public |

### Branch & Task Management

| Command | Purpose | Location |
|---------|---------|----------|
| `/create-branch` | Create new branch with standardized todo documentation structure (7 files). | Public |
| `/create-bugfix` | Create bugfix branch from ticket (Sentry, support, etc.) with documentation. | Public |
| `/finish-todo` | Archive completed todo - move to completed folder, document achievements, handle git branch. | Public |
| `/plan-feature` | Interactive feature planning wizard. Guided discovery of requirements before implementation. | Public |
| `/update-architecture` | Update architecture map documentation for CB projects. | Public |
| `/violation-log` | Log Claude violations (deployment without permission, completion claims, etc.). | Public |

### Auditing & Analysis

| Command | Purpose | Location |
|---------|---------|----------|
| `/a11y-audit` | WCAG 2.1 AA accessibility audit using Pa11y with axe-core. | Public |
| `/analyze-refactor-candidates` | Find large/complex files needing refactoring. Categorizes by size and complexity. | Public |
| `/audit-branches` | Review git branches across projects, identify stale branches for cleanup. | Public |
| `/audit-codebase` | Dead code analysis using vulture, complexity metrics using radon. | Public |
| `/check-terms` | Check content against RequestDesk terms API for overused/avoid terms. | Public |
| `/lighthouse` | Lighthouse performance audit for web pages. | Public |

### Deployment

| Command | Purpose | Location |
|---------|---------|----------|
| `/deploy-project` | Deploy any project using tag-based system with iteration support. Works for requestdesk (app) or astro-sites (marketing). Supports `--mark-tested` and `--final` flags. | Public |

### Personal Workflow (Brent-specific)

| Command | Purpose | Location |
|---------|---------|----------|
| `/brent-start` | Daily operating system startup. Load rocks, tasks, content schedule. | Local (symlink) |
| `/brent-finish` | End of day closeout. Log time, capture accomplishments, save context. | Local (symlink) |
| `/brent-task` | Set active task for time tracking. One task at a time, must log before switching. | Local (symlink) |
| `/daily-content` | Content planning dashboard. Review and update content TODO list. | Local (symlink) |

### Brand & Content

| Command | Purpose | Location |
|---------|---------|----------|
| `/brand-brent` | Load Brent Peterson brand persona from API for consistent voice. | Local (symlink) |
| `/brand-cucumber` | Load Content Cucumber brand persona from API. | Local (symlink) |
| `/brand-requestdesk` | Load RequestDesk brand persona from API. | Local (symlink) |
| `/cucumber-writer` | Content creation wizard for Content Cucumber with brand voice. | Local (symlink) |
| `/brent-writing` | Interactive content creation wizard for Brent's content. | Local (no symlink) |

---

## TODO: Commands to Create

| Command | Purpose | Priority |
|---------|---------|----------|
| `/claude-help` | List all commands with descriptions. `--<command>` for details. | High |
| `/content-audit` | SEO/AEO audit with `--enrich` flag for schema enrichment. Combines old seo-audit + aeo-enrich. | Medium |

## TODO: Commands to Update

| Command | Update Needed |
|---------|---------------|
| `/claude-save` | Add `--close` flag (absorb claude-close functionality) |
| `/claude-debug` | Absorb log-debug functionality, add deployment/production debugging |
| `/claude-start` | Add root directory validation, security features from security-start |

---

## Deleted Commands (for reference)

| Command | Reason | Replacement |
|---------|--------|-------------|
| `claude-close` | Redundant | `claude-save --close` (TODO) |
| `claude-resume` | Redundant | `claude-start` |
| `claude-save-mcp` | Redundant | `claude-save` |
| `create-local-command` | Rarely used | Manual process |
| `log-debug` | Merge | `claude-debug` |
| `screenshot` | Never used | Deleted |
| `seo-audit` | Merge | `content-audit` (TODO) |
| `aeo-enrich` | Merge | `content-audit --enrich` (TODO) |
| `deploy-documentation` | Unused | Deleted |
| `deploy-astro-site` | Redundant | `deploy-project astro-sites` |
| `deploy-main-site` | Redundant | `deploy-project astro-sites` |
| `debug-deployment` | Merge | `claude-debug` |
| `debug-production` | Merge | `claude-debug` |
| `view-docker-logs` | Merge | `claude-debug` |
| `security-start` | Merge | `claude-start` |
| `security-close` | Merge | `claude-save --close` |
| `zsolutely` | Not needed | Base Claude behavior |

---

## Skills

Skills are registered automatically from command files. Each command in `.claude/commands/` becomes a skill.

**Current Skills:** All commands listed above have corresponding skills.

---

## Agents

Available agent types for the Task tool:

| Agent | Purpose |
|-------|---------|
| `general-purpose` | Research, code search, multi-step tasks. Has access to all tools. |
| `Explore` | Fast codebase exploration. Find files, search code, answer questions about structure. |
| `Plan` | Software architect for designing implementation plans. Returns step-by-step plans. |
| `claude-code-guide` | Answer questions about Claude Code features, hooks, MCP servers, Agent SDK. |

---

## Changelog

| Date | Change |
|------|--------|
| 2026-01-05 | Major audit - removed 16 redundant commands, consolidated deploy commands, moved brent-* to local |
| 2026-01-04 | Initial document created |
