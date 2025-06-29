# Optimize Command

## Purpose
Comprehensive optimization and performance enhancement command for improving system efficiency, resource utilization, and overall performance across applications and infrastructure.

## Specialist Integration
- **Primary**: @specialists/cognitive/analyzer.md
- **Supporting**: @specialists/technical/devops.md, @specialists/technical/backend-dev.md

## Command Syntax
```
@commands/specialized/optimize.md [--target] [--metric] [--approach] [--constraint]
```

## Parameters
- `--target`: Optimization target (performance, memory, network, database, cost, energy)
- `--metric`: Success metrics (latency, throughput, utilization, efficiency, user-experience)
- `--approach`: Optimization approach (algorithmic, architectural, infrastructure, code-level)
- `--constraint`: Optimization constraints (budget, compatibility, risk-tolerance, timeline)

## Usage Examples

### Application Performance Optimization
```
@commands/specialized/optimize.md --target=performance --metric=latency --approach=code-level --constraint=compatibility
```
**Activates**: @specialists/cognitive/analyzer.md for performance analysis and optimization
**Tools**: @shared/mcp-integration/sequential.md for performance profiling and analysis
**Patterns**: @patterns/operational/performance-patterns.md, @patterns/development/optimization-patterns.md

### Database Query Optimization
```
@commands/specialized/optimize.md --target=database --metric=throughput --approach=algorithmic --specialist=@specialists/technical/backend-dev.md
```
**Activates**: @specialists/technical/backend-dev.md for database optimization
**Tools**: @shared/mcp-integration/magic.md for query analysis and optimization
**Patterns**: @patterns/architectural/data-patterns.md, @patterns/operational/database-optimization.md

### Infrastructure Cost Optimization
```
@commands/specialized/optimize.md --target=cost --metric=efficiency --approach=infrastructure --constraint=budget
```
**Activates**: @specialists/technical/devops.md, @specialists/cognitive/analyzer.md
**Tools**: @shared/mcp-integration/sequential.md for resource analysis and optimization
**Patterns**: @patterns/operational/cost-optimization.md, @patterns/architectural/cloud-patterns.md

## Execution Workflow

### Phase 1: Performance Analysis
1. **Baseline Measurement**
   - Establish current performance baselines
   - Identify performance bottlenecks and issues
   - Analyze resource utilization patterns

2. **Root Cause Analysis**
   - Investigate underlying performance issues
   - Analyze system architecture and design
   - Identify optimization opportunities

### Phase 2: Optimization Strategy
1. **Strategy Development**
   - Prioritize optimization opportunities by impact
   - Design optimization approaches and techniques
   - Plan implementation timeline and resources

2. **Risk Assessment**
   - Evaluate optimization risks and dependencies
   - Plan testing and validation strategies
   - Establish rollback and contingency plans

### Phase 3: Implementation
1. **Code Optimization**
   - Implement algorithmic improvements
   - Optimize data structures and algorithms
   - Enhance memory management and resource usage

2. **Infrastructure Optimization**
   - Optimize system configurations and settings
   - Implement caching and performance enhancements
   - Scale and tune infrastructure resources

### Phase 4: Validation & Monitoring
1. **Performance Testing**
   - Execute comprehensive performance tests
   - Validate optimization effectiveness
   - Compare results against baseline measurements

2. **Continuous Monitoring**
   - Implement performance monitoring and alerting
   - Track optimization sustainability
   - Identify new optimization opportunities

## Integration Points
- **Analysis**: Performance analysis through @commands/specialized/analyze.md workflows
- **Monitoring**: Optimization tracking via @commands/core/monitor.md continuous monitoring
- **Testing**: Performance validation through @commands/core/test.md comprehensive testing
- **Documentation**: Optimization documentation via @commands/specialized/document.md

## Success Criteria
- [ ] Performance targets achieved or exceeded
- [ ] Resource utilization optimized
- [ ] System stability and reliability maintained
- [ ] Cost efficiency improvements realized
- [ ] User experience enhanced
- [ ] Optimization sustainability ensured

## Memory & Context Usage
- **Optimization History**: @memory/optimization/optimization-log.md
- **Performance Baselines**: @memory/optimization/performance-baselines.md
- **Optimization Strategies**: @memory/optimization/strategy-catalog.md
- **Session Notes**: @memory/sessions/current-session.md#optimization-log

## Error Handling & Fallbacks
- Optimization failures → @specialists/cognitive/analyzer.md for alternative approaches
- Performance regressions → Automatic rollback to previous configurations
- Resource constraints → @specialists/technical/devops.md for infrastructure solutions
- Compatibility issues → @specialists/technical/backend-dev.md for code-level solutions

## Advanced Features
- **AI-Driven Optimization**: Machine learning-based performance optimization
- **Predictive Optimization**: Proactive optimization based on usage patterns
- **Multi-Objective Optimization**: Balanced optimization across multiple metrics
- **Continuous Optimization**: Automated ongoing performance improvements