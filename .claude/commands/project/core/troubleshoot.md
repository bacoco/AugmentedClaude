# Troubleshoot Command

## Purpose
Systematic problem diagnosis and resolution for errors, performance issues, integration problems, and security incidents with root cause analysis and remediation.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/analyzer.md
- **Supporting**: Varies by issue type
  - Errors: Relevant technical specialist
  - Performance: @claude/agents/technical/backend-dev.md, @claude/agents/technical/frontend-dev.md
  - Integration: @claude/agents/orchestration/system-integrator.md
  - Security: @claude/agents/technical/security.md

## Command Syntax
```
@claude/commands/core/troubleshoot.md [--issue-type] [--urgency] [--context] [--symptoms] [--specialist]
```

## Parameters
- `--issue-type`: Type of issue (error, performance, integration, security, availability, data)
- `--urgency`: Issue urgency (low, medium, high, critical)
- `--context`: Additional context or error messages
- `--symptoms`: Observable symptoms or behavior
- `--specialist`: Override default specialist selection

## Usage Examples

### Error Troubleshooting
```
@claude/commands/core/troubleshoot.md --issue-type=error --urgency=high --context="NullPointerException in payment service"
```
**Activates**: @claude/agents/cognitive/analyzer.md + @claude/agents/technical/backend-dev.md
**Tools**: @claude/integrations/sequential.md for step-by-step diagnosis
**Patterns**: @claude/patterns/operational/incident-response.md
**Memory**: Logs findings in @claude/memory/sessions/current-session.md#troubleshooting-log

### Performance Issues
```
@claude/commands/core/troubleshoot.md --issue-type=performance --symptoms="API response time > 5s" --urgency=critical
```
**Activates**: @claude/agents/cognitive/analyzer.md for root cause analysis
**Tools**: @claude/integrations/puppeteer.md for frontend performance testing
**Patterns**: @claude/patterns/development/performance-patterns.md
**Output**: Performance report in @claude/memory/knowledge/performance-issues.md

### Integration Problems
```
@claude/commands/core/troubleshoot.md --issue-type=integration --context="Third-party API authentication failing"
```
**Activates**: @claude/agents/orchestration/system-integrator.md
**Tools**: @claude/integrations/browsermcp.md for API testing
**Patterns**: @claude/patterns/architectural/integration-patterns.md
**Memory**: Updates @claude/memory/knowledge/integration-issues.md

## Execution Workflow

### Phase 1: Initial Assessment
1. **Problem Identification**
   - Gather error logs and stack traces
   - Document symptoms and behavior
   - Establish timeline of events
   - Check @claude/memory/knowledge/lessons-learned.md for similar issues

2. **Impact Analysis**
   - Identify affected systems and users
   - Assess business impact and urgency
   - Determine scope of investigation
   - Establish communication protocols

### Phase 2: Diagnostic Investigation
1. **Data Collection**
   - System logs and monitoring data
   - Performance metrics and traces
   - Configuration and environment details
   - Recent changes from @claude/memory/sessions/current-session.md

2. **Root Cause Analysis**
   - Use @claude/integrations/sequential.md for systematic analysis
   - Apply 5-whys methodology
   - Correlate events and changes
   - Test hypotheses systematically

### Phase 3: Solution Development
1. **Immediate Mitigation**
   - Implement quick fixes for critical issues
   - Establish workarounds if needed
   - Monitor stability after changes
   - Document temporary measures

2. **Permanent Resolution**
   - Design comprehensive solution
   - Consider architectural implications
   - Plan implementation approach
   - Prepare rollback strategy

### Phase 4: Implementation & Validation
1. **Fix Deployment**
   - Implement solution in test environment
   - Validate fix effectiveness
   - Deploy to production with monitoring
   - Verify issue resolution

2. **Post-Mortem**
   - Document root cause and resolution
   - Update @claude/memory/knowledge/lessons-learned.md
   - Create preventive measures
   - Share knowledge with team

## Integration Points
- **Monitoring**: @claude/patterns/operational/monitoring-patterns.md for observability
- **Testing**: @claude/commands/core/test.md for validation
- **Review**: @claude/commands/core/review.md for solution quality
- **Documentation**: Update runbooks and procedures

## Diagnostic Workflows

### Error Diagnosis Workflow
1. **Stack Trace Analysis**
   - Parse error messages and stack traces
   - Identify error origin and propagation
   - Check for known issues in memory

2. **Code Investigation**
   - Review recent changes
   - Analyze error-prone code sections
   - Check dependency versions

3. **Environment Verification**
   - Configuration validation
   - Resource availability check
   - Permission and access verification

### Performance Diagnosis Workflow
1. **Metric Collection**
   - Response time analysis
   - Resource utilization (CPU, memory, I/O)
   - Database query performance
   - Network latency measurements

2. **Bottleneck Identification**
   - Profile application performance
   - Identify slow queries or operations
   - Analyze resource contention
   - Check for memory leaks

3. **Optimization Planning**
   - Prioritize performance improvements
   - Design caching strategies
   - Plan database optimizations
   - Consider architectural changes

### Security Incident Workflow
1. **Threat Assessment**
   - Identify attack vectors
   - Assess data exposure
   - Check system integrity
   - Review access logs

2. **Containment**
   - Isolate affected systems
   - Revoke compromised credentials
   - Apply security patches
   - Enable additional monitoring

3. **Recovery**
   - Restore from secure backups
   - Verify system integrity
   - Update security measures
   - Document incident details

## Success Criteria
- [ ] Root cause accurately identified
- [ ] Issue resolved or mitigated effectively
- [ ] No regression or new issues introduced
- [ ] Solution documented and reproducible
- [ ] Preventive measures implemented
- [ ] Knowledge base updated

## Memory & Context Usage
- **Issue History**: @claude/memory/knowledge/troubleshooting-history.md
- **Known Issues**: @claude/memory/knowledge/known-issues.md
- **Solution Patterns**: @claude/memory/knowledge/solution-patterns.md
- **System Context**: @claude/memory/context/system-architecture.md

## Advanced Features

### Predictive Troubleshooting
```
@claude/commands/core/troubleshoot.md --mode=predictive --analyze=trends
```
Analyzes patterns to predict potential issues before they occur.

### Automated Diagnostics
```
@claude/commands/core/troubleshoot.md --issue-type=auto --urgency=high
```
Automatically determines issue type and executes appropriate diagnostic workflow.

### Correlation Analysis
Integrates with @claude/patterns/operational/monitoring-patterns.md for:
- Multi-system correlation
- Event timeline reconstruction
- Anomaly detection
- Pattern recognition from historical data

## Error Handling
- **Incomplete Data**: Request additional logs or context
- **Multiple Root Causes**: Prioritize and address systematically
- **Cannot Reproduce**: Create detailed reproduction steps
- **Access Limitations**: Escalate or find alternative diagnostic methods