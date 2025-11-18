Plan Feature - Interactive Discovery & Requirements Wizard

**USAGE:**
- `/plan-feature` - Launch interactive feature planning wizard with guided discovery

**🎯 PURPOSE:**
Interactive feature planning wizard that discovers existing CB architecture, gathers comprehensive requirements, and generates pre-filled planning documents ready for implementation.

**🧙‍♂️ FULLY GUIDED WIZARD WORKFLOW:**

This command provides a comprehensive 10-15 question guided discovery session that automatically:
- ✅ Discovers existing CB technology and components
- ✅ Gathers detailed requirements and acceptance criteria
- ✅ Maps architecture impact across CB layers
- ✅ Generates pre-filled planning documents (not templates)
- ✅ Creates todo structure ready for `/create-branch` implementation

**Phase 1: Launch Interactive Planning Wizard**

**CRITICAL**: This is a FULLY INTERACTIVE command. Ask ALL questions step by step, wait for user answers, and build comprehensive requirements before creating any files.

**Discovery Question Framework (10-15 Questions):**

### 🎯 **STEP 1: FEATURE BASICS** (Questions 1-3)

**Question 1:** "What is the name of the feature you want to plan?"
- Capture: Feature name for file/branch naming
- Validate: Ensure name is clear and specific
- Examples: "user notification system", "payment dashboard", "inventory sync"

**Question 2:** "Describe the feature in 1-2 sentences. What problem does it solve for users?"
- Capture: Feature description and user problem
- Use for: Planning document introduction and context
- Examples: "Allow users to receive real-time notifications about order status. Solves the problem of users not knowing when their orders are processed."

**Question 3:** "Who are the primary users of this feature?"
- Options to choose from:
  - End customers/clients
  - Internal content writers
  - Company administrators
  - System/API consumers
  - Multiple user types
- Capture: Target user types for requirements scoping

### 🔍 **STEP 2: EXISTING TECHNOLOGY DISCOVERY** (Questions 4-7)

**CRITICAL**: Before asking these questions, AUTOMATICALLY search the codebase for existing components:

**Auto-Discovery Search Commands:**
```bash
# Search for existing models and schemas
grep -r "class.*Model" backend/app/models/ --include="*.py" | head -10

# Find existing API endpoints
grep -r "@router\." backend/app/routers/ --include="*.py" | head -10

# Identify existing services
find backend/app/services/ -name "*.py" -exec basename {} .py \; | head -10

# Discover frontend components
find frontend/src/components/ -name "*.tsx" | head -10

# Look for existing integrations
grep -r "import.*requests\|import.*httpx\|import.*aiohttp" backend/ --include="*.py" | head -5
```

**Question 4:** "Based on our codebase analysis, here are existing models we found: [LIST DISCOVERED MODELS]. Do any of these relate to your feature?"
- Show discovered Pydantic models from backend/app/models/
- Ask user to identify related/reusable models
- Capture: Models that need extension vs new models needed

**Question 5:** "Here are existing API endpoints: [LIST DISCOVERED ENDPOINTS]. Will this feature extend any existing APIs or need completely new ones?"
- Show discovered router endpoints from backend/app/routers/
- Ask about API integration vs new endpoint creation
- Capture: API integration strategy

**Question 6:** "We found these existing services: [LIST DISCOVERED SERVICES]. Can any of these be leveraged or will you need new service logic?"
- Show discovered services from backend/app/services/
- Identify business logic reuse opportunities
- Capture: Service layer integration plan

**Question 7:** "Available frontend components include: [LIST DISCOVERED COMPONENTS]. Which components might be reused or extended for this feature?"
- Show discovered React components
- Identify UI pattern reuse opportunities
- Capture: Frontend architecture approach

### 📋 **STEP 3: DETAILED REQUIREMENTS** (Questions 8-10)

**Question 8:** "What are the core functional requirements? (List 3-5 specific things the feature must do)"
- Guide user to specific, testable requirements
- Examples: "Send email notification when order status changes", "Display notification history in user dashboard"
- Capture: Detailed functional requirements for planning documents

