# Incident Response Workflow

## Overview
Emergency response workflow for managing production incidents with structured severity classification, escalation procedures, and post-incident review processes. Designed for rapid response and systematic resolution of critical system issues.

## MCP Server Integration
- **@claude/integrations/sequential.md** - Incident coordination and task orchestration
- **@claude/integrations/perplexity.md** - Solution research and knowledge base search
- **@claude/integrations/magic.md** - Incident timeline visualization and reporting
- **@claude/integrations/context7.md** - Documentation and runbook access

## Severity Classification

### Priority Levels
| Level | Severity | Impact | Response Time | Example |
|-------|----------|--------|---------------|---------|
| P1 | Critical | Complete service outage | < 15 min | Site down, data loss |
| P2 | High | Major feature unavailable | < 30 min | Payment failure, auth broken |
| P3 | Medium | Degraded performance | < 2 hours | Slow queries, partial outage |
| P4 | Low | Minor issues | < 24 hours | UI glitch, non-critical bug |

## Workflow Stages

### 1. Detection & Initial Assessment
**Specialist**: @claude/agents/technical/devops.md
**MCP Servers**: Sequential + Magic

```bash
@claude/commands/core/troubleshoot.md --incident --severity-assessment --impact-analysis
```

**Activities**:
- Alert validation and deduplication
- Initial severity classification
- Impact scope determination
- Affected service identification
- User impact assessment
- Business impact evaluation
- Initial timeline establishment

### 2. Triage & War Room Setup
**Specialist**: @claude/agents/orchestration/project-manager.md
**MCP Servers**: Sequential + Context7

```bash
@claude/commands/orchestration/coordinate.md --incident-response --war-room --roles
```

**Activities**:
- Incident commander assignment
- Communication channels setup
- Stakeholder notification
- Role assignments (technical lead, communications, scribe)
- Escalation path activation
- Status page update
- Customer communication preparation

### 3. Containment & Mitigation
**Specialist**: @claude/agents/technical/devops.md
**MCP Servers**: Sequential + Perplexity

```bash
@claude/commands/core/troubleshoot.md --contain --mitigate --temporary-fix
```

**Activities**:
- Immediate containment actions
- Traffic diversion/throttling
- Feature flag toggling
- Rollback evaluation
- Circuit breaker activation
- Cache invalidation
- Emergency scaling
- Data integrity verification

### 4. Root Cause Analysis & Resolution
**Specialist**: @claude/agents/cognitive/analyzer.md
**MCP Servers**: Perplexity + Sequential

```bash
@claude/commands/core/analyze.md --root-cause --logs --metrics --traces
```

**Activities**:
- Log aggregation and analysis
- Metric correlation
- Distributed trace examination
- Error pattern identification
- Configuration drift detection
- Dependency failure analysis
- Code change correlation
- Infrastructure state verification

### 5. Recovery & Validation
**Specialist**: @claude/agents/technical/qa-tester.md
**MCP Servers**: Sequential + BrowserMCP

```bash
@claude/commands/core/test.md --recovery-validation --smoke-tests --monitoring
```

**Activities**:
- Service restoration verification
- End-to-end testing
- Data consistency checks
- Performance baseline validation
- Monitoring alert clearance
- Customer-facing validation
- Rollback plan preparation
- Recovery metrics collection

### 6. Post-Incident Review
**Specialist**: @claude/agents/cognitive/strategist.md
**MCP Servers**: Sequential + Magic

```bash
@claude/commands/core/review.md --post-mortem --timeline --action-items
```

**Activities**:
- Incident timeline construction
- Contributing factors analysis
- Process breakdown identification
- Improvement recommendations
- Action item assignment
- Documentation updates
- Runbook enhancement
- Knowledge base updates

## Automation Script

```javascript
// Incident Response Automation
TodoWrite([
  {
    id: "initial_assessment",
    content: "Assess incident severity and impact scope",
    status: "in_progress",
    priority: "high",
    specialist: "@claude/agents/technical/devops.md",
    estimatedTime: "5min",
    severity: "P1"
  },
  {
    id: "war_room_setup",
    content: "Establish war room and assign incident roles",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/orchestration/project-manager.md",
    estimatedTime: "10min",
    dependencies: ["initial_assessment"]
  },
  {
    id: "containment_actions",
    content: "Execute immediate containment and mitigation",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/devops.md",
    estimatedTime: "15min",
    dependencies: ["war_room_setup"]
  },
  {
    id: "root_cause_analysis",
    content: "Investigate root cause through logs and metrics",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/cognitive/analyzer.md",
    estimatedTime: "30min",
    dependencies: ["containment_actions"]
  },
  {
    id: "resolution_implementation",
    content: "Implement permanent fix and validate",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/devops.md",
    estimatedTime: "45min",
    dependencies: ["root_cause_analysis"]
  },
  {
    id: "post_incident_review",
    content: "Conduct post-mortem and document learnings",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/cognitive/strategist.md",
    estimatedTime: "60min",
    dependencies: ["resolution_implementation"]
  }
]);

// Parallel emergency response teams
Task("Security Team", "Investigate potential security implications");
Task("Data Team", "Verify data integrity and recovery needs");
Task("Communications Team", "Manage stakeholder and customer updates");
```

## Escalation Procedures

