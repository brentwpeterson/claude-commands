# Claude Code Configuration Template

This repository provides a comprehensive template for setting up Claude Code configuration directories with slash commands, security scanning, session management, and **custom command management**.

## 🚀 Quick Start

1. **Copy this entire `.claude` directory** to the root of your project
2. **Customize settings**: Copy `settings.template.json` to `settings.local.json` and modify for your project
3. **Add to gitignore**: Ensure sensitive files are excluded (see Security section)
4. **Set up custom commands**: Choose your approach for project-specific commands (see Custom Commands section)
5. **Start using commands**: Try `/claude-start` to begin a development session

## 📁 Directory Structure & Usage

```
.claude/
├── commands/                 # Public slash commands (shared via git)
│   ├── claude-start.md      # Standard development commands
│   ├── claude-save.md       # Safe to share across projects
│   └── deploy-*.md          # Generic deployment commands
├── agents/                   # Specialized agent configurations
├── branch-context/           # Session context per git branch (gitignored)
├── archived-contexts/        # Completed session contexts (gitignored)
├── security-scans/           # Automated security scan reports (gitignored)
├── violations/               # Instruction compliance tracking (gitignored)
├── archived-commands/        # Retired/deprecated commands
├── settings.template.json    # Template configuration file (safe to share)
├── settings.local.json       # Your local settings (gitignored - create from template)
└── root-directory-map.md     # Project structure documentation
```

### 📂 Directory Usage Guide

#### `/commands/` - **Public Slash Commands**
- **Purpose**: Standard commands shared across all users of your project
- **Git Status**: ✅ **Tracked** - Safe to commit and share
- **Contents**: Generic commands like `/claude-start`, `/claude-save`, `/deploy-project`
- **Usage**: Commands that work for any developer on your team

#### `/branch-context/` - **Session Context Files**
- **Purpose**: Stores resume instructions created by `/claude-save` commands
- **Git Status**: ❌ **Gitignored** - Contains session-specific paths and state
- **Contents**: Files like `main-context.md`, `feature-api-integration-context.md`
- **Usage**: Automatic - used by save/start commands for session handoffs

#### `/archived-contexts/` - **Completed Sessions**
- **Purpose**: Archive of completed work contexts for historical reference
- **Git Status**: ❌ **Gitignored** - May contain sensitive development paths
- **Contents**: Completed context files moved from `/branch-context/`
- **Usage**: Reference old sessions, learn from past implementations

#### `/security-scans/` - **Security Reports**
- **Purpose**: Automated security scan results and violation tracking
- **Git Status**: ❌ **Gitignored** - May contain sensitive security findings
- **Contents**: Scan reports, credential alerts, security scores
- **Usage**: Automatic - monitors for security issues during development

## 🎯 Custom Command Management

**Problem**: You need project-specific commands (like `/deploy-main-site` with your specific URLs) but don't want to pollute the public template repository.

### 🔧 Current Solution: Symlink System

We've implemented a symlink-based approach to manage private commands:

#### **Setup Process:**

1. **Use the automated command:**
   ```bash
   /create-local-command deploy-main-site
   ```

2. **Or manually create directory and files:**
   ```bash
   mkdir .claude-local/commands/
   echo "# My Private Deploy Command" > .claude-local/commands/deploy-main-site.md
   cd .claude/commands/
   ln -s ../../.claude-local/commands/deploy-main-site.md deploy-main-site.md
   ```

3. **Edit your command file:**
   ```bash
   # Customize the template in .claude-local/commands/deploy-main-site.md
   ```

4. **Test the command:**
   ```bash
   /deploy-main-site
   ```

#### **How It Works:**
- ✅ **Claude Code finds commands** via symlinks in `.claude/commands/`
- ✅ **Private commands stay private** in `.claude-local/` (gitignored)
- ✅ **Public template stays clean** - no project-specific details
- ✅ **Easy to add new commands** - automated with `/create-local-command`

