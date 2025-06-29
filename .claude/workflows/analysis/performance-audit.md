# Performance Audit Workflow

## Overview
Comprehensive performance analysis workflow for identifying bottlenecks, optimizing system performance, and establishing performance baselines across frontend, backend, and infrastructure layers.

## MCP Server Integration
- **@claude/integrations/puppeteer.md** - Frontend performance testing and Core Web Vitals
- **@claude/integrations/sequential.md** - Multi-step analysis and report generation
- **@claude/integrations/browsermcp.md** - Visual performance metrics and rendering analysis
- **@claude/integrations/magic.md** - Performance data visualization and insights

## Workflow Stages

### 1. Performance Baseline Establishment
**Specialist**: @claude/agents/technical/devops.md
**MCP Servers**: Puppeteer + Sequential

```bash
@claude/commands/core/analyze.md --performance --baseline --metrics=[cls,lcp,fid,fcp,ttfb]
```

**Activities**:
- Current performance metrics capture
- Historical data comparison
- Performance budget definition
- Monitoring setup validation

### 2. Frontend Performance Profiling
**Specialist**: @claude/agents/technical/frontend-dev.md
**MCP Servers**: Puppeteer + BrowserMCP

```bash
@claude/commands/core/test.md --source=puppeteer --performance --lighthouse --web-vitals
```

**Activities**:
- Core Web Vitals measurement (CLS, LCP, FID)
- Bundle size analysis and code splitting
- JavaScript execution profiling
- Render performance optimization
- Network waterfall analysis
- Resource loading optimization
- Third-party script impact assessment

### 3. Backend Performance Analysis
**Specialist**: @claude/agents/technical/backend-dev.md
**MCP Servers**: Sequential + Magic

```bash
@claude/commands/core/analyze.md --backend --api-latency --database --caching
```

**Activities**:
- API endpoint response time analysis
- Database query optimization
- N+1 query detection
- Cache hit rate analysis
- Memory usage profiling
- CPU utilization patterns
- Connection pool optimization
- Background job performance

### 4. Infrastructure Performance Assessment
**Specialist**: @claude/agents/technical/devops.md
**MCP Servers**: Sequential + Context7

```bash
@claude/commands/specialized/analyze.md --infrastructure --resources --scaling --bottlenecks
```

**Activities**:
- Resource utilization analysis
- Auto-scaling effectiveness
- Load balancer performance
- CDN cache effectiveness
- Container resource limits
- Network latency mapping
- Storage I/O performance
- Service mesh overhead

### 5. Comprehensive Analysis & Optimization
**Specialist**: @claude/agents/cognitive/analyzer.md
**MCP Servers**: Sequential + Magic

```bash
@claude/commands/core/analyze.md --synthesize --bottlenecks --recommendations --priority
```

**Activities**:
- Cross-layer bottleneck identification
- Performance correlation analysis
- Cost-benefit optimization matrix
- Implementation priority ranking
- Risk assessment for optimizations
- Performance budget recommendations

## Automation Script

```javascript
// Performance Audit Automation
TodoWrite([
  {
    id: "baseline_capture",
    content: "Establish current performance baseline across all metrics",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/devops.md",
    estimatedTime: "30min"
  },
  {
    id: "frontend_profiling",
    content: "Profile frontend performance including Core Web Vitals and bundle analysis",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/frontend-dev.md",
    estimatedTime: "90min"
  },
  {
    id: "backend_analysis",
    content: "Analyze backend performance: APIs, database queries, caching",
    status: "pending",
    priority: "high",
    specialist: "@claude/agents/technical/backend-dev.md",
    estimatedTime: "120min"
  },
  {
    id: "infrastructure_assessment",
    content: "Assess infrastructure performance and resource utilization",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/technical/devops.md",
    estimatedTime: "60min"
  },
  {
    id: "optimization_roadmap",
    content: "Create comprehensive optimization roadmap with priorities",
    status: "pending",
    priority: "medium",
    specialist: "@claude/agents/cognitive/analyzer.md",
    estimatedTime: "45min"
  }
]);

// Parallel execution for comprehensive coverage
Task("Frontend Performance Team", "Run Lighthouse audits and bundle analysis in parallel");
Task("Backend Performance Team", "Profile API endpoints and database queries simultaneously");
Task("Infrastructure Team", "Monitor resource utilization and scaling behavior");
```