**Question 9:** "Are there any non-functional requirements (performance, security, scalability, integration constraints)?"
- Ask about performance needs, security considerations, external integrations
- Examples: "Must handle 1000+ notifications per minute", "Integrate with existing email service"
- Capture: Technical constraints and requirements

**Question 10:** "What external systems or third-party services will this feature integrate with?"
- Ask about APIs, webhooks, external services
- Examples: "SendGrid for email", "Stripe webhooks", "External inventory API"
- Capture: Integration requirements and dependencies

### 🏗️ **STEP 4: ARCHITECTURE PLANNING** (Questions 11-13)

**Question 11:** "Based on CB's technical flow (Frontend → DataLayer → Router → Service → Model → Collection), which layers will this feature impact?"
- Present CB layer checklist for user to select
- Frontend (React components, UI state)
- DataLayer (API calls, data providers)
- Router (FastAPI endpoints)
- Service (Business logic)
- Model (Data structures, validation)
- Collection (Database operations)
- Capture: Architecture impact mapping

**Question 12:** "Will this feature require database changes (new collections, schema updates, migrations)?"
- Ask about data storage needs
- New collections vs extending existing
- Migration requirements
- Capture: Database impact assessment

**Question 13:** "How should this feature handle errors and edge cases?"
- Ask about error handling strategy
- User-facing error messages
- Logging and monitoring needs
- Capture: Error handling approach

### ✅ **STEP 5: ACCEPTANCE CRITERIA & COMPLETION** (Questions 14-15)

**Question 14:** "Define 3-5 specific, measurable acceptance criteria. How will you know this feature is complete and working correctly?"
- Guide user to create specific, testable criteria
- Format: "Given [condition], When [action], Then [expected result]"
- Examples: "Given a user has notifications enabled, When their order status changes, Then they receive an email within 5 minutes"
- Capture: Detailed acceptance criteria for planning documents

**Question 15:** "What's the estimated complexity and scope of this feature?"
- Options:
  - Simple (1-2 files, existing patterns, minimal risk)
  - Moderate (3-5 files, some new patterns, moderate complexity)
  - Complex (6+ files, new architecture, high complexity, external integrations)
- Capture: Complexity assessment for planning

### 📊 **STEP 6: SMART ANALYSIS & RECOMMENDATIONS**

After gathering all answers, provide intelligent analysis:

**Architecture Recommendations:**
- "Based on your requirements and existing codebase, I recommend:"
- Suggest specific models to extend vs create new
- Recommend API patterns based on existing endpoints
- Suggest frontend component reuse strategies
- Identify potential integration challenges

**Risk Assessment:**
- Identify potential technical risks based on requirements
- Flag complex integrations or new patterns
- Suggest mitigation strategies

**Implementation Approach:**
- Recommend development phases based on complexity
- Suggest testing strategies
- Identify dependencies and blockers

## **Phase 2: Todo Structure Creation with Pre-filled Documents**

**CRITICAL**: After completing all discovery questions, create todo structure with REAL CONTENT (not templates):

### **Step 1: Determine Feature Category and Name**
- Convert feature name to branch-safe format (kebab-case)
- Determine category (most features will be `feature/`)
- Create branch name: `feature/[kebab-case-name]`

### **Step 2: Create Todo Directory Structure**
- Create folder: `/todo/current/feature/[feature-name]/`
- If `/todo/current/` doesn't exist, create entire path
- Use standardized 7-file structure

### **Step 3: Generate Pre-filled Planning Documents**

**Create 7 files with REAL CONTENT based on discovery answers:**

