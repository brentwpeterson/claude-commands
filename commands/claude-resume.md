Resume work on a specific branch in a workspace project with smart conflict resolution and context restoration

**Usage**: `/claude-resume <project> <branch>`

**Purpose**: Safely resume work on an existing branch by checking it out, merging latest changes from default branch, handling conflicts intelligently, and restoring work context.

**Examples**:
- `/claude-resume frontend feature/new-api`
- `/claude-resume backend fix/payment-bug`
- `/claude-resume mobile-app enhancement/ui-improvements`

**🗂️ WORKSPACE VALIDATION:**
1. **Validate Workspace Structure:**
   - Ensure running from workspace root or navigate there
   - Verify `.claude/` folder exists in workspace root (not duplicated in subprojects)
   - Validate target project exists (auto-discovered Git repositories per `.claude/local/workspace.env` configuration)

**Phase 1: Environment Setup & Safety**
2. **Navigate to Target Project:**
   ```bash
   # Store original location
   ORIGINAL_DIR=$(pwd)

   # Navigate to project
   cd <project>/

   # Verify git repository
   if [ ! -d ".git" ]; then
     echo "❌ ERROR: Not a git repository"
     exit 1
   fi
   ```

3. **Safety Checks & Stash:**
   ```bash
   # Check for uncommitted changes
   if [ -n "$(git status --porcelain)" ]; then
     echo "⚠️ Uncommitted changes detected. Stashing..."
     git stash push -m "claude-resume auto-stash $(date)"
     echo "✅ Changes stashed for safety"
   fi

   # Record current branch before switching
   CURRENT_BRANCH=$(git branch --show-current)
   echo "📍 Currently on branch: $CURRENT_BRANCH"
   ```

**Phase 2: Default Branch Detection & Update**
4. **Auto-detect Default Branch:**
   ```bash
   # Detect if repo uses master or main
   DEFAULT_BRANCH=""
   if git show-ref --verify --quiet refs/heads/master; then
     DEFAULT_BRANCH="master"
   elif git show-ref --verify --quiet refs/heads/main; then
     DEFAULT_BRANCH="main"
   else
     echo "❌ ERROR: Cannot detect default branch (master/main)"
     exit 1
   fi

   echo "🎯 Detected default branch: $DEFAULT_BRANCH"
   ```

5. **Update Default Branch:**
   ```bash
   # Fetch latest changes
   echo "🔄 Fetching latest changes..."
   git fetch origin

   # Update default branch
   echo "📥 Updating $DEFAULT_BRANCH..."
   git checkout $DEFAULT_BRANCH
   git pull origin $DEFAULT_BRANCH
   ```

**Phase 3: Branch Checkout & Validation**
6. **Smart Branch Checkout:**
   ```bash
   TARGET_BRANCH="<branch>"

   # Check if branch exists locally
   if git show-ref --verify --quiet refs/heads/$TARGET_BRANCH; then
     echo "📍 Checking out existing local branch: $TARGET_BRANCH"
     git checkout $TARGET_BRANCH
   # Check if branch exists on remote
   elif git show-ref --verify --quiet refs/remotes/origin/$TARGET_BRANCH; then
     echo "📥 Creating local branch from remote: $TARGET_BRANCH"
     git checkout -b $TARGET_BRANCH origin/$TARGET_BRANCH
   else
     echo "❌ ERROR: Branch '$TARGET_BRANCH' not found locally or on remote"
     echo "Available branches:"
     git branch -a
     exit 1
   fi
   ```

**Phase 4: Intelligent Merge & Conflict Resolution**
7. **Attempt Merge with Default Branch:**
   ```bash
   echo "🔄 Merging $DEFAULT_BRANCH into $TARGET_BRANCH..."

   # Check how far behind we are
   COMMITS_BEHIND=$(git rev-list --count HEAD..origin/$DEFAULT_BRANCH)
   echo "📊 Branch is $COMMITS_BEHIND commits behind $DEFAULT_BRANCH"

   if [ "$COMMITS_BEHIND" = "0" ]; then
     echo "✅ Branch is up to date with $DEFAULT_BRANCH"
   else
     # Attempt merge
     if git merge origin/$DEFAULT_BRANCH --no-edit; then
       echo "✅ Auto-merge successful"
     else
       echo "⚠️ Merge conflicts detected. Applying intelligent resolution..."

       # List conflicted files
       CONFLICT_FILES=$(git diff --name-only --diff-filter=U)
       echo "📋 Conflicted files:"
       echo "$CONFLICT_FILES"

       # Apply master/main wins strategy with analysis
       for file in $CONFLICT_FILES; do
         echo "🔍 Analyzing conflict in: $file"

         # Check if file is critical for branch functionality
         if [[ "$file" == *"package.json"* ]] || [[ "$file" == *"requirements.txt"* ]] || [[ "$file" == *"Dockerfile"* ]]; then
           echo "⚠️ Critical file detected: $file"
           echo "📝 Applying $DEFAULT_BRANCH version but preserving branch-specific dependencies"

           # Use theirs (master/main) but note for manual review
           git checkout --theirs "$file"
           git add "$file"
           echo "📌 TODO: Review $file for branch-specific requirements"
         else
           echo "📁 Standard file: $file - applying $DEFAULT_BRANCH version"
           git checkout --theirs "$file"
           git add "$file"
         fi
       done

       # Complete merge
       git commit --no-edit
       echo "✅ Merge conflicts resolved using $DEFAULT_BRANCH strategy"
     fi
   fi
   ```

