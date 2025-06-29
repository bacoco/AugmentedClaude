# Analyze Command

## Purpose
Deep analytical investigation command for examining code patterns, performance metrics, data trends, and system behaviors to extract actionable insights.

## Specialist Integration
- **Primary**: @specialists/cognitive/analyzer.md
- **Supporting**: @specialists/domain/data-scientist.md, @specialists/cognitive/researcher.md

## Command Syntax
```
@commands/specialized/analyze.md [--target] [--method] [--depth] [--output]
```

## Parameters
- `--target`: Analysis target (codebase, performance, data, usage, trends, dependencies)
- `--method`: Analysis method (static, dynamic, statistical, behavioral, predictive)
- `--depth`: Analysis depth (surface, detailed, comprehensive, exhaustive)
- `--output`: Output format (report, visualization, recommendations, dashboard)

## Usage Examples

### Codebase Analysis
```
@commands/specialized/analyze.md --target=codebase --method=static --depth=comprehensive --output=report
```
**Activates**: @specialists/cognitive/analyzer.md for code pattern analysis
**Tools**: @shared/mcp-integration/sequential.md for static analysis tools integration
**Patterns**: @patterns/development/analysis-patterns.md, @patterns/development/code-quality.md

### Performance Analysis
```
@commands/specialized/analyze.md --target=performance --method=dynamic --depth=detailed --output=visualization
```
**Activates**: @specialists/cognitive/analyzer.md, @specialists/technical/devops.md
**Tools**: @shared/mcp-integration/magic.md for performance profiling and visualization
**Patterns**: @patterns/operational/performance-patterns.md, @patterns/operational/monitoring-patterns.md

### Data Trend Analysis
```
@commands/specialized/analyze.md --target=data --method=statistical --specialist=@specialists/domain/data-scientist.md
```
**Activates**: @specialists/domain/data-scientist.md for statistical analysis
**Tools**: @shared/mcp-integration/perplexity.md for external data correlation
**Patterns**: @patterns/analytical/data-analysis.md, @patterns/analytical/trend-analysis.md

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
- **Research**: Analysis findings support @commands/specialized/research.md investigations
- **Optimization**: Performance insights feed @commands/specialized/optimize.md strategies
- **Monitoring**: Analysis enhances @commands/core/monitor.md capabilities
- **Decision Making**: Insights inform @specialists/cognitive/strategist.md planning

## Success Criteria
- [ ] Analysis objectives clearly achieved
- [ ] Significant patterns and trends identified
- [ ] Actionable insights generated
- [ ] Findings properly validated and verified
- [ ] Comprehensive documentation produced
- [ ] Stakeholder recommendations provided

## Memory & Context Usage
- **Analysis History**: @memory/analysis/analysis-history.md
- **Pattern Library**: @memory/knowledge/identified-patterns.md
- **Methodology**: @memory/analysis/analysis-methods.md
- **Session Notes**: @memory/sessions/current-session.md#analysis-log

## Error Handling & Fallbacks
- Insufficient data → @commands/specialized/collect.md for additional data gathering
- Analysis complexity → @specialists/domain/data-scientist.md for advanced techniques
- Tool limitations → @shared/mcp-integration/perplexity.md for alternative approaches
- Inconclusive results → @specialists/cognitive/researcher.md for additional investigation

## Advanced Features
- **Real-Time Analysis**: Continuous analysis of streaming data
- **Predictive Modeling**: Future trend forecasting and prediction
- **Comparative Analysis**: Multi-system and historical comparisons
- **Interactive Exploration**: Dynamic analysis and drill-down capabilities