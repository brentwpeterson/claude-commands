# Audit Python/FastAPI Codebase

Perform a comprehensive audit of this Python/FastAPI codebase to identify dead code, redundant files, overly complex modules, and architectural issues.

## Step 1: Install Audit Tools (if needed)

Check if these tools are installed, and install any that are missing:
- vulture (dead code detection)
- radon (complexity metrics)
- pydeps (dependency visualization)

```bash
pip install vulture radon pydeps --quiet
```

## Step 2: Dead Code Analysis

Run vulture to find unused code:

```bash
vulture . --min-confidence 70 --exclude venv,.venv,node_modules,__pycache__,.git
```

Create a report of findings, categorized by:
- **Unused imports**
- **Unused functions/methods**
- **Unused variables**
- **Unused classes**
- **Potentially orphaned files** (files with mostly dead code)

## Step 3: Complexity Analysis

Run radon to identify overly complex files (especially router files):

```bash
radon cc . -a -s --exclude "venv/*,.venv/*" --min C
radon raw . -s --exclude "venv/*,.venv/*" | head -50
```

Flag any files with:
- Cyclomatic complexity grade C or worse
- More than 500 lines of code
- More than 20 functions in a single file

## Step 4: Dependency Mapping

Analyze import relationships:

```bash
pydeps . --cluster --no-show --max-bacon 3 -o /tmp/deps.svg 2>/dev/null || echo "pydeps visualization skipped"
```

Identify:
- Files that are never imported by anything else
- Circular dependencies
- Router files that import too many modules

## Step 5: FastAPI-Specific Checks

Analyze the FastAPI structure for:
- **Router files**: List all files containing `APIRouter()` and count their endpoints
- **Unused routes**: Routes defined but potentially not included in the main app
- **Duplicate route patterns**: Similar or identical endpoint paths
- **Model redundancy**: Pydantic models that are duplicates or near-duplicates

## Step 6: Generate Report

Create a structured report with:

### Summary
- Total files analyzed
- Estimated dead code percentage
- Most complex files (top 5)
- Largest files by LOC (top 5)

### Recommended Actions
Prioritize findings into:

1. **Safe to Remove** - Files/code with high confidence of being unused
2. **Needs Review** - Potentially unused but requires verification
3. **Refactor Candidates** - Complex files that should be split
4. **Quick Wins** - Unused imports and variables that are easy fixes

### Interactive Cleanup
For each category, ask if I want to:
- See the details
- Automatically fix (for safe items like unused imports)
- Get a refactoring plan (for complex files)
- Skip

## Important Guidelines

- Never delete or modify files without explicit confirmation
- For router refactoring, suggest a domain-driven structure
- Consider test files - unused code there may be intentional test fixtures
- Check git history before recommending removal of seemingly dead code
- Preserve any files that might be dynamically imported or used via reflection