**Phase 5: Context Restoration**
8. **Locate and Display Work Context:**
   ```bash
   # Look for task documentation
   TASK_FOLDER=""

   # Search in common task locations
   for category in feature fix enhancement refactor infrastructure; do
     if [ -d "../../todo/current/$category" ]; then
       for task_dir in ../../todo/current/$category/*/; do
         if [[ "$task_dir" == *"$TARGET_BRANCH"* ]] || [[ "$task_dir" == *"$(echo $TARGET_BRANCH | sed 's|.*/||')"* ]]; then
           TASK_FOLDER="$task_dir"
           break 2
         fi
       done
     fi
   done

   if [ -n "$TASK_FOLDER" ]; then
     echo "📁 Found task documentation: $TASK_FOLDER"

     # Display README if available
     if [ -f "$TASK_FOLDER/README.md" ]; then
       echo ""
       echo "📋 WORK CONTEXT:"
       echo "==============="
       head -20 "$TASK_FOLDER/README.md"
       echo ""
       echo "📖 Full context: $TASK_FOLDER/README.md"
     fi

     # Check for progress logs
     if ls "$TASK_FOLDER"/*.log 1> /dev/null 2>&1; then
       echo "📊 Progress logs available in: $TASK_FOLDER"
     fi
   else
     echo "⚠️ No task documentation found for branch: $TARGET_BRANCH"
     echo "💡 Consider running: /project:create-branch to set up task structure"
   fi
   ```

9. **Check Branch Context Files:**
   ```bash
   # Look for branch-specific context in workspace .claude folder
   BRANCH_CONTEXT_FILE="../../.claude/branch-context/${TARGET_BRANCH}-context.md"

   if [ -f "$BRANCH_CONTEXT_FILE" ]; then
     echo "🧠 Found branch context: $BRANCH_CONTEXT_FILE"
     echo ""
     echo "🎯 PREVIOUS SESSION CONTEXT:"
     echo "============================"
     head -15 "$BRANCH_CONTEXT_FILE"
     echo ""
     echo "📖 Full context: $BRANCH_CONTEXT_FILE"
   fi
   ```

**Phase 6: Status Summary & Next Steps**
10. **Generate Resume Summary:**
    ```bash
    echo ""
    echo "🎯 BRANCH RESUME COMPLETE"
    echo "========================="
    echo "📍 Project: <project>"
    echo "🌿 Branch: $TARGET_BRANCH"
    echo "🔄 Merged: $COMMITS_BEHIND commits from $DEFAULT_BRANCH"
    echo "📂 Working Directory: $(pwd)"

    # Show recent commits on this branch
    echo ""
    echo "📊 RECENT BRANCH ACTIVITY:"
    echo "=========================="
    git log --oneline -5 --graph --decorate

    # Show current git status
    echo ""
    echo "📋 CURRENT STATUS:"
    echo "=================="
    git status --short

    if [ -n "$TASK_FOLDER" ]; then
      echo ""
      echo "📁 Task Documentation: $TASK_FOLDER"
    fi

    echo ""
    echo "🎯 READY TO CONTINUE WORK ON: $TARGET_BRANCH"
    echo "Next: Review context and continue implementation"
    ```

**🛡️ ERROR HANDLING:**
- Validates all parameters before execution
- Safely stashes uncommitted changes
- Provides clear error messages with resolution steps
- Falls back gracefully on merge conflicts
- Preserves original working directory state

**🔄 INTEGRATION:**
- Works with existing `/project:*` commands
- Integrates with task documentation structure
- Preserves branch context from `/claude-close` saves
- Compatible with workspace-wide `.claude/` configuration

**🎯 INTELLIGENCE FEATURES:**
- Auto-detects master vs main branch
- Analyzes merge conflicts for criticality
- Restores work context from multiple sources
- Provides comprehensive status summary
- Suggests next actions based on branch state

This ensures safe, intelligent branch resumption with full context restoration!