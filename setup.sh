#!/bin/bash

# Claude Code Configuration Setup Script
# This script helps set up the Claude Code template in your project

set -e

echo "🚀 Setting up Claude Code Configuration Template..."

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo -e "${RED}❌ Error: This must be run in a git repository${NC}"
    exit 1
fi

# Get project root
PROJECT_ROOT=$(git rev-parse --show-toplevel)
CLAUDE_DIR="$PROJECT_ROOT/.claude"

echo "📁 Project root: $PROJECT_ROOT"

# Create settings.local.json from template
if [ ! -f "$CLAUDE_DIR/settings.local.json" ]; then
    echo "⚙️ Creating settings.local.json from template..."
    cp "$CLAUDE_DIR/settings.template.json" "$CLAUDE_DIR/settings.local.json"
    echo -e "${GREEN}✅ Created settings.local.json${NC}"
else
    echo -e "${YELLOW}⚠️ settings.local.json already exists, skipping...${NC}"
fi

# Add gitignore entries if not present
GITIGNORE_FILE="$PROJECT_ROOT/.gitignore"
CLAUDE_GITIGNORE_ENTRIES=".claude/settings.local.json
.claude/branch-context/
.claude/security-scans/
.claude/violations/
.claude/archived-contexts/"

echo "📝 Checking .gitignore configuration..."

if [ ! -f "$GITIGNORE_FILE" ]; then
    echo "🆕 Creating .gitignore file..."
    touch "$GITIGNORE_FILE"
fi

# Check if Claude entries are already in gitignore
if ! grep -q ".claude/settings.local.json" "$GITIGNORE_FILE"; then
    echo "➕ Adding Claude Code entries to .gitignore..."
    echo "" >> "$GITIGNORE_FILE"
    echo "# Claude Code Configuration - Sensitive files" >> "$GITIGNORE_FILE"
    echo "$CLAUDE_GITIGNORE_ENTRIES" >> "$GITIGNORE_FILE"
    echo -e "${GREEN}✅ Updated .gitignore${NC}"
else
    echo -e "${YELLOW}⚠️ Claude Code entries already in .gitignore${NC}"
fi

# Create required directories if they don't exist
REQUIRED_DIRS=(
    "$CLAUDE_DIR/branch-context"
    "$CLAUDE_DIR/security-scans"
    "$CLAUDE_DIR/violations"
    "$CLAUDE_DIR/archived-contexts"
)

for dir in "${REQUIRED_DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}✅ Created directory: $(basename "$dir")${NC}"
    fi
done

# Customize settings.local.json with project-specific paths
echo "🔧 Customizing settings for your project..."

# Replace generic paths with actual project path
sed -i.bak "s|/path/to/project|$PROJECT_ROOT|g" "$CLAUDE_DIR/settings.local.json"
sed -i.bak "s|/Users/username/scripts|$(dirname "$PROJECT_ROOT")|g" "$CLAUDE_DIR/settings.local.json"

# Remove backup file
rm -f "$CLAUDE_DIR/settings.local.json.bak"

echo -e "${GREEN}✅ Updated paths in settings.local.json${NC}"

# Final instructions
echo ""
echo "🎉 Claude Code Template Setup Complete!"
echo ""
echo "📋 Next Steps:"
echo "1. Review and customize $CLAUDE_DIR/settings.local.json"
echo "2. Remove any sensitive example tokens from settings"
echo "3. Test a command: Try typing '/claude-start' in Claude Code"
echo "4. Read $CLAUDE_DIR/README.md for detailed usage instructions"
echo ""
echo -e "${YELLOW}⚠️ Important Security Notes:${NC}"
echo "- Never commit settings.local.json to git"
echo "- Review context files before sharing - they may contain sensitive info"
echo "- The .gitignore has been configured to protect sensitive files"
echo ""
echo -e "${GREEN}✅ Happy coding with Claude!${NC}"