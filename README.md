# Claude Code Configuration Template

This repository provides a comprehensive template for setting up Claude Code configuration directories with slash commands, security scanning, and session management.

## 🚀 Quick Start

1. **Copy this entire `.claude` directory** to the root of your project
2. **Customize settings**: Copy `settings.template.json` to `settings.local.json` and modify for your project
3. **Add to gitignore**: Ensure sensitive files are excluded (see Security section)
4. **Start using commands**: Try `/claude-start` to begin a development session

## 📁 Directory Structure

```
.claude/
├── commands/                 # Custom slash commands
├── agents/                   # Specialized agent configurations
├── branch-context/           # Session context per git branch
├── archived-contexts/        # Completed session contexts
├── security-scans/           # Automated security scan reports
├── violations/               # Instruction compliance tracking
├── archived-commands/        # Retired/deprecated commands
├── settings.template.json    # Template configuration file
├── settings.local.json       # Your local settings (create from template)
└── root-directory-map.md     # Project structure documentation
```

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
```

**Include in git** (these are safe templates):
```
.claude/commands/
.claude/agents/
.claude/archived-commands/
.claude/settings.template.json
.claude/README.md
```

## 🛠️ Available Commands

### Development Workflow
- `/claude-start` - Begin new development session
- `/claude-save` - Save current session context
- `/claude-resume` - Resume previous session
- `/create-branch` - Create feature branch from requirements
- `/claude-commit` - Commit changes with AI assistance

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
1. Create `.md` file in `/commands/` directory
2. Follow existing command format and structure
3. Include usage examples and documentation
4. Test command functionality thoroughly

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
1. Maintain privacy-first approach
2. Test all command modifications
3. Update documentation accordingly
4. Ensure security compliance

## ⚠️ Important Notes

- **Never commit `settings.local.json`** - contains sensitive permissions
- **Review context files** before sharing - may contain private information
- **Sanitize examples** when contributing back to template
- **Test commands** in safe environment before production use

## 📝 License

This template is provided as-is for development workflow improvement. Customize freely for your projects while maintaining security best practices.

---

**Template created by**: Community contribution
**Last updated**: 2025-10-28
**Version**: 1.0.0