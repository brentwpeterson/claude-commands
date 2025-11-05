# CB Memory System Usage Guide

Complete guide for using OpenMemory integration in CB-Workspace.

## 🚀 Quick Start

### 1. Check System Status
```bash
# Verify OpenMemory server is running
curl -s http://localhost:8080/health | jq .

# List current memories
./scripts/list-memories.sh 5
```

### 2. Store Your First Memory
```bash
# Basic memory storage
./scripts/store-memory.sh "Fixed deployment issue with Docker ARM64 platform flag" \
  '["project:astro-sites", "problem:docker-arm64", "solution", "deployment"]'

# Session-based memory
./scripts/store-memory.sh "Completed user authentication refactor for cb-requestdesk" \
  '["session:2025-11-04", "project:cb-requestdesk", "achievement:auth-refactor"]' \
  '{"completion_date": "2025-11-04", "files_changed": 12, "tests_passing": true}'
```

### 3. Search and Query
```bash
# Find Docker-related solutions
./scripts/query-memory.sh "Docker deployment problems" 5

# Find project-specific knowledge
./scripts/query-memory.sh "cb-shopify API integration" 8

# Cross-project pattern search
./scripts/query-memory.sh "AWS infrastructure setup" 10
```

## 🏷️ Tagging Strategy

### Project Tags (Primary)
```bash
project:cb-requestdesk    # Main application hub
project:cb-shopify        # Shopify integration
project:cb-wordpress      # WordPress extension
project:cb-magento        # Magento integration
project:cb-junogo         # Juno GO integration
project:astro-sites       # Astro deployment system
project:jobs              # Automation and monitoring
```

### Pattern Tags (Cross-Project)
```bash
pattern:deployment        # Deployment strategies
pattern:api-design        # API patterns and conventions
pattern:database          # Database operations and migrations
pattern:docker            # Docker configurations
pattern:aws               # AWS infrastructure
pattern:authentication    # Auth patterns and solutions
pattern:testing           # Testing strategies
```

### Session Tags (Temporal)
```bash
session:YYYY-MM-DD        # Daily work sessions
problem:description       # Problem identification
solution                  # Solution implementation
achievement:name          # Major accomplishments
debugging                 # Debugging sessions
architecture:decision     # Architectural choices
```

### Work Type Tags
```bash
feature-branch           # Feature development
bugfix                   # Bug fixes
refactoring             # Code refactoring
infrastructure          # Infrastructure work
documentation           # Documentation updates
```

## 🧠 Memory Sectors

OpenMemory automatically classifies memories into cognitive sectors:

### Episodic Sector
**What**: Session-based memories, specific events
**Examples**: Daily work sessions, debugging stories, deployment experiences
**Tags**: `session:*`, `debugging`, `deployment`

### Semantic Sector
**What**: Knowledge and facts, architecture decisions
**Examples**: API patterns, database schemas, design principles
**Tags**: `pattern:*`, `architecture:*`, `knowledge`

### Procedural Sector
**What**: How-to guides, processes, solutions
**Examples**: Deployment procedures, problem solutions, step-by-step guides
**Tags**: `solution`, `procedure`, `how-to`

### Reflective Sector
**What**: Lessons learned, retrospectives
**Examples**: What worked/didn't work, process improvements
**Tags**: `lessons-learned`, `retrospective`, `improvement`

### Emotional Sector
**What**: Preferences, confidence levels
**Examples**: Technology preferences, successful patterns
**Tags**: `preference`, `confidence`, `success`

## 📊 Advanced Queries

### Cross-Project Pattern Discovery
```bash
# Find all Docker-related work across projects
./scripts/query-memory.sh "Docker configuration" 10

# Authentication patterns across CB projects
./scripts/query-memory.sh "authentication implementation" 8
```

### Problem-Solution Matching
```bash
# Find solutions to deployment issues
./scripts/query-memory.sh "deployment failed" 5

# Database migration experiences
./scripts/query-memory.sh "database migration" 8
```

### Architecture Decision History
```bash
# AWS infrastructure decisions
./scripts/query-memory.sh "AWS architecture" 10

# API design choices
./scripts/query-memory.sh "API endpoint design" 8
```

## 🔄 Migration Workflow

### Import Existing Context Files
```bash
# Import all context files (creates backup)
python3 migration/context-importer.py

# Import single file
python3 migration/context-importer.py --file /path/to/context.md

# Import without backup
python3 migration/context-importer.py --no-backup
```

### Post-Migration Verification
```bash
# Check import success
./scripts/list-memories.sh 20

# Search for specific project memories
./scripts/query-memory.sh "project:astro-sites" 10

# Verify migration tags
./scripts/query-memory.sh "context-migration" 20
```

## 🔗 Integration with CB Workflow

### At Start of Work Session
```bash
# Search for related work
./scripts/query-memory.sh "current project context" 5

# Find similar problems
./scripts/query-memory.sh "deployment issues" 8
```

### During Development
```bash
# Store key decisions
./scripts/store-memory.sh "Chose JWT over sessions for API auth" \
  '["project:cb-shopify", "architecture:decision", "api-auth"]'

# Document solutions
./scripts/store-memory.sh "Fixed CORS by adding nginx proxy headers" \
  '["problem:cors", "solution", "nginx", "project:astro-sites"]'
```

### At End of Session
```bash
# Store session summary
./scripts/store-memory.sh "Completed multi-site Docker setup for contentbasis domains" \
  '["session:2025-11-04", "project:astro-sites", "achievement:docker-nginx"]' \
  '{"domains": ["contentbasis.io", "contentbasis.ai"], "deployment_ready": true}'
```

## 🎯 Best Practices

### Memory Content
- **Be Specific**: "Fixed Docker ARM64 issue with --platform flag" vs "Fixed Docker"
- **Include Context**: Reference project, file paths, exact errors
- **Document Solutions**: Not just what broke, but how you fixed it
- **Add Metadata**: Dates, file counts, success metrics

### Tagging Strategy
- **Always Include Project**: Every memory should have `project:*` tag
- **Use Consistent Patterns**: Stick to established tag naming conventions
- **Cross-Reference**: Use pattern tags to link related work across projects
- **Date Everything**: Include session dates for temporal context

### Search Strategies
- **Start Broad**: "Docker issues" then narrow to "Docker ARM64 platform"
- **Use Project Context**: Search within specific projects when relevant
- **Pattern Matching**: Look for cross-project solutions
- **Temporal Searches**: Find recent work with session dates

## 🛠️ Troubleshooting

### Server Issues
```bash
# Check server status
curl -s http://localhost:8080/health

# Restart server
cd /Users/brent/scripts/OpenMemory/backend && npm run dev
```

### Import Issues
```bash
# Check file permissions
ls -la /Users/brent/scripts/CB-Workspace/.claude/branch-context/

# Test single file import
python3 migration/context-importer.py --file path/to/test.md
```

### Search Not Finding Results
- Check if memories exist: `./scripts/list-memories.sh 20`
- Try broader search terms
- Remove project/sector filters
- Check for typos in tags

## 📈 Performance Tips

- **Memory Decay**: Important memories get reinforced through access
- **Sector Optimization**: Search within specific sectors for faster results
- **Tag Consistency**: Consistent tagging improves search accuracy
- **Regular Cleanup**: Archive or delete obsolete memories

---

For API reference and technical details, see `api-reference.md`