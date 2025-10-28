# Local Workspace Configuration

This directory contains workspace-specific configuration files that are **excluded from git** to maintain privacy and allow per-workspace customization.

## Configuration Files

### `workspace.env`
Main configuration file with environment variables for workspace behavior.

**Setup:**
```bash
# Copy template and customize
cp workspace.env.template workspace.env
# Edit with your preferences
vim workspace.env  # or your preferred editor
```

### `project-overrides.json`
Per-project configuration overrides for special handling.

### `user-preferences.json`
User-specific preferences for command behavior.

## Environment Variables

Commands automatically source `workspace.env` if it exists. Key variables:

| Variable | Purpose | Example |
|----------|---------|---------|
| `WORKSPACE_NAME` | Display name for workspace | "My Development Projects" |
| `DEFAULT_MAIN_BRANCH` | Primary branch name | "main" or "master" |
| `PROJECT_INCLUDE_PATTERNS` | Which directories to scan | "*" or "app-*,service-*" |
| `PROJECT_EXCLUDE_PATTERNS` | Directories to ignore | ".git,node_modules,dist" |
| `STALE_BRANCH_DAYS` | Days before branch considered stale | "30" |
| `DOCS_PATH` | Where to create documentation | "docs/git" |

## Project Discovery

Commands automatically discover git repositories using these patterns:

```bash
# Include patterns (comma-separated)
PROJECT_INCLUDE_PATTERNS="*"                    # All directories
PROJECT_INCLUDE_PATTERNS="app-*,service-*"      # Only matching prefixes
PROJECT_INCLUDE_PATTERNS="frontend,backend,api" # Specific names

# Exclude patterns (comma-separated)
PROJECT_EXCLUDE_PATTERNS=".git,.github,node_modules,dist,build"
```

## Project Types

Define custom handling for different project types:

```bash
# Node.js projects
PROJECT_TYPE_NODEJS_PATTERN="package.json"
PROJECT_TYPE_NODEJS_COMMANDS="npm install,npm test,npm run build"

# Python projects
PROJECT_TYPE_PYTHON_PATTERN="requirements.txt,pyproject.toml"
PROJECT_TYPE_PYTHON_COMMANDS="pip install -r requirements.txt,python -m pytest"

# Docker projects
PROJECT_TYPE_DOCKER_PATTERN="Dockerfile,docker-compose.yml"
PROJECT_TYPE_DOCKER_COMMANDS="docker build .,docker-compose up"
```

## Security

This directory is configured in `.gitignore` to exclude:
- `workspace.env` - Your actual configuration
- `project-overrides.json` - Project-specific settings
- `user-preferences.json` - Personal preferences
- `*.local.*` - Any local configuration files

## Usage in Commands

Commands check for local configuration automatically:

```bash
# Commands will use these files if they exist:
1. .claude/local/workspace.env
2. Environment variables in shell
3. Default values in command

# Example: audit-branches command will use:
WORKSPACE_NAME="My Projects" /audit-branches
```

## Example Configuration

```bash
# workspace.env
WORKSPACE_NAME="E-commerce Platform"
PROJECT_INCLUDE_PATTERNS="frontend,backend,api,mobile-app"
PROJECT_EXCLUDE_PATTERNS=".git,node_modules,dist,coverage"
DEFAULT_MAIN_BRANCH="main"
STALE_BRANCH_DAYS="21"
DOCS_PATH="docs/development/git"
SECURITY_SCAN_ENABLED="true"
AUTO_UPDATE_BRANCHES="false"
```

This allows each workspace to have its own behavior while keeping the template commands generic and reusable.

## Template Files

- `workspace.env.template` - Copy to `workspace.env` and customize
- `project-overrides.json.template` - Copy to `project-overrides.json` for special projects
- `user-preferences.json.template` - Copy to `user-preferences.json` for personal settings