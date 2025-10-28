**COMMAND: Audit Git Branches (Generic Workspace)**

**Usage**: `/audit-branches [project-name]`

**Purpose:** Review all Git branches across discovered projects in the workspace and clean up merged branches.

**🔧 CONFIGURATION:**
This command uses local workspace configuration for customization:
- **Environment**: `.claude/local/workspace.env` (copy from template)
- **Project Overrides**: `.claude/local/project-overrides.json` (optional)
- **User Preferences**: `.claude/local/user-preferences.json` (optional)

**Phase 0: Setup and Configuration Loading**

0. **Load Configuration and Discover Projects:**
   ```bash
   # Store original working directory
   ORIGINAL_DIR=$(pwd)

   # Load workspace configuration if it exists
   CONFIG_FILE="$ORIGINAL_DIR/.claude/local/workspace.env"
   if [ -f "$CONFIG_FILE" ]; then
       echo "📋 Loading workspace configuration..."
       source "$CONFIG_FILE"
       echo "✅ Configuration loaded for: ${WORKSPACE_NAME:-'Workspace'}"
   else
       echo "⚠️ No local configuration found. Using defaults."
       echo "💡 Create .claude/local/workspace.env from template for customization"
   fi

   # Set defaults if not configured
   WORKSPACE_NAME="${WORKSPACE_NAME:-$(basename "$ORIGINAL_DIR") Workspace}"
   DEFAULT_MAIN_BRANCH="${DEFAULT_MAIN_BRANCH:-main}"
   PROJECT_INCLUDE_PATTERNS="${PROJECT_INCLUDE_PATTERNS:-*}"
   PROJECT_EXCLUDE_PATTERNS="${PROJECT_EXCLUDE_PATTERNS:-'.git,.github,.vscode,.idea,node_modules,dist,build,coverage,.pytest_cache,__pycache__'}"
   DOCS_PATH="${DOCS_PATH:-documentation/docs/technical/git}"
   STALE_BRANCH_DAYS="${STALE_BRANCH_DAYS:-30}"
   BRANCH_CATEGORIES="${BRANCH_CATEGORIES:-'feature,enhancement,fix,bug,hotfix,security,performance,refactor,docs,test,chore'}"

   echo "🏢 Workspace: $WORKSPACE_NAME"
   echo "📁 Root: $ORIGINAL_DIR"
   ```

