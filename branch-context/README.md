# Branch Context Directory

This directory contains context files that Claude saves between sessions for different Git branches.

## Purpose
- Maintains session continuity when switching between branches
- Stores progress, plans, and important context for ongoing work
- Allows resuming complex tasks after session breaks

## Structure
Each file follows the naming pattern: `{branch-name}-context.md`

Examples:
- `main-context.md` - Context for main branch work
- `feature-user-auth-context.md` - Context for feature branch
- `fix-login-bug-context.md` - Context for bug fix branch

## Content Format
Context files typically include:
- Session accomplishments and progress
- Current task status and next steps
- Technical implementation details
- Branch-specific notes and decisions
- Working directory and file locations

## Auto-Generated
These files are automatically created and updated by Claude during development sessions. You generally don't need to manually edit them.

## Privacy Note
When using this template publicly, ensure branch context files don't contain:
- Sensitive API keys or tokens
- Private server URLs or credentials
- Confidential business information
- Personal file paths or usernames