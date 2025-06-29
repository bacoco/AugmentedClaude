# Analyze Command

## Purpose
Deep analytical investigation command for examining code patterns, performance metrics, data trends, and system behaviors to extract actionable insights.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/analyzer.md
- **Supporting**: @claude/agents/domain/data-scientist.md, @claude/agents/cognitive/researcher.md

## Command Syntax
```
@claude/commands/specialized/analyze.md [--target] [--method] [--depth] [--output]
```

## Parameters
- `--target`: Analysis target (codebase, performance, data, usage, trends, dependencies)
- `--method`: Analysis method (static, dynamic, statistical, behavioral, predictive)
- `--depth`: Analysis depth (surface, detailed, comprehensive, exhaustive)
- `--output`: Output format (report, visualization, recommendations, dashboard)

## Usage Examples

### Codebase Analysis
```
@claude/commands/specialized/analyze.md --target=codebase --method=static --depth=comprehensive --output=report
```
**Activates**: @claude/agents/cognitive/analyzer.md for code pattern analysis
**Tools**: @claude/integrations/sequential.md for static analysis tools integration
**Patterns**: @claude/patterns/development/analysis-patterns.md, @claude/patterns/development/code-quality.md

### Performance Analysis
```
@claude/commands/specialized/analyze.md --target=performance --method=dynamic --depth=detailed --output=visualization
```
**Activates**: @claude/agents/cognitive/analyzer.md, @claude/agents/technical/devops.md
**Tools**: @claude/integrations/magic.md for performance profiling and visualization
**Patterns**: @claude/patterns/operational/performance-patterns.md, @claude/patterns/operational/monitoring-patterns.md

### Data Trend Analysis
```
@claude/commands/specialized/analyze.md --target=data --method=statistical --specialist=@claude/agents/domain/data-scientist.md
```
**Activates**: @claude/agents/domain/data-scientist.md for statistical analysis
**Tools**: @claude/integrations/perplexity.md for external data correlation
**Patterns**: @claude/patterns/analytical/data-analysis.md, @claude/patterns/analytical/trend-analysis.md

## Execution Workflow

### Phase 1: Analysis Preparation
1. **Target Identification**
   - Define analysis scope and objectives
   - Identify data sources and collection points
   - Establish success criteria and metrics

2. **Method Selection**
   - Choose appropriate analytical techniques
   - Configure analysis tools and environments
   - Prepare data collection and processing pipelines

### Phase 2: Data Collection
1. **Raw Data Gathering**
   - Extract relevant data from target systems
   - Collect historical and real-time metrics
   - Aggregate data from multiple sources

2. **Data Preprocessing**
   - Clean and normalize collected data
   - Handle missing or inconsistent values
   - Prepare data for analytical processing

### Phase 3: Analysis Execution
1. **Pattern Recognition**
   - Identify trends, anomalies, and correlations
   - Apply statistical and machine learning techniques
   - Generate initial findings and hypotheses

2. **Deep Investigation**
   - Drill down into significant patterns
   - Cross-validate findings across data sources
   - Test hypotheses and validate conclusions

### Phase 4: Insight Generation
1. **Results Synthesis**
   - Consolidate analysis results and findings
   - Generate actionable insights and recommendations
   - Create comprehensive analysis reports

2. **Visualization & Presentation**
   - Develop clear data visualizations
   - Create executive summaries and dashboards
   - Prepare stakeholder-specific presentations

## Integration Points
- **Research**: Analysis findings support @claude/commands/specialized/research.md investigations
- **Optimization**: Performance insights feed @claude/commands/specialized/optimize.md strategies
- **Monitoring**: Analysis enhances @claude/commands/core/monitor.md capabilities
- **Decision Making**: Insights inform @claude/agents/cognitive/strategist.md planning

## Success Criteria
- [ ] Analysis objectives clearly achieved
- [ ] Significant patterns and trends identified
- [ ] Actionable insights generated
- [ ] Findings properly validated and verified
- [ ] Comprehensive documentation produced
- [ ] Stakeholder recommendations provided

## Memory & Context Usage
- **Analysis History**: @claude/memory/analysis/analysis-history.md
- **Pattern Library**: @claude/memory/knowledge/identified-patterns.md
- **Methodology**: @claude/memory/analysis/analysis-methods.md
- **Session Notes**: @claude/memory/sessions/current-session.md#analysis-log

## Error Handling & Fallbacks
- Insufficient data → @claude/commands/specialized/collect.md for additional data gathering
- Analysis complexity → @claude/agents/domain/data-scientist.md for advanced techniques
- Tool limitations → @claude/integrations/perplexity.md for alternative approaches
- Inconclusive results → @claude/agents/cognitive/researcher.md for additional investigation

## Advanced Features
- **Real-Time Analysis**: Continuous analysis of streaming data
- **Predictive Modeling**: Future trend forecasting and prediction
- **Comparative Analysis**: Multi-system and historical comparisons
- **Interactive Exploration**: Dynamic analysis and drill-down capabilities