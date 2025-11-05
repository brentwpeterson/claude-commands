# OpenMemory API Reference

Complete API reference for CB-Workspace OpenMemory integration.

## 🔧 Configuration

```bash
API_URL="http://localhost:8080"
API_KEY="fGqS8XZNFZnjzONJu5bOrBH+nCioPsnP3SZvWLbODXw="
USER_ID="cb-workspace"

HEADERS=(
    -H "Content-Type: application/json"
    -H "Authorization: Bearer $API_KEY"
)
```

## 📡 API Endpoints

### Health Check
**GET** `/health`

Check if OpenMemory server is running and get system info.

```bash
curl -s http://localhost:8080/health
```

**Response:**
```json
{
  "ok": true,
  "version": "2.0-hsg-tiered",
  "embedding": {
    "provider": "synthetic",
    "dimensions": 1536,
    "mode": "simple"
  },
  "tier": "smart",
  "expected": {
    "recall": 85,
    "qps": "500-600",
    "ram": "0.9GB/10k"
  }
}
```

### Store Memory
**POST** `/memory/add`

Store a new memory with content, tags, and metadata.

```bash
curl -X POST http://localhost:8080/memory/add \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "content": "Implemented Docker multi-site container for astro-sites",
    "tags": ["project:astro-sites", "docker", "solution"],
    "metadata": {
      "completion_date": "2025-11-04",
      "domains": ["contentbasis.io", "contentbasis.ai"]
    },
    "user_id": "cb-workspace"
  }'
```

**Request Body:**
```typescript
{
  content: string;           // Memory content (required)
  tags?: string[];          // Array of tags (optional)
  metadata?: object;        // Arbitrary metadata (optional)
  user_id?: string;         // User identifier (optional)
}
```

**Response:**
```json
{
  "id": "e8a31ab1-c5ed-442f-ac96-d8b078d52777",
  "primary_sector": "procedural",
  "sectors": ["procedural"],
  "chunks": 1
}
```

### Query Memories
**POST** `/memory/query`

Search memories using semantic similarity.

```bash
curl -X POST http://localhost:8080/memory/query \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "query": "Docker deployment issues",
    "k": 8,
    "filters": {
      "user_id": "cb-workspace",
      "sector": "procedural"
    }
  }'
```

**Request Body:**
```typescript
{
  query: string;            // Search query (required)
  k?: number;              // Max results (default: 8)
  filters?: {
    user_id?: string;      // Filter by user
    sector?: string;       // Filter by sector
    min_score?: number;    // Minimum similarity score
  }
}
```

**Response:**
```json
{
  "query": "Docker deployment issues",
  "matches": [
    {
      "id": "e8a31ab1-c5ed-442f-ac96-d8b078d52777",
      "content": "Implemented Docker multi-site container...",
      "score": 0.987654,
      "sectors": ["procedural"],
      "primary_sector": "procedural",
      "salience": 0.8,
      "last_seen_at": 1762273692938
    }
  ]
}
```

### List Memories
**GET** `/memory/all?l={limit}&sector={sector}`

List recent memories with optional filtering.

```bash
curl -X GET "http://localhost:8080/memory/all?l=10&sector=procedural" \
  -H "Authorization: Bearer $API_KEY"
```

**Query Parameters:**
- `l` (number): Limit number of results (default: 100)
- `u` (number): Offset for pagination (default: 0)
- `sector` (string): Filter by memory sector (optional)

**Response:**
```json
{
  "items": [
    {
      "id": "e8a31ab1-c5ed-442f-ac96-d8b078d52777",
      "content": "Implemented Docker multi-site container...",
      "tags": ["project:astro-sites", "docker", "solution"],
      "metadata": {
        "completion_date": "2025-11-04",
        "domains": ["contentbasis.io", "contentbasis.ai"]
      },
      "created_at": 1762273692938,
      "updated_at": 1762273692938,
      "last_seen_at": 1762273692938,
      "salience": 0.8,
      "decay_lambda": 0.02,
      "primary_sector": "procedural",
      "version": 1
    }
  ]
}
```

### Get Memory by ID
**GET** `/memory/{id}`

Retrieve a specific memory by its ID.

```bash
curl -X GET "http://localhost:8080/memory/e8a31ab1-c5ed-442f-ac96-d8b078d52777" \
  -H "Authorization: Bearer $API_KEY"
```

**Response:**
```json
{
  "id": "e8a31ab1-c5ed-442f-ac96-d8b078d52777",
  "content": "Implemented Docker multi-site container...",
  "primary_sector": "procedural",
  "sectors": ["procedural"],
  "tags": ["project:astro-sites", "docker", "solution"],
  "metadata": {
    "completion_date": "2025-11-04",
    "domains": ["contentbasis.io", "contentbasis.ai"]
  },
  "created_at": 1762273692938,
  "updated_at": 1762273692938,
  "last_seen_at": 1762273692938,
  "salience": 0.8,
  "decay_lambda": 0.02,
  "version": 1
}
```

