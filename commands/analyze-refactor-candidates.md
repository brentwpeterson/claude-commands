Analyze and document files that need refactoring: $ARGUMENTS

**Target Directory:** $ARGUMENTS (optional - defaults to current directory)
**Action:** Search, analyze, and document files that need refactoring based on Python file size guidelines

**Phase 1: File Discovery & Analysis**
1. **Search for Refactor Candidates:**
   - Search Python files recursively in target directory
   - Count lines of code (excluding comments and empty lines)
   - Analyze file structure and complexity
   - Categorize files by refactor priority:
     - **🔴 CRITICAL (5000+ lines)** - Immediate refactoring needed
     - **⚠️ HIGH (2000-4999 lines)** - Should refactor soon
     - **⚠️ MEDIUM (1000-1999 lines)** - Consider refactoring
     - **ℹ️ LOW (500-999 lines)** - Monitor for growth
     - **✅ OPTIMAL (0-499 lines)** - Good size for Claude

2. **File Quality Assessment:**
   - Analyze imports and dependencies
   - Identify potential module boundaries
   - Check for repeated patterns
   - Assess function/class complexity
   - Detect code smells (long functions, high complexity)

**Phase 2: Refactor Priority Matrix**
3. **Generate Priority Report:**
   - Create structured analysis document
   - Rank files by refactoring urgency
   - Estimate effort required (Small/Medium/Large)
   - Identify quick wins vs major refactors
   - Map dependencies between files

4. **Claude Code Impact Assessment:**
   Using the Python File Size Guide criteria:

   | File Size | Claude's Ability | Refactor Priority |
   |-----------|------------------|-------------------|
   | 0-500 lines | ⚡ Instant - Full comprehension | ✅ Optimal |
   | 500-1000 lines | ✅ Excellent - Complete context | ℹ️ Monitor |
   | 1000-2000 lines | ⚠️ Good - May need to scroll | ⚠️ Consider |
   | 2000-3000 lines | ⚠️ Challenging - Works in sections | ⚠️ Should refactor |
   | 3000-5000 lines | 🔴 Difficult - Limited context | 🔴 High priority |
   | 5000+ lines | ❌ Problematic - May hit limits | 🔴 Critical |

**Phase 3: Refactor Strategy Documentation**
5. **Create Refactor Roadmap:**
   - Generate file: `/todo/current/refactor/[target-dir]-refactor-analysis/README.md`
   - Include detailed findings:
     ```markdown
     # Refactor Analysis Report - [Target Directory]
     **Generated:** [current-date]
     **Analyzed:** [file-count] Python files
     **Claude Code Compatibility:** [summary]

     ## 🔴 CRITICAL - Immediate Action Required
     [List files 5000+ lines with specific recommendations]

     ## ⚠️ HIGH PRIORITY - Plan Refactoring
     [List files 2000-4999 lines with suggested splits]

     ## ⚠️ MEDIUM PRIORITY - Monitor Growth
     [List files 1000-1999 lines with growth warnings]

     ## Recommended Refactor Strategy
     [Specific suggestions for each file]

     ## Quick Wins (Low Effort, High Impact)
     [Files that can be easily split]

     ## Major Refactors (High Effort, High Impact)
     [Complex files needing architectural changes]
     ```

6. **Generate Refactor Tasks:**
   - Create individual task files for each refactor candidate
   - Include specific splitting suggestions
   - Estimate time and complexity
   - Suggest modular structure based on file analysis

**Phase 4: Implementation Guidance**
7. **Claude Code Optimization Tips:**
   - For each large file, provide:
     - Suggested module structure
     - Import dependency mapping
     - Function/class grouping recommendations
     - Splitting sequence (which parts to extract first)
     - Testing strategy for refactored modules

8. **Create Refactor Branch (Optional):**
   - If user confirms, create `refactor/[target-dir]-modularization` branch
   - Set up task folder structure
   - Initialize refactor tracking documentation

**Phase 5: Monitoring & Metrics**
9. **Establish Baseline Metrics:**
   - Record current file sizes
   - Track refactoring progress
   - Set up alerts for file growth beyond thresholds
   - Create monthly review schedule

10. **Success Criteria:**
    - Target: No files over 2000 lines
    - Ideal: Most files under 500 lines
    - Claude Code efficiency: All files in "Excellent" or "Instant" categories
    - Maintainability: Clear module boundaries and responsibilities

**Output Files Created:**
- `/todo/current/refactor/[target-dir]-refactor-analysis/README.md` - Main analysis report
- `/todo/current/refactor/[target-dir]-refactor-analysis/file-sizes.csv` - Raw data
- `/todo/current/refactor/[target-dir]-refactor-analysis/refactor-tasks/` - Individual task files
- `/todo/current/refactor/[target-dir]-refactor-analysis/implementation-plan.md` - Step-by-step refactor guide

**Usage Examples:**
- `/project:analyze-refactor-candidates` (analyze current directory)
- `/project:analyze-refactor-candidates backend/app/routers/` (analyze specific directory)
- `/project:analyze-refactor-candidates backend/` (analyze entire backend)

**Integration with Existing Workflow:**
- Works with `/project:create-branch` for implementing refactor tasks
- Compatible with `/claude-complete` for tracking refactor progress
- Supports `/project:audit-branches` for refactor branch management

**File Size Thresholds (Based on Python File Size Guide):**
- **Optimal for Claude:** 0-500 lines (instant comprehension)
- **Good for Claude:** 500-1000 lines (excellent context)
- **Manageable:** 1000-2000 lines (may need scrolling)
- **Challenging:** 2000-3000 lines (works in sections)
- **Difficult:** 3000-5000 lines (limited context)
- **Problematic:** 5000+ lines (may hit token limits)

This command transforms large, unwieldy files into Claude Code-friendly modules that enable more effective development, refactoring, and maintenance.