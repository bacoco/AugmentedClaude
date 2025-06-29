# Bug Resolution Workflow

## Overview
Systematic approach to investigating, diagnosing, and resolving software bugs and issues.

## Specialists Involved
- **Primary**: @specialists/cognitive/analyzer.md
- **Supporting**: @specialists/technical/qa-tester.md, domain specialists based on bug area

## Phase 1: Issue Triage & Classification
**Duration**: 30 minutes
**Lead Specialist**: @specialists/cognitive/analyzer.md

### Triage Tasks
1. **Issue Classification**
   - Execute: @commands/core/analyze.md --issue-severity --impact-assessment
   - Pattern: @patterns/operational/incident-patterns.md#severity-classification
   - Output: Severity level (Critical/High/Medium/Low)

2. **Specialist Assignment**
   - Frontend bugs → @specialists/technical/frontend-dev.md
   - Backend bugs → @specialists/technical/backend-dev.md
   - Security bugs → @specialists/technical/security.md
   - Performance bugs → @specialists/cognitive/analyzer.md

### Deliverables
- [ ] Bug severity classification
- [ ] Specialist assignment
- [ ] Initial impact assessment
- [ ] Timeline expectations set

## Phase 2: Investigation & Root Cause Analysis
**Duration**: 2-4 hours
**Lead Specialist**: Domain-specific specialist + @specialists/cognitive/analyzer.md

### Investigation Tasks
1. **Reproduction**
   - Execute: @commands/core/troubleshoot.md --reproduce --environment-check
   - Pattern: @patterns/development/debugging-patterns.md#reproduction-steps
   - Tools: @shared/mcp-integration/puppeteer.md#bug-reproduction

2. **Root Cause Analysis**
   - Execute: @commands/core/analyze.md --root-cause --system-impact
   - Pattern: @patterns/development/debugging-patterns.md#five-whys
   - Tools: @shared/mcp-integration/sequential.md#systematic-analysis

### Deliverables
- [ ] Bug reproduction steps
- [ ] Root cause identification
- [ ] System impact analysis
- [ ] Fix complexity estimation

## Phase 3: Solution Development
**Duration**: 1-8 hours (based on complexity)
**Lead Specialist**: Domain-specific specialist

### Development Tasks
1. **Fix Implementation**
   - Execute: @commands/core/build.md --bug-fix --minimal-change
   - Pattern: @patterns/development/bug-fix-patterns.md#surgical-fixes
   - Memory: @memory/knowledge/anti-patterns.md#bug-patterns

2. **Testing**
   - Execute: @commands/core/test.md --regression --fix-validation
   - Pattern: @patterns/development/testing-patterns.md#bug-testing
   - Specialist: @specialists/technical/qa-tester.md

### Deliverables
- [ ] Bug fix implementation
- [ ] Unit tests for fix
- [ ] Regression test validation
- [ ] Code review completed

## Phase 4: Verification & Deployment
**Duration**: 30 minutes - 2 hours
**Lead Specialist**: @specialists/technical/qa-tester.md

### Verification Tasks
1. **Quality Assurance**
   - Execute: @commands/core/test.md --comprehensive --edge-cases
   - Pattern: @patterns/development/testing-patterns.md#bug-verification

2. **Deployment**
   - Critical bugs: Immediate hotfix deployment
   - Other bugs: Include in next regular deployment
   - Execute: @commands/core/deploy.md --bug-fix --monitoring
   - Specialist: @specialists/technical/devops.md

### Deliverables
- [ ] Fix verification completed
- [ ] Deployment successful
- [ ] Monitoring confirms resolution
- [ ] User notification sent (if needed)

## Escalation Paths
- **Critical Production Bug**: @workflows/operations/incident-response.md --severity=critical
- **Security Bug**: @specialists/technical/security.md --emergency-response
- **Cannot Reproduce**: @specialists/cognitive/researcher.md --deep-investigation

## Success Criteria
- [ ] Bug reproduced and root cause identified
- [ ] Fix implemented with minimal side effects
- [ ] Comprehensive testing completed
- [ ] No regression introduced
- [ ] User satisfaction restored

## Memory & Learning
- Document in: @memory/knowledge/bug-patterns.md
- Update anti-patterns: @memory/knowledge/anti-patterns.md
- Add to troubleshooting guide: @memory/knowledge/troubleshooting-guide.md
