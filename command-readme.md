# Claude Commands Reference

**Last Updated:** 2026-02-02
**Total Commands:** 55

---

## Quick Reference

```
Session:       /claude-save, /claude-start, /claude-switch, /claude-clean,
               /claude-commit, /claude-complete, /claude-debug, /claude-trash

Communication: /claude-comms

Task/Sprint:   /start-work, /create-bugfix, /finish-todo, /sprint,
               /add-backlog, /plan-feature

Development:   /update-architecture, /frontend-design, /sync-wp-plugin

Audit:         /a11y-audit, /analyze-refactor-candidates, /audit-branches,
               /audit-codebase, /check-terms, /content-audit, /lighthouse,
               /sentry-report

Deploy:        /deploy-project

Content:       /brand-brent, /brand-cucumber, /brand-requestdesk,
               /cucumber-writer, /rd-blog, /daily-content,
               /newsletter-planner, /canva

Social:        /create-social, /plan-social

Email/CRM:     /respond-email, /respond-comment, /send-email,
               /hubspot-enrich, /detect-platform

Personal:      /brent-start, /brent-finish, /brent-task

TWC:           /twc-start, /twc-finish, /twc-note, /twc-status, /twc-backlog

Meta:          /claude-help, /claude-learner, /violation-log, /rotate-violations

Deprecated:    /create-branch (use /start-work)
```

---

## Session Management

| Command | Purpose |
|---------|---------|
| `/claude-save <project> [flags] [X%]` | Save session context for handoff. Modes: full (>15%), quick (8-15% or `--quick`), emergency (<8%). Flags: `--close`, `--backlog`, `--no-todo`. |
| `/claude-start <project>` | Resume from saved session. Reads context file, restores branch state and next actions. |
| `/claude-switch` | Switch git branches with context preservation. Saves current context, switches, loads new. |
| `/claude-clean` | Save work to current branch, switch to master for fresh start. Includes security scanning. |
| `/claude-commit` | Enhanced commit with security validation. Scans for API keys, credentials, hardcoded URLs. |
| `/claude-complete` | Complete a branch. Run checklist, merge to master, archive documentation. |
| `/claude-debug` | Structured debugging with attempt tracking. Prevents circular debugging by logging what was tried. |
| `/claude-trash [name]` | Close window and clean up. Archives context files and comms, removes name from registries. |

## Inter-Claude Communication

| Command | Purpose |
|---------|---------|
| `/claude-comms` | Check inbox for messages from other Claude instances. |
| `/claude-comms <name>` | Check inbox as a specific identity (e.g., `/claude-comms galileo`). |
| `/claude-comms start` | Start a new conversation with another Claude. Shows active instances, writes message file, gives handoff instructions. |

## Task & Sprint Management

| Command | Purpose |
|---------|---------|
| `/start-work` | Create task with mandatory acceptance criteria. Replaces `/create-branch`. |
| `/create-bugfix` | Create bugfix branch from ticket (Sentry, support, etc.) with documentation. |
| `/finish-todo` | Archive completed todo. Move to completed folder, document achievements. |
| `/sprint` | Sprint management. View, create, and manage development sprints via backlog API. |
| `/add-backlog` | Add item to RequestDesk backlog API. |
| `/plan-feature` | Interactive feature planning wizard. Guided discovery of requirements before implementation. |

## Development

| Command | Purpose |
|---------|---------|
| `/update-architecture` | Update architecture map documentation for CB projects. |
| `/frontend-design` | Create production-grade frontend interfaces with high design quality. |
| `/sync-wp-plugin` | Sync WordPress plugin files between development and production. |

## Auditing & Analysis

| Command | Purpose |
|---------|---------|
| `/a11y-audit` | WCAG 2.1 AA accessibility audit using Pa11y with axe-core. |
| `/analyze-refactor-candidates` | Find large/complex files needing refactoring. |
| `/audit-branches` | Review git branches across projects, identify stale branches. |
| `/audit-codebase` | Dead code analysis (vulture), complexity metrics (radon). |
| `/check-terms` | Check content against RequestDesk terms API for overused/avoid terms. |
| `/content-audit` | SEO/AEO audit with `--enrich` flag for schema enrichment. |
| `/lighthouse` | Lighthouse performance audit for web pages. |
| `/sentry-report` | Generate error report from Sentry. |

## Deployment

| Command | Purpose |
|---------|---------|
| `/deploy-project` | Deploy using tag-based system with iteration support. Supports `--mark-tested` and `--final`. |

## Content & Brand

| Command | Purpose |
|---------|---------|
| `/brand-brent` | Load Brent Peterson brand persona for consistent voice. |
| `/brand-cucumber` | Load Content Cucumber brand persona. |
| `/brand-requestdesk` | Load RequestDesk brand persona. |
| `/cucumber-writer` | Content creation with Content Cucumber brand voice. |
| `/rd-blog` | Create RequestDesk blog posts with Brent's voice. |
| `/daily-content` | Content planning dashboard. Review and update content schedule. |
| `/newsletter-planner` | Plan and draft newsletter content. |
| `/canva` | Design creation and management via Canva MCP. |

## Social Media

| Command | Purpose |
|---------|---------|
| `/create-social` | Draft, review, and schedule a social post. |
| `/plan-social` | Multi-platform drip campaign planning, drafting, and scheduling. |

## Email & HubSpot

| Command | Purpose |
|---------|---------|
| `/respond-email` | Respond to emails using HubSpot context. |
| `/respond-comment` | Respond to comments (blog, social). |
| `/send-email` | Send email via HubSpot task workflow. |
| `/hubspot-enrich` | Contact personalization and platform detection. |
| `/detect-platform` | Detect contact's e-commerce platform via Wappalyzer. |

## Personal Workflow (Brent)

| Command | Purpose |
|---------|---------|
| `/brent-start` | Daily operating system. Load schedule, tasks, content plan. |
| `/brent-finish` | End of day closeout. Log time, capture accomplishments, archive stale context/comms/sessions. |
| `/brent-task` | Set active task for time tracking. |

## Tuesdays with Claude (TWC)

| Command | Purpose |
|---------|---------|
| `/twc-start` | Start a new TWC article. |
| `/twc-finish` | Finalize and publish TWC article. |
| `/twc-note` | Add a note to current TWC article. |
| `/twc-status` | Check TWC article pipeline status. |
| `/twc-backlog` | Manage TWC article backlog. |

## Meta & System

| Command | Purpose |
|---------|---------|
| `/claude-help` | Command reference. `--list` for names only, `<command>` for details. |
| `/claude-learner` | Collaborative learning through discussion. |
| `/violation-log` | Log Claude rule violations. |
| `/rotate-violations` | Archive old violation logs. |

---

## Deprecated

| Command | Replacement |
|---------|-------------|
| `/create-branch` | `/start-work` |
| `claude-close` | `/claude-save --close` |
| `claude-resume` | `/claude-start` |
| `claude-save-mcp` | `/claude-save` |
| `log-debug` | `/claude-debug` |
| `seo-audit` | `/content-audit` |
| `aeo-enrich` | `/content-audit --enrich` |
| `deploy-astro-site` | `/deploy-project` |
| `deploy-main-site` | `/deploy-project` |

---

## Workspace Shortcodes

Used with session commands (`/claude-save`, `/claude-start`, etc.)

| Shortcode | Project | Directory |
|-----------|---------|-----------|
| `rd` | RequestDesk | `requestdesk-app` |
| `rd-test` | RequestDesk Testing | `requestdesk-app-testing` |
| `astro` | Astro Sites | `astro-sites` |
| `shop` | Shopify | `cb-shopify` |
| `wpp` | WordPress Plugin | `requestdesk-wordpress` |
| `wps` | WordPress Sites | `wordpress-sites` |
| `mage` | Magento | `cb-magento-integration` |
| `juno` | JunoGO | `cb-junogo` |
| `job` | Jobs | `jobs` |
| `brent` | Brent Workspace | `brent-workspace` |
| `bt` | Brent Timekeeper | `brent-timekeeper` |
| `cc` | Claude Commands | `.claude` |
| `doc` | Documentation | `documentation` |

---

## Changelog

| Date | Change |
|------|--------|
| 2026-02-02 | Full inventory update. Added 20+ missing commands. Overhauled /claude-save (917->236 lines). Added /claude-comms start mode. Added /claude-trash. Added comms cleanup to /brent-finish. |
| 2026-01-05 | Major audit. Removed 16 redundant commands, consolidated deploy commands. |
| 2026-01-04 | Initial document created. |
