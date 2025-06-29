# Research Command

## Purpose
Deep investigation and knowledge acquisition command for gathering insights, analyzing trends, and building comprehensive understanding of technologies, markets, and domains.

## Specialist Integration
- **Primary**: @claude/agents/cognitive/researcher.md
- **Supporting**: @claude/agents/cognitive/analyzer.md, @claude/agents/domain/data-scientist.md

## Command Syntax
```
@claude/commands/specialized/research.md [--topic] [--depth] [--sources] [--output]
```

## Parameters
- `--topic`: Research topic or domain (technology, market, competitor, user-behavior, best-practices)
- `--depth`: Research depth (overview, detailed, exhaustive)
- `--sources`: Source preferences (academic, industry, documentation, forums, all)
- `--output`: Output format (report, summary, knowledge-base, presentation)

## Usage Examples

### Technology Stack Research
```
@claude/commands/specialized/research.md --topic="Next.js 14 app router patterns" --depth=detailed --sources=documentation,forums
```
**Activates**: @claude/agents/cognitive/researcher.md, @claude/agents/technical/frontend-dev.md
**Tools**: @claude/integrations/perplexity.md for web research, @claude/integrations/firecrawl.md for documentation crawling
**Patterns**: @claude/patterns/development/research-patterns.md#technology-evaluation

### Market Analysis Research
```
@claude/commands/specialized/research.md --topic="AI coding assistant market trends 2024" --depth=exhaustive --output=report
```
**Activates**: @claude/agents/cognitive/researcher.md, @claude/agents/domain/product-manager.md
**Tools**: @claude/integrations/context7.md for industry insights, @claude/integrations/perplexity.md for market data
**Patterns**: @claude/patterns/strategic/market-analysis.md

### Security Best Practices Research
```
@claude/commands/specialized/research.md --topic="Zero trust architecture implementation" --sources=academic,industry --specialist=@claude/agents/technical/security.md
```
**Activates**: @claude/agents/technical/security.md, @claude/agents/cognitive/researcher.md
**Tools**: @claude/integrations/browsermcp.md for research navigation, @claude/integrations/sequential.md for analysis
**Patterns**: @claude/patterns/development/security-patterns.md#research-methodology

## Execution Workflow

### Phase 1: Research Planning
1. **Scope Definition**
   - Clarify research objectives and questions
   - Identify key areas of investigation
   - Set success criteria and deliverables

2. **Source Strategy**
   - Map relevant information sources
   - Prioritize authoritative sources
   - Plan data collection approach

### Phase 2: Data Collection
1. **Primary Research**
   - Direct documentation analysis
   - Code repository exploration
   - API and tool investigation

2. **Secondary Research**
   - Academic papers and whitepapers
   - Industry reports and case studies
   - Community forums and discussions

### Phase 3: Analysis & Synthesis
1. **Information Processing**
   - Extract key insights and patterns
   - Compare multiple perspectives
   - Identify trends and correlations

2. **Critical Evaluation**
   - Assess source credibility
   - Validate findings across sources
   - Challenge assumptions and biases

### Phase 4: Knowledge Structuring
1. **Insight Organization**
   - Create structured knowledge maps
   - Build comparison matrices
   - Develop decision frameworks

2. **Deliverable Creation**
   - Generate comprehensive reports
   - Create executive summaries
   - Build reference documentation

## Integration Points
- **Architecture**: Findings feed into @claude/agents/cognitive/architect.md for design decisions
- **Development**: Technical insights support @claude/commands/core/build.md workflows
- **Strategy**: Market research informs @claude/agents/cognitive/strategist.md planning
- **Documentation**: Results documented via @claude/commands/specialized/document.md

## Success Criteria
- [ ] Research questions clearly answered
- [ ] Multiple credible sources consulted
- [ ] Contradictions and biases addressed
- [ ] Actionable insights generated
- [ ] Knowledge properly structured and stored
- [ ] Recommendations clearly articulated

## Memory & Context Usage
- **Research History**: @claude/memory/knowledge/research-history.md
- **Source Library**: @claude/memory/knowledge/trusted-sources.md
- **Domain Knowledge**: @claude/memory/knowledge/domain-expertise.md
- **Session Notes**: @claude/memory/sessions/current-session.md#research-notes

## Error Handling & Fallbacks
- Insufficient sources → Expand search with @claude/integrations/perplexity.md
- Conflicting information → @claude/agents/cognitive/analyzer.md for deeper analysis
- Technical complexity → Domain specialist consultation
- Time constraints → Prioritized research with phased approach

## Advanced Features
- **Continuous Monitoring**: Set up alerts for new developments
- **Collaborative Research**: Multi-specialist investigation teams
- **Knowledge Graphs**: Visual relationship mapping
- **Trend Analysis**: Historical pattern recognition and forecasting