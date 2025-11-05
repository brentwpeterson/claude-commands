# 🏗️ Template Usage Guide

## About This Template

This OpenMemory integration template uses **real-world examples from CB-Workspace**. All the examples show actual working patterns from a live multi-project development environment.

## Why Real Examples?

✅ **Better than generic placeholders** - You see realistic naming patterns, realistic project structures, and actual usage scenarios
✅ **Proven patterns** - These examples are from a working system with validated performance improvements
✅ **Copy-and-adapt** - Much easier to adapt real examples than guess from generic templates

## How to Adapt CB Examples to Your Workspace

### 🔄 **Step 1: Replace Project Names**

**CB Examples → Your Projects:**
```
project:cb-requestdesk → project:your-main-app
project:cb-shopify   → project:your-integration
project:cb-wordpress → project:your-cms
project:astro-sites  → project:your-frontend
project:jobs         → project:your-automation
```

### 🔄 **Step 2: Update Paths**

**CB Example Paths:**
```bash
# CB Example:
cd /Users/brent/scripts/CB-Workspace/memory-system

# Your Path:
cd /path/to/your/workspace/memory-system
```

**OpenMemory Installation:**
```bash
# CB Example:
cd /Users/brent/scripts/OpenMemory/backend && npm run dev

# Your Path:
cd /path/to/your/OpenMemory/backend && npm run dev
```

### 🔄 **Step 3: Adapt Memory Content**

**CB Example:**
```bash
./scripts/store-memory.sh "Fixed Docker ARM64 issue in astro-sites deployment" \
  '["project:astro-sites", "problem:docker-arm64", "solution:platform-flag"]'
```

**Your Version:**
```bash
./scripts/store-memory.sh "Fixed Docker ARM64 issue in frontend deployment" \
  '["project:my-frontend", "problem:docker-arm64", "solution:platform-flag"]'
```

### 🔄 **Step 4: Update User ID**

**In API Config (`config/api-config.sh`):**
```bash
# CB Example:
export OM_USER_ID="cb-workspace"

# Your Version:
export OM_USER_ID="your-workspace-name"
```

## 📁 Files to Customize

### **Required Changes:**
- `config/api-config.sh` - Update USER_ID and paths
- `scripts/*.sh` - Update any hard-coded paths
- Examples in `examples/` - Replace CB project names

### **Optional Changes:**
- `examples/project-memories/` - Add your own project examples
- `examples/session-examples/` - Add your own session patterns
- `docs/` - Update with your project-specific documentation

## 🎯 Keep the Patterns, Change the Names

**✅ KEEP:**
- The tagging patterns (`project:`, `pattern:`, `session:`, `problem:`, `solution`)
- The directory structure
- The memory classification approach
- The scripts and tools

**🔄 CHANGE:**
- Project names in examples
- File paths specific to CB environment
- User ID and workspace naming
- Example content to match your projects

## 🚀 Result

You'll have a fully functional OpenMemory system with:
- ✅ Proven patterns from a working system
- ✅ Your project names and structure
- ✅ Ready-to-use intelligent memory management
- ✅ Cross-project knowledge discovery

The CB examples show you exactly how to structure your own memories for maximum effectiveness!