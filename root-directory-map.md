# CB-Workspace Root Directory Map

**Purpose**: Authoritative reference for CB-Workspace directory structure - prevents random file creation
**Last Updated**: 2025-11-01
**Status**: Workspace Configuration - Multi-project management

## ✅ **APPROVED WORKSPACE STRUCTURE**

```
/Users/brent/scripts/CB-Workspace/
├── .claude/                         # Claude AI commands and configuration (workspace-level) [TRACKED]
│   ├── commands/                    # Claude command definitions
│   ├── branch-context/              # Branch-specific context files
│   ├── root-directory-map.md        # This file - workspace structure reference
│   └── incorrect-instruction-log.md # Claude violation tracking
├── .claude-cb-specific/             # CB-specific Claude configuration and documentation [TRACKED]
├── .git/                            # Git repository data (workspace-level) [GITIGNORED: automatically]
├── .idea/                           # JetBrains IDE settings (workspace-level) [GITIGNORED: entire directory]
├── .venv/                           # Python virtual environment (workspace-level) [GITIGNORED: entire directory]
├── automated-testing/               # Cross-project testing utilities [TRACKED]
│   ├── scripts/                     # Automated test scripts
│   └── README.md                    # Testing documentation
├── cb-requestdesk/                  # Main application repository [SEPARATE GIT REPO]
│   ├── backend/                     # FastAPI backend
│   │   ├── app/                     # Application code
│   │   │   ├── routers/             # API endpoints
│   │   │   ├── services/            # Business logic
│   │   │   ├── models/              # Data models
│   │   │   ├── migrations/          # Database migrations
│   │   │   └── utils/               # Utilities
│   │   ├── tests/                   # Backend tests
│   │   │   └── curl_scripts/        # API testing scripts
│   │   └── requirements.txt         # Python dependencies
│   ├── frontend/                    # React frontend
│   │   ├── src/                     # Source code
│   │   │   ├── components/          # React components
│   │   │   ├── services/            # API services
│   │   │   └── utils/               # Frontend utilities
│   │   ├── public/                  # Public assets
│   │   └── package.json             # Node dependencies
│   ├── docker/                      # Docker configuration
│   │   ├── docker-compose.yml       # Development environment
│   │   └── Dockerfile               # Container definitions
│   ├── documentation/               # Project documentation
│   │   └── docs/                    # Detailed documentation
│   ├── todo/                        # Task management (cb-requestdesk)
│   │   ├── current/                 # Active tasks
│   │   └── completed/               # Completed tasks
│   ├── tmp/                         # Temporary files [GITIGNORED]
│   ├── CLAUDE.md                    # Project-specific Claude instructions
│   ├── README.md                    # Project documentation
│   ├── VERSION                      # Current version
│   ├── CHANGELOG.md                 # Version history
│   └── .env                         # Environment variables [GITIGNORED]
├── cb-shopify/                      # Shopify integration repository [SEPARATE GIT REPO]
│   ├── gadget/                      # Gadget framework files
│   ├── todo/                        # Task management (cb-shopify)
│   ├── CLAUDE.md                    # Project-specific Claude instructions
│   └── [Gadget/Shopify app structure]
├── cb-wordpress/                    # WordPress extension repository [SEPARATE GIT REPO]
│   ├── plugin/                      # WordPress plugin files
│   ├── todo/                        # Task management (cb-wordpress)
│   ├── CLAUDE.md                    # Project-specific Claude instructions
│   └── [WordPress plugin structure]
├── cb-magento/                      # Magento integration repository [SEPARATE GIT REPO]
│   ├── extension/                   # Magento extension files
│   ├── todo/                        # Task management (cb-magento)
│   ├── CLAUDE.md                    # Project-specific Claude instructions
│   └── [Magento extension structure]
├── cb-junogo/                       # JunoGO integration repository [SEPARATE GIT REPO]
│   ├── integration/                 # JunoGO integration files
│   ├── todo/                        # Task management (cb-junogo)
│   ├── CLAUDE.md                    # Project-specific Claude instructions
│   └── [JunoGO integration structure]
├── documentation/                   # Comprehensive project documentation [TRACKED]
│   ├── cb-requestdesk/              # Main application documentation
│   ├── cb-shopify/                  # Shopify integration documentation
│   ├── cb-wordpress/                # WordPress extension documentation
│   ├── cb-magento/                  # Magento integration documentation
│   ├── cb-junogo/                   # JunoGO integration documentation
│   └── README.md                    # Documentation overview
├── jobs/                            # Automated maintenance and monitoring systems [TRACKED]
│   ├── scripts/                     # Automated maintenance scripts
│   └── README.md                    # Jobs documentation
├── .DS_Store                        # macOS system file [GITIGNORED: all .DS_Store files]
├── TODO/                            # Write-protected directory [WRITE-PROTECTED: root-owned]
├── .gitignore                       # Workspace git ignore patterns [TRACKED]
├── AGENTS.md                        # Agent configuration and documentation [TRACKED]
├── CLAUDE.md                        # Workspace-level Claude instructions [TRACKED]
└── README.md                        # Workspace documentation [TRACKED]
```

## 🔍 **REPOSITORY STATUS LEGEND**
- **[TRACKED]** - File/directory committed to CB-Workspace git repository
- **[SEPARATE GIT REPO]** - Individual CB project with its own git repository
- **[GITIGNORED: condition]** - File/directory ignored by workspace git
- **[WRITE-PROTECTED: root-owned]** - Directory protected from Claude modifications
- **[GITIGNORED: automatically]** - Git's default behavior

