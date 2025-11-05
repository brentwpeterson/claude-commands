#!/bin/bash

# CB Memory System Test Script
# Run this to verify the OpenMemory system is working correctly

set -e  # Exit on error

echo "🧪 CB Memory System Test"
echo "========================="

# Test 1: Server Health Check
echo ""
echo "1️⃣ Testing server status..."
if curl -s http://localhost:8080/health > /dev/null; then
    echo "✅ Server is responding"
    curl -s http://localhost:8080/health | jq '.'
else
    echo "❌ Server not responding on http://localhost:8080"
    echo "💡 Start with: cd /Users/brent/scripts/OpenMemory/backend && npm run dev"
    exit 1
fi

# Change to memory system directory
cd "$(dirname "$0")"
echo ""
echo "📂 Working directory: $(pwd)"

# Test 2: Store a test memory
echo ""
echo "2️⃣ Storing test memory..."
TEST_CONTENT="Claude test memory created at $(date) - System verification"
TEST_TAGS='["test", "claude-session", "verification", "automated-test"]'

if ./scripts/store-memory.sh "$TEST_CONTENT" "$TEST_TAGS"; then
    echo "✅ Test memory stored successfully"
else
    echo "❌ Failed to store test memory"
    exit 1
fi

# Test 3: Query for the test memory
echo ""
echo "3️⃣ Searching for test memory..."
echo "Query: 'Claude test memory verification'"
if ./scripts/query-memory.sh "Claude test memory verification" 3; then
    echo "✅ Query completed successfully"
else
    echo "❌ Query failed"
    exit 1
fi

# Test 4: List recent memories
echo ""
echo "4️⃣ Listing recent memories..."
if ./scripts/list-memories.sh 5; then
    echo "✅ Memory listing completed"
else
    echo "❌ Failed to list memories"
    exit 1
fi

# Test 5: Cross-project search
echo ""
echo "5️⃣ Testing cross-project search..."
echo "Query: 'project:cb-workspace'"
if ./scripts/query-memory.sh "project:cb-workspace" 3; then
    echo "✅ Cross-project search completed"
else
    echo "❌ Cross-project search failed"
    exit 1
fi

echo ""
echo "🎉 All tests passed!"
echo "========================="
echo "✅ OpenMemory system is working correctly"
echo "✅ Server responding on http://localhost:8080"
echo "✅ Memory storage working"
echo "✅ Semantic search working"
echo "✅ Memory listing working"
echo "✅ Cross-project queries working"
echo ""
echo "💡 You can now use the memory system in your Claude sessions!"
echo "📖 See CLAUDE.md for usage instructions"