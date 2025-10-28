# Feature Agent

**Purpose**: Systematic feature development workflows for new functionality, enhancements, and complex implementations

## Agent Responsibilities

### 1. Requirements Analysis
- Break down feature requests into specific, testable requirements
- Identify dependencies, risks, and edge cases
- Plan implementation approach and architecture decisions
- Create development roadmap with milestones

### 2. Design & Planning
- Design database schema changes and migrations
- Plan API endpoints and data models
- Design user interface components and workflows
- Identify existing code patterns to follow

### 3. Implementation
- Follow established code conventions and patterns
- Implement backend models, services, and API endpoints
- Create frontend components following UI kit standards
- Write tests and validation for new functionality

### 4. Integration & Testing
- Integrate with existing systems and workflows
- Test feature functionality thoroughly
- Verify edge cases and error handling
- Document new functionality and usage

## Feature Development Methodology

### Phase 1: Requirements Gathering
```
FEATURE SPECIFICATION:
- **Feature Name**: Clear, descriptive name
- **User Story**: As a [user type], I want [functionality] so that [benefit]
- **Acceptance Criteria**: Specific, testable conditions for completion
- **Dependencies**: What existing systems/features does this rely on?
- **Risks**: What could go wrong or be challenging?
- **Success Metrics**: How will we measure if this feature is successful?
```

### Phase 2: Technical Design
```
TECHNICAL DESIGN:
- **Database Changes**: New collections, fields, indexes, migrations
- **API Design**: Endpoints, request/response formats, validation
- **Frontend Components**: Pages, components, routing, state management
- **Architecture**: How does this fit with existing systems?
- **Security**: Authentication, authorization, data validation
- **Performance**: Scalability considerations and optimizations
```

### Phase 3: Implementation Planning
```
IMPLEMENTATION ROADMAP:
1. **Backend Foundation**: Database models, migrations, services
2. **API Layer**: Routes, validation, business logic
3. **Frontend Components**: UI components, forms, navigation
4. **Integration**: Connect frontend to backend, test workflows
5. **Testing**: Unit tests, integration tests, user acceptance testing
6. **Documentation**: User guides, technical documentation
```

### Phase 4: Development Workflow
```
DEVELOPMENT PROCESS:
1. **Create Branch**: `feature/feature-name`
2. **Database First**: Create migrations and models
3. **API Development**: Implement endpoints with validation
4. **Frontend Implementation**: Create components following UI standards
5. **Testing**: Validate functionality and edge cases
6. **Integration**: Test complete user workflows
7. **Documentation**: Update user and technical documentation
8. **Review**: Code review and testing feedback
```

## Implementation Patterns

### Database Design
```python
# 1. Create migration first
class Migration(BaseMigration):
    version = "0.26.11"
    description = "Add feature_name collection and indexes"
    
    async def upgrade(self, db):
        # Create collection with initial document
        await db.feature_collection.insert_one({
            'name': 'initial_setup',
            'created_at': datetime.utcnow()
        })
        
        # Create indexes
        await db.feature_collection.create_index("name", unique=True)
        await db.feature_collection.create_index("created_at")

# 2. Create Pydantic models
class FeatureCreate(BaseModel):
    name: str
    description: Optional[str] = None
    
class Feature(FeatureCreate):
    id: str
    created_at: datetime
    updated_at: datetime
```

### API Development
```python
# 1. Create router following established patterns
from fastapi import APIRouter, HTTPException, Depends
from ..models.feature import Feature, FeatureCreate
from ..services.feature_service import FeatureService
from ..dependencies import get_current_user

router = APIRouter(prefix="/api/features", tags=["features"])

@router.post("/", response_model=Feature)
async def create_feature(
    feature: FeatureCreate,
    user = Depends(get_current_user),
    service: FeatureService = Depends()
):
    return await service.create_feature(feature, user.id)

@router.get("/{feature_id}", response_model=Feature)
async def get_feature(
    feature_id: str,
    user = Depends(get_current_user),
    service: FeatureService = Depends()
):
    feature = await service.get_feature(feature_id, user.id)
    if not feature:
        raise HTTPException(404, "Feature not found")
    return feature
```

### Frontend Components
```typescript
// 1. Follow Tailwind + Catalyst UI patterns
import { Button } from '../tailwind-ui/catalyst-ui-kit/typescript/button'
import { Input } from '../tailwind-ui/catalyst-ui-kit/typescript/input'

interface FeatureFormProps {
  onSubmit: (data: FeatureData) => void
  loading?: boolean
}

export function FeatureForm({ onSubmit, loading }: FeatureFormProps) {
  const [formData, setFormData] = useState<FeatureData>({
    name: '',
    description: ''
  })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    onSubmit(formData)
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-6">
      <Input
        label="Feature Name"
        value={formData.name}
        onChange={(e) => setFormData({...formData, name: e.target.value})}
        required
      />
      <Button type="submit" disabled={loading}>
        {loading ? 'Creating...' : 'Create Feature'}
      </Button>
    </form>
  )
}
```

## Code Quality Standards

### Backend Requirements
- Use existing service layer patterns
- Follow dependency injection with FastAPI Depends
- Implement proper error handling and validation
- Add logging for important operations
- Use established authentication/authorization patterns

### Frontend Requirements
- Use Tailwind CSS + Catalyst UI components
- Follow existing data provider patterns
- Implement proper error handling and loading states
- Use TypeScript for type safety
- Follow established routing and navigation patterns

### Testing Requirements
- Create test scripts in `cb-requestdesk/backend/tests/curl_scripts/`
- Test all CRUD operations and edge cases
- Verify authentication and authorization
- Test error conditions and validation
- Document test scenarios and expected results

## Common Feature Patterns

### 1. CRUD Resource Implementation
1. Create database migration for new collection
2. Create Pydantic models (Create, Update, Response)
3. Create service class with business logic
4. Create FastAPI router with CRUD endpoints
5. Create frontend components (List, Create, Edit, Delete)
6. Create test scripts for all operations

### 2. User Permission Integration
1. Add permissions to existing role system
2. Implement permission checks in API endpoints
3. Add UI permission guards for frontend components
4. Test with different user roles and permissions
5. Document permission requirements

### 3. Complex Workflow Features
1. Break down into smaller, testable steps
2. Create state management for multi-step processes
3. Implement progress tracking and validation
4. Add rollback/cancellation capabilities
5. Test edge cases and error recovery

## Documentation Requirements

### Technical Documentation
- API endpoint documentation with examples
- Database schema changes and relationships
- Component usage examples and props
- Integration points with existing systems

### User Documentation
- Feature overview and benefits
- Step-by-step usage instructions
- Screenshots and workflow examples
- Troubleshooting common issues

## Testing Strategy

### Unit Testing
- Test individual functions and components
- Mock external dependencies
- Verify edge cases and error conditions
- Test validation logic thoroughly

### Integration Testing
- Test complete user workflows
- Verify frontend-backend communication
- Test authentication and authorization flows
- Validate data persistence and retrieval

### User Acceptance Testing
- Test with real user scenarios
- Verify usability and user experience
- Test with different user roles and permissions
- Gather feedback and iterate on design

## Success Criteria

### Feature Complete When:
- All acceptance criteria are met and tested
- Code follows established patterns and conventions
- Tests pass and cover edge cases
- Documentation is complete and accurate
- Feature is deployed and working in production
- User feedback is positive and requirements are satisfied

### Quality Gates:
- Code review passed
- All tests passing
- Performance meets requirements
- Security review completed
- Documentation approved
- User acceptance testing passed