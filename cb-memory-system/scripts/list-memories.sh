#!/bin/bash
# List memories from OpenMemory CB-Workspace

# Load API configuration
source "$(dirname "$0")/../config/api-config.sh"

# Usage information
usage() {
    cat << EOF
Usage: $0 [limit] [sector]

List recent memories from CB-Workspace OpenMemory system.

Arguments:
    limit       Number of memories to show (optional, default: 10)
    sector      Filter by memory sector (optional)

Examples:
    # Show 10 most recent memories
    $0

    # Show 20 most recent memories
    $0 20

    # Show procedural memories (how-to, processes)
    $0 15 procedural

    # Show semantic memories (knowledge, facts)
    $0 10 semantic

Sectors:
    episodic    - Session-based memories, specific events
    semantic    - Knowledge and facts, architecture decisions
    procedural  - How-to guides, processes, solutions
    emotional   - Preferences, confidence levels
    reflective  - Lessons learned, retrospectives

Display includes:
    • Memory ID and content preview
    • Tags and metadata
    • Sector classification
    • Salience (importance) and last access
    • Creation/update timestamps
EOF
}

# Check arguments
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Check server
if ! check_server; then
    exit 1
fi

# Parse arguments
limit="${1:-10}"
sector="$2"

# Validate sector if provided
if [[ -n "$sector" ]]; then
    valid_sectors=("episodic" "semantic" "procedural" "emotional" "reflective")
    if [[ ! " ${valid_sectors[*]} " =~ " $sector " ]]; then
        echo "❌ Invalid sector: $sector"
        echo "📋 Valid sectors: ${valid_sectors[*]}"
        exit 1
    fi
fi

# Build URL with parameters
url="$OM_ENDPOINT_LIST?l=$limit"
[[ -n "$sector" ]] && url="$url&sector=$sector"

echo "📋 Listing CB-Workspace memories..."
echo "📊 Limit: $limit"
[[ -n "$sector" ]] && echo "🧩 Sector: $sector"
echo ""

# List memories
response=$(curl -s "${OM_HEADERS[@]}" "$url")

# Parse and display results
if echo "$response" | jq -e '.items' > /dev/null 2>&1; then
    count=$(echo "$response" | jq '.items | length')
    echo "✅ Found $count memories"
    echo ""

    if [[ "$count" -gt 0 ]]; then
        echo "$response" | jq -r '.items[] |
            "🆔 ID: \(.id)",
            "📄 Content: \(.content)",
            "🏷️  Tags: \(.tags | join(", "))",
            (if .metadata and (.metadata | keys | length > 0) then "📊 Metadata: \(.metadata | tostring)" else empty end),
            "🧩 Sector: \(.primary_sector)",
            "⭐ Salience: \(.salience)",
            "📅 Created: \(.created_at | tonumber | strftime("%Y-%m-%d %H:%M"))",
            "👁️  Last seen: \(.last_seen_at | tonumber | strftime("%Y-%m-%d %H:%M"))",
            "═══════════════════════════════════════════════════════════════"'
    else
        echo "💡 No memories found"
        echo ""
        if [[ -n "$sector" ]]; then
            echo "Suggestions:"
            echo "  • Try without sector filter: $0 $limit"
            echo "  • Check other sectors: episodic, semantic, procedural, emotional, reflective"
        else
            echo "This might be a new installation. Try storing some memories first:"
            echo "  ./store-memory.sh \"Your first CB-Workspace memory\""
        fi
    fi
else
    echo "❌ Failed to list memories"
    echo "$response" | format_response
    exit 1
fi

echo ""
echo "💡 Tips:"
echo "   • Search memories: ./query-memory.sh \"search terms\""
echo "   • Store new memory: ./store-memory.sh \"content\" '[\"tags\"]'"
echo "   • View specific memory: curl \"$OM_ENDPOINT_GET/MEMORY_ID\" -H \"Authorization: Bearer $OM_API_KEY\""