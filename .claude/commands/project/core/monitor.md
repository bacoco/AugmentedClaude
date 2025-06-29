# Monitor Command

## Purpose
Real-time monitoring and observability command for tracking system performance, health metrics, and operational status across all components.

## Specialist Integration
- **Primary**: @claude/agents/technical/devops.md
- **Supporting**: @claude/agents/cognitive/analyzer.md, @claude/agents/technical/backend-dev.md

## Command Syntax
```
@claude/commands/core/monitor.md [--scope] [--metrics] [--duration] [--alerts]
```

## Parameters
- `--scope`: Monitoring scope (system, application, infrastructure, network, security)
- `--metrics`: Metrics to track (performance, health, errors, usage, business)
- `--duration`: Monitoring duration (real-time, historical, continuous)
- `--alerts`: Alert configuration (thresholds, notifications, escalation)

## Usage Examples

### System Performance Monitoring
```
@claude/commands/core/monitor.md --scope=system --metrics=performance --duration=real-time
```
**Activates**: @claude/agents/technical/devops.md for infrastructure monitoring
**Tools**: @claude/integrations/sequential.md for metric collection and analysis
**Patterns**: @claude/patterns/operational/monitoring-patterns.md, @claude/patterns/operational/alerting.md

### Application Health Monitoring
```
@claude/commands/core/monitor.md --scope=application --metrics=health,errors --alerts=critical
```
**Activates**: @claude/agents/technical/backend-dev.md, @claude/agents/cognitive/analyzer.md
**Tools**: @claude/integrations/magic.md for dashboard generation
**Patterns**: @claude/patterns/operational/health-checks.md, @claude/patterns/development/error-handling.md

### Security Monitoring
```
@claude/commands/core/monitor.md --scope=security --metrics=usage --duration=continuous --specialist=@claude/agents/technical/security.md
```
**Activates**: @claude/agents/technical/security.md for security event monitoring
**Tools**: @claude/integrations/perplexity.md for threat intelligence correlation
**Patterns**: @claude/patterns/operational/security-monitoring.md

## Execution Workflow

### Phase 1: Monitoring Setup
1. **Scope Definition**
   - Identify components and services to monitor
   - Define key performance indicators (KPIs)
   - Establish baseline metrics and thresholds

2. **Infrastructure Preparation**
   - Configure monitoring agents and collectors
   - Set up data storage and retention policies
   - Establish network connectivity and security

### Phase 2: Data Collection
1. **Metric Gathering**
   - Real-time performance data collection
   - Log aggregation and parsing
   - Event stream processing

2. **Data Processing**
   - Metric aggregation and normalization
   - Anomaly detection and pattern recognition
   - Correlation analysis across components

### Phase 3: Analysis & Alerting
1. **Health Assessment**
   - Compare metrics against thresholds
   - Identify trends and anomalies
   - Generate health scores and reports

2. **Alert Management**
   - Trigger alerts for threshold violations
   - Escalate critical issues appropriately
   - Provide actionable remediation guidance

### Phase 4: Reporting & Optimization
1. **Dashboard Updates**
   - Real-time visualization updates
   - Historical trend analysis
   - Executive summary generation

2. **Continuous Improvement**
   - Monitor effectiveness assessment
   - Threshold tuning and optimization
   - New metric identification and integration

## Integration Points
- **Troubleshooting**: Alert triggers invoke @claude/commands/core/troubleshoot.md
- **Analysis**: Performance data feeds @claude/agents/cognitive/analyzer.md
- **Security**: Security events trigger @claude/agents/technical/security.md review
- **Documentation**: Monitoring results logged via @claude/commands/specialized/document.md

## Success Criteria
- [ ] All critical components monitored
- [ ] Key metrics tracked and visualized
- [ ] Alert thresholds properly configured
- [ ] Response times within acceptable limits
- [ ] No false positive alerts
- [ ] Comprehensive operational visibility

## Memory & Context Usage
- **Monitoring Config**: @claude/memory/operations/monitoring-config.md
- **Baseline Metrics**: @claude/memory/operations/performance-baselines.md
- **Alert History**: @claude/memory/operations/alert-history.md
- **Session Notes**: @claude/memory/sessions/current-session.md#monitoring-log

## Error Handling & Fallbacks
- Monitoring failures → @claude/agents/technical/devops.md for infrastructure review
- Data collection issues → @claude/integrations/sequential.md fallback mechanisms
- Alert fatigue → @claude/agents/cognitive/analyzer.md for threshold optimization
- Performance degradation → @claude/commands/core/troubleshoot.md automatic invocation

## Advanced Features
- **Predictive Analytics**: Machine learning-based trend prediction
- **Multi-Cloud Monitoring**: Cross-platform observability
- **Custom Dashboards**: Stakeholder-specific visualizations
- **Automated Remediation**: Self-healing system responses