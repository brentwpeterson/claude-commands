Create Local Command - Automated Local Command Setup

**USAGE:** `/create-local-command [command-name]` - Create a new local command with automatic symlink setup

**🎯 PURPOSE:**
Automate creation of project-specific commands in `.claude-local/` with proper symlink integration

**📋 COMMAND WORKFLOW:**

**Step 1: Validate Command Name**
1. **Check name format:**
   - Must be lowercase with hyphens (e.g., "deploy-my-app")
   - No spaces, special characters, or uppercase
   - Must not be empty

2. **Block conflicts with existing public commands:**
   - Check if command exists in `.claude/commands/` as actual file (not symlink)
   - If conflict found: **ERROR and STOP** - "Command '[name]' conflicts with existing public command. Choose a different name."
   - **DO NOT ALLOW overriding public commands**

**Step 2: Check for Existing Files**
3. **Check if local command file exists:**
   - Path: `.claude-local/commands/[command-name].md`
   - If exists: **ASK USER** - "Local command '[name]' already exists. Overwrite? [y/N]"
   - If user says 'N' or anything other than 'y': STOP

4. **Check if symlink exists:**
   - Path: `.claude/commands/[command-name].md`
   - If exists: **ASK USER** - "Symlink '[name]' already exists. Replace? [y/N]"
   - If user says 'N' or anything other than 'y': STOP

**Step 3: Auto-Create Directory Structure**
5. **Create directories if needed:**
   - Auto-create: `.claude-local/commands/` (if doesn't exist)
   - Auto-create: `.claude/commands/` (if doesn't exist - fix broken setup)

**Step 4: Create Command Template**
6. **Create local command file:**
   - Path: `.claude-local/commands/[command-name].md`
   - Use template below:

```markdown
# [Command Name] - Local Command

**USAGE:** `/[command-name] [parameters]` - [Brief description of what this command does]

**🎯 PURPOSE:**
[Detailed description of the command's purpose and when to use it]

**📋 WORKFLOW:**

**Step 1: [First Step]**
1. **[Action description]:**
   - [Command or instruction]
   - [Expected result]

**Step 2: [Second Step]**
2. **[Action description]:**
   - [Command or instruction]
   - [Expected result]

**🔧 CUSTOMIZATION NOTES:**
- Replace [PROJECT-NAME] with your actual project name
- Update [YOUR-DOMAIN] with your domain
- Modify paths to match your project structure

**⚠️ SECURITY:**
- This is a LOCAL command - contains project-specific details
- Never commit this file to public repositories
- Keep sensitive information in environment variables
```

**Step 5: Create Symlink**
7. **Create symlink for Claude Code:**
   - Create: `.claude/commands/[command-name].md` → `../../.claude-local/commands/[command-name].md`
   - Use relative path for portability

**Step 6: Update Gitignore**
8. **Auto-add gitignore entries:**
   - Add `.claude-local/` to .gitignore (if not already there)
   - Add `.claude/commands/[command-name].md` to .gitignore
   - Create .gitignore if it doesn't exist

**Step 7: Success Output**
9. **Display success information:**
   ```
   ✅ Local command created successfully!

   📁 Command file: .claude-local/commands/[command-name].md
   🔗 Symlink created: .claude/commands/[command-name].md
   📝 Edit the command file to customize your workflow

   🧪 Test your command:
   /[command-name]

   ⚠️ Remember to edit the template and add your specific instructions!
   ```

**🚨 CRITICAL ERROR HANDLING:**
- **File exists**: ASK user before overwriting
- **Symlink exists**: ASK user before replacing
- **Name conflicts**: BLOCK and error - never allow conflicts with public commands
- **Directory missing**: AUTO-CREATE - fix broken setups automatically

**🎯 EXAMPLES:**
```bash
/create-local-command deploy-production
/create-local-command backup-database
/create-local-command sync-staging
```

**✅ RESULT:**
User gets a ready-to-use local command that:
- Works immediately with Claude Code
- Stays private (properly gitignored)
- Has clear template to customize
- Includes project-specific instructions