### Escalation Matrix
```yaml
escalation_paths:
  P1:
    immediate: ["on-call engineer", "team lead", "engineering manager"]
    15_minutes: ["director of engineering", "VP engineering"]
    30_minutes: ["CTO", "CEO (if customer impact)"]
  P2:
    immediate: ["on-call engineer", "team lead"]
    30_minutes: ["engineering manager"]
    2_hours: ["director of engineering"]
  P3:
    immediate: ["on-call engineer"]
    2_hours: ["team lead"]
  P4:
    next_business_day: ["assigned engineer"]

notification_channels:
  P1: ["pagerduty", "slack-incidents", "email", "sms", "phone"]
  P2: ["pagerduty", "slack-incidents", "email"]
  P3: ["slack-incidents", "email"]
  P4: ["slack-team", "jira"]
```

## Communication Templates

### Initial Incident Report
```markdown
**INCIDENT DECLARED - [P1/P2/P3/P4]**
Time: [TIMESTAMP]
Services Affected: [SERVICE_NAMES]
Impact: [USER_IMPACT_DESCRIPTION]
Current Status: Investigating

War Room: [LINK]
Status Page: [LINK]
Incident Commander: [NAME]
```

### Status Update Template
```markdown
**INCIDENT UPDATE - [INCIDENT_ID]**
Time: [TIMESTAMP]
Status: [Investigating/Identified/Monitoring/Resolved]
Summary: [BRIEF_UPDATE]
Next Update: [TIME]

Current Actions:
- [ACTION_1]
- [ACTION_2]

Customer Impact: [DESCRIPTION]
```

## War Room Structure

### Roles & Responsibilities
| Role | Responsibility | Authority |
|------|----------------|-----------|
| Incident Commander | Overall coordination | All decisions |
| Technical Lead | Technical investigation | Technical changes |
| Communications Lead | Internal/external updates | Messaging |
| Scribe | Documentation and timeline | None |
| Subject Matter Experts | Domain expertise | Advisory |

### Communication Channels
```yaml
channels:
  war_room:
    voice: "incident-bridge-[ID]"
    chat: "#incident-[ID]"
    video: "meet.company.com/incident-[ID]"
  updates:
    internal: "#incidents-status"
    customer: "status.company.com"
    executive: "#exec-incidents"
```

## Post-Mortem Process

### Timeline Construction
1. Aggregate all relevant timestamps
2. Correlate system events with actions
3. Identify decision points
4. Map cause-and-effect relationships
5. Highlight critical moments

### Five Whys Analysis
```yaml
problem: "Service outage occurred"
why_1: "Database connection pool exhausted"
why_2: "Connection leak in new code"
why_3: "Missing connection cleanup in error path"
why_4: "Inadequate error handling testing"
why_5: "Gap in code review checklist"
```

### Action Items Template
```markdown
## Action Items from Incident [ID]

### Immediate (< 1 week)
- [ ] Fix connection leak in error handling
- [ ] Add monitoring for connection pool usage
- [ ] Update deployment rollback procedures

### Short-term (< 1 month)
- [ ] Implement connection pool alerts
- [ ] Add integration tests for error paths
- [ ] Review and update runbooks

### Long-term (< 3 months)
- [ ] Architectural review of connection management
- [ ] Automated testing for resource leaks
- [ ] Incident response training refresh
```

## Deliverables

### Incident Report
- Executive summary
- Timeline of events
- Technical root cause
- Impact assessment
- Resolution steps
- Preventive measures

### Root Cause Analysis (RCA)
- Problem statement
- Investigation methodology
- Technical deep-dive
- Contributing factors
- Systemic issues identified
- Remediation plan

### Improvement Actions
- Process improvements
- Technical fixes
- Monitoring enhancements
- Documentation updates
- Training needs
- Tool improvements

## Success Criteria
- Mean Time to Detect (MTTD) < 5 minutes
- Mean Time to Respond (MTTR) < 15 minutes
- Mean Time to Resolve (MTTR) < 2 hours
- Post-mortem completed within 48 hours
- All P1/P2 incidents have RCA
- Action items tracked to completion

## Memory Integration
- Incident history: `@claude/memory/knowledge/incident-history.md`
- Common root causes: `@claude/memory/knowledge/common-failures.md`
- Runbook library: `@claude/memory/knowledge/runbooks.md`
- Lessons learned: `@claude/memory/knowledge/lessons-learned.md`
- Current incident: `@claude/memory/sessions/current-session.md#active-incident`

## Integration Points
- **@claude/workflows/analysis/performance-audit.md** - Performance-related incidents
- **@claude/workflows/analysis/security-assessment.md** - Security incidents
- **@claude/workflows/development/bug-resolution.md** - Bug-related incidents
- **@claude/workflows/operations/deployment.md** - Deployment failures

## Emergency Procedures

### Data Loss Scenario
1. **Immediate Actions**
   - Stop all write operations
   - Activate data recovery team
   - Assess backup availability
   - Notify legal/compliance

2. **Recovery Process**
   - Point-in-time recovery evaluation
   - Backup restoration testing
   - Data consistency verification
   - Gradual service restoration

### Security Breach
1. **Containment**
   - Isolate affected systems
   - Revoke compromised credentials
   - Enable enhanced logging
   - Activate security team

2. **Investigation**
   - Forensic data collection
   - Attack vector analysis
   - Lateral movement assessment
   - Customer data impact review

## Best Practices
1. Always declare incidents early - better safe than sorry
2. Over-communicate during incidents
3. Focus on mitigation before root cause
4. Document everything in real-time
5. No blame during incident response
6. Customer impact drives all decisions
7. Practice incident response regularly
8. Update runbooks based on incidents
9. Automate common response procedures
10. Maintain calm and systematic approach