# @ Referencing System Guide for Claude Code & MCP

## Overview

This guide demonstrates the powerful @ referencing system that enables intelligent cross-linking between specialists, workflows, and patterns in the optimal MD tree structure for Claude Code and MCP integration.

## Core @ Reference Patterns

### 1. Direct Specialist References
```markdown
# Activate specific specialist
@specialists/cognitive/architect.md

# Reference specific section of specialist
@specialists/technical/frontend-dev.md#react-patterns

# Reference specialist with context
@specialists/technical/security.md#owasp-analysis --context="api-security"
```

### 2. Workflow Chain References  
```markdown
# Sequential workflow execution
@workflows/development/feature-development.md
└── @workflows/development/code-review.md
    └── @workflows/development/deployment.md

# Parallel workflow execution
@workflows/analysis/system-design.md || @workflows/analysis/security-assessment.md

# Conditional workflow execution
@workflows/development/bug-resolution.md --if-error-exists
```

### 3. Smart Pattern References
```markdown
# Pattern inheritance
@patterns/architectural/microservices.md -> @patterns/development/testing-patterns.md

# Contextual pattern selection
@patterns/architectural/* --match="event-driven" --for="real-time-system"

# Pattern composition
@patterns/development/error-handling.md + @patterns/operational/monitoring-patterns.md
```

### 4. Memory Context References
```markdown
# Current session context
@memory/sessions/current-session.md#active-decisions

# Historical context
@memory/knowledge/lessons-learned.md --topic="microservice-migration"

# Dynamic context building
@memory/context/project-overview.md -> @memory/context/technical-stack.md
```

### 5. MCP Tool Integration References
```markdown
# Tool-specific references
@shared/mcp-integration/sequential.md#complex-reasoning
@shared/mcp-integration/magic.md#component-generation
@shared/mcp-integration/puppeteer.md#e2e-testing
@shared/mcp-integration/context7.md#api-documentation

# Tool orchestration
@shared/mcp-integration/sequential.md -> @shared/mcp-integration/context7.md
```

## Advanced @ Reference Patterns

### Conditional References
```markdown
# Availability-based selection
@if-available:specialists/domain/data-scientist.md 
@fallback:specialists/cognitive/analyzer.md

# Capability-based selection  
@if-has-tool:puppeteer -> specialists/technical/qa-tester.md
@else -> specialists/technical/frontend-dev.md#manual-testing
```

### Dynamic References
```markdown
# Context-aware specialist selection
@current-specialist --domain="frontend" --task="optimization"
# Resolves to: @specialists/technical/frontend-dev.md#performance

# File-type based selection
@auto-specialist --file="*.tsx" 
# Resolves to: @specialists/technical/frontend-dev.md

# Error-type based selection
@auto-specialist --error="security"
# Resolves to: @specialists/technical/security.md
```

### Parameterized References
```markdown
# References with parameters
@specialists/cognitive/architect.md --scale="enterprise" --domain="fintech"
@workflows/development/feature-development.md --complexity="high" --timeline="2-weeks"
@patterns/architectural/microservices.md --services=5 --communication="async"
```

### Collaborative References
```markdown
# Multi-specialist collaboration
@collaborate:[
  specialists/cognitive/architect.md,
  specialists/technical/backend-dev.md,
  specialists/domain/product-manager.md
] --mode="consensus" --topic="api-design"

# Sequential collaboration with handoff
@sequence:[
  specialists/cognitive/researcher.md#requirements,
  specialists/cognitive/architect.md#design,
  specialists/technical/backend-dev.md#implementation
]
```

## Practical Implementation Examples

### Example 1: Feature Development with Smart References

