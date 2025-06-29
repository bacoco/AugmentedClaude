# Monitor Command

## Purpose
Real-time monitoring and observability command for tracking system performance, health metrics, and operational status across all components.

## Specialist Integration
- **Primary**: @specialists/technical/devops.md
- **Supporting**: @specialists/cognitive/analyzer.md, @specialists/technical/backend-dev.md

## Command Syntax
```
@commands/core/monitor.md [--scope] [--metrics] [--duration] [--alerts]
```

## Parameters
- `--scope`: Monitoring scope (system, application, infrastructure, network, security)
- `--metrics`: Metrics to track (performance, health, errors, usage, business)
- `--duration`: Monitoring duration (real-time, historical, continuous)
- `--alerts`: Alert configuration (thresholds, notifications, escalation)

## Usage Examples

### System Performance Monitoring
```
@commands/core/monitor.md --scope=system --metrics=performance --duration=real-time
```
**Activates**: @specialists/technical/devops.md for infrastructure monitoring
**Tools**: @shared/mcp-integration/sequential.md for metric collection and analysis
**Patterns**: @patterns/operational/monitoring-patterns.md, @patterns/operational/alerting.md

### Application Health Monitoring
```
@commands/core/monitor.md --scope=application --metrics=health,errors --alerts=critical
```
**Activates**: @specialists/technical/backend-dev.md, @specialists/cognitive/analyzer.md
**Tools**: @shared/mcp-integration/magic.md for dashboard generation
**Patterns**: @patterns/operational/health-checks.md, @patterns/development/error-handling.md

### Security Monitoring
```
@commands/core/monitor.md --scope=security --metrics=usage --duration=continuous --specialist=@specialists/technical/security.md
```
**Activates**: @specialists/technical/security.md for security event monitoring
**Tools**: @shared/mcp-integration/perplexity.md for threat intelligence correlation
**Patterns**: @patterns/operational/security-monitoring.md

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
- **Troubleshooting**: Alert triggers invoke @commands/core/troubleshoot.md
- **Analysis**: Performance data feeds @specialists/cognitive/analyzer.md
- **Security**: Security events trigger @specialists/technical/security.md review
- **Documentation**: Monitoring results logged via @commands/specialized/document.md

## Success Criteria
- [ ] All critical components monitored
- [ ] Key metrics tracked and visualized
- [ ] Alert thresholds properly configured
- [ ] Response times within acceptable limits
- [ ] No false positive alerts
- [ ] Comprehensive operational visibility

## Memory & Context Usage
- **Monitoring Config**: @memory/operations/monitoring-config.md
- **Baseline Metrics**: @memory/operations/performance-baselines.md
- **Alert History**: @memory/operations/alert-history.md
- **Session Notes**: @memory/sessions/current-session.md#monitoring-log

## Error Handling & Fallbacks
- Monitoring failures → @specialists/technical/devops.md for infrastructure review
- Data collection issues → @shared/mcp-integration/sequential.md fallback mechanisms
- Alert fatigue → @specialists/cognitive/analyzer.md for threshold optimization
- Performance degradation → @commands/core/troubleshoot.md automatic invocation

## Advanced Features
- **Predictive Analytics**: Machine learning-based trend prediction
- **Multi-Cloud Monitoring**: Cross-platform observability
- **Custom Dashboards**: Stakeholder-specific visualizations
- **Automated Remediation**: Self-healing system responses