#### **Adding New Private Commands:**
```bash
# 1. Use the automated command (recommended)
/create-local-command my-command

# 2. Or manually:
echo "# My Command" > .claude-local/commands/my-command.md
cd .claude/commands/
ln -s ../../.claude-local/commands/my-command.md my-command.md
echo ".claude/commands/my-command.md" >> .gitignore

# 3. Test
/my-command
```

### 🤝 Alternative: Contribute Back to Template

**If your command could benefit others:**

1. **Generalize your command** - Remove project-specific details
2. **Add placeholder values** - Use `[PROJECT-NAME]`, `[URL]`, etc.
3. **Create pull request** to this template repository
4. **Benefits**: Shared maintenance, community improvements

**Example of generalizing:**
```markdown
# Before (private)
curl -X POST "https://my-specific-app.com/api/deploy"

# After (public template)
curl -X POST "https://[YOUR-DOMAIN]/api/deploy"
```

### 💡 **We Need Better Solutions!**

**Current symlink approach works but could be improved. We're looking for suggestions:**

#### **Potential Issues with Current Approach:**
- ❓ **Symlink complexity** - Not everyone is comfortable with symlinks
- ❓ **Windows compatibility** - Symlinks behave differently on Windows
- ❓ **Manual gitignore management** - Easy to forget to exclude symlinked files
- ❓ **Discovery** - Hard to find what private commands exist

#### **Ideas for Better Solutions:**
- 🤔 **Configuration-based** - Settings file that points to private command directories?
- 🤔 **Naming convention** - Special prefixes that auto-exclude from git?
- 🤔 **Directory inclusion** - Claude Code searches multiple directories automatically?
- 🤔 **Environment variables** - Point to external command directories?

#### **📣 Request for Input:**
**If you have ideas for a better approach, please:**
1. **Open an issue** in this repository
2. **Describe your solution** - How would it work?
3. **Consider edge cases** - Windows, team sharing, security
4. **Propose implementation** - Changes needed to Claude Code?

**Current approach works but we want to make custom command management even easier!**

## ⚙️ Configuration

### Initial Setup

1. **Create local settings**:
   ```bash
   cp .claude/settings.template.json .claude/settings.local.json
   ```

2. **Customize permissions** in `settings.local.json`:
   - Update file paths to match your project structure
   - Add project-specific bash commands
   - Configure read permissions for your directories
   - Remove any JWT tokens or sensitive examples

3. **Update commands** to match your workflow:
   - Modify paths in command files
   - Adjust project names and structure references
   - Customize deployment and testing commands

### Security Configuration

**Critical**: Add to your `.gitignore`:
```gitignore
# Claude Code - Exclude sensitive session data
.claude/settings.local.json
.claude/branch-context/
.claude/security-scans/
.claude/violations/
.claude/archived-contexts/

# Private project-specific commands (if using symlink approach)
.claude-local/
.claude/commands/deploy-main-site.md
# Add other private command symlinks here as needed
```

**Include in git** (these are safe templates):
```
.claude/commands/               # Public commands only (exclude private symlinks)
.claude/agents/
.claude/archived-commands/
.claude/settings.template.json
.claude/README.md
.claude/root-directory-map.md
```

**⚠️ Important**: If using custom commands via symlinks, remember to add each symlinked file to `.gitignore` to prevent accidentally committing project-specific details.

## 🛠️ Available Commands

### Development Workflow
- `/claude-start` - Begin new development session
- `/claude-save` - Save current session context
- `/claude-resume` - Resume previous session
- `/create-branch` - Create feature branch from requirements
- `/claude-commit` - Commit changes with AI assistance

### Local Command Management
- `/create-local-command [name]` - Create new local command with automatic symlink setup

### Deployment & Testing
- `/deploy-requestdesk` - Deploy main application
- `/debug-deployment` - Debug deployment issues
- `/debug-production` - Production environment debugging

