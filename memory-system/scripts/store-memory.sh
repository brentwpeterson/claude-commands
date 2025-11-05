#!/bin/bash
# Store a new memory in OpenMemory CB-Workspace

# Load API configuration
source "$(dirname "$0")/../config/api-config.sh"

# Usage information
usage() {
    cat << EOF
Usage: $0 "content" [tags] [metadata]

Store a new memory in CB-Workspace OpenMemory system.

Arguments:
    content     Memory content (required)
    tags        JSON array of tags (optional, default: auto-generated)
    metadata    JSON object metadata (optional)

Examples:
    # Basic memory
    $0 "Fixed Docker ARM64 issue in astro-sites deployment"

    # With tags
    $0 "API authentication pattern for cb-shopify" '["project:cb-shopify", "pattern:api-auth", "solution"]'

    # With tags and metadata
    $0 "Database migration completed" '["project:cb-requestdesk", "database", "migration"]' '{"completion_date": "2025-11-04", "tables_affected": 5}'

    # Session context
    $0 "Worked on multi-site Docker container for contentbasis domains" '["session:2025-11-04", "project:astro-sites", "achievement:docker-nginx"]'

CB Project Tags:
    project:cb-requestdesk, project:cb-shopify, project:cb-wordpress
    project:cb-magento, project:cb-junogo, project:astro-sites, project:jobs

Pattern Tags:
    pattern:deployment, pattern:api-design, pattern:database
    pattern:docker, pattern:aws, pattern:authentication

Session Tags:
    session:YYYY-MM-DD, problem:description, solution, achievement:name
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
content="$1"
tags="${2:-[]}"
metadata="${3:-{}}"

# Auto-generate tags if not provided
if [[ "$tags" == "[]" ]]; then
    current_date=$(date +%Y-%m-%d)
    tags='["session:'$current_date'", "manual-entry"]'
    echo "📝 Auto-generated tags: $tags"
fi

# Validate JSON
if ! echo "$tags" | jq . > /dev/null 2>&1; then
    echo "❌ Invalid tags JSON: $tags"
    exit 1
fi

if ! echo "$metadata" | jq . > /dev/null 2>&1; then
    echo "❌ Invalid metadata JSON: $metadata"
    exit 1
fi

# Prepare payload
payload=$(jq -n \
    --arg content "$content" \
    --argjson tags "$tags" \
    --argjson metadata "$metadata" \
    --arg user_id "$OM_USER_ID" \
    '{
        content: $content,
        tags: $tags,
        metadata: $metadata,
        user_id: $user_id
    }')

echo "🧠 Storing memory in CB-Workspace..."
echo "📄 Content: $content"
echo "🏷️  Tags: $tags"

# Store memory
response=$(curl -s "${OM_HEADERS[@]}" \
    -d "$payload" \
    "$OM_ENDPOINT_ADD")

# Check response
if echo "$response" | jq -e '.id' > /dev/null 2>&1; then
    memory_id=$(echo "$response" | jq -r '.id')
    sector=$(echo "$response" | jq -r '.primary_sector')
    echo "✅ Memory stored successfully!"
    echo "🆔 ID: $memory_id"
    echo "🧩 Sector: $sector"
    echo "$response" | format_response
else
    echo "❌ Failed to store memory"
    echo "$response" | format_response
    exit 1
fi