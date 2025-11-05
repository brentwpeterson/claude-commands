#!/bin/bash
# Query memories from OpenMemory CB-Workspace

# Load API configuration
source "$(dirname "$0")/../config/api-config.sh"

# Usage information
usage() {
    cat << EOF
Usage: $0 "query" [k] [project] [sector]

Search memories in CB-Workspace OpenMemory system.

Arguments:
    query       Search query (required)
    k           Number of results (optional, default: 8)
    project     Filter by project (optional)
    sector      Filter by memory sector (optional)

Examples:
    # Basic search
    $0 "Docker deployment issues"

    # Limit results
    $0 "API authentication" 5

    # Filter by project
    $0 "deployment patterns" 10 cb-shopify

    # Filter by sector
    $0 "problem solutions" 5 "" procedural

    # Cross-project patterns
    $0 "AWS configuration" 8

Filters:
    Projects: cb-requestdesk, cb-shopify, cb-wordpress, cb-magento, cb-junogo, astro-sites, jobs
    Sectors: episodic, semantic, procedural, emotional, reflective

Search Tips:
    - Use descriptive terms: "Docker ARM64 deployment"
    - Include project names: "cb-shopify API integration"
    - Search for patterns: "authentication implementation"
    - Find solutions: "fixed CORS issue"
EOF
}

# Check arguments
if [[ $# -lt 1 || "$1" == "-h" || "$1" == "--help" ]]; then
    usage
    exit 0
fi

# Check server
if ! check_server; then
    exit 1
fi

# Parse arguments
query="$1"
k="${2:-8}"
project="$3"
sector="$4"

# Validate project if provided
if [[ -n "$project" ]]; then
    if ! validate_project "$project"; then
        exit 1
    fi
fi

# Validate sector if provided
if [[ -n "$sector" ]]; then
    valid_sectors=("episodic" "semantic" "procedural" "emotional" "reflective")
    if [[ ! " ${valid_sectors[*]} " =~ " $sector " ]]; then
        echo "❌ Invalid sector: $sector"
        echo "📋 Valid sectors: ${valid_sectors[*]}"
        exit 1
    fi
fi

# Build filters
filters="{}"
if [[ -n "$project" || -n "$sector" ]]; then
    filter_parts=()
    [[ -n "$project" ]] && filter_parts+=("\"user_id\": \"$OM_USER_ID\"")
    [[ -n "$sector" ]] && filter_parts+=("\"sector\": \"$sector\"")

    filter_json=$(printf ",%s" "${filter_parts[@]}")
    filter_json="{${filter_json:1}}"
    filters="$filter_json"
fi

# Prepare payload
payload=$(jq -n \
    --arg query "$query" \
    --argjson k "$k" \
    --argjson filters "$filters" \
    '{
        query: $query,
        k: $k,
        filters: $filters
    }')

echo "🔍 Searching CB-Workspace memories..."
echo "📝 Query: \"$query\""
echo "📊 Results: up to $k"
[[ -n "$project" ]] && echo "📁 Project: $project"
[[ -n "$sector" ]] && echo "🧩 Sector: $sector"
echo ""

# Query memories
response=$(curl -s "${OM_HEADERS[@]}" \
    -d "$payload" \
    "$OM_ENDPOINT_QUERY")

# Parse and display results
if echo "$response" | jq -e '.matches' > /dev/null 2>&1; then
    matches=$(echo "$response" | jq '.matches | length')
    echo "✅ Found $matches memories"
    echo ""

    if [[ "$matches" -gt 0 ]]; then
        echo "$response" | jq -r '.matches[] |
            "🆔 ID: \(.id)",
            "📄 Content: \(.content)",
            "🧩 Sector: \(.primary_sector)",
            "⭐ Score: \(.score)",
            "💪 Salience: \(.salience)",
            "📅 Last seen: \(.last_seen_at)",
            "---"'
    else
        echo "💡 Try broader search terms or check different projects/sectors"
        echo ""
        echo "Suggestions:"
        echo "  • Remove project/sector filters"
        echo "  • Use simpler keywords"
        echo "  • Search for patterns: 'deployment', 'API', 'Docker'"
    fi
else
    echo "❌ Search failed"
    echo "$response" | format_response
    exit 1
fi