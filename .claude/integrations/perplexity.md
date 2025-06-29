# Perplexity MCP Integration

## Overview
Perplexity provides AI-powered search capabilities, enabling specialists to access real-time web information, current events, and comprehensive research data with citations and source verification.

## Primary Use Cases
- Real-time web search and information gathering
- Market research and competitive intelligence
- Current events and trend analysis
- Technical problem investigation
- Academic and scientific research

## Specialist Integration

### Best Suited Specialists
1. **@claude/agents/cognitive/researcher.md**
   - Comprehensive web research and data gathering
   - Multi-source information synthesis
   - Trend analysis and market research
   - Academic and technical research

2. **@claude/agents/cognitive/analyzer.md**
   - Real-time issue investigation
   - Competitive analysis and benchmarking
   - Root cause analysis with current data
   - Performance comparison research

3. **@claude/agents/cognitive/strategist.md**
   - Market trend analysis
   - Industry insights and forecasting
   - Strategic intelligence gathering
   - Competitor strategy research

4. **@claude/agents/domain/product-manager.md**
   - Market research and validation
   - Feature comparison analysis
   - User needs and trend research
   - Pricing and positioning research

5. **@claude/agents/technical/security.md**
   - Zero-day vulnerability research
   - Current threat intelligence
   - Security incident investigation
   - Compliance updates and changes

## Workflow Integration

### Research Workflows
- **@claude/workflows/analysis/market-research.md**
  - Real-time market data gathering
  - Competitor analysis and tracking
  - Industry trend identification

- **@claude/workflows/development/feature-development.md#research**
  - Technical solution research
  - Implementation approach comparison
  - Best practices discovery

- **@claude/workflows/analysis/competitive-analysis.md**
  - Competitor feature tracking
  - Market positioning research
  - Pricing strategy analysis

## Command Integration

### Search Command
```
@commands/specialized/research.md --source=perplexity --query=[query] --timeframe=[recent|all]
```
**Activates**: Perplexity for real-time web search
**Specialists**: @claude/agents/cognitive/researcher.md
**Output**: Cited research findings with source verification

### Market Analysis
```
@commands/core/analyze.md --market --source=perplexity --competitors=[list]
```
**Activates**: Perplexity for competitive intelligence
**Specialists**: @claude/agents/domain/product-manager.md
**Output**: Market analysis with competitor insights

### Trend Research
```
@commands/specialized/research.md --trends --source=perplexity --industry=[sector]
```
**Activates**: Perplexity for trend analysis
**Specialists**: @claude/agents/cognitive/strategist.md
**Output**: Industry trends with supporting data

## Configuration

### Search Parameters
- **Depth**: Surface-level to comprehensive deep-dive
- **Timeframe**: Real-time, recent (24h-7d), historical
- **Sources**: Academic, news, technical, social media
- **Verification**: Citation checking and source credibility

### Response Processing
- Source verification and credibility scoring
- Information synthesis from multiple sources
- Bias detection and balanced reporting
- Real-time data integration

## Memory Integration
- **Search History**: @claude/memory/sessions/current-session.md#perplexity-searches
- **Research Cache**: @claude/memory/knowledge/search-results.md
- **Trend Tracking**: @claude/memory/context/market-trends.md

## Quality Assurance
- Multi-source verification for critical information
- Citation tracking and source documentation
- Recency validation for time-sensitive data
- Bias mitigation through diverse source selection

## Usage Examples

### Technical Research
```
Specialist: @claude/agents/cognitive/researcher.md
Query: "Latest developments in quantum computing error correction"
Perplexity: Searches academic papers, tech news, research labs
Output: Comprehensive report with recent breakthroughs and citations
```

### Market Intelligence
```
Specialist: @claude/agents/domain/product-manager.md
Query: "SaaS pricing trends in project management tools 2024"
Perplexity: Analyzes competitor pricing, market reports, user discussions
Output: Pricing strategy recommendations with market data
```

### Security Research
```
Specialist: @claude/agents/technical/security.md
Query: "Recent vulnerabilities in Node.js ecosystem"
Perplexity: Searches CVE databases, security blogs, GitHub issues
Output: Vulnerability assessment with mitigation strategies
```

## Error Handling
- **No Results**: Refine query parameters and retry
- **Conflicting Information**: Present multiple perspectives with source analysis
- **Rate Limiting**: Implement intelligent caching and query optimization
- **Source Unavailable**: Fallback to alternative search strategies

## Performance Optimization
- Query result caching for frequently searched topics
- Intelligent query expansion for better results
- Parallel search execution for comprehensive topics
- Result summarization for quick insights

## Integration Benefits
- **Real-time Information**: Access to current web data
- **Comprehensive Coverage**: Multiple source synthesis
- **Citation Support**: Verifiable information with sources
- **AI Enhancement**: Intelligent search and summarization
- **Time Efficiency**: Rapid research capabilities

## Best Practices
1. Use specific, well-formed queries for better results
2. Specify timeframe for time-sensitive research
3. Cross-reference critical information with Context7
4. Cache results for repeated queries
5. Document sources for audit trails