1. **Auto-Discover Git Projects:**
   ```bash
   # Discover all git repositories in workspace
   echo "🔍 Discovering Git projects in workspace..."

   DISCOVERED_PROJECTS=()
   IFS=',' read -ra EXCLUDE_ARRAY <<< "$PROJECT_EXCLUDE_PATTERNS"
   IFS=',' read -ra INCLUDE_ARRAY <<< "$PROJECT_INCLUDE_PATTERNS"

   # Function to check if directory should be excluded
   should_exclude() {
       local dir="$1"
       for pattern in "${EXCLUDE_ARRAY[@]}"; do
           if [[ "$dir" == $pattern* ]] || [[ "$dir" == *"$pattern"* ]]; then
               return 0  # Should exclude
           fi
       done
       return 1  # Should include
   }

   # Function to check if directory matches include patterns
   should_include() {
       local dir="$1"
       # If include pattern is "*", include everything
       if [[ "$PROJECT_INCLUDE_PATTERNS" == "*" ]]; then
           return 0
       fi

       for pattern in "${INCLUDE_ARRAY[@]}"; do
           if [[ "$dir" == $pattern* ]] || [[ "$dir" == *"$pattern"* ]]; then
               return 0  # Should include
           fi
       done
       return 1  # Should not include
   }

   # Scan for git repositories
   for dir in */; do
       if [ -d "$dir" ]; then
           dir_name=$(basename "$dir")

           # Check exclusion patterns first
           if should_exclude "$dir_name"; then
               echo "⏭️ Skipping excluded directory: $dir_name"
               continue
           fi

           # Check inclusion patterns
           if ! should_include "$dir_name"; then
               echo "⏭️ Skipping non-matching directory: $dir_name"
               continue
           fi

           # Check if it's a git repository
           if [ -d "$dir/.git" ]; then
               DISCOVERED_PROJECTS+=("$dir_name")
               echo "✅ Found Git project: $dir_name"
           else
               echo "📁 Directory $dir_name exists but is not a Git repository"
           fi
       fi
   done

   # Handle project argument
   if [ "$1" ]; then
       PROJECT="$1"
       if [[ ! " ${DISCOVERED_PROJECTS[@]} " =~ " ${PROJECT} " ]]; then
           echo "❌ Project '$PROJECT' not found in discovered projects"
           echo "📋 Available projects: ${DISCOVERED_PROJECTS[*]}"
           exit 1
       fi
   else
       # Auto-detect from current directory or show selection
       if [[ $(basename $(pwd)) != $(basename "$ORIGINAL_DIR") ]]; then
           # We're in a subdirectory, try to detect project
           current_dir=$(basename $(pwd))
           if [[ " ${DISCOVERED_PROJECTS[@]} " =~ " ${current_dir} " ]]; then
               PROJECT="$current_dir"
               echo "🎯 Auto-detected project: $PROJECT"
           else
               echo "❓ Cannot auto-detect project from current directory"
               echo "📋 Available projects: ${DISCOVERED_PROJECTS[*]}"
               echo "Usage: /audit-branches [project-name]"
               exit 1
           fi
       else
           # Show project selection
           if [ ${#DISCOVERED_PROJECTS[@]} -eq 0 ]; then
               echo "❌ No Git projects found in workspace"
               echo "💡 Ensure your projects are Git repositories and match include patterns"
               exit 1
           elif [ ${#DISCOVERED_PROJECTS[@]} -eq 1 ]; then
               PROJECT="${DISCOVERED_PROJECTS[0]}"
               echo "🎯 Using only available project: $PROJECT"
           else
               echo "🎯 Multiple projects found. Please specify:"
               for i in "${!DISCOVERED_PROJECTS[@]}"; do
                   echo "  $((i+1)). ${DISCOVERED_PROJECTS[i]}"
               done
               echo ""
               echo "Usage: /audit-branches [project-name]"
               exit 1
           fi
       fi
   fi
   ```

2. **Navigate to Project and Load Project-Specific Config:**
   ```bash
   # Navigate to project directory
   cd "$PROJECT"
   echo "📁 Working in project: $PROJECT ($(pwd))"

   # Load project-specific overrides if they exist
   OVERRIDES_FILE="$ORIGINAL_DIR/.claude/local/project-overrides.json"
   if [ -f "$OVERRIDES_FILE" ] && command -v jq >/dev/null 2>&1; then
       echo "🔧 Loading project-specific overrides..."

       # Extract project-specific settings
       PROJECT_MAIN_BRANCH=$(jq -r ".projects.\"$PROJECT\".mainBranch // \"$DEFAULT_MAIN_BRANCH\"" "$OVERRIDES_FILE")
       PROJECT_DOCS_PATH=$(jq -r ".projects.\"$PROJECT\".documentationPath // \"$DOCS_PATH\"" "$OVERRIDES_FILE")
       PROJECT_STALE_DAYS=$(jq -r ".projects.\"$PROJECT\".staleBranchDays // $STALE_BRANCH_DAYS" "$OVERRIDES_FILE")
       EXCLUDE_FROM_AUDIT=$(jq -r ".projects.\"$PROJECT\".excludeFromAudit // false" "$OVERRIDES_FILE")

       if [ "$EXCLUDE_FROM_AUDIT" = "true" ]; then
           echo "⏭️ Project $PROJECT is excluded from audit per configuration"
           cd "$ORIGINAL_DIR"
           exit 0
       fi

       echo "✅ Using project-specific settings:"
       echo "   Main branch: $PROJECT_MAIN_BRANCH"
       echo "   Docs path: $PROJECT_DOCS_PATH"
       echo "   Stale after: $PROJECT_STALE_DAYS days"
   else
       PROJECT_MAIN_BRANCH="$DEFAULT_MAIN_BRANCH"
       PROJECT_DOCS_PATH="$DOCS_PATH"
       PROJECT_STALE_DAYS="$STALE_BRANCH_DAYS"
   fi

   # Verify we're in a git repository
   if [ ! -d ".git" ]; then
       echo "❌ $PROJECT is not a git repository"
       cd "$ORIGINAL_DIR"
       exit 1
   fi

   echo "🎯 Auditing branches for project: $PROJECT"
   echo "📍 Main branch: $PROJECT_MAIN_BRANCH"
   ```

