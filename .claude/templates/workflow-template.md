# Workflow Template

<!--
INSTRUCTIONS FOR USING THIS TEMPLATE:
1. Copy this template to the appropriate location in /workflows/
2. Replace all placeholder text wrapped in [brackets]
3. Remove any optional sections that aren't needed
4. Ensure all references use the @ notation
5. Follow the examples at the bottom for guidance
6. Workflows should be complete, end-to-end processes
-->

# [Workflow Name] Workflow

## Overview
<!-- REQUIRED: Brief description of the workflow's purpose and scope -->
[Complete description of what this workflow accomplishes from start to finish]

## Specialists Involved
<!-- REQUIRED: List all specialists participating in this workflow -->
- **Primary**: [Main specialists who lead phases]
- **Supporting**: [Specialists who provide assistance]

## Phase 1: [Phase Name]
<!-- REQUIRED: Each workflow must have at least 2 phases -->
**Duration**: [Estimated time range]
**Lead Specialist**: @claude/agents/[category]/[specialist].md

### Tasks
1. **[Task Name]**
   - Execute: @commands/[category]/[command].md --[parameters]
   - Pattern: @claude/patterns/[category]/[pattern].md#[section]
   - Output: [Expected deliverable]

2. **[Task Name]**
   - Specialist: @claude/agents/[category]/[specialist].md
   - Execute: @commands/[category]/[command].md --[parameters]
   - Pattern: @claude/patterns/[category]/[pattern].md#[section]
   - Memory: @claude/memory/context/[file].md

### Deliverables
<!-- Checklist of what must be completed in this phase -->
- [ ] [Deliverable 1]
- [ ] [Deliverable 2]
- [ ] [Deliverable 3]

## Phase 2: [Phase Name]
**Duration**: [Estimated time range]
**Lead Specialist**: @claude/agents/[category]/[specialist].md

### Tasks
1. **[Task Name]**
   - Execute: @commands/[category]/[command].md --[parameters]
   - Pattern: @claude/patterns/[category]/[pattern].md#[section]
   - Tools: @claude/mcp-integration/[tool].md#[usage]

2. **[Task Name]**
   - Specialist: @claude/agents/[category]/[specialist].md
   - Execute: @commands/[category]/[command].md --[parameters]
   - Pattern: @claude/patterns/[category]/[pattern].md#[section]

### Deliverables
- [ ] [Deliverable 1]
- [ ] [Deliverable 2]
- [ ] [Deliverable 3]

<!-- Add more phases as needed -->

## Success Criteria
<!-- REQUIRED: Overall success metrics for the entire workflow -->
- [ ] [Success criterion 1]
- [ ] [Success criterion 2]
- [ ] [Success criterion 3]
- [ ] [Success criterion 4]

## Emergency Escalation
<!-- OPTIONAL but RECOMMENDED: How to handle critical issues -->
- **[Issue Type]**: @claude/workflows/[category]/[escalation-workflow].md --severity=[level]
- **[Issue Type]**: @claude/agents/[category]/[specialist].md --emergency
- **[Issue Type]**: @claude/agents/[category]/[specialist].md --urgent-review

## Memory & Learning
<!-- REQUIRED: How to capture and preserve knowledge from this workflow -->
- Document lessons learned: @claude/memory/knowledge/lessons-learned.md#[section]
- Update patterns: @claude/patterns/[category]/[pattern].md
- Archive decisions: @claude/memory/context/[decisions-file].md

## Integration Points
<!-- OPTIONAL: How this workflow connects with others -->
- **Pre-workflow**: @claude/workflows/[category]/[workflow].md
- **Post-workflow**: @claude/workflows/[category]/[workflow].md
- **Parallel workflows**: @claude/workflows/[category]/[workflow].md

## Quality Gates
<!-- OPTIONAL: Checkpoints between phases -->
### Between Phase 1 and Phase 2
- [ ] [Quality check 1]
- [ ] [Quality check 2]
- [ ] Approval from: @claude/agents/[category]/[specialist].md

## Collaboration Points
<!-- OPTIONAL: When multiple specialists work together -->
- **[Collaboration Name]**
  - Execute: @commands/core/review.md --comprehensive
  - Collaborate: @collaborate:[
      specialists/[category]/[specialist1].md,
      specialists/[category]/[specialist2].md,
      specialists/[category]/[specialist3].md
    ]

---

## EXAMPLE: Completed Workflow Template

# Security Audit Workflow

## Overview
Comprehensive security assessment workflow for identifying vulnerabilities, validating security controls, and ensuring compliance with security standards across the entire application stack.

## Specialists Involved
- **Primary**: @claude/agents/technical/security.md, @claude/agents/cognitive/analyzer.md
- **Supporting**: @claude/agents/technical/backend-dev.md, @claude/agents/technical/frontend-dev.md, @claude/agents/technical/devops.md

## Phase 1: Reconnaissance & Planning
**Duration**: 1 day
**Lead Specialist**: @claude/agents/technical/security.md

### Tasks
1. **Scope Definition**
   - Execute: @commands/specialized/analyze.md --security-scope --attack-surface
   - Pattern: @claude/patterns/operational/security-testing.md#scope-definition
   - Output: Security audit scope document

2. **Threat Modeling**
   - Specialist: @claude/agents/cognitive/analyzer.md
   - Execute: @commands/specialized/analyze.md --threat-model --stride
   - Pattern: @claude/patterns/development/security-patterns.md#threat-modeling
   - Memory: @claude/memory/context/security-requirements.md

