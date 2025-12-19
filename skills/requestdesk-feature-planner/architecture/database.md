# Database Architecture (MongoDB 8)

## Connection

- **Local**: `mongodb://localhost:27017/requestdesk_prod`
- **Production**: MongoDB Atlas via AWS Secrets Manager
- **Driver**: PyMongo (synchronous)

## Core Collections

### users
```javascript
{
  _id: ObjectId,
  username: String,           // Unique login identifier
  email: String,              // Unique email
  hashed_password: String,
  role: String,               // superadmin, company_admin, content_manager, content_writer, client
  company_id: String,         // Primary company (ObjectId as string)
  is_active: Boolean,
  is_superuser: Boolean,
  created_at: Date,
  updated_at: Date,
  // Optional fields
  first_name: String,
  last_name: String,
  plugin_keys: Object,        // { typingmind: "key", ... }
  guest_companies: [String],  // Additional company access
}
```

### companies
```javascript
{
  _id: ObjectId,
  name: String,
  domain: String,
  settings: Object,
  created_at: Date,
  updated_at: Date,
  owner_id: String,           // User who owns this company
}
```

### agents
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  company_id: String,
  created_by: String,
  system_prompt: String,
  model: String,              // gpt-4o, claude-3-5-sonnet, etc.
  // Integrations
  shopify_enabled: Boolean,
  shopify_store_url: String,
  shopify_api_key: String,
  wordpress_enabled: Boolean,
  wordpress_site_url: String,
  wordpress_api_key: String,
  // Knowledge base
  knowledge_collection_ids: [String],
  // Settings
  temperature: Number,
  max_tokens: Number,
  created_at: Date,
  updated_at: Date,
}
```

### tickets
```javascript
{
  _id: ObjectId,
  title: String,
  description: String,
  status: String,             // open, in_progress, review, completed, closed
  priority: String,           // low, medium, high, urgent
  company_id: String,
  created_by: String,
  assigned_to: String,        // Writer assigned
  agent_id: String,           // Optional: AI agent for this ticket
  due_date: Date,
  tags: [String],
  created_at: Date,
  updated_at: Date,
}
```

### campaigns
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  company_id: String,
  created_by: String,
  status: String,             // draft, active, paused, completed
  start_date: Date,
  end_date: Date,
  agent_id: String,
  settings: Object,
  created_at: Date,
  updated_at: Date,
}
```

### knowledge_base_collections
```javascript
{
  _id: ObjectId,
  name: String,
  description: String,
  company_id: String,
  user_id: String,
  agent_id: String,           // Optional: linked agent
  source_type: String,        // manual, shopify, wordpress, upload
  settings: Object,
  created_at: Date,
  updated_at: Date,
}
```

### knowledge_chunks
```javascript
{
  _id: ObjectId,
  collection_id: String,
  company_id: String,
  content: String,            // The actual text content
  embedding: [Number],        // 1536-dimension vector (OpenAI)
  metadata: Object,           // Source-specific metadata
  source_type: String,        // shopify, wordpress, manual, upload
  source_id: String,          // Original item ID
  created_at: Date,
  updated_at: Date,
}
```

### sync_history
```javascript
{
  _id: ObjectId,
  agent_id: String,
  company_id: String,
  sync_type: String,          // products, collections, blog_articles, wordpress
  status: String,             // pending, in_progress, completed, failed
  items_synced: Number,
  error_message: String,
  started_at: Date,
  completed_at: Date,
}
```

### llm_providers
```javascript
{
  _id: ObjectId,
  company_id: String,
  provider: String,           // openai, anthropic, google
  api_key: String,            // Encrypted
  models: [String],           // Available models
  is_active: Boolean,
  created_at: Date,
}
```

## Query Patterns

### Always Filter by Company
```python
# REQUIRED for multi-tenant isolation
query = {"company_id": user.get("company_id")}
results = collection.find(query)
```

### Pagination
```python
skip = (page - 1) * per_page
cursor = collection.find(query).skip(skip).limit(per_page)
total = collection.count_documents(query)
```

### Text Search
```python
# Requires text index on collection
collection.find({"$text": {"$search": search_term}})
```

### Vector Search (RAG)
```python
# MongoDB Atlas Vector Search
pipeline = [
    {
        "$vectorSearch": {
            "index": "vector_index",
            "path": "embedding",
            "queryVector": query_embedding,
            "numCandidates": 100,
            "limit": 10
        }
    }
]
```

## Indexes

### Required Indexes
```javascript
// users
db.users.createIndex({ "username": 1 }, { unique: true })
db.users.createIndex({ "email": 1 }, { unique: true })
db.users.createIndex({ "company_id": 1 })

// agents
db.agents.createIndex({ "company_id": 1 })

// tickets
db.tickets.createIndex({ "company_id": 1 })
db.tickets.createIndex({ "assigned_to": 1 })
db.tickets.createIndex({ "status": 1 })

// knowledge_chunks
db.knowledge_chunks.createIndex({ "collection_id": 1 })
db.knowledge_chunks.createIndex({ "company_id": 1 })
// Vector index created in Atlas UI
```

## Migrations

Location: `backend/app/migrations/`

```python
# Migration template
{
    "version": "0.33.8",
    "description": "Add new field to agents",
    "up": lambda db: db.agents.update_many({}, {"$set": {"new_field": None}}),
    "down": lambda db: db.agents.update_many({}, {"$unset": {"new_field": ""}}),
}
```

Run migrations:
```bash
docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run
```

## Key Principles

1. **No Foreign Keys** - MongoDB doesn't enforce; validate in application
2. **Denormalize When Needed** - Embed related data for read performance
3. **String IDs** - Store ObjectIds as strings in reference fields
4. **Company Isolation** - Every document has `company_id`
5. **Soft Deletes** - Use `is_deleted` flag, don't actually delete