#### **README.md** (Pre-filled with actual feature info)
```markdown
# [Feature Name from Q1] - TODO Task (PLANNING PHASE)

**Branch:** [Not created yet - planning phase]
**Status:** PLANNING COMPLETE - Ready for Implementation
**Created:** [current-date]
**Category:** feature

**IMPORTANT**: When ready to implement, run `/create-branch todo/current/feature/[feature-name]/README.md`
which will create the actual git branch and update this README with the real branch name.

## 📚 **REQUIRED READING FOR CLAUDE**
**Before working on this task, READ THESE GUIDELINES:**
- `../../../todo-workflow-guidelines.md` - Session management and workflow rules
- `../../../technical-implementation-guidelines.md` - CB development standards and templates

**Critical reminder**: If you don't know what todo you're working on, ASK IMMEDIATELY.

## 🎯 **FEATURE OVERVIEW**
[Feature description from Q2]

**Target Users:** [User types from Q3]

**Problem Solved:** [User problem from Q2]

## ✅ **PLANNING COMPLETION STATUS**
- [x] Requirements gathered through interactive discovery wizard
- [x] Existing technology analyzed and mapped
- [x] Architecture impact identified across CB layers
- [x] Acceptance criteria defined and validated
- [x] Risk assessment completed
- [x] Ready for implementation branch creation

## 📁 **FILES IN THIS TODO**
- [x] README.md - This file (feature overview and status)
- [x] [feature-name]-plan.md - Complete requirements, architecture, and implementation plan
- [x] progress.log - Planning session completed, ready for implementation tracking
- [x] debug.log - Structured debug template for implementation phase
- [x] notes.md - Discovery insights and architectural decisions
- [x] architecture-map.md - CB layer impact mapping with existing component analysis
- [x] user-documentation.md - Documentation plan based on target users

## 🚀 **NEXT STEPS**
1. Review all generated planning documents
2. Validate acceptance criteria and requirements
3. When approved: /create-branch todo/current/feature/[feature-name]/README.md
4. Begin implementation following the detailed plan
```

#### **[feature-name]-plan.md** (Complete requirements document)
```markdown
# [Feature Name] - Complete Implementation Plan

## 📋 **REQUIREMENTS ANALYSIS**

### **User Problem & Solution**
**Problem:** [From Q2]
**Solution:** [Feature description from Q2]
**Target Users:** [From Q3]

### **Functional Requirements** (From Q8)
[List each requirement from Q8 as detailed bullet points]

### **Non-Functional Requirements** (From Q9)
[List each requirement from Q9 with specific criteria]

### **External Integrations** (From Q10)
[List each integration with implementation notes]

## 🏗️ **ARCHITECTURE ANALYSIS**

### **CB Layer Impact Assessment** (From Q11)
[List each impacted layer with specific changes needed]

### **Existing Component Reuse Strategy**
**Models to Extend/Reuse:** [From Q4 analysis]
**API Endpoints to Extend:** [From Q5 analysis]
**Services to Leverage:** [From Q6 analysis]
**Frontend Components to Reuse:** [From Q7 analysis]

### **Database Impact** (From Q12)
[Detailed database changes, migrations, new collections needed]

### **Error Handling Strategy** (From Q13)
[Specific error handling approach and implementation]

## ✅ **ACCEPTANCE CRITERIA** (From Q14)
**CRITICAL: Every todo MUST have acceptance criteria**
[Convert each criterion from Q14 into checkbox format]
- [ ] [Specific measurable outcome 1]
- [ ] [Specific measurable outcome 2]
- [ ] [Specific measurable outcome 3]

## 📊 **COMPLEXITY ASSESSMENT** (From Q15)
**Estimated Complexity:** [Simple/Moderate/Complex from Q15]
**Scope:** [Based on requirements analysis]
**Risk Level:** [Based on integrations and new components needed]

## 🔧 **IMPLEMENTATION PLAN**

### **Phase 1: Foundation Setup**
[Based on architecture analysis, create specific implementation phases]

### **Phase 2: Core Development**
[Specific development steps based on requirements]

### **Phase 3: Integration & Testing**
[Testing strategy based on complexity and integrations]

## 🧪 **TESTING STRATEGY**
**Test locally before deployment:**
- [ ] Unit tests for new components
- [ ] Integration tests for API endpoints
- [ ] Manual testing of user workflows
- [ ] Error handling verification
- [ ] External integration testing

## 🚨 **RISKS & MITIGATION**
[Based on discovery analysis, list specific risks and mitigations]

## ✅ **COMPLETION CHECKLIST**
- [ ] All acceptance criteria verified
- [ ] Code reviewed and tested
- [ ] Documentation updated
- [ ] External integrations tested
- [ ] User approval received
- [ ] Ready for deployment
```

#### **architecture-map.md** (Pre-filled with discovered components)
```markdown
# [Feature Name] - CB Architecture Flow Map

## 🏗️ **CB TECHNICAL LAYERS ANALYSIS**

### **Frontend Layer**
**Existing Components to Reuse:**
[List components discovered in Q7 with reuse strategy]

**New Components Needed:**
[Based on requirements, list new components needed]

### **DataLayer**
**Existing API Integrations:**
[List existing API calls that can be leveraged]

**New API Integration Needed:**
[Based on Q5 analysis and new requirements]

### **Router Layer (FastAPI)**
**Existing Endpoints to Extend:**
[List endpoints from Q5 discovery that will be extended]

**New Endpoints Required:**
[Based on functional requirements from Q8]

### **Service Layer**
**Existing Services to Leverage:**
[List services from Q6 discovery with integration notes]

**New Business Logic Required:**
[Based on requirements analysis]

### **Model Layer**
**Existing Models to Extend:**
[List models from Q4 discovery with extension strategy]

**New Data Models Required:**
[Based on requirements and database impact from Q12]

### **Collection Layer (Database)**
**Database Changes Required:**
[Detailed database impact from Q12]

**Migration Strategy:**
[Based on complexity assessment]

## 🔄 **DATA FLOW MAPPING**
```
[Specific data flow for this feature based on requirements]
User Action → [Specific Component] → [Specific API Call] → [Specific Endpoint] → [Specific Service] → [Specific Model] → [Database Operation]
```

## 🧩 **INTEGRATION POINTS**
**External Services:** [From Q10]
**Internal Dependencies:** [Based on existing component analysis]
**API Contracts:** [Based on requirements]

## 📝 **IMPLEMENTATION NOTES**
[Key architectural decisions and technical considerations from discovery]
```

#### **progress.log** (Planning session completed)
```
##############################################################################
# FEATURE PLANNING PROGRESS LOG - [FEATURE-NAME]
##############################################################################
[current-timestamp] - Interactive planning wizard initiated
[current-timestamp] - Feature basics gathered (Q1-Q3): [feature-name]
[current-timestamp] - Existing technology discovery completed (Q4-Q7)
[current-timestamp] - Requirements analysis finished (Q8-Q10)
[current-timestamp] - Architecture planning completed (Q11-Q13)
[current-timestamp] - Acceptance criteria defined (Q14)
[current-timestamp] - Complexity assessment finished (Q15)
[current-timestamp] - Pre-filled planning documents generated
[current-timestamp] - PLANNING PHASE COMPLETE - Ready for implementation

# IMPLEMENTATION PHASE TRACKING (Future):
# [timestamp] - [Development activity] - [Result/Progress]
##############################################################################
```

#### **notes.md** (Discovery insights)
```markdown
# [Feature Name] - Discovery Insights & Decisions

## 🔍 **PLANNING DISCOVERY INSIGHTS**

### **Existing Technology Analysis**
**Models Available for Reuse:** [Key findings from Q4]
**API Patterns Identified:** [Key findings from Q5]
**Service Patterns Available:** [Key findings from Q6]
**Frontend Patterns Available:** [Key findings from Q7]

### **Architecture Decisions**
[Key architectural decisions made during planning with rationale]

### **Integration Strategy**
**External Integrations:** [From Q10 with implementation notes]
**Internal Dependencies:** [Based on existing component analysis]

### **Risk Assessment Results**
[Specific risks identified and mitigation strategies]

## 💡 **IMPLEMENTATION GUIDANCE**
[Specific guidance for implementation phase based on discovery]

## 🚧 **POTENTIAL BLOCKERS IDENTIFIED**
[Blockers identified during planning with proposed solutions]
```

