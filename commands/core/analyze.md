# Analyze Command

## Purpose
Multi-dimensional analysis command for investigating problems, evaluating performance, and understanding system behavior.

## Specialist Integration
- **Primary**: @specialists/cognitive/analyzer.md
- **Supporting**: Domain-specific specialists based on analysis type

## Command Syntax
```
@commands/core/analyze.md [--type] [--scope] [--depth] [--specialist]
```

## Parameters
- `--type`: Analysis type (performance, security, code-quality, system, data)
- `--scope`: Analysis scope (component, system, network, user-behavior)
- `--depth`: Analysis depth (surface, detailed, comprehensive)
- `--specialist`: Specialist override for domain-specific analysis

## Usage Examples

### Performance Analysis
```
@commands/core/analyze.md --type=performance --scope=frontend --depth=comprehensive
```
**Activates**: @specialists/cognitive/analyzer.md + @specialists/technical/frontend-dev.md
**Tools**: @shared/mcp-integration/puppeteer.md for browser performance analysis
**Patterns**: @patterns/development/performance-patterns.md

### Security Analysis
```
@commands/core/analyze.md --type=security --scope=api --specialist=@specialists/technical/security.md
```
**Activates**: @specialists/technical/security.md with analyzer support
**Tools**: @shared/mcp-integration/sequential.md for threat modeling
**Patterns**: @patterns/development/security-patterns.md

### Code Quality Analysis
```
@commands/core/analyze.md --type=code-quality --scope=component --depth=detailed
```
**Activates**: @specialists/cognitive/analyzer.md
**Tools**: @shared/mcp-integration/context7.md for best practices research
**Patterns**: @patterns/development/code-quality-patterns.md

## Execution Workflow

### Phase 1: Analysis Setup
1. **Context Gathering**
   - Load relevant memory: @memory/context/project-overview.md
   - Identify analysis scope and constraints
   - Select appropriate tools and specialists

2. **Baseline Establishment**
   - Gather current metrics and benchmarks
   - Document initial state
   - Set analysis success criteria

### Phase 2: Data Collection
1. **Metric Gathering**
   - Performance metrics (response times, throughput, resource usage)
   - Security metrics (vulnerabilities, compliance status)
   - Quality metrics (complexity, coverage, maintainability)

2. **Evidence Collection**
   - Logs, traces, and monitoring data
   - Code analysis results
   - User feedback and behavior data

### Phase 3: Analysis & Investigation
1. **Pattern Recognition**
   - Identify trends and anomalies
   - Compare against known patterns
   - Use @patterns/* for reference comparisons

2. **Root Cause Analysis**
   - Apply systematic investigation techniques
   - Use @shared/mcp-integration/sequential.md for complex analysis
   - Document hypothesis and validation process

### Phase 4: Reporting & Recommendations
1. **Findings Documentation**
   - Structured analysis report
   - Evidence and supporting data
   - Risk assessment and impact analysis

2. **Recommendation Generation**
   - Prioritized improvement recommendations
   - Implementation effort estimates
   - Success measurement criteria

## Analysis Types

### Performance Analysis
- **Metrics**: Response time, throughput, resource utilization
- **Tools**: @shared/mcp-integration/puppeteer.md (frontend), monitoring tools
- **Specialists**: @specialists/cognitive/analyzer.md, performance-focused technical specialists
- **Patterns**: @patterns/development/performance-patterns.md

### Security Analysis
- **Metrics**: Vulnerability count, compliance score, threat exposure
- **Tools**: @shared/mcp-integration/sequential.md for threat modeling
- **Specialists**: @specialists/technical/security.md
- **Patterns**: @patterns/development/security-patterns.md

### System Analysis
- **Metrics**: System health, dependency mapping, failure patterns
- **Tools**: @shared/mcp-integration/context7.md for architecture research
- **Specialists**: @specialists/cognitive/architect.md, @specialists/cognitive/analyzer.md
- **Patterns**: @patterns/architectural/*

## Integration Points
- **Troubleshooting**: Automatic escalation to @commands/core/troubleshoot.md for issues
- **Optimization**: Recommendations feed into @commands/specialized/optimize.md
- **Security**: Security findings trigger @commands/specialized/secure.md workflows
- **Documentation**: Results documented via @commands/specialized/document.md

## Success Criteria
- [ ] Analysis objectives clearly defined and met
- [ ] Comprehensive data collection completed
- [ ] Root causes identified with supporting evidence
- [ ] Actionable recommendations provided
- [ ] Risk assessment and prioritization completed
- [ ] Follow-up actions clearly defined

## Memory & Context Usage
- **Analysis History**: @memory/knowledge/analysis-history.md
- **Baseline Metrics**: @memory/context/performance-baselines.md
- **Known Issues**: @memory/knowledge/anti-patterns.md
- **Session Tracking**: @memory/sessions/current-session.md#analysis-log

## Error Handling & Escalation
- Insufficient data → @specialists/cognitive/researcher.md for deeper investigation
- Complex systems → @specialists/cognitive/architect.md for architectural analysis
- Security concerns → @specialists/technical/security.md immediate involvement
- Performance critical → Emergency escalation to @specialists/orchestration/project-manager.md
