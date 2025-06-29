# Security Assessment Workflow

## Overview
Comprehensive security audit and assessment process to identify vulnerabilities and ensure compliance.

## Specialists Involved
- **Primary**: @specialists/technical/security.md
- **Supporting**: @specialists/technical/backend-dev.md, @specialists/cognitive/analyzer.md

## Phase 1: Assessment Planning
**Duration**: 1 day
**Lead Specialist**: @specialists/technical/security.md

### Planning Tasks
1. **Scope Definition**
   - Execute: @commands/specialized/secure.md --assessment-scope --threat-model
   - Pattern: @patterns/operational/security-testing.md#scope-planning
   - Context: @memory/context/compliance-requirements.md

2. **Methodology Selection**
   - OWASP testing methodology
   - NIST cybersecurity framework
   - Industry-specific compliance (PCI DSS, HIPAA, etc.)

### Deliverables
- [ ] Assessment scope document
- [ ] Threat model diagram
- [ ] Testing methodology plan
- [ ] Success criteria defined

## Phase 2: Automated Security Scanning
**Duration**: 4-6 hours
**Lead Specialist**: @specialists/technical/security.md

### Scanning Activities
1. **Static Code Analysis**
   - Execute: @commands/specialized/secure.md --static-analysis --vulnerability-scan
   - Pattern: @patterns/development/security-patterns.md#static-analysis
   - Tools: @shared/mcp-integration/sequential.md#code-analysis

2. **Dynamic Application Security Testing**
   - Execute: @commands/specialized/secure.md --dynamic-testing --penetration-scan
   - Tools: @shared/mcp-integration/puppeteer.md#security-automation

### Deliverables
- [ ] Static analysis report
- [ ] Dynamic testing results
- [ ] Vulnerability inventory
- [ ] Risk assessment matrix

## Phase 3: Manual Security Testing
**Duration**: 2-3 days
**Lead Specialist**: @specialists/technical/security.md

### Manual Testing Activities
1. **Authentication & Authorization Testing**
   - Execute: @commands/specialized/secure.md --auth-testing --privilege-escalation
   - Pattern: @patterns/development/security-patterns.md#access-control

2. **Business Logic Testing**
   - Execute: @commands/core/analyze.md --business-logic --security-flaws
   - Collaborate: @specialists/domain/product-manager.md --business-rules

### Deliverables
- [ ] Authentication security report
- [ ] Authorization control validation
- [ ] Business logic security assessment
- [ ] Data protection evaluation

## Phase 4: Infrastructure Security Review
**Duration**: 1-2 days
**Lead Specialist**: @specialists/technical/security.md + @specialists/technical/devops.md

### Infrastructure Review
1. **Network Security**
   - Execute: @commands/specialized/secure.md --network-security --firewall-rules
   - Pattern: @patterns/operational/security-patterns.md#network-hardening

2. **Server Hardening**
   - Execute: @commands/specialized/secure.md --server-hardening --configuration-review
   - Pattern: @patterns/operational/security-patterns.md#server-security

### Deliverables
- [ ] Network security assessment
- [ ] Server hardening report
- [ ] Configuration compliance check
- [ ] Infrastructure risk analysis

## Phase 5: Compliance Verification
**Duration**: 1-2 days
**Lead Specialist**: @specialists/technical/security.md

### Compliance Activities
1. **Regulatory Compliance Check**
   - Execute: @commands/specialized/secure.md --compliance-audit --framework-mapping
   - Pattern: @patterns/operational/compliance-patterns.md#audit-procedures
   - Context: @memory/context/compliance-requirements.md

### Deliverables
- [ ] Compliance gap analysis
- [ ] Regulatory requirements mapping
- [ ] Audit evidence collection
- [ ] Compliance certification readiness

## Phase 6: Reporting & Remediation Planning
**Duration**: 1 day
**Lead Specialist**: @specialists/technical/security.md

### Reporting Activities
1. **Executive Summary**
   - Execute: @commands/specialized/document.md --security-report --executive-summary
   - Pattern: @patterns/operational/security-reporting.md#stakeholder-communication

2. **Remediation Roadmap**
   - Execute: @commands/core/plan.md --remediation-roadmap --priority-matrix
   - Collaborate: @specialists/orchestration/project-manager.md

### Deliverables
- [ ] Comprehensive security assessment report
- [ ] Executive summary for leadership
- [ ] Prioritized remediation roadmap
- [ ] Cost-benefit analysis for fixes

## Critical Finding Escalation
- **Critical Vulnerabilities**: Immediate escalation to @specialists/orchestration/project-manager.md
- **Compliance Violations**: Escalate to legal/compliance team
- **Active Threats**: @workflows/operations/incident-response.md --security-incident

## Success Criteria
- [ ] Comprehensive vulnerability assessment completed
- [ ] All high/critical findings documented
- [ ] Compliance status clearly established
- [ ] Remediation plan with timelines created
- [ ] Stakeholder communication completed

## Memory & Learning
- Update: @memory/knowledge/security-incidents.md
- Document: @memory/knowledge/vulnerability-patterns.md
- Archive: @memory/context/compliance-history.md