**Phase 1: Setup Documentation Structure**

3. **Check and Create Folders as Needed:**
   ```bash
   # Create project-specific documentation structure
   if [ "${CREATE_DOCS_STRUCTURE:-true}" = "true" ]; then
       if [ ! -d "$PROJECT_DOCS_PATH" ]; then
           echo "📁 Creating git documentation structure for $PROJECT..."
           mkdir -p "$PROJECT_DOCS_PATH/active-branches"
           mkdir -p "$PROJECT_DOCS_PATH/merged-branches"
           mkdir -p "$PROJECT_DOCS_PATH/branch-reports"
           mkdir -p "$PROJECT_DOCS_PATH/scripts"
           mkdir -p "$PROJECT_DOCS_PATH/templates"
           echo "✅ Created git documentation structure in $PROJECT"
       fi

       # Check for any missing subfolders and create them
       for folder in active-branches merged-branches branch-reports scripts templates; do
           if [ ! -d "$PROJECT_DOCS_PATH/$folder" ]; then
               echo "📁 Creating missing folder: $PROJECT_DOCS_PATH/$folder"
               mkdir -p "$PROJECT_DOCS_PATH/$folder"
           fi
       done
   fi
   ```

**Phase 2: Discover and List All Branches**

4. **Get Complete Branch Inventory:**
   ```bash
   # Fetch latest from remote if configured
   if [ "${AUTO_FETCH_BEFORE_AUDIT:-true}" = "true" ]; then
       echo "🔄 Fetching latest from remote..."
       git fetch --all --prune 2>/dev/null || echo "⚠️ Could not fetch from remote"
   fi

   # List all local branches
   echo "📋 Analyzing branches..."
   git branch --format="%(refname:short),%(upstream:short),%(ahead-behind)" > /tmp/local_branches.txt

   # List all remote branches
   git branch -r --format="%(refname:short)" > /tmp/remote_branches.txt

   # Check merge status for each branch
   git branch --merged "$PROJECT_MAIN_BRANCH" > /tmp/merged_branches.txt
   git branch --no-merged "$PROJECT_MAIN_BRANCH" > /tmp/unmerged_branches.txt

   # Get stale branches (older than configured days)
   STALE_DATE=$(date -d "$PROJECT_STALE_DAYS days ago" "+%Y-%m-%d" 2>/dev/null || date -v -"$PROJECT_STALE_DAYS"d "+%Y-%m-%d")
   git for-each-ref --format='%(refname:short) %(committerdate)' refs/heads | \
       while read branch date; do
           if [ "$(date -d "$date" "+%Y-%m-%d" 2>/dev/null || date -j -f "%Y-%m-%d %H:%M:%S %z" "$date" "+%Y-%m-%d")" \< "$STALE_DATE" ]; then
               echo "$branch"
           fi
       done > /tmp/stale_branches.txt 2>/dev/null
   ```

