# Memory System - OpenMemory Integration Template

**🏗️ REAL-WORLD EXAMPLE from CB-Workspace**

This template demonstrates OpenMemory integration for intelligent context management across multiple projects. All examples use the CB-Workspace ecosystem as a working reference - adapt the project names and structure to your own workspace.

## 🎯 Purpose

Bridges the context gap between Claude Code sessions by providing:
- **Semantic memory search** across all your projects
- **Automatic context classification** (procedural, semantic, episodic, reflective)
- **Cross-project pattern recognition** (Docker configs, API designs, etc.)
- **Memory decay management** (old todos fade, important decisions persist)

## 📋 **Adapting This Template**

**Replace CB project names with yours:**
- `cb-requestdesk` → `your-main-app`
- `cb-shopify` → `your-integration-project`
- `cb-wordpress` → `your-cms-project`
- `astro-sites` → `your-frontend-project`
- `jobs` → `your-automation-project`

**The patterns and structure remain the same!**

## 🏗️ Architecture Example

**Multi-Project Memory Organization (CB-Workspace example):**
```
Your-Workspace Memory Namespace (user_id: "your-workspace")
├── Project Memories
│   ├── project:cb-requestdesk (main hub) ← your-main-app
│   ├── project:cb-shopify (live integration) ← your-integration
│   ├── project:cb-wordpress (production) ← your-cms
│   ├── project:cb-magento (development) ← your-new-project
│   ├── project:cb-junogo (external) ← your-external-integration
│   ├── project:astro-sites (deployment) ← your-frontend
│   └── project:jobs (automation) ← your-scripts
├── Cross-Project Patterns
│   ├── pattern:deployment (AWS, Docker, ECS)
│   ├── pattern:api-design (REST, auth, webhooks)
│   └── pattern:infrastructure (nginx, SSL, domains)
└── Session Context
    ├── session:YYYY-MM-DD (daily work)
    ├── problem:solution-pairs
    └── architecture:decisions
```

**Adapt this structure to your projects - the tagging patterns are more important than the specific names!**

## 🛠️ Installation Status

- ✅ **OpenMemory Server**: Running at `http://localhost:8080`
- ✅ **Database**: `/Users/brent/scripts/OpenMemory/backend/data/cb-workspace-memory.sqlite`
- ✅ **Performance**: SMART tier (85% recall, optimized for development)
- ✅ **API Access**: HTTP endpoints with authentication
- ✅ **First Memory**: CB-Workspace setup documented

## 📁 Project Structure

```
cb-memory-system/
├── README.md                    # This file
├── scripts/                     # CLI interaction tools
│   ├── store-memory.sh         # Store new memories
│   ├── query-memory.sh         # Search existing memories
│   ├── list-memories.sh        # Browse all memories
│   └── migrate-contexts.py     # Import .claude/branch-context/*
├── docs/                       # Documentation
│   ├── api-reference.md        # HTTP API endpoints
│   ├── usage-guide.md          # How-to guides
│   └── namespace-design.md     # Memory organization
├── examples/                   # Usage examples
│   ├── project-memories/       # Sample project memories
│   └── session-examples/       # Sample session contexts
├── config/                     # Configuration
│   ├── api-config.sh          # API settings
│   └── memory-templates/       # Memory templates
└── migration/                  # Migration tools
    ├── context-importer.py     # Import existing contexts
    └── backup/                 # Backup existing contexts
```

## 🚀 Quick Start (CB Examples)

1. **Store a memory (adapt project names to yours):**
   ```bash
   ./scripts/store-memory.sh "Fixed Docker ARM64 issue in astro-sites deployment" \
     '["project:astro-sites", "problem:docker-arm64", "solution:platform-flag"]'

   # Your version might be:
   # ./scripts/store-memory.sh "Fixed Docker ARM64 issue in frontend deployment" \
   #   '["project:my-frontend", "problem:docker-arm64", "solution:platform-flag"]'
   ```

2. **Search memories:**
   ```bash
   ./scripts/query-memory.sh "Docker deployment issues" 5
   ```

3. **List recent work:**
   ```bash
   ./scripts/list-memories.sh 10
   ```

## 🔗 Integration Points

**With Existing CB Workflow:**
- Import existing `.claude/branch-context/*.md` files
- Store session context at end of work sessions
- Query related patterns when starting new projects
- Cross-reference solutions when debugging

**API Endpoints:**
- `POST /memory/add` - Store new memories
- `POST /memory/query` - Semantic search
- `GET /memory/all` - List memories
- `GET /memory/:id` - Retrieve specific memory

## 📊 Expected Benefits

**vs Current File-Based Context:**
- 30-70% token reduction for context management
- Automatic cross-project discovery
- Semantic search vs manual file browsing
- Memory reinforcement vs static files
- Graph-based connections vs linear organization

**CB Projects Supported:**
- cb-requestdesk, cb-shopify, cb-wordpress, cb-magento, cb-junogo, astro-sites, jobs

---

**Installation Date**: 2025-11-04
**OpenMemory Version**: 2.0-hsg-tiered
**Performance Tier**: SMART (85% recall)