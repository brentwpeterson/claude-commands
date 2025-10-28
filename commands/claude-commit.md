Enhanced commit with comprehensive security validation and documentation updates

**🎯 PURPOSE:**
Create secure, well-documented commits with comprehensive validation, security scanning, and automatic documentation updates that provide full context for code changes.

**⚡ QUICK USAGE:**
`/claude-commit [message]` - Full validation and commit
`/claude-commit --security-only` - Security scan only (no commit)

**🔄 WORKFLOW:**

**Phase 1: Pre-Commit Security Validation**
1. **File Size Validation:**
   - Check all Python files being committed for size violations
   - **BLOCKING condition**: Any Python file over 1000 lines
   - Files between 500-1000 lines get warnings
   - Use Python File Size Guide criteria:
     ```
     FILE SIZE CHECK...
     OPTIMAL: file.py (324 lines) - Optimal for Claude
     WARNING: growing.py (847 lines) - Monitor for growth
     CRITICAL: large.py (1,247 lines) - EXCEEDS 1000 LINE LIMIT
     ```

2. **Critical Security Scan:**
   - Run comprehensive security scanner on all staged files
   - Check for hardcoded API keys (OpenAI, Anthropic, AWS, GitHub)
   - Detect hardcoded URLs (localhost, production endpoints)
   - Validate environment variable usage patterns
   - **BLOCK commit if CRITICAL issues found**

3. **Security Issue Handling:**
   ```
   CRITICAL ISSUES FOUND → BLOCK COMMIT
   - Real API keys detected
   - Database URLs with embedded credentials
   - Private keys or certificates in code
   - Authentication tokens in source
   - Python files over 1000 lines (Claude Code degradation)

   HIGH PRIORITY WARNINGS → USER CONFIRMATION
   - Hardcoded production URLs
   - Suspicious token-like strings
   - Configuration that should be environment variables
   - Python files between 500-1000 lines (growth monitoring)

   MEDIUM/LOW ISSUES → LOG WITH SUGGESTIONS
   - Localhost URLs in production files
   - Magic numbers that should be constants
   - Hardcoded file paths
   ```

4. **Security Report Generation:**
   - Create detailed findings report in `.claude/security-reports/[timestamp]-pre-commit.md`
   - Categorize by severity (CRITICAL, HIGH, MEDIUM, LOW)
   - Provide specific fix recommendations with line numbers
   - Include security attestation for commit message

**Phase 2: Change Analysis & Documentation 📚**
4. **Git Change Analysis:**
   - Analyze `git diff --cached` for all staged files
   - Categorize changes: frontend, backend, database, documentation, configuration
   - Identify potential breaking changes
   - Calculate change complexity and impact scope

5. **CHANGELOG.md Auto-Update:**
   - Read current version from `/VERSION` file
   - Parse git diff to understand change types
   - Auto-categorize entries:
     - **Added:** New features users can see/use
     - **Changed:** Improvements to existing features  
     - **Fixed:** Bug fixes users will notice
     - **Technical:** Internal improvements, refactoring
   - Update current version section with new entries
   - Maintain proper semantic versioning format

6. **Documentation Validation:**
   - Check if new React components need documentation
   - Validate if new API endpoints need docs updates
   - Detect configuration changes requiring setup docs
   - Flag missing README updates for new features

**Phase 3: Verbose Commit Message Generation 📝**
7. **Comprehensive Commit Message Creation:**
   ```
   [type]: [brief description]
   
   ## CHANGES OVERVIEW:
   - Frontend: [X files] - [Brief summary of UI changes]
   - Backend: [X files] - [Brief summary of API/logic changes] 
   - Database: [X files] - [Schema or migration changes]
   - Security: [X files] - [Security improvements or fixes]
   
   ## IMPACT ANALYSIS:
   - User Experience: [How users will be affected]
   - API Changes: [Breaking changes, new endpoints]
   - Database: [Migration requirements, data impact]
   - Configuration: [Environment variable changes]
   
   ## SECURITY ATTESTATION:
   No hardcoded API keys detected
   No hardcoded production URLs
   Environment variables properly used
   All Python files under 1000 lines (Claude Code compatible)
   [Any warnings with accepted risk and remediation plan]
   
   ## TESTING REQUIREMENTS:
   - [ ] Unit tests for [specific components/functions]
   - [ ] Integration tests for [specific API flows]
   - [ ] Manual testing of [user workflows affected]
   - [ ] Security validation of [authentication/authorization changes]
   
   ## DEPLOYMENT CONSIDERATIONS:
   - Environment variables: [New requirements or changes]
   - Database migrations: [If schema changes included]
   - Configuration updates: [Docker, deployment configs]
   - Cache invalidation: [If frontend assets changed significantly]
   
   ## BREAKING CHANGES:
   [None] or [Detailed description of breaking changes and migration path]
   
   🤖 Generated with [Claude Code](https://claude.ai/code)
   
   Co-Authored-By: Claude <noreply@anthropic.com>
   ```