### Reinforce Memory
**POST** `/memory/reinforce`

Boost the salience (importance) of a memory.

```bash
curl -X POST http://localhost:8080/memory/reinforce \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "id": "e8a31ab1-c5ed-442f-ac96-d8b078d52777",
    "boost": 0.1
  }'
```

**Request Body:**
```typescript
{
  id: string;              // Memory ID (required)
  boost?: number;          // Boost amount 0.01-1.0 (default: 0.1)
}
```

### Update Memory
**PATCH** `/memory/{id}`

Update content, tags, or metadata of existing memory.

```bash
curl -X PATCH "http://localhost:8080/memory/e8a31ab1-c5ed-442f-ac96-d8b078d52777" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d '{
    "tags": ["project:astro-sites", "docker", "solution", "production"],
    "metadata": {
      "completion_date": "2025-11-04",
      "domains": ["contentbasis.io", "contentbasis.ai"],
      "status": "deployed"
    }
  }'
```

### Delete Memory
**DELETE** `/memory/{id}`

Permanently delete a memory.

```bash
curl -X DELETE "http://localhost:8080/memory/e8a31ab1-c5ed-442f-ac96-d8b078d52777" \
  -H "Authorization: Bearer $API_KEY"
```

## 🧠 Memory Sectors

### Automatic Classification
OpenMemory automatically classifies memories into cognitive sectors:

| Sector | Purpose | Common Tags | Examples |
|--------|---------|-------------|----------|
| **episodic** | Session events, stories | `session:*`, `debugging` | "Spent 3 hours debugging CORS" |
| **semantic** | Knowledge, facts | `pattern:*`, `architecture:*` | "JWT tokens expire after 1 hour" |
| **procedural** | How-to, processes | `solution`, `procedure` | "Fix Docker ARM64: add --platform flag" |
| **emotional** | Preferences, confidence | `preference`, `success` | "React hooks work better than classes" |
| **reflective** | Lessons learned | `retrospective`, `improvement` | "Should have tested locally first" |

### Sector Filtering
Filter queries by sector for more targeted results:

```bash
# Find only procedural (how-to) memories
curl -X POST http://localhost:8080/memory/query \
  -d '{"query": "deployment", "filters": {"sector": "procedural"}}'

# List semantic (knowledge) memories
curl -X GET "http://localhost:8080/memory/all?sector=semantic"
```

## 📊 Response Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | Success | Request completed successfully |
| 400 | Bad Request | Invalid request body or parameters |
| 404 | Not Found | Memory not found |
| 500 | Server Error | Internal server error |

## 🔒 Authentication

All API requests require Bearer token authentication:

```bash
Authorization: Bearer fGqS8XZNFZnjzONJu5bOrBH+nCioPsnP3SZvWLbODXw=
```

## 💾 Data Types

### Memory Object
```typescript
interface Memory {
  id: string;                    // Unique identifier
  content: string;               // Memory content
  primary_sector: string;        // Primary classification
  sectors: string[];             // All applicable sectors
  tags: string[];                // User-defined tags
  metadata: object;              // Arbitrary metadata
  created_at: number;            // Creation timestamp
  updated_at: number;            // Last update timestamp
  last_seen_at: number;          // Last access timestamp
  salience: number;              // Importance score (0-1)
  decay_lambda: number;          // Decay rate
  version: number;               // Version number
  user_id?: string;              // User identifier
}
```

### Search Result
```typescript
interface SearchResult {
  id: string;                    // Memory ID
  content: string;               // Memory content
  score: number;                 // Similarity score
  sectors: string[];             // Memory sectors
  primary_sector: string;        // Primary sector
  salience: number;              // Current salience
  last_seen_at: number;          // Last access time
  path?: string;                 // Graph path (advanced)
}
```

## 🔄 Memory Lifecycle

1. **Creation**: Memory stored with initial salience (~0.4)
2. **Access**: Each query/retrieval updates `last_seen_at`
3. **Reinforcement**: Salience increases with access frequency
4. **Decay**: Salience decreases over time based on `decay_lambda`
5. **Deletion**: Manual deletion or automatic pruning

## 🎯 Best Practices

### API Usage
- Always include `user_id` for multi-user isolation
- Use specific queries over broad searches
- Include relevant metadata for future filtering
- Tag consistently for better search results

### Performance
- Limit large queries with `k` parameter
- Use sector filtering for targeted searches
- Cache frequently accessed memory IDs
- Monitor salience scores for important memories

### Data Management
- Regular backups of important memories
- Periodic cleanup of obsolete memories
- Consistent tagging strategy across team
- Document metadata schema for consistency

---

For usage examples and workflow integration, see `usage-guide.md`