5. **Create Active Branch Registry:**
   Generate `$PROJECT_DOCS_PATH/ACTIVE-BRANCHES.md`:
   ```markdown
   # Active Git Branches - $(date)
   # Project: $PROJECT
   # Workspace: $WORKSPACE_NAME

   ## Summary
   - Total local branches: $(wc -l < /tmp/local_branches.txt)
   - Merged with $PROJECT_MAIN_BRANCH: $(wc -l < /tmp/merged_branches.txt)
   - Unmerged branches: $(wc -l < /tmp/unmerged_branches.txt)
   - Stale branches (>$PROJECT_STALE_DAYS days): $(wc -l < /tmp/stale_branches.txt)
   - Protected branches: $PROJECT_MAIN_BRANCH

   ## Branch Status Overview

   ### 🔒 Protected Branches
   | Branch | Purpose | Last Activity | Status |
   |--------|---------|---------------|---------|
   | $PROJECT_MAIN_BRANCH | Main development & deployments | $(git log -1 --format="%ad" --date=short $PROJECT_MAIN_BRANCH) | 🔒 Protected |

   ### ✅ Merged Branches (Safe to Delete)
   | Branch | Category | Last Commit | Merge Date | Author | Description |
   |--------|----------|-------------|------------|--------|-------------|
   [Generated from merged branches analysis]

   ### 🔄 Active/Unmerged Branches
   | Branch | Category | Last Commit | Behind Main | Author | Status |
   |--------|----------|-------------|-------------|--------|---------|
   [Generated from unmerged branches analysis]

   ### ❓ Investigation Needed (Stale Branches)
   | Branch | Issue | Last Activity | Recommendation |
   |--------|-------|---------------|----------------|
   [Generated from stale branches analysis]
   ```

**Phase 3: Interactive Branch Review**

6. **For Each Branch, Collect Information:**

   **Technical Data (Automatic):**
   ```bash
   # For each branch discovered:
   for branch in $(git branch --format="%(refname:short)"); do
       if [ "$branch" != "$PROJECT_MAIN_BRANCH" ]; then
           echo "Analyzing branch: $branch"

           # Get technical details
           git log --oneline -n 5 "$branch"
           git show --stat "$branch"
           git log --pretty=format:"%h %ad %an %s" --date=short -n 10 "$branch"
           git diff --name-only "$PROJECT_MAIN_BRANCH..$branch"

           # Get commit counts
           ahead_count=$(git rev-list --count "$PROJECT_MAIN_BRANCH..$branch" 2>/dev/null || echo "0")
           behind_count=$(git rev-list --count "$branch..$PROJECT_MAIN_BRANCH" 2>/dev/null || echo "0")

           echo "Branch $branch: $ahead_count ahead, $behind_count behind $PROJECT_MAIN_BRANCH"
       fi
   done
   ```

   **Interactive Questions (For Each Branch):**
   ```
   Branch: [name]
   Last commit: [message] ([date])
   Author: [name]
   Commits ahead of $PROJECT_MAIN_BRANCH: [X]
   Commits behind $PROJECT_MAIN_BRANCH: [X]
   Merge status: [Merged/Unmerged]

   Questions:
   1. What category is this branch?
      ($BRANCH_CATEGORIES)

   2. What is the current status?
      a) ✅ Completed and merged
      b) 🔄 Active work in progress
      c) ⏸️ Paused/blocked work
      d) ❌ Abandoned/obsolete
      e) ❓ Unknown/needs investigation

   3. Brief description of this branch's purpose:
      [User input]

   4. If unmerged, what's needed to complete?
      [User input for unmerged branches]

   5. Safe to delete? (for merged branches)
      [y/n with reasoning]
   ```

**Phase 4: Create Individual Branch Documentation**

7. **For Each Branch, Create Documentation File:**
   (Same format as before, but using configured paths and main branch)

**Phase 5: Generate Reports and Action Plans**

8. **Create Comprehensive Branch Report:**
   Generate `$PROJECT_DOCS_PATH/branch-reports/BRANCH-AUDIT-$(date +%Y%m%d).md`
   (Adapted format using project-specific information)

**Phase 6: Update Active Branches with Main**

9. **Merge Main into Active Branches:**
   ```bash
   # For each active branch that's behind main:
   for branch in $(cat /tmp/unmerged_branches.txt); do
       if [ "$branch" != "$PROJECT_MAIN_BRANCH" ] && [ -n "$branch" ]; then
           echo "🔄 Updating branch: $branch"

           # Show how far behind main this branch is
           behind_count=$(git rev-list --count "$branch..$PROJECT_MAIN_BRANCH")
           echo "Branch $branch is $behind_count commits behind $PROJECT_MAIN_BRANCH"

           # Check if auto-update is enabled for this project
           AUTO_UPDATE=$(jq -r ".projects.\"$PROJECT\".autoUpdateBranches // false" "$OVERRIDES_FILE" 2>/dev/null || echo "false")

           if [ "$AUTO_UPDATE" = "true" ] || [ "${AUTO_UPDATE_BRANCHES:-false}" = "true" ]; then
               merge_response="y"
           else
               echo "Merge $PROJECT_MAIN_BRANCH into $branch? (y/n/skip_all)"
               read -r merge_response
           fi

           # Rest of merge logic (same as before but using PROJECT_MAIN_BRANCH)
       fi
   done
   ```