```markdown
# Feature Development: User Authentication System

## Phase 1: Research & Analysis
**Specialist**: @specialists/cognitive/researcher.md
**Tools**: @shared/mcp-integration/context7.md#auth-libraries

### Requirements Gathering
- Execute: @commands/specialized/research.md --domain="authentication"
- Pattern: @patterns/development/requirements-gathering.md#security-requirements
- Context: @memory/context/business-context.md#user-management

### Security Analysis
- Specialist: @specialists/technical/security.md
- Execute: @commands/core/analyze.md --security --auth-flows
- Pattern: @patterns/architectural/security-patterns.md#oauth2
- Reference: @shared/mcp-integration/sequential.md#threat-modeling

## Phase 2: System Design
**Primary**: @specialists/cognitive/architect.md --expertise="security-architecture"
**Collaborating**: @specialists/technical/security.md

### Architecture Design
- Execute: @commands/core/design.md --api --auth-service
- Pattern: @patterns/architectural/microservices.md#auth-service
- Tools: @shared/mcp-integration/sequential.md#complex-design
- Memory: @memory/sessions/current-session.md#design-decisions

### API Specification
- Execute: @commands/specialized/design.md --api-spec --auth-endpoints
- Pattern: @patterns/development/api-patterns.md#rest-auth
- Reference: @shared/mcp-integration/context7.md#openapi-spec

## Phase 3: Implementation
**Primary**: @specialists/technical/backend-dev.md --stack="node-express"
**Supporting**: @specialists/technical/frontend-dev.md --stack="react"

### Backend Implementation
- Execute: @commands/core/build.md --api --auth-service
- Pattern: @patterns/development/secure-coding.md#input-validation
- Tools: @shared/mcp-integration/sequential.md#step-by-step-implementation
- Memory: @memory/context/technical-stack.md#nodejs-patterns

### Frontend Integration
- Specialist: @specialists/technical/frontend-dev.md
- Execute: @commands/core/build.md --react --auth-components
- Pattern: @patterns/development/frontend-patterns.md#auth-state
- Tools: @shared/mcp-integration/magic.md#login-components

## Phase 4: Testing & Validation
**Primary**: @specialists/technical/qa-tester.md
**Security Review**: @specialists/technical/security.md

### Automated Testing
- Execute: @commands/core/test.md --integration --auth-flows
- Pattern: @patterns/development/testing-patterns.md#auth-testing
- Tools: @shared/mcp-integration/puppeteer.md#auth-e2e

### Security Testing
- Execute: @commands/specialized/secure.md --penetration-test --auth
- Pattern: @patterns/operational/security-testing.md#owasp
- Reference: @memory/knowledge/security-checklist.md

## Phase 5: Deployment
**Primary**: @specialists/technical/devops.md
**Oversight**: @specialists/orchestration/project-manager.md

### Production Deployment
- Execute: @commands/core/deploy.md --production --auth-service
- Pattern: @patterns/operational/deployment-patterns.md#zero-downtime
- Workflow: @workflows/development/deployment.md#security-service
- Memory: @memory/sessions/current-session.md#deployment-log
```

### Example 2: Bug Resolution with Intelligent References

```markdown
# Bug Resolution: Performance Degradation in User Dashboard

## Issue Context
**Reporter**: Product Team
**Impact**: High - 3s page load time (target: <1s)
**Affected**: User dashboard with data visualization

## Phase 1: Initial Investigation
**Primary Specialist**: @specialists/cognitive/analyzer.md --mode="systematic"
**Tools**: @shared/mcp-integration/puppeteer.md#performance-profiling

### Symptom Analysis
- Execute: @commands/core/troubleshoot.md --performance --frontend
- Pattern: @patterns/development/debugging-patterns.md#performance
- Context: @memory/sessions/current-session.md#issue-symptoms

### Data Gathering
- Execute: @commands/core/analyze.md --profile --user-dashboard
- Tools: @shared/mcp-integration/puppeteer.md#lighthouse-audit
- Reference: @memory/knowledge/performance-baselines.md#dashboard-metrics

## Phase 2: Root Cause Analysis
**Continuing Specialist**: @specialists/cognitive/analyzer.md
**Domain Expert**: @specialists/technical/frontend-dev.md --focus="performance"

### Frontend Analysis
- Execute: @commands/specialized/optimize.md --frontend --analysis
- Pattern: @patterns/development/performance-patterns.md#react-optimization
- Tools: @shared/mcp-integration/sequential.md#multi-step-analysis

### Backend Analysis  
- Specialist: @specialists/technical/backend-dev.md
- Execute: @commands/core/analyze.md --api --response-times
- Pattern: @patterns/architectural/performance-patterns.md#api-optimization
- Context: @memory/context/technical-stack.md#database-patterns

## Phase 3: Solution Implementation
**Frontend Optimization**: @specialists/technical/frontend-dev.md
**Backend Optimization**: @specialists/technical/backend-dev.md
**Coordination**: @specialists/orchestration/project-manager.md

### Frontend Fixes
- Execute: @commands/core/build.md --optimize --dashboard-components
- Pattern: @patterns/development/performance-patterns.md#lazy-loading
- Tools: @shared/mcp-integration/magic.md#optimized-components

### Backend Fixes
- Execute: @commands/core/build.md --optimize --api-endpoints
- Pattern: @patterns/operational/caching-patterns.md#redis-strategy
- Reference: @memory/knowledge/database-optimization.md

## Phase 4: Validation & Monitoring
**Testing**: @specialists/technical/qa-tester.md
**Performance Monitoring**: @specialists/technical/devops.md

### Performance Testing
- Execute: @commands/core/test.md --performance --load-testing
- Pattern: @patterns/development/testing-patterns.md#performance-tests
- Tools: @shared/mcp-integration/puppeteer.md#automated-performance

### Deployment & Monitoring
- Execute: @commands/core/deploy.md --staged --performance-monitoring
- Pattern: @patterns/operational/monitoring-patterns.md#performance-alerts
- Memory: @memory/sessions/current-session.md#resolution-log
```