**Phase 4: Final Validation & Commit 🚀**
8. **Pre-Commit Checks:**
   - Verify all files are properly staged
   - Run final security validation on staged content only
   - Confirm documentation updates are included in staging
   - Validate commit message meets standards

9. **Commit Execution:**
   - Create commit using comprehensive generated message
   - Include security attestation in commit metadata
   - Add co-authoring information
   - Handle multi-line commit messages properly using heredoc

10. **Post-Commit Summary:**
    ```
    ✅ SECURE COMMIT CREATED
    
    📋 COMMIT DETAILS:
    - Hash: [commit-hash]
    - Files: [X] files across [Y] categories
    - Security: [status] - [summary of findings]
    - Documentation: Updated CHANGELOG.md for v[version]
    
    🔒 SECURITY STATUS:
    - Critical Issues: 0 ✅
    - High Priority: [X] (accepted/resolved)
    - Scan Duration: [time]
    
    📚 DOCUMENTATION:
    - CHANGELOG.md: Updated with [X] entries
    - Technical docs: [status of updates]
    
    🎯 NEXT STEPS:
    - Run tests to validate changes
    - Consider deployment with: /deploy-code
    - Review security warnings if any: .claude/security-reports/[timestamp]
    ```

**🔒 SECURITY INTEGRATION:**

**Critical Security Patterns (BLOCKING):**
- `sk-[a-zA-Z0-9]{32,}` - OpenAI API keys
- `claude-[a-zA-Z0-9-_]{32,}` - Anthropic API keys  
- `AKIA[0-9A-Z]{16}` - AWS access keys
- `xoxb-[0-9]{11}-[0-9]{12}-[a-zA-Z0-9]{24}` - Slack tokens
- `ghp_[A-Za-z0-9]{36}` - GitHub personal access tokens
- Database connection strings with embedded credentials

**High Priority Patterns (WARNING):**
- `http://localhost:\d+` - Hardcoded localhost URLs
- `https://app\.requestdesk\.ai` - Hardcoded production URLs
- `127\.0\.0\.1:\d+` - Hardcoded local IP addresses
- Configuration values that should be environment variables

**Smart Exclusions:**
- node_modules/, .git/, venv/ directories
- package-lock.json, yarn.lock files  
- Documentation and log files
- Test files with legitimate localhost usage
- Docker configuration files

**🚫 BLOCKING CONDITIONS:**
- Critical security issues detected (API keys, credentials)
- No staged files found
- Git repository in unstable state (mid-merge, mid-rebase)
- CHANGELOG.md parsing errors (malformed version sections)

**📝 COMMAND OPTIONS:**

**Standard Mode (Default):**
```bash
/claude-commit "Add user authentication system"
```
- Full security scan with blocking for critical issues
- Comprehensive documentation updates  
- Verbose commit message generation
- Interactive confirmation for high-priority warnings

**Security-Only Mode:**
```bash
/claude-commit --security-only
```
- Run comprehensive security validation only
- Generate detailed security report
- No commit creation, just validation and reporting
- Perfect for pre-commit hooks or CI/CD integration

**🛡️ SAFETY FEATURES:**

1. **Non-Destructive Validation:**
   - All scans run on staged content only
   - No automatic file modifications without user consent
   - Clear rollback instructions if issues found
   - Detailed logging for audit and debugging

2. **User Control:**
   - User confirmation required for high-priority warnings
   - Option to abort commit at any validation stage
   - Clear remediation guidance for all issues
   - Educational feedback about security best practices

3. **Performance Optimization:**
   - Smart file filtering for large repositories
   - Parallel scanning where possible
   - Cached results for unchanged files
   - Target completion time: <30 seconds for full validation

**🔗 INTEGRATION:**
- Works seamlessly with existing `/claude-clean`, `/claude-start` commands
- Compatible with `/deploy-code` workflow for post-commit deployment
- Integrates with branch-based development via `/project:*` commands
- Supports git hooks for automated security validation

**📊 SUCCESS METRICS:**
- Zero critical security issues in commits
- 95% reduction in hardcoded credentials
- Consistent, comprehensive commit messages
- Automated documentation maintenance
- Enhanced developer security awareness through educational feedback

This command transforms the commit process into a comprehensive quality gate that ensures security, documentation, and code quality standards while maintaining developer productivity.