**Phase 7: Context File Cleanup**

10. **Audit Context Files Against Discovered Projects:**
    ```bash
    # Navigate back to workspace root for context cleanup
    cd "$ORIGINAL_DIR"

    echo "🔍 Scanning Claude context files across all projects..."
    CONTEXT_DIR=".claude/branch-context"

    if [ -d "$CONTEXT_DIR" ]; then
        # Get all context files
        CONTEXT_FILES=$(ls -1 "$CONTEXT_DIR"/*.md 2>/dev/null | xargs -n1 basename)

        STALE_CONTEXTS=()
        ACTIVE_CONTEXTS=()

        for context_file in $CONTEXT_FILES; do
            # Extract branch name from context file
            branch_name=$(echo "$context_file" | sed 's/-context\.md$//')

            echo "Checking: $context_file -> branch: $branch_name"

            # Check if branch exists in any discovered project
            branch_found=false

            for project in "${DISCOVERED_PROJECTS[@]}"; do
                cd "$project"

                # Check if branch exists locally or remotely
                if git branch -a | grep -q "$branch_name" 2>/dev/null; then
                    echo "  ✅ Branch '$branch_name' found in $project"
                    branch_found=true
                    ACTIVE_CONTEXTS+=("$context_file")
                    break
                fi

                cd "$ORIGINAL_DIR"
            done

            if [ "$branch_found" = false ]; then
                echo "  ❌ Branch '$branch_name' not found in any project"
                STALE_CONTEXTS+=("$context_file")
            fi
        done

        # Handle stale contexts (same logic as before)
    fi
    ```

**Phase 8: Return to Original Directory**

11. **Cleanup and Summary:**
    ```bash
    # Return to original directory
    cd "$ORIGINAL_DIR"
    echo "📍 Returned to workspace root: $(pwd)"

    # Summary of completed work
    echo "✅ Branch audit completed for project: $PROJECT"
    echo "📋 Documentation created in: $PROJECT/$PROJECT_DOCS_PATH/"
    echo "🗂️  Branch reports available for review"
    echo "🧹 Context file cleanup completed"
    echo "🏢 Workspace: $WORKSPACE_NAME"

    # Clean up temporary files
    rm -f /tmp/local_branches.txt /tmp/remote_branches.txt /tmp/merged_branches.txt /tmp/unmerged_branches.txt /tmp/stale_branches.txt
    ```

**Usage:**
```bash
# Auto-discover and select project:
/audit-branches

# Specific project:
/audit-branches frontend
/audit-branches backend
/audit-branches mobile-app

# Any project name that matches your workspace structure
```

**🚨 MANDATORY FINAL OUTPUT**

Same format as before, but using discovered project names and configured main branch.

**Configuration Examples:**

```bash
# workspace.env
WORKSPACE_NAME="E-commerce Platform"
PROJECT_INCLUDE_PATTERNS="frontend,backend,api,mobile-*"
PROJECT_EXCLUDE_PATTERNS=".git,node_modules,dist,coverage"
DEFAULT_MAIN_BRANCH="main"
STALE_BRANCH_DAYS="21"
```

```json
// project-overrides.json
{
  "projects": {
    "legacy-system": {
      "excludeFromAudit": true
    },
    "mobile-app": {
      "mainBranch": "develop",
      "staleBranchDays": 45,
      "autoUpdateBranches": true
    }
  }
}
```

This generic version works with any workspace structure while maintaining all the functionality of the original command. The configuration system allows customization without hardcoding project names or paths.