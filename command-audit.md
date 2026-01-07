# Claude Commands Audit

**Generated:** 2026-01-04
**Audited by:** Claude Code

---

## Executive Summary

| Metric | Count |
|--------|-------|
| Total Commands (public) | 44 |
| Total Commands (local) | 6 |
| Commands with Skills | 44/44 (100%) |
| Symlinked to .claude-local | 4 |
| **Needs Migration to .claude-local** | **6** |
| Contains API Tokens | 4 |
| Contains Hardcoded Paths | 6 |
| Contains Production URLs | 2 |

### Critical Issues

| Priority | Issue | Command | Action Required |
|----------|-------|---------|-----------------|
| **HIGH** | API token in public repo | `brand-brent.md` | Move to .claude-local |
| **HIGH** | Hardcoded user paths | `brent-*.md`, `daily-content.md` | Make generic or move |
| **MEDIUM** | Duplicate file | `brand-brent.md` | Remove from .claude/commands/ |
| **LOW** | Missing symlink | `brent-writing.md` | Add symlink if needed |

---

## Commands Inventory

### Public Commands (`.claude/commands/`)

| Command | Has Skill | Last Updated | Purpose | Sensitive Content |
|---------|-----------|--------------|---------|-------------------|
| `a11y-audit.md` | Yes | 2025-12-16 | WCAG 2.1 AA accessibility audit using Pa11y | None |
| `aeo-enrich.md` | Yes | 2025-12-13 | AEO/GEO page enrichment with schemas | None |
| `analyze-refactor-candidates.md` | Yes | 2025-09-22 | Find files needing refactoring by size/complexity | None |
| `audit-branches.md` | Yes | 2025-10-28 | Review and clean up git branches across projects | None |
| `audit-codebase.md` | Yes | 2025-12-20 | Python/FastAPI dead code and complexity analysis | None |
| `brand-brent.md` | Yes | 2025-12-27 | Load Brent Peterson brand persona | **API TOKEN** |
| `brand-cucumber.md` | Yes (symlink) | 2025-12-27 | Load Content Cucumber brand persona | Symlink to local |
| `brand-requestdesk.md` | Yes (symlink) | 2025-12-15 | Load RequestDesk brand persona | Symlink to local |
| `brent-finish.md` | Yes | 2025-12-31 | End of day closeout and time logging | **HARDCODED PATHS** |
| `brent-start.md` | Yes | 2026-01-04 | Daily operating system startup | **HARDCODED PATHS** |
| `brent-task.md` | Yes | 2026-01-02 | Set active task for time tracking | **HARDCODED PATHS** |
| `check-terms.md` | Yes | 2025-12-30 | Check content against terms API | **PROD URL** |
| `claude-clean.md` | Yes | 2025-09-22 | Save work and start clean session on master | None |
| `claude-close.md` | Yes | 2025-11-14 | Standardized session handoff | None |
| `claude-commit.md` | Yes | 2025-09-22 | Enhanced commit with security validation | None |
| `claude-complete.md` | Yes | 2025-11-14 | Complete branch with checklist | None |
| `claude-debug.md` | Yes | 2025-10-28 | Structured debug session with regression tracking | None |
| `claude-resume.md` | Yes | 2025-11-14 | Resume work on specific branch | None |
| `claude-save-mcp.md` | Yes | 2025-11-17 | Save session with MCP verification | None |
| `claude-save.md` | Yes | 2026-01-02 | Save session and create handoff | None |
| `claude-start.md` | Yes | 2025-12-18 | Start session from saved instructions | **HARDCODED PATHS** |
| `claude-switch.md` | Yes | 2025-12-19 | Smart branch switching with context | None |
| `create-branch.md` | Yes | 2025-11-14 | Create branch with documentation structure | None |
| `create-bugfix.md` | Yes | 2025-11-14 | Create bugfix branch from ticket | None |
| `create-local-command.md` | Yes | 2025-11-01 | Create local command with symlink | None |
| `cucumber-writer.md` | Yes (symlink) | 2025-12-27 | Content creation with Cucumber brand | Symlink to local |
| `daily-content.md` | Yes | 2025-12-31 | Daily content planning dashboard | **HARDCODED PATHS** |
| `debug-deployment.md` | Yes | 2025-08-05 | Debug deployment failures | None |
| `debug-production.md` | Yes | 2025-08-02 | Debug production issues | None |
| `deploy-astro-site.md` | Yes | 2025-12-13 | Deploy Astro site from shared container | None |
| `deploy-documentation.md` | Yes | 2025-08-25 | Deploy documentation site | None |
| `deploy-main-site.md` | Yes (symlink) | 2025-11-01 | Deploy RequestDesk main site | Symlink to local |
| `deploy-project.md` | Yes | 2025-12-19 | Deploy project with tag-based system | None |
| `finish-todo.md` | Yes | 2025-11-14 | Complete todo and archive | None |
| `lighthouse.md` | Yes | 2025-12-20 | Lighthouse performance audit | None |
| `log-debug.md` | Yes | 2025-09-19 | Log debug attempt | None |
| `plan-feature.md` | Yes | 2025-11-17 | Interactive feature planning wizard | None |
| `screenshot.md` | Yes | 2025-12-24 | Screenshot capture and analysis | None |
| `security-close.md` | Yes | 2025-10-28 | Security-focused session close | None |
| `security-start.md` | Yes | 2025-09-19 | Security-focused session start | None |
| `seo-audit.md` | Yes | 2025-12-13 | SEO/AEO audit | None |
| `update-architecture.md` | Yes | 2025-11-02 | Update architecture map documentation | None |
| `view-docker-logs.md` | Yes | 2025-08-26 | View Docker container logs | None |
| `violation-log.md` | Yes | 2025-11-02 | Log Claude violations | None |
| `zsolutely.md` | Yes | 2025-09-19 | Stop repetitive agreement phrases | None |