### Maintenance
- `/claude-clean` - Clean up session files
- `/security-start` - Begin security scan session
- `/security-close` - Complete security scan and report

## 🎯 Command Examples

### Create a new feature branch:
```bash
/create-branch my-project todo/user-authentication.md
```

### Create a local command:
```bash
/create-local-command deploy-production
```

### Start a development session:
```bash
/claude-start
```

### Deploy with debugging:
```bash
/deploy-requestdesk
/debug-deployment
```

## 🔒 Security Features

### Automated Security Scanning
- End-of-session security scans
- Credential detection and alerting
- Security score tracking over time
- Violation logging and learning

### Best Practices
- Templates exclude sensitive information
- Context files auto-sanitize paths
- Permission-based command execution
- Audit trail for all activities

## 📚 Context Management

### Branch Context
- Automatic context switching per git branch
- Session continuity across interruptions
- Progress tracking and task management
- Technical decision documentation

### Archive System
- Completed contexts moved to archive
- Historical reference preservation
- Learning from past implementations
- Knowledge base for teams

## 🔧 Customization

### Adding New Commands

**For Public Commands** (safe to share):
1. Create `.md` file in `/commands/` directory
2. Follow existing command format and structure
3. Include usage examples and documentation
4. Test command functionality thoroughly
5. Use placeholder values for project-specific details

**For Private Commands** (project-specific):
- Use the **Symlink System** described in "Custom Command Management" section above
- Or contribute generalized versions back to the template

### Project-Specific Agents
1. Add agent configurations to `/agents/` directory
2. Define agent capabilities and tools
3. Configure for your specific workflow needs
4. Document agent usage and examples

### Custom Security Rules
1. Modify security scanning patterns
2. Add project-specific sensitive patterns
3. Configure violation tracking rules
4. Customize security reporting format

## 📖 Documentation

Each directory contains its own README with:
- Purpose and usage explanation
- File format specifications
- Privacy and security considerations
- Examples and best practices

## 🤝 Contributing

When contributing improvements:
1. **Maintain privacy-first approach** - Keep project-specific details out of public templates
2. **Test all command modifications** - Ensure they work across different environments
3. **Update documentation accordingly** - Including this README and command documentation
4. **Ensure security compliance** - No credentials, URLs, or sensitive paths in templates
5. **Generalize custom commands** - Use placeholders like `[PROJECT-NAME]` instead of specific values

### Contributing Custom Commands Back

**If your private command could benefit others:**
1. **Remove project-specific details** - URLs, paths, credentials, etc.
2. **Add clear placeholders** - `[YOUR-DOMAIN]`, `[PROJECT-NAME]`, `[API-KEY]`
3. **Add usage documentation** - Explain what needs to be customized
4. **Test with placeholders** - Ensure the template command works when values are substituted
5. **Create pull request** - Include description of what the command does

## ⚠️ Important Notes

- **Never commit `settings.local.json`** - contains sensitive permissions
- **Never commit private commands** - use symlink system or gitignore properly
- **Review context files** before sharing - may contain private information
- **Sanitize examples** when contributing back to template
- **Test commands** in safe environment before production use
- **Remember to gitignore symlinked private commands** - easy to accidentally commit project details

## 📝 License

This template is provided as-is for development workflow improvement. Customize freely for your projects while maintaining security best practices.

---

## 📋 Summary

This template provides:
- ✅ **Standard slash commands** for development workflow
- ✅ **Custom command management** via symlink system
- ✅ **Session context management** with automatic save/resume
- ✅ **Security scanning** and violation tracking
- ✅ **Privacy-first approach** - sensitive data stays local
- ✅ **Team collaboration** - safe templates, private customizations

**Need help improving the custom command system?** We're actively looking for better solutions - see the "We Need Better Solutions!" section above.

---

**Template created by**: Community contribution
**Last updated**: 2025-11-01
**Version**: 1.1.0 - Added custom command management system