## 🏗️ **WORKSPACE DESIGN PRINCIPLES**

### Centralized Configuration
- **Claude commands**: Unified across all CB projects via `.claude/` folder
- **Workspace documentation**: `CLAUDE.md`, `README.md` at workspace root
- **Project coordination**: Workspace-level files for managing entire ecosystem

### Distributed Project Code
- **Individual repositories**: Each CB project maintains its own git history
- **Project isolation**: Changes to one project don't affect others
- **Access control**: Different team members can access different projects

### Consistent Structure
- **Todo folders**: Every project has `todo/current/` and `todo/completed/`
- **Claude integration**: All projects work with workspace Claude commands
- **Documentation**: Each project has project-specific `CLAUDE.md`

## 🚫 **PROHIBITED IN WORKSPACE ROOT**

**The workspace root should contain ONLY workspace coordination files:**

### ❌ Never Create These in Root:
- **Project-specific code files** → Belong in individual `cb-*/` directories
- **Database files** → Belong in appropriate project directories
- **Log files** → Belong in individual project `/logs/` or `/tmp/` directories
- **Build artifacts** → Belong in individual project build directories
- **Environment files for projects** → Belong in individual project roots
- **Test scripts** → Belong in individual project test directories
- **Random markdown files** → Use project-specific documentation or `cb-*/todo/`

### ❌ Never Create These Directories in Root:
- `/scripts/` → Use individual project script directories
- `/docs/` → Use individual project documentation
- `/technical/` → Use individual project technical documentation
- `/logs/` → Use individual project logging
- `/backup/` → Use individual project backup strategies
- `/deployment/` → Use individual project deployment configs

## 📁 **PROPER FILE LOCATIONS BY TYPE**

### Workspace-Level Files (Root)
- **Claude configuration**: `.claude/` directory for general configuration
- **CB-specific Claude configuration**: `.claude-cb-specific/` directory for CB-specific documentation
- **Workspace documentation**: `CLAUDE.md`, `README.md`, `AGENTS.md`, `documentation/`
- **Cross-project testing**: `automated-testing/` directory
- **Git configuration**: `.gitignore`, `.git/`
- **IDE configuration**: `.idea/` (workspace settings)
- **Python environment**: `.venv/` (if needed for workspace tools)

### Project-Level Files (cb-*/`)
- **All source code**: Within appropriate `cb-*` directory
- **Project documentation**: `cb-*/CLAUDE.md`, `cb-*/README.md`
- **Task management**: `cb-*/todo/current/`, `cb-*/todo/completed/`
- **Project configuration**: `cb-*/.env`, `cb-*/docker/`, etc.
- **Project logs**: `cb-*/logs/`, `cb-*/tmp/`

### Shared Resources
- **Claude commands**: `.claude/commands/` (workspace-level)
- **Development patterns**: Individual project documentation
- **API documentation**: Within relevant `cb-*` project

## 🎯 **WORKSPACE VS PROJECT RESPONSIBILITIES**

### Workspace Repository Manages:
- ✅ Claude command definitions and configuration (general and CB-specific)
- ✅ Cross-project coordination documentation
- ✅ Comprehensive project documentation (documentation/ directory)
- ✅ Workspace setup and onboarding instructions
- ✅ Multi-project development workflows

### Individual Project Repositories Manage:
- ✅ All source code and assets
- ✅ Project-specific configuration and dependencies
- ✅ Individual deployment and testing
- ✅ Project-specific documentation and task management

## 🔧 **MAINTENANCE RULES**

1. **Workspace Root Policy**: Only workspace coordination files belong here
2. **Project Isolation**: Never mix project code with workspace configuration
3. **Claude Commands**: Multi-project commands in workspace, project-specific commands in projects
4. **Documentation Split**: Workspace docs here, project docs in individual repos
5. **Repository Boundaries**: Respect the separation between workspace and project repositories

## 📋 **COMPLIANCE CHECKING**

**Check workspace root compliance:**
```bash
# Workspace root should only contain these items
ls -la | grep -E "(\.claude|\.claude-cb-specific|\.git|\.idea|\.venv|cb-|documentation|automated-testing|CLAUDE\.md|README\.md|AGENTS\.md|\.gitignore|\.DS_Store)"

# Find prohibited workspace items (should return empty)
ls -la | grep -v -E "(\.claude|\.claude-cb-specific|\.git|\.idea|\.venv|cb-|documentation|automated-testing|CLAUDE\.md|README\.md|AGENTS\.md|\.gitignore|\.DS_Store|total|drwx)"
```

**Check project isolation:**
```bash
# Each CB project should be a separate directory
ls -la cb-*/ | grep -E "(todo|CLAUDE\.md)"

# Verify no project code leaked into workspace root
find . -maxdepth 1 -name "*.py" -o -name "*.js" -o -name "*.json" -o -name "*.sql"
```

## 🚨 **ENFORCEMENT**

This workspace structure is enforced by:
- **Claude startup commands**: Check structure before beginning work
- **Workspace README**: Clear guidance for new developers
- **Git ignore patterns**: Prevent accidental project code commits
- **Development workflow**: Claude commands respect project boundaries

**Violations should be corrected immediately:**
- **Files in wrong location**: Move to appropriate project or workspace location
- **Project code in workspace**: Move to appropriate `cb-*` directory
- **Workspace files in projects**: Consolidate to workspace level

This structure enables centralized CB ecosystem management while maintaining clean project separation.