### Local Commands (`.claude-local/commands/`)

| Command | Symlinked | Last Updated | Purpose | Sensitive Content |
|---------|-----------|--------------|---------|-------------------|
| `brand-brent.md` | No (duplicate exists in public) | 2025-12-24 | Brent Peterson brand persona | **API TOKEN** |
| `brand-cucumber.md` | Yes | 2025-12-27 | Content Cucumber brand persona | **API TOKEN** |
| `brand-requestdesk.md` | Yes | 2025-12-15 | RequestDesk brand persona | **API TOKEN** |
| `brent-writing.md` | **No** | 2025-12-31 | Interactive content creation wizard | **API TOKEN** |
| `cucumber-writer.md` | Yes | 2025-12-27 | Content creation for Cucumber | **API TOKEN** |
| `deploy-main-site.md` | Yes | 2025-11-02 | Main site deployment | CB-specific |

---

## Sensitive Content Analysis

### API Tokens Exposed in Public Commands

| Command | Token Preview | Risk |
|---------|--------------|------|
| `brand-brent.md` | `WOfNoONZNyPOEja1-ClY2-...` | **HIGH** - Token in public repo |

**Recommendation:** Remove `brand-brent.md` from `.claude/commands/` - it's a duplicate of the file in `.claude-local/commands/`

### Hardcoded Paths

| Command | Path Pattern | Issue |
|---------|-------------|-------|
| `brent-start.md` | `/Users/brent/scripts/CB-Workspace/` | User-specific |
| `brent-finish.md` | `/Users/brent/scripts/CB-Workspace/` | User-specific |
| `brent-task.md` | `/Users/brent/scripts/CB-Workspace/` | User-specific |
| `daily-content.md` | `/Users/brent/scripts/CB-Workspace/` | User-specific |
| `claude-start.md` | Project directory mappings | User-specific |

