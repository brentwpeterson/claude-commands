# /sentry-report

**Purpose**: Show Sentry error reports for RequestDesk applications with environment filtering (development vs production).

**Usage**:
- `/sentry-report` - Show summary of all environments
- `/sentry-report --prod` - Show production issues only (PRIORITY)
- `/sentry-report --dev` - Show development issues only
- `/sentry-report backend` - Show backend issues only
- `/sentry-report frontend` - Show frontend issues only
- `/sentry-report --unresolved` - Show only unresolved issues
- `/sentry-report --today` - Show issues from today only
- `/sentry-report --analyze <ISSUE-ID>` - Deep analysis of specific issue with Seer AI

**Arguments**:
- `--prod` / `--production`: Filter to production environment only
- `--dev` / `--development`: Filter to development environment only
- `backend` / `frontend` / `all` (optional): Filter by project (default: all)
- `--unresolved`: Show only unresolved issues
- `--today`: Filter to issues from today
- `--week`: Filter to issues from past 7 days
- `--analyze <ISSUE-ID>`: Get AI-powered root cause analysis for specific issue

## Environment Information

**Tracked Environments**:
| Environment | Description | Priority |
|-------------|-------------|----------|
| `production` | Live app.requestdesk.ai | HIGH - fix immediately |
| `development` | Local dev (localhost:3000/3001) | Normal - fix before deploy |

## Sentry Configuration

**Organization**: `content-basis-llc`
**Region URL**: `https://us.sentry.io`

**Projects**:
| Project Slug | Description |
|--------------|-------------|
| `requestdesk-backend` | FastAPI backend API |
| `requestdesk-frontend` | React frontend app |
| `javascript-react` | Additional React/JS errors |

## Implementation Instructions for Claude

### ON COMMAND EXECUTION:

#### Step 1: Determine Scope

Based on arguments, determine which projects to query:
- `backend` -> `requestdesk-backend`
- `frontend` -> `requestdesk-frontend`, `javascript-react`
- `all` or no argument -> All three projects

#### Step 2: Build Query Parameters

**Default query**: "unresolved issues from the last 7 days"

Modify based on flags:
- `--prod` / `--production`: Add "in production environment" to query
- `--dev` / `--development`: Add "in development environment" to query
- `--unresolved`: "unresolved issues"
- `--today`: "issues from today"
- `--week`: "issues from the last 7 days"

**Environment Query Examples**:
- Default (both): "unresolved issues from the last 7 days"
- Production only: "unresolved issues in production environment from the last 7 days"
- Development only: "unresolved issues in development environment from the last 7 days"

#### Step 3: Execute Sentry Queries

**First, get environment breakdown (for default view without --prod/--dev):**

Use `mcp__sentry__search_events` to get error counts by environment:
```
organizationSlug: content-basis-llc
regionUrl: https://us.sentry.io
projectSlug: requestdesk-backend
naturalLanguageQuery: "errors grouped by environment from last 7 days"
```

**Then, for each project, use `mcp__sentry__search_issues`:**

```
organizationSlug: content-basis-llc
regionUrl: https://us.sentry.io
projectSlugOrId: [project-slug]
naturalLanguageQuery: [built query with environment filter if --prod/--dev]
limit: 10
```

**If `--analyze` flag with issue ID:**

Use `mcp__sentry__analyze_issue_with_seer` to get AI-powered root cause analysis:
```
organizationSlug: content-basis-llc
regionUrl: https://us.sentry.io
issueId: [ISSUE-ID]
```

#### Step 4: Format Output

**Summary View (default - both environments):**

```markdown
## Sentry Report - RequestDesk
**Generated**: [timestamp]
**Organization**: content-basis-llc

### Environment Summary (Last 7 Days)
| Environment | Errors | Priority |
|-------------|--------|----------|
| production | X | HIGH |
| development | Y | Normal |

### Production Issues (PRIORITY)
| Issue | Events | First Seen | Culprit |
|-------|--------|------------|---------|
| [Title] | X | date | [file/function] |

### Development Issues
| Issue | Events | First Seen | Culprit |
|-------|--------|------------|---------|
| [Title] | X | date | [file/function] |

### Summary
- **Production Issues**: X (fix immediately)
- **Development Issues**: Y (fix before deploy)
- **Most Affected Area**: [culprit/router]

### Quick Actions
- Production issues only: `/sentry-report --prod`
- Development issues only: `/sentry-report --dev`
- Analyze specific issue: `/sentry-report --analyze ISSUE-ID`
- View in Sentry: https://content-basis-llc.sentry.io
```