#### **user-documentation.md** (Documentation plan)
```markdown
# [Feature Name] - Documentation Plan

## 📚 **PUBLIC DOCUMENTATION REQUIREMENTS**

### **End User Guide** (Based on target users: [from Q3])
**Feature Overview:**
[User-facing description based on Q1-Q2]

**User Workflows:**
[Based on functional requirements from Q8]

### **API Documentation** (If applicable)
**Endpoints to Document:**
[Based on API requirements from Q5 and Q8]

## 🔒 **INTERNAL DOCUMENTATION REQUIREMENTS**

### **Developer Implementation Guide**
**Architecture Overview:** [Based on CB layer analysis]
**Integration Points:** [Based on Q10 external integrations]
**Configuration Requirements:** [Based on non-functional requirements Q9]

### **Troubleshooting Guide**
**Error Scenarios:** [Based on error handling strategy Q13]
**Common Issues:** [Based on risk assessment]

## 📋 **DOCUMENTATION COMPLETION CHECKLIST**
- [ ] User guide written for [target users from Q3]
- [ ] API documentation updated
- [ ] Installation/setup instructions provided
- [ ] Integration examples included
- [ ] Internal troubleshooting guide complete
- [ ] Error handling documented
```

#### **debug.log** (Ready for implementation debugging)
```
##############################################################################
# DEBUG LOG - [FEATURE-NAME]
##############################################################################
# INSTRUCTIONS FOR USE:
# - Use /debug-attempt [try-number] command to add structured entries
# - Each debug attempt = one attempt number
# - Format: Attempt #X | Date Time | What tested | Result | What was tried/learned
##############################################################################
# SUMMARY OF ATTEMPTS:
# (Debug attempts will be added here by /debug-attempt command during implementation)
##############################################################################
# PLANNING PHASE COMPLETED:
[current-timestamp] - Planning phase complete - No debugging needed yet
[current-timestamp] - Ready for implementation debugging if issues arise
##############################################################################
```

### **Step 4: Planning Complete Summary**

After creating all files, provide comprehensive summary:

```
🎉 **FEATURE PLANNING COMPLETE!**

📁 **Planning Structure Created:** /todo/current/feature/[feature-name]/
📝 **Structure:** Standard 7-File (Complete Planning Documents)
✅ **Files Created:** 7 files with real content (not templates)

📊 **Discovery Summary:**
- ✅ Feature analyzed: [feature name and description]
- ✅ Existing tech mapped: [X models, Y endpoints, Z services discovered]
- ✅ Requirements gathered: [X functional, Y non-functional requirements]
- ✅ Architecture planned: [CB layers impacted]
- ✅ Acceptance criteria defined: [X specific criteria]
- ✅ Complexity assessed: [Simple/Moderate/Complex]

📚 **Next Steps:**
1. Review generated planning documents in todo folder
2. Validate requirements and acceptance criteria
3. When ready to implement: /create-branch todo/current/feature/[feature-name]/README.md
4. Begin implementation following detailed plan

🔍 **Integration Ready:**
- ✅ /claude-save will validate: "✅ Complete (7/7 files)"
- ✅ /create-branch can create implementation branch from planning
- ✅ All planning documents pre-filled with real requirements
- ✅ Architecture mapping completed for CB layers

🎯 **Planning Quality:**
- Requirements gathered through 15-question discovery wizard
- Existing technology automatically discovered and mapped
- Architecture impact analyzed across all CB layers
- Risk assessment and mitigation strategies included
- Implementation-ready with specific, measurable acceptance criteria

**Ready for implementation! 🚀**
```

## 🎯 **COMMAND SUMMARY**

**What /plan-feature does:**
1. **Interactive Discovery**: 15 guided questions covering feature basics, existing tech, requirements, architecture, and acceptance criteria
2. **Automatic Analysis**: Searches codebase for existing components and integration opportunities
3. **Smart Recommendations**: Provides architecture guidance and risk assessment based on discovery
4. **Pre-filled Documents**: Creates 7-file todo structure with real content (not templates)
5. **Implementation Ready**: Seamlessly integrates with `/create-branch` for development transition

**Integration with CB Workflow:**
- Works with CB memory system for cross-project pattern discovery
- Integrates with `/create-branch` for smooth transition to implementation
- Validates with `/claude-save` completeness checks
- Follows CB technical guidelines and architecture patterns

**Expected Time Savings:**
- Reduces planning from 30+ minutes to 10-15 minutes
- Eliminates template filling and manual research
- Provides comprehensive requirements gathering
- Creates immediately actionable planning documents