### Example 3: Security Assessment with Multi-Specialist Collaboration

```markdown
# Security Assessment: E-commerce Platform Audit

## Assessment Scope
**Platform**: Full-stack e-commerce application
**Timeline**: 2 weeks comprehensive assessment
**Compliance**: PCI DSS, GDPR

## Phase 1: Assessment Planning
**Lead**: @specialists/technical/security.md --certification="cissp"
**Support**: @specialists/orchestration/project-manager.md

### Threat Modeling
- Execute: @commands/specialized/secure.md --threat-model --ecommerce
- Pattern: @patterns/architectural/security-patterns.md#threat-modeling
- Tools: @shared/mcp-integration/sequential.md#systematic-analysis
- Framework: @memory/knowledge/security-frameworks.md#stride

### Assessment Strategy
- Execute: @commands/core/analyze.md --security --assessment-plan
- Pattern: @patterns/operational/security-testing.md#comprehensive-audit
- Context: @memory/context/business-context.md#compliance-requirements

## Phase 2: Technical Security Review
**Application Security**: @specialists/technical/security.md
**Infrastructure Security**: @specialists/technical/devops.md --focus="security"
**Code Review**: @specialists/technical/backend-dev.md + @specialists/technical/frontend-dev.md

### Code Security Analysis
- Execute: @commands/core/analyze.md --security --static-analysis
- Pattern: @patterns/development/secure-coding.md#owasp-guidelines
- Tools: @shared/mcp-integration/context7.md#security-libraries
- Collaborate: @collaborate:[
    specialists/technical/security.md,
    specialists/technical/backend-dev.md
  ] --mode="code-review"

### Infrastructure Assessment
- Specialist: @specialists/technical/devops.md
- Execute: @commands/specialized/secure.md --infrastructure --cloud-security
- Pattern: @patterns/operational/security-patterns.md#cloud-hardening
- Reference: @memory/knowledge/infrastructure-security.md#aws-security

### Frontend Security Review
- Specialist: @specialists/technical/frontend-dev.md --security-focus
- Execute: @commands/core/analyze.md --security --client-side
- Pattern: @patterns/development/frontend-security.md#xss-prevention
- Tools: @shared/mcp-integration/puppeteer.md#security-testing

## Phase 3: Penetration Testing
**Lead**: @specialists/technical/security.md --specialty="penetration-testing"
**Coordination**: @specialists/orchestration/project-manager.md

### Automated Security Testing
- Execute: @commands/specialized/secure.md --automated-pentest
- Pattern: @patterns/operational/security-testing.md#automated-scanning
- Tools: @shared/mcp-integration/sequential.md#multi-vector-testing

### Manual Security Testing
- Execute: @commands/specialized/secure.md --manual-pentest --business-logic
- Pattern: @patterns/operational/security-testing.md#manual-techniques
- Context: @memory/context/business-context.md#critical-workflows

## Phase 4: Compliance Verification
**Compliance Lead**: @specialists/technical/security.md --domain="compliance"
**Documentation**: @specialists/domain/tech-writer.md --specialty="compliance"

### PCI DSS Compliance
- Execute: @commands/specialized/secure.md --compliance-check --pci-dss
- Pattern: @patterns/operational/compliance-patterns.md#pci-requirements
- Reference: @memory/knowledge/compliance-frameworks.md#pci-dss-controls

### GDPR Privacy Assessment
- Execute: @commands/core/analyze.md --privacy --data-flows
- Pattern: @patterns/architectural/privacy-patterns.md#gdpr-compliance
- Tools: @shared/mcp-integration/sequential.md#privacy-analysis

## Phase 5: Remediation Planning
**Security Lead**: @specialists/technical/security.md
**Implementation Planning**: @specialists/cognitive/architect.md
**Project Management**: @specialists/orchestration/project-manager.md

### Risk Prioritization
- Execute: @commands/core/analyze.md --risk-assessment --prioritization
- Pattern: @patterns/operational/risk-management.md#security-prioritization
- Memory: @memory/sessions/current-session.md#findings-summary

### Remediation Roadmap
- Collaborate: @collaborate:[
    specialists/technical/security.md,
    specialists/cognitive/architect.md,
    specialists/orchestration/project-manager.md
  ] --mode="planning" --output="roadmap"
- Pattern: @patterns/operational/remediation-patterns.md#phased-approach
- Timeline: @workflows/development/security-remediation.md
```

