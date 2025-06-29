# Analyze Command

## Purpose
Multi-dimensional analysis command for investigating problems, evaluating performance, and understanding system behavior.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/analyzer.md
- **Supporting**: Domain-specific specialists based on analysis type

## Command Syntax
```
@claude/commands/core/analyze.md [--type] [--scope] [--depth] [--specialist]
```

## Parameters
- `--type`: Analysis type (performance, security, code-quality, system, data)
- `--scope`: Analysis scope (component, system, network, user-behavior)
- `--depth`: Analysis depth (surface, detailed, comprehensive)
- `--specialist`: Specialist override for domain-specific analysis

## Usage Examples

### Performance Analysis
```
@claude/commands/core/analyze.md --type=performance --scope=frontend --depth=comprehensive
```
**Activates**: @claude/agents/cognitive/analyzer.md + @claude/agents/technical/frontend-dev.md
**Tools**: @claude/integrations/puppeteer.md for browser performance analysis
**Patterns**: @claude/patterns/development/performance-patterns.md

### Security Analysis
```
@claude/commands/core/analyze.md --type=security --scope=api --specialist=@claude/agents/technical/security.md
```
**Activates**: @claude/agents/technical/security.md with analyzer support
**Tools**: @claude/integrations/sequential.md for threat modeling
**Patterns**: @claude/patterns/development/security-patterns.md

### Code Quality Analysis
```
@claude/commands/core/analyze.md --type=code-quality --scope=component --depth=detailed
```
**Activates**: @claude/agents/cognitive/analyzer.md
**Tools**: @claude/integrations/context7.md for best practices research
**Patterns**: @claude/patterns/development/code-quality-patterns.md

## Execution Workflow

### Phase 1: Analysis Setup
1. **Context Gathering**
   - Load relevant memory: @claude/memory/context/project-overview.md
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
   - Use @claude/patterns/* for reference comparisons

2. **Root Cause Analysis**
   - Apply systematic investigation techniques
   - Use @claude/integrations/sequential.md for complex analysis
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
- **Tools**: @claude/integrations/puppeteer.md (frontend), monitoring tools
- **Specialists**: @claude/agents/cognitive/analyzer.md, performance-focused technical specialists
- **Patterns**: @claude/patterns/development/performance-patterns.md

### Security Analysis
- **Metrics**: Vulnerability count, compliance score, threat exposure
- **Tools**: @claude/integrations/sequential.md for threat modeling
- **Specialists**: @claude/agents/technical/security.md
- **Patterns**: @claude/patterns/development/security-patterns.md

### System Analysis
- **Metrics**: System health, dependency mapping, failure patterns
- **Tools**: @claude/integrations/context7.md for architecture research
- **Specialists**: @claude/agents/cognitive/architect.md, @claude/agents/cognitive/analyzer.md
- **Patterns**: @claude/patterns/architectural/*

## Integration Points
- **Troubleshooting**: Automatic escalation to @claude/commands/core/troubleshoot.md for issues
- **Optimization**: Recommendations feed into @claude/commands/specialized/optimize.md
- **Security**: Security findings trigger @claude/commands/specialized/secure.md workflows
- **Documentation**: Results documented via @claude/commands/specialized/document.md

## Success Criteria
- [ ] Analysis objectives clearly defined and met
- [ ] Comprehensive data collection completed
- [ ] Root causes identified with supporting evidence
- [ ] Actionable recommendations provided
- [ ] Risk assessment and prioritization completed
- [ ] Follow-up actions clearly defined

## Memory & Context Usage
- **Analysis History**: @claude/memory/knowledge/analysis-history.md
- **Baseline Metrics**: @claude/memory/context/performance-baselines.md
- **Known Issues**: @claude/memory/knowledge/anti-patterns.md
- **Session Tracking**: @claude/memory/sessions/current-session.md#analysis-log

## Error Handling & Escalation
- Insufficient data → @claude/agents/cognitive/researcher.md for deeper investigation
- Complex systems → @claude/agents/cognitive/architect.md for architectural analysis
- Security concerns → @claude/agents/technical/security.md immediate involvement
- Performance critical → Emergency escalation to @claude/agents/orchestration/project-manager.md
