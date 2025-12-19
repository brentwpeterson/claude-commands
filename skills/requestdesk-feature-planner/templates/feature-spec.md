# Feature Specification Template

Use this template when generating specs for Claude Code to implement.

---

# Feature: [Feature Name]

## Overview
[2-3 sentence description of the feature and its purpose]

## User Story
As a [role], I want to [action], so that [benefit].

## Target Users
- [ ] Superadmin
- [ ] Company Admin
- [ ] Content Manager
- [ ] Content Writer
- [ ] Client

---

## Requirements

### Functional Requirements
- [ ] FR1: [Requirement description]
- [ ] FR2: [Requirement description]
- [ ] FR3: [Requirement description]

### Non-Functional Requirements
- [ ] NFR1: Performance - [specify]
- [ ] NFR2: Security - [specify]
- [ ] NFR3: Usability - [specify]

---

## Acceptance Criteria

**CRITICAL: All criteria must be verified before completion**

- [ ] AC1: [Given/When/Then format]
- [ ] AC2: [Given/When/Then format]
- [ ] AC3: [Given/When/Then format]
- [ ] AC4: [Given/When/Then format]
- [ ] AC5: [Given/When/Then format]

---

## Technical Implementation

### Backend Changes

#### New/Modified Endpoints
| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/api/resource` | List resources |
| POST | `/api/resource` | Create resource |
| PUT | `/api/resource/{id}` | Update resource |
| DELETE | `/api/resource/{id}` | Delete resource |

#### Service Layer
- **New Service**: `backend/app/services/[service_name].py`
- **Methods needed**:
  - `list_for_user(user, filters)`
  - `create(data, user)`
  - `update(id, data, user)`
  - `delete(id, user)`

#### Models
```python
class ResourceCreate(BaseModel):
    name: str
    description: Optional[str]
    # Add fields

class ResourceResponse(BaseModel):
    id: str
    name: str
    description: Optional[str]
    created_at: datetime
    # Add fields
```

### Frontend Changes

#### New Components
- `frontend/src/components/[feature]/[Component].tsx`
- Use Tailwind CSS + Catalyst UI (NO MUI)

#### Pages/Routes
- Add route in `App.tsx` or React Admin resources
- URL pattern: `/[resource]`, `/[resource]/{id}`

#### API Integration
- Use relative URLs: `/api/[resource]`
- Handle loading and error states

### Database Changes

#### 🚨 CRITICAL: USE MIGRATIONS FOR ALL DATA CHANGES 🚨

**NEVER directly modify the database. ALL changes go through migrations.**

This has caused 5+ hour debugging sessions when:
- Data was added directly to local MongoDB
- Production failed because data didn't exist
- Nobody documented what was added

**If this feature needs initial data, seed data, or configuration:**
1. Create a migration file in `backend/app/migrations/versions/`
2. Migration runs on ALL environments automatically
3. Document what data is being added

#### New Collection (if needed)
```javascript
{
  _id: ObjectId,
  company_id: String,      // REQUIRED for multi-tenant
  created_by: String,
  created_at: Date,
  updated_at: Date,
  // Feature-specific fields
}
```

#### Indexes
```javascript
db.[collection].createIndex({ "company_id": 1 })
// Add other indexes as needed
```

#### Models Required (BEFORE creating collection)
- [ ] **Create model file**: `backend/app/models/{feature_name}.py`
- [ ] **Define schemas**: `{Feature}Create`, `{Feature}Update`, `{Feature}Response`
- [ ] **Include company_id**: Required for multi-tenant isolation
- [ ] **Add timestamps**: `created_at`, `updated_at` in response model

#### Migration Required
- [ ] **Migration file created**: `backend/app/migrations/versions/v{VERSION}_{description}.py`
- [ ] **Migration tested locally**: `docker exec cbtextapp-backend-1 python -m app.migrations.migration_manager --run`
- [ ] **Migration documented**: Clear description of what data is added/modified
- [ ] **No direct DB inserts**: All data changes in migration file only

---

## Files to Modify

### Backend
| File | Changes |
|------|---------|
| `backend/app/routers/[router].py` | Add endpoints |
| `backend/app/services/[service].py` | Add business logic |
| `backend/app/models/[model].py` | Add Pydantic models |
| `backend/app/main.py` | Register new router (if new) |

### Frontend
| File | Changes |
|------|---------|
| `frontend/src/components/[feature]/` | New components |
| `frontend/src/App.tsx` | Add routes/resources |
| `frontend/src/dataProvider/index.ts` | Custom data handling (if needed) |

---

## Testing Strategy

### Manual Testing
1. [ ] Test as superadmin
2. [ ] Test as company_admin
3. [ ] Test as content_manager
4. [ ] Test as content_writer
5. [ ] Test as client
6. [ ] Verify company isolation
7. [ ] Test error handling

### Edge Cases
- [ ] Empty data
- [ ] Invalid input
- [ ] Unauthorized access
- [ ] Missing required fields
- [ ] Duplicate entries

### Test Credentials
```
Admin: username=admin, password=Test1234!
Manager: username=brent, password=Test12345!
Writer: username=content_writer, password=Test1234!
Client: username=client, password=Test1234!
Cucumber: username=cucumber, password=test1234
```

---

## Dependencies

### Existing Features Used
- [ ] User authentication
- [ ] Company isolation
- [ ] [Other features]

### New Dependencies
- [ ] None / [List any new packages]

---

## Deployment Notes

- [ ] Database migration required
- [ ] Environment variables needed
- [ ] Breaking changes: [Yes/No]
- [ ] Backwards compatible: [Yes/No]

---

## UI Mockup (if applicable)

```
┌─────────────────────────────────────┐
│  [Page Title]                       │
├─────────────────────────────────────┤
│                                     │
│  [Describe layout]                  │
│                                     │
│  ┌──────────┐  ┌──────────┐        │
│  │ Button 1 │  │ Button 2 │        │
│  └──────────┘  └──────────┘        │
│                                     │
└─────────────────────────────────────┘
```

---

## Handoff Checklist

Before passing to Claude Code:
- [ ] All requirements clear and specific
- [ ] Acceptance criteria are testable
- [ ] Files to modify are identified
- [ ] No ambiguous decisions remaining
- [ ] User has approved the spec
