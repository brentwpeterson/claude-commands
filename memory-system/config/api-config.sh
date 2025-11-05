#!/bin/bash
# CB Memory System - OpenMemory API Configuration
# Source this file in scripts to access API settings

# OpenMemory API Configuration
export OM_API_URL="http://localhost:8080"
export OM_API_KEY="fGqS8XZNFZnjzONJu5bOrBH+nCioPsnP3SZvWLbODXw="
export OM_USER_ID="cb-workspace"

# API Headers
export OM_HEADERS=(
    -H "Content-Type: application/json"
    -H "Authorization: Bearer $OM_API_KEY"
)

# Common API Endpoints
export OM_ENDPOINT_ADD="$OM_API_URL/memory/add"
export OM_ENDPOINT_QUERY="$OM_API_URL/memory/query"
export OM_ENDPOINT_LIST="$OM_API_URL/memory/all"
export OM_ENDPOINT_GET="$OM_API_URL/memory"
export OM_ENDPOINT_HEALTH="$OM_API_URL/health"

# Helper function to check if OpenMemory server is running
check_server() {
    if ! curl -s "$OM_ENDPOINT_HEALTH" > /dev/null 2>&1; then
        echo "❌ OpenMemory server is not running at $OM_API_URL"
        echo "💡 Start server: cd /Users/brent/scripts/OpenMemory/backend && npm run dev"
        return 1
    fi
    return 0
}

# Helper function to format JSON response
format_response() {
    if command -v jq > /dev/null 2>&1; then
        jq .
    else
        cat
    fi
}

# CB Project validation
validate_project() {
    local project="$1"
    local valid_projects=(
        "cb-requestdesk" "cb-shopify" "cb-wordpress"
        "cb-magento" "cb-junogo" "astro-sites" "jobs" "cb-workspace"
    )

    for valid in "${valid_projects[@]}"; do
        if [[ "$project" == "$valid" ]]; then
            return 0
        fi
    done

    echo "⚠️  Unknown project: $project"
    echo "📋 Valid projects: ${valid_projects[*]}"
    return 1
}