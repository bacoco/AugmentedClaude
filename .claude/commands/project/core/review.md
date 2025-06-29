# Review Command

## Purpose
Comprehensive code and architecture review processes ensuring quality, security, performance, and maintainability across all system components.

## Specialist Integration
- **Primary**: Varies by review type
  - Code Review: Domain-specific technical specialists
  - Architecture Review: @claude/agents/cognitive/architect.md
  - Security Review: @claude/agents/technical/security.md
  - Performance Review: @claude/agents/cognitive/analyzer.md
- **Supporting**: @claude/agents/technical/qa-tester.md, @claude/agents/domain/tech-writer.md

## Command Syntax
```
@claude/commands/core/review.md [--type] [--depth] [--scope] [--criteria] [--specialist]
```

## Parameters
- `--type`: Review type (code, architecture, security, performance, documentation, all)
- `--depth`: Review depth (quick=30min, standard=2hr, thorough=4hr+)
- `--scope`: Review scope (file, component, module, system, repository)
- `--criteria`: Custom review criteria or checklist
- `--specialist`: Override default specialist selection

## Usage Examples

### Code Review
```
@claude/commands/core/review.md --type=code --depth=standard --scope=component
```
**Activates**: Relevant technical specialist based on code type
**Tools**: @claude/integrations/context7.md for best practices validation
**Patterns**: @claude/patterns/development/code-quality-patterns.md
**Output**: Review report in @claude/memory/sessions/current-session.md#code-review

### Architecture Review
```
@claude/commands/core/review.md --type=architecture --depth=thorough --scope=system
```
**Activates**: @claude/agents/cognitive/architect.md
**Tools**: @claude/integrations/sequential.md for multi-layer analysis
**Patterns**: @claude/patterns/architectural/integration-patterns.md
**Memory**: Updates @claude/memory/knowledge/architectural-decisions.md

### Security Review
```
@claude/commands/core/review.md --type=security --depth=thorough --criteria=owasp-top-10
```
**Activates**: @claude/agents/technical/security.md
**Tools**: @claude/integrations/perplexity.md for vulnerability research
**Patterns**: @claude/patterns/development/security-patterns.md, @claude/patterns/operational/security-testing.md
**Output**: Security assessment in @claude/memory/knowledge/security-assessments.md

## Execution Workflow

### Phase 1: Review Preparation
1. **Context Loading**
   - Load relevant code/architecture from repository
   - Retrieve historical review data from memory
   - Identify review criteria and standards

2. **Specialist Activation**
   - Select appropriate specialist based on review type
   - Load domain-specific knowledge and patterns
   - Prepare review checklist and tools

### Phase 2: Systematic Analysis
1. **Static Analysis**
   - Code quality metrics and complexity analysis
   - Pattern compliance verification
   - Dependency and coupling assessment

2. **Dynamic Analysis** (if applicable)
   - Performance profiling for performance reviews
   - Security scanning for security reviews
   - Integration testing for architecture reviews

### Phase 3: Deep Review
1. **Detailed Inspection**
   - Line-by-line code review for critical sections
   - Architecture decision record validation
   - Security vulnerability identification
   - Performance bottleneck analysis

2. **Best Practices Validation**
   - Reference: @claude/memory/knowledge/best-practices.md
   - Industry standard compliance
   - Anti-pattern detection from @claude/memory/knowledge/anti-patterns.md

### Phase 4: Recommendation & Reporting
1. **Issue Prioritization**
   - Critical: Security vulnerabilities, data loss risks
   - High: Performance issues, architectural flaws
   - Medium: Code quality, maintainability concerns
   - Low: Style violations, minor improvements

2. **Report Generation**
   - Comprehensive findings documentation
   - Actionable recommendations with examples
   - Update relevant memory stores

## Integration Points
- **Testing**: @claude/commands/core/test.md for validation of findings
- **Building**: @claude/commands/core/build.md for implementing recommendations
- **Analysis**: @claude/commands/core/analyze.md for deeper investigation
- **Documentation**: @claude/agents/domain/tech-writer.md for review documentation

## Success Criteria
- [ ] All critical issues identified and documented
- [ ] Recommendations are actionable and prioritized
- [ ] Code/architecture meets quality standards
- [ ] Security vulnerabilities addressed
- [ ] Performance targets validated
- [ ] Review findings stored in memory

## Quality Gates
### Code Review Gates
- [ ] No critical security vulnerabilities
- [ ] Test coverage >= 80%
- [ ] Cyclomatic complexity < 10
- [ ] No high-priority code smells
- [ ] Documentation complete

### Architecture Review Gates
- [ ] Alignment with architectural principles
- [ ] Scalability requirements met
- [ ] Integration patterns properly implemented
- [ ] No single points of failure
- [ ] Clear separation of concerns

### Security Review Gates
- [ ] OWASP Top 10 compliance
- [ ] No exposed sensitive data
- [ ] Authentication/authorization properly implemented
- [ ] Input validation present
- [ ] Secure communication protocols used

### Performance Review Gates
- [ ] Response time within SLA
- [ ] Resource utilization optimal
- [ ] No memory leaks detected
- [ ] Database queries optimized
- [ ] Caching strategy effective

## Memory & Context Usage
- **Review History**: @claude/memory/sessions/review-history.md
- **Quality Standards**: @claude/memory/knowledge/quality-standards.md
- **Previous Issues**: @claude/memory/knowledge/lessons-learned.md#review-findings
- **Team Patterns**: @claude/memory/context/team-practices.md

## Advanced Features

### Automated Review Pipeline
```
@claude/commands/core/review.md --type=all --depth=standard --scope=repository
```
Executes comprehensive review across all types with automated tooling integration.

### Comparative Review
```
@claude/commands/core/review.md --type=code --compare=main --scope=branch
```
Reviews changes between branches with focus on regression risks.

### Continuous Review Integration
Integrates with @claude/patterns/operational/continuous-improvement.md for:
- Incremental reviews on each commit
- Trend analysis of code quality metrics
- Team performance insights
- Knowledge base updates from findings

## Error Handling
- **Missing Context**: Automatic context retrieval from repository
- **Tool Failures**: Fallback to manual review processes
- **Incomplete Reviews**: Checkpoint saving and resumption
- **Conflicting Standards**: Priority-based resolution with documentation