## Performance Metrics Configuration

### Frontend Metrics
```yaml
core_web_vitals:
  lcp: # Largest Contentful Paint
    target: < 2.5s
    warning: 2.5s - 4.0s
    critical: > 4.0s
  fid: # First Input Delay
    target: < 100ms
    warning: 100ms - 300ms
    critical: > 300ms
  cls: # Cumulative Layout Shift
    target: < 0.1
    warning: 0.1 - 0.25
    critical: > 0.25

bundle_metrics:
  initial_bundle:
    target: < 200KB
    warning: 200KB - 500KB
    critical: > 500KB
  total_size:
    target: < 1MB
    warning: 1MB - 2MB
    critical: > 2MB
```

### Backend Metrics
```yaml
api_performance:
  p50_latency:
    target: < 100ms
    warning: 100ms - 200ms
    critical: > 200ms
  p95_latency:
    target: < 500ms
    warning: 500ms - 1000ms
    critical: > 1000ms
  p99_latency:
    target: < 1000ms
    warning: 1000ms - 2000ms
    critical: > 2000ms

database:
  query_time:
    target: < 50ms
    warning: 50ms - 200ms
    critical: > 200ms
  connection_pool:
    utilization_target: < 70%
    warning: 70% - 85%
    critical: > 85%
```

## Output Deliverables

### Performance Audit Report
- Executive summary with key findings
- Performance scorecard by layer
- Detailed metrics analysis
- Bottleneck identification map
- Before/after comparison projections
- Cost-benefit analysis for optimizations

### Optimization Roadmap
- Prioritized optimization tasks
- Implementation complexity assessment
- Expected performance gains
- Resource requirements
- Timeline recommendations
- Quick wins vs. long-term improvements

### Implementation Guide
- Step-by-step optimization procedures
- Code examples and configurations
- Testing strategies for each optimization
- Rollback procedures
- Performance monitoring setup

## Success Criteria
- All Core Web Vitals in "Good" range
- API response times meet SLA requirements
- Database query performance optimized
- Resource utilization under 80%
- Performance budget established and tracked
- Monitoring and alerting configured

## Memory Integration
- Performance baselines: `@claude/memory/knowledge/performance-baselines.md`
- Optimization history: `@claude/memory/knowledge/performance-optimizations.md`
- Known bottlenecks: `@claude/memory/context/performance-bottlenecks.md`
- Session results: `@claude/memory/sessions/current-session.md#performance-audit`

## Integration Points
- **@claude/workflows/development/feature-development.md** - Performance requirements for new features
- **@claude/workflows/operations/incident-response.md** - Performance degradation incidents
- **@claude/workflows/development/code-review.md** - Performance impact assessment

## Automation Opportunities

### Continuous Performance Monitoring
```yaml
performance_monitoring:
  schedule: "0 */6 * * *" # Every 6 hours
  tasks:
    - synthetic_monitoring
    - real_user_monitoring
    - resource_tracking
    - alert_threshold_check
```

### Performance Regression Testing
```yaml
ci_pipeline:
  performance_tests:
    - lighthouse_ci
    - load_testing
    - api_benchmarks
    - database_profiling
  thresholds:
    fail_on_regression: true
    tolerance: 5%
```

## Emergency Procedures
1. **Severe Performance Degradation**
   - Activate incident response workflow
   - Enable emergency caching
   - Scale resources immediately
   - Implement circuit breakers

2. **Resource Exhaustion**
   - Auto-scaling trigger verification
   - Traffic throttling activation
   - Non-critical service degradation
   - Cache warming procedures

## Best Practices
1. Always establish baseline before optimization
2. Focus on user-impacting metrics first
3. Consider cost-benefit for all optimizations
4. Test optimizations under realistic load
5. Monitor for regression after changes
6. Document all performance-related decisions
7. Maintain performance budget discipline