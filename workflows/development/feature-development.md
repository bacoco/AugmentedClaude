# Feature Development Workflow

## Overview
Complete end-to-end workflow for developing new features, from requirements to production deployment.

## Specialists Involved
- **Primary**: @specialists/cognitive/architect.md, @specialists/technical/frontend-dev.md, @specialists/technical/backend-dev.md
- **Supporting**: @specialists/domain/product-manager.md, @specialists/technical/qa-tester.md, @specialists/technical/security.md

## Phase 1: Requirements & Analysis
**Duration**: 1-2 days
**Lead Specialist**: @specialists/domain/product-manager.md

### Tasks
1. **Requirements Gathering**
   - Execute: @commands/specialized/research.md --user-needs --business-requirements
   - Pattern: @patterns/development/requirements-gathering.md#user-stories
   - Output: Requirements document with acceptance criteria

2. **Technical Feasibility Analysis**  
   - Specialist: @specialists/cognitive/architect.md
   - Execute: @commands/core/analyze.md --technical-feasibility --architecture-impact
   - Pattern: @patterns/architectural/impact-analysis.md
   - Memory: @memory/context/technical-stack.md

### Deliverables
- [ ] User stories with acceptance criteria
- [ ] Technical feasibility assessment
- [ ] Architecture impact analysis
- [ ] Effort estimation

## Phase 2: Design & Architecture
**Duration**: 2-3 days  
**Lead Specialist**: @specialists/cognitive/architect.md

### Tasks
1. **System Design**
   - Execute: @commands/core/design.md --feature-architecture --api-design
   - Pattern: @patterns/architectural/microservices.md#feature-boundaries
   - Tools: @shared/mcp-integration/sequential.md#architectural-reasoning

2. **UI/UX Design**
   - Specialist: @specialists/domain/ux-designer.md
   - Execute: @commands/specialized/design.md --user-flows --wireframes
   - Pattern: @patterns/development/ux-patterns.md#user-centered-design
   - Tools: @shared/mcp-integration/magic.md#prototype-generation

### Deliverables
- [ ] Feature architecture document
- [ ] API specification
- [ ] UI/UX designs and prototypes
- [ ] Database schema changes

## Phase 3: Implementation
**Duration**: 5-8 days
**Lead Specialists**: @specialists/technical/backend-dev.md, @specialists/technical/frontend-dev.md

### Backend Implementation
1. **API Development**
   - Execute: @commands/core/build.md --api --database --business-logic
   - Pattern: @patterns/development/api-patterns.md#rest-design
   - Tools: @shared/mcp-integration/sequential.md#step-by-step-implementation

2. **Database Changes**
   - Execute: @commands/core/build.md --database --migrations --validation
   - Pattern: @patterns/architectural/data-patterns.md#schema-evolution

### Frontend Implementation  
1. **Component Development**
   - Specialist: @specialists/technical/frontend-dev.md
   - Execute: @commands/core/build.md --components --state-management
   - Pattern: @patterns/development/frontend-patterns.md#component-architecture
   - Tools: @shared/mcp-integration/magic.md#component-generation

2. **Integration**
   - Execute: @commands/core/build.md --api-integration --error-handling
   - Pattern: @patterns/development/frontend-patterns.md#api-integration

### Deliverables
- [ ] Backend API implementation
- [ ] Database schema updates
- [ ] Frontend components and pages
- [ ] Unit tests (80%+ coverage)

## Phase 4: Quality Assurance
**Duration**: 2-3 days
**Lead Specialist**: @specialists/technical/qa-tester.md

### Testing Activities
1. **Automated Testing**
   - Execute: @commands/core/test.md --integration --e2e --performance
   - Pattern: @patterns/development/testing-patterns.md#test-pyramid
   - Tools: @shared/mcp-integration/puppeteer.md#automated-testing

2. **Security Review**
   - Specialist: @specialists/technical/security.md
   - Execute: @commands/specialized/secure.md --code-review --vulnerability-scan
   - Pattern: @patterns/development/security-patterns.md#secure-coding

### Deliverables
- [ ] Integration test suite
- [ ] E2E test scenarios
- [ ] Security assessment report
- [ ] Performance benchmarks

## Phase 5: Code Review & Refinement
**Duration**: 1-2 days
**Lead Specialist**: @specialists/cognitive/architect.md

### Review Activities
1. **Technical Review**
   - Execute: @commands/core/review.md --architecture --code-quality --performance
   - Pattern: @patterns/development/code-review.md#comprehensive-review
   - Collaborate: @collaborate:[
       specialists/cognitive/architect.md,
       specialists/technical/security.md,
       specialists/technical/qa-tester.md
     ]

### Deliverables
- [ ] Code review feedback addressed
- [ ] Architecture compliance verified
- [ ] Performance requirements met
- [ ] Security requirements satisfied

## Phase 6: Deployment
**Duration**: 1 day
**Lead Specialist**: @specialists/technical/devops.md

### Deployment Activities
1. **Staging Deployment**
   - Execute: @commands/core/deploy.md --staging --smoke-tests
   - Pattern: @patterns/operational/deployment-patterns.md#blue-green

2. **Production Deployment**
   - Execute: @commands/core/deploy.md --production --monitoring --rollback-ready
   - Pattern: @patterns/operational/deployment-patterns.md#zero-downtime
   - Memory: @memory/sessions/current-session.md#deployment-log

### Deliverables
- [ ] Successful staging deployment
- [ ] Production deployment completed
- [ ] Monitoring and alerts configured
- [ ] Rollback plan validated

## Success Criteria
- [ ] All acceptance criteria met
- [ ] Performance requirements satisfied
- [ ] Security requirements compliant
- [ ] Test coverage >= 80%
- [ ] Zero critical bugs in production
- [ ] User feedback positive (>4.0/5.0)

## Emergency Escalation
- **Production Issues**: @workflows/operations/incident-response.md --severity=high
- **Security Concerns**: @specialists/technical/security.md --emergency
- **Architecture Problems**: @specialists/cognitive/architect.md --urgent-review

## Memory & Learning
- Document lessons learned: @memory/knowledge/lessons-learned.md#feature-development
- Update patterns: @patterns/development/feature-patterns.md
- Archive decisions: @memory/context/architectural-decisions.md