## Best Practices for @ Referencing

### 1. Reference Validation
```markdown
# Implement reference checking
@validate-references --recursive --check-existence --check-sections

# Handle broken references gracefully
@specialists/technical/frontend-dev.md || @specialists/cognitive/architect.md#frontend-guidance
```

### 2. Performance Optimization
```markdown
# Lazy loading of references
@lazy:patterns/architectural/microservices.md

# Cache frequently used references
@cache:memory/context/project-overview.md --ttl=1h

# Compressed references for token efficiency  
@compress:specialists/technical/security.md#quick-security-check
```

### 3. Context-Aware Selection
```markdown
# Smart specialist selection based on context
@auto-select:specialist --domain="frontend" --task="performance" --complexity="high"
# Resolves to: @specialists/technical/frontend-dev.md#performance-optimization

# Dynamic workflow selection
@auto-select:workflow --phase="implementation" --type="feature" --risk="medium"
# Resolves to: @workflows/development/feature-development.md#standard-implementation
```

### 4. Error Handling and Fallbacks
```markdown
# Graceful degradation
@specialists/domain/data-scientist.md 
@fallback:specialists/cognitive/analyzer.md#data-analysis
@error-handler:"Data science specialist not available, using general analysis approach"

# Multiple fallback levels
@specialists/technical/mobile-dev.md
@fallback:specialists/technical/frontend-dev.md#mobile-patterns
@fallback:specialists/cognitive/architect.md#mobile-architecture
@final-fallback:"Mobile development requires specialized knowledge - consider consulting external expert"
```

### 5. Documentation and Tracking
```markdown
# Track reference usage
@track-usage:specialists/technical/security.md --metrics="frequency,context,effectiveness"

# Document reference relationships
@document-relationships --output="reference-map.md" --format="mermaid"

# Validate reference integrity
@validate-integrity --check-cycles --check-dependencies --report="integrity-report.md"
```

## Integration with Claude Code Commands

### Setting Up @ References in Claude Code
```bash
# Initialize the reference system
claude-code --config="reference-system" --enable

# Load specialist registry
claude-code --load-specialists=".claude/specialists/_registry.md"

# Enable intelligent referencing
claude-code --enable-smart-references --context-aware

# Validate reference structure
claude-code --validate-references --recursive --report
```

### Using @ References in Commands
```bash
# Execute with specialist reference
claude-code "@specialists/technical/frontend-dev.md analyze --performance"

# Chain workflows with references
claude-code "@workflows/development/feature-development.md --specialist=@specialists/cognitive/architect.md"

# Use dynamic references
claude-code "@auto-specialist --file=src/components/UserDashboard.tsx optimize"
```

This comprehensive @ referencing system enables intelligent, context-aware collaboration between specialists, workflows, and patterns, making Claude Code and MCP integration highly efficient and powerful.