**Recommendation:** These are personal workflow commands. Either:
1. Move to `.claude-local/` and symlink, OR
2. Make them generic with environment variable substitution

### Production URLs

| Command | URL | Risk |
|---------|-----|------|
| `check-terms.md` | `https://app.requestdesk.ai/api/public/content-terms` | Low - public endpoint |
| `brand-*.md` | `https://app.requestdesk.ai/api/agent/content` | Low - but tokens are the issue |

---

## Recommendations

### Immediate Actions (Priority 1)

1. **Remove duplicate `brand-brent.md` from public**
   ```bash
   rm /Users/brent/scripts/CB-Workspace/.claude/commands/brand-brent.md
   # Then symlink:
   cd /Users/brent/scripts/CB-Workspace/.claude/commands
   ln -s ../../.claude-local/commands/brand-brent.md brand-brent.md
   ```

2. **Add symlink for `brent-writing.md`** (if needed as slash command)
   ```bash
   cd /Users/brent/scripts/CB-Workspace/.claude/commands
   ln -s ../../.claude-local/commands/brent-writing.md brent-writing.md
   ```

### Medium-Term Actions (Priority 2)

3. **Move personal workflow commands to .claude-local**

   These commands are Brent-specific and contain hardcoded paths:
   - `brent-start.md`
   - `brent-finish.md`
   - `brent-task.md`
   - `daily-content.md`

   Either move them to `.claude-local/` or make them generic with workspace detection.

4. **Update `.gitignore`** to exclude new symlinks:
   ```gitignore
   # Personal commands (symlinked from .claude-local)
   .claude/commands/brand-brent.md
   .claude/commands/brent-writing.md
   .claude/commands/brent-start.md
   .claude/commands/brent-finish.md
   .claude/commands/brent-task.md
   .claude/commands/daily-content.md
   ```

### Low-Priority Improvements (Priority 3)

5. **Add workspace detection to personal commands**

   Instead of hardcoded paths, use:
   ```bash
   WORKSPACE_ROOT="${CB_WORKSPACE:-$(git rev-parse --show-toplevel)/..}"
   ```

6. **Document command categories**

   Consider organizing commands by purpose:
   - Session management: `claude-*`
   - Personal workflow: `brent-*`
   - Content creation: `*-writer`, `brand-*`
   - Auditing: `*-audit`, `audit-*`
   - Deployment: `deploy-*`

---

## Command Categories

### Session Management (Generic - Keep Public)
- `claude-clean.md`
- `claude-close.md`
- `claude-commit.md`
- `claude-complete.md`
- `claude-debug.md`
- `claude-resume.md`
- `claude-save.md`
- `claude-save-mcp.md`
- `claude-start.md`
- `claude-switch.md`

### Development Workflow (Generic - Keep Public)
- `create-branch.md`
- `create-bugfix.md`
- `create-local-command.md`
- `finish-todo.md`
- `log-debug.md`
- `plan-feature.md`
- `update-architecture.md`
- `violation-log.md`

### Auditing & Analysis (Generic - Keep Public)
- `a11y-audit.md`
- `aeo-enrich.md`
- `analyze-refactor-candidates.md`
- `audit-branches.md`
- `audit-codebase.md`
- `check-terms.md`
- `lighthouse.md`
- `screenshot.md`
- `seo-audit.md`

### Deployment (Mixed)
- `deploy-astro-site.md` - Generic, keep public
- `deploy-documentation.md` - Generic, keep public
- `deploy-project.md` - Generic, keep public
- `deploy-main-site.md` - CB-specific, correctly in local

### Debugging (Generic - Keep Public)
- `debug-deployment.md`
- `debug-production.md`
- `view-docker-logs.md`

### Security (Generic - Keep Public)
- `security-close.md`
- `security-start.md`

### Personal/Brent-Specific (Should be Local)
- `brent-finish.md` - Move to local
- `brent-start.md` - Move to local
- `brent-task.md` - Move to local
- `daily-content.md` - Move to local