3. **Tool Preparation**
   - Execute: @commands/specialized/secure.md --prepare-tools --scanners
   - Tools: @claude/mcp-integration/puppeteer.md#security-testing
   - Output: Configured security testing environment

### Deliverables
- [ ] Security audit scope document
- [ ] Threat model with identified risks
- [ ] Testing environment ready
- [ ] Audit timeline established

## Phase 2: Vulnerability Assessment
**Duration**: 2-3 days
**Lead Specialist**: @claude/agents/technical/security.md

### Tasks
1. **Static Code Analysis**
   - Execute: @commands/specialized/secure.md --static-analysis --all-languages
   - Pattern: @claude/patterns/operational/security-testing.md#sast
   - Tools: @claude/mcp-integration/context7.md#vulnerability-lookup

2. **Dynamic Application Testing**
   - Execute: @commands/specialized/secure.md --dynamic-testing --authenticated
   - Pattern: @claude/patterns/operational/security-testing.md#dast
   - Tools: @claude/mcp-integration/puppeteer.md#penetration-testing

3. **Infrastructure Security**
   - Specialist: @claude/agents/technical/devops.md
   - Execute: @commands/specialized/secure.md --infrastructure --cloud-config
   - Pattern: @claude/patterns/operational/security-testing.md#infrastructure

### Deliverables
- [ ] SAST findings report
- [ ] DAST findings report
- [ ] Infrastructure vulnerabilities identified
- [ ] Prioritized vulnerability list

## Phase 3: Manual Testing & Verification
**Duration**: 2 days
**Lead Specialist**: @claude/agents/cognitive/analyzer.md

### Tasks
1. **Business Logic Testing**
   - Execute: @commands/specialized/test.md --security --business-logic
   - Pattern: @claude/patterns/development/security-patterns.md#logic-flaws
   - Collaborate: @collaborate:[
       specialists/technical/security.md,
       specialists/technical/backend-dev.md
     ]

2. **Authentication & Authorization**
   - Execute: @commands/specialized/secure.md --auth-testing --comprehensive
   - Pattern: @claude/patterns/development/security-patterns.md#auth-patterns
   - Output: Auth vulnerability report

### Deliverables
- [ ] Business logic vulnerabilities documented
- [ ] Authentication/authorization issues identified
- [ ] Manual testing evidence collected

## Phase 4: Remediation Planning
**Duration**: 1 day
**Lead Specialist**: @claude/agents/technical/security.md

### Tasks
1. **Risk Assessment**
   - Execute: @commands/specialized/analyze.md --risk-scoring --cvss
   - Pattern: @claude/patterns/operational/risk-management.md#assessment
   - Memory: @claude/memory/knowledge/security-standards.md

2. **Remediation Roadmap**
   - Execute: @commands/specialized/plan.md --security-fixes --prioritized
   - Pattern: @claude/patterns/operational/security-testing.md#remediation
   - Output: Prioritized fix timeline

### Deliverables
- [ ] Risk-scored vulnerability report
- [ ] Remediation roadmap with timelines
- [ ] Security fix implementation guides

## Phase 5: Validation & Reporting
**Duration**: 1 day
**Lead Specialist**: @claude/agents/cognitive/analyzer.md

### Tasks
1. **Fix Verification**
   - Execute: @commands/specialized/secure.md --verify-fixes --regression-test
   - Pattern: @claude/patterns/operational/security-testing.md#validation
   - Tools: @claude/mcp-integration/puppeteer.md#regression-testing

2. **Final Report Generation**
   - Execute: @commands/specialized/document.md --security-report --executive-summary
   - Pattern: @claude/patterns/operational/security-testing.md#reporting
   - Memory: @claude/memory/sessions/current-session.md#security-audit

### Deliverables
- [ ] Fix verification results
- [ ] Executive security report
- [ ] Technical security report
- [ ] Compliance attestation (if applicable)

## Success Criteria
- [ ] All critical vulnerabilities identified
- [ ] Risk assessment completed for all findings
- [ ] Remediation plan approved by stakeholders
- [ ] No high/critical vulnerabilities in production
- [ ] Security posture improved from baseline
- [ ] Compliance requirements satisfied

## Emergency Escalation
- **Critical Vulnerability Found**: @claude/workflows/operations/incident-response.md --severity=critical
- **Active Exploitation Detected**: @claude/agents/technical/security.md --emergency --incident-response
- **Compliance Violation**: @claude/agents/domain/compliance-officer.md --urgent

## Memory & Learning
- Document lessons learned: @claude/memory/knowledge/lessons-learned.md#security-audits
- Update patterns: @claude/patterns/operational/security-testing.md
- Archive decisions: @claude/memory/context/security-decisions.md
- Store vulnerability patterns: @claude/memory/knowledge/vulnerability-patterns.md

## Integration Points
- **Pre-workflow**: @claude/workflows/development/feature-development.md
- **Post-workflow**: @claude/workflows/operations/security-monitoring.md
- **Parallel workflows**: @claude/workflows/operations/compliance-audit.md

## Quality Gates
### Between Phase 2 and Phase 3
- [ ] All automated scans completed
- [ ] Initial findings reviewed
- [ ] Approval from: @claude/agents/technical/security.md

### Between Phase 4 and Phase 5
- [ ] All fixes implemented
- [ ] Risk acceptance documented
- [ ] Approval from: @claude/agents/cognitive/architect.md