**Environment-Filtered View (--prod or --dev):**

```markdown
## Sentry Report - RequestDesk [ENVIRONMENT]
**Generated**: [timestamp]
**Environment**: production/development

### Backend (requestdesk-backend)
| Issue | Events | Users | First Seen | Status |
|-------|--------|-------|------------|--------|
| [Title] | X | Y | date | unresolved/resolved |

**Total**: X unresolved issues

### Frontend (requestdesk-frontend)
| Issue | Events | Users | First Seen | Status |
|-------|--------|-------|------------|--------|
| [Title] | X | Y | date | unresolved/resolved |

**Total**: X unresolved issues
```

**Analyze View (--analyze flag):**

```markdown
## Sentry Issue Analysis - [ISSUE-ID]

### Issue Summary
- **Title**: [error title]
- **Project**: [project]
- **Events**: X occurrences
- **Users Affected**: Y

### AI Root Cause Analysis
[Seer analysis results]

### Suggested Fix
[Code recommendations from Seer]

### Stack Trace
[Key frames from error]

### Next Steps
1. [Recommended action]
2. [Recommended action]
```

### SPECIAL FLAGS:

- `--prod` / `--production`: Show production issues only (HIGH PRIORITY)
- `--dev` / `--development`: Show development issues only
- `--unresolved`: Filter to unresolved issues only
- `--today`: Issues from today
- `--week`: Issues from past 7 days (default)
- `--analyze <ID>`: Deep dive into specific issue with AI analysis
- `--stats`: Show event counts and trends

### EXAMPLE SESSIONS:

**Basic report (both environments):**
```
User: /sentry-report

Claude:
## Sentry Report - RequestDesk
**Generated**: 2026-01-23 10:30 AM

### Environment Summary (Last 7 Days)
| Environment | Errors | Priority |
|-------------|--------|----------|
| production | 61 | HIGH |
| development | 231 | Normal |

### Production Issues (PRIORITY)
| Issue | Events | First Seen | Culprit |
|-------|--------|------------|---------|
| HTTP error during login: 401 | 4 | Jan 19 | auth.login_for_access_token |
| Error during password verification | 2 | Jan 20 | auth.login_for_access_token |

### Development Issues (Top 5)
| Issue | Events | First Seen | Culprit |
|-------|--------|------------|---------|
| HTTP error during login: 401 | 74 | Jan 3 | auth.login_for_access_token |
| Error fetching integration types | 4 | Today | integration_types.get |

### Summary
- **Production Issues**: 2 (fix immediately)
- **Development Issues**: 34 (fix before deploy)
- **Most Affected Area**: auth.login_for_access_token
```

**Production only:**
```
User: /sentry-report --prod

Claude:
## Sentry Report - RequestDesk [PRODUCTION]
**Generated**: 2026-01-23 10:30 AM
**Environment**: production

### Backend Issues
| Issue | Events | First Seen | Status |
|-------|--------|------------|--------|
| HTTP error during login: 401 | 4 | Jan 19 | unresolved |
| Error during password verification | 2 | Jan 20 | unresolved |

**Total**: 2 production issues requiring immediate attention
```

**Analyze specific issue:**
```
User: /sentry-report --analyze RD-BACKEND-123

Claude:
## Sentry Issue Analysis - RD-BACKEND-123

### Issue Summary
- **Title**: ValidationError in /api/content
- **Project**: requestdesk-backend
- **Events**: 45 occurrences
- **Users Affected**: 12

### AI Root Cause Analysis
The error occurs when the content_type field receives an unexpected value...

### Suggested Fix
Add validation for content_type before processing:
[code snippet]

### Next Steps
1. Add input validation for content_type field
2. Add unit test for edge case
3. Deploy and verify fix resolves issue
```

### SUCCESS CRITERIA:

1. **Quick overview** - See all issues at a glance
2. **Actionable** - Know which issues need attention
3. **Deep analysis** - Get AI-powered root cause when needed
4. **Environment aware** - Distinguish local vs production issues

### INTEGRATION:

- Use with `/claude-debug` for structured debugging sessions
- Issues can inform `/create-bugfix` ticket creation
- Links to Sentry UI for full details