### Brand/Content (Correctly in Local)
- `brand-brent.md` - In local, but duplicate in public (remove public)
- `brand-cucumber.md` - Correctly symlinked
- `brand-requestdesk.md` - Correctly symlinked
- `brent-writing.md` - In local, no symlink
- `cucumber-writer.md` - Correctly symlinked

### Utility (Generic - Keep Public)
- `zsolutely.md`

---

## Skill Mapping

All 44 commands have corresponding skills registered. The skill system appears to be 1:1 with commands.

| Skill Name | Command File | Notes |
|------------|--------------|-------|
| `a11y-audit` | `a11y-audit.md` | Match |
| `aeo-enrich` | `aeo-enrich.md` | Match |
| `analyze-refactor-candidates` | `analyze-refactor-candidates.md` | Match |
| `audit-branches` | `audit-branches.md` | Match |
| `audit-codebase` | `audit-codebase.md` | Match |
| `brand-brent` | `brand-brent.md` | Match |
| `brand-cucumber` | `brand-cucumber.md` | Match (symlink) |
| `brand-requestdesk` | `brand-requestdesk.md` | Match (symlink) |
| `brent-finish` | `brent-finish.md` | Match |
| `brent-start` | `brent-start.md` | Match |
| `brent-task` | `brent-task.md` | Match |
| `check-terms` | `check-terms.md` | Match |
| `claude-clean` | `claude-clean.md` | Match |
| `claude-close` | `claude-close.md` | Match |
| `claude-commit` | `claude-commit.md` | Match |
| `claude-complete` | `claude-complete.md` | Match |
| `claude-debug` | `claude-debug.md` | Match |
| `claude-resume` | `claude-resume.md` | Match |
| `claude-save` | `claude-save.md` | Match |
| `claude-save-mcp` | `claude-save-mcp.md` | Match |
| `claude-start` | `claude-start.md` | Match |
| `claude-switch` | `claude-switch.md` | Match |
| `create-branch` | `create-branch.md` | Match |
| `create-bugfix` | `create-bugfix.md` | Match |
| `create-local-command` | `create-local-command.md` | Match |
| `cucumber-writer` | `cucumber-writer.md` | Match (symlink) |
| `daily-content` | `daily-content.md` | Match |
| `debug-deployment` | `debug-deployment.md` | Match |
| `debug-production` | `debug-production.md` | Match |
| `deploy-astro-site` | `deploy-astro-site.md` | Match |
| `deploy-documentation` | `deploy-documentation.md` | Match |
| `deploy-main-site` | `deploy-main-site.md` | Match (symlink) |
| `deploy-project` | `deploy-project.md` | Match |
| `finish-todo` | `finish-todo.md` | Match |
| `lighthouse` | `lighthouse.md` | Match |
| `log-debug` | `log-debug.md` | Match |
| `plan-feature` | `plan-feature.md` | Match |
| `screenshot` | `screenshot.md` | Match |
| `security-close` | `security-close.md` | Match |
| `security-start` | `security-start.md` | Match |
| `seo-audit` | `seo-audit.md` | Match |
| `update-architecture` | `update-architecture.md` | Match |
| `view-docker-logs` | `view-docker-logs.md` | Match |
| `violation-log` | `violation-log.md` | Match |
| `zsolutely` | `zsolutely.md` | Match |

---

## Appendix: File Stats

### Oldest Commands (may need review)
1. `debug-production.md` - 2025-08-02 (5 months old)
2. `debug-deployment.md` - 2025-08-05
3. `deploy-documentation.md` - 2025-08-25
4. `view-docker-logs.md` - 2025-08-26

### Most Recently Updated
1. `brent-start.md` - 2026-01-04 (today)
2. `claude-save.md` - 2026-01-02
3. `brent-task.md` - 2026-01-02
4. `brent-finish.md` - 2025-12-31
5. `daily-content.md` - 2025-12-31
