# Feature Development Workflow

## Overview
Complete end-to-end workflow for developing new features, from requirements to production deployment.

## Specialists Involved
- **Primary**: @claude/agents/cognitive/architect.md, @claude/agents/technical/frontend-dev.md, @claude/agents/technical/backend-dev.md
- **Supporting**: @claude/agents/domain/product-manager.md, @claude/agents/technical/qa-tester.md, @claude/agents/technical/security.md

## Phase 1: Requirements & Analysis
**Duration**: 1-2 days
**Lead Specialist**: @claude/agents/domain/product-manager.md

### Tasks
1. **Requirements Gathering**
   - Execute: @claude/commands/specialized/research.md --user-needs --business-requirements
   - Pattern: @claude/patterns/development/requirements-gathering.md#user-stories
   - Output: Requirements document with acceptance criteria

2. **Technical Feasibility Analysis**  
   - Specialist: @claude/agents/cognitive/architect.md
   - Execute: @claude/commands/core/analyze.md --technical-feasibility --architecture-impact
   - Pattern: @claude/patterns/architectural/impact-analysis.md
   - Memory: @claude/memory/context/technical-stack.md

### Deliverables
- [ ] User stories with acceptance criteria
- [ ] Technical feasibility assessment
- [ ] Architecture impact analysis
- [ ] Effort estimation

## Phase 2: Design & Architecture
**Duration**: 2-3 days  
**Lead Specialist**: @claude/agents/cognitive/architect.md

### Tasks
1. **System Design**
   - Execute: @claude/commands/core/design.md --feature-architecture --api-design
   - Pattern: @claude/patterns/architectural/microservices.md#feature-boundaries
   - Tools: @claude/integrations/sequential.md#architectural-reasoning

2. **UI/UX Design**
   - Specialist: @claude/agents/domain/ux-designer.md
   - Execute: @claude/commands/specialized/design.md --user-flows --wireframes
   - Pattern: @claude/patterns/development/ux-patterns.md#user-centered-design
   - Tools: @claude/integrations/magic.md#prototype-generation

### Deliverables
- [ ] Feature architecture document
- [ ] API specification
- [ ] UI/UX designs and prototypes
- [ ] Database schema changes

## Phase 3: Implementation
**Duration**: 5-8 days
**Lead Specialists**: @claude/agents/technical/backend-dev.md, @claude/agents/technical/frontend-dev.md

### Backend Implementation
1. **API Development**
   - Execute: @claude/commands/core/build.md --api --database --business-logic
   - Pattern: @claude/patterns/development/api-patterns.md#rest-design
   - Tools: @claude/integrations/sequential.md#step-by-step-implementation

2. **Database Changes**
   - Execute: @claude/commands/core/build.md --database --migrations --validation
   - Pattern: @claude/patterns/architectural/data-patterns.md#schema-evolution

### Frontend Implementation  
1. **Component Development**
   - Specialist: @claude/agents/technical/frontend-dev.md
   - Execute: @claude/commands/core/build.md --components --state-management
   - Pattern: @claude/patterns/development/frontend-patterns.md#component-architecture
   - Tools: @claude/integrations/magic.md#component-generation

2. **Integration**
   - Execute: @claude/commands/core/build.md --api-integration --error-handling
   - Pattern: @claude/patterns/development/frontend-patterns.md#api-integration

### Deliverables
- [ ] Backend API implementation
- [ ] Database schema updates
- [ ] Frontend components and pages
- [ ] Unit tests (80%+ coverage)

## Phase 4: Quality Assurance
**Duration**: 2-3 days
**Lead Specialist**: @claude/agents/technical/qa-tester.md

### Testing Activities
1. **Automated Testing**
   - Execute: @claude/commands/core/test.md --integration --e2e --performance
   - Pattern: @claude/patterns/development/testing-patterns.md#test-pyramid
   - Tools: @claude/integrations/puppeteer.md#automated-testing

2. **Security Review**
   - Specialist: @claude/agents/technical/security.md
   - Execute: @claude/commands/specialized/secure.md --code-review --vulnerability-scan
   - Pattern: @claude/patterns/development/security-patterns.md#secure-coding

### Deliverables
- [ ] Integration test suite
- [ ] E2E test scenarios
- [ ] Security assessment report
- [ ] Performance benchmarks

## Phase 5: Code Review & Refinement
**Duration**: 1-2 days
**Lead Specialist**: @claude/agents/cognitive/architect.md

### Review Activities
1. **Technical Review**
   - Execute: @claude/commands/core/review.md --architecture --code-quality --performance
   - Pattern: @claude/patterns/development/code-review.md#comprehensive-review
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
**Lead Specialist**: @claude/agents/technical/devops.md

### Deployment Activities
1. **Staging Deployment**
   - Execute: @claude/commands/core/deploy.md --staging --smoke-tests
   - Pattern: @claude/patterns/operational/deployment-patterns.md#blue-green

2. **Production Deployment**
   - Execute: @claude/commands/core/deploy.md --production --monitoring --rollback-ready
   - Pattern: @claude/patterns/operational/deployment-patterns.md#zero-downtime
   - Memory: @claude/memory/sessions/current-session.md#deployment-log

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
- **Production Issues**: @claude/workflows/operations/incident-response.md --severity=high
- **Security Concerns**: @claude/agents/technical/security.md --emergency
- **Architecture Problems**: @claude/agents/cognitive/architect.md --urgent-review

## Memory & Learning
- Document lessons learned: @claude/memory/knowledge/lessons-learned.md#feature-development
- Update patterns: @claude/patterns/development/feature-patterns.md
- Archive decisions: @claude/memory/context/architectural-decisions.md
