# Market Research Workflow

## Overview
Comprehensive market research workflow leveraging multiple MCP servers and specialists for thorough competitive analysis and market intelligence.

## MCP Server Integration
- **@shared/mcp-integration/perplexity.md** - Real-time market trends and news
- **@shared/mcp-integration/firecrawl.md** - Competitor data extraction
- **@shared/mcp-integration/sequential.md** - Multi-step analysis
- **@shared/mcp-integration/context7.md** - Industry reports and documentation

## Workflow Stages

### 1. Market Landscape Analysis
**Specialist**: @specialists/cognitive/researcher.md
**MCP Servers**: Perplexity + Context7

```bash
@commands/specialized/research.md --source=perplexity --market-trends --industry=[sector]
```

**Activities**:
- Industry trend identification
- Market size and growth analysis
- Regulatory landscape review
- Technology adoption patterns

### 2. Competitor Intelligence
**Specialist**: @specialists/cognitive/analyzer.md
**MCP Servers**: Firecrawl + Perplexity

```bash
@commands/specialized/collect.md --source=firecrawl --competitors --features --pricing
```

**Activities**:
- Feature comparison matrix
- Pricing strategy analysis
- Marketing message extraction
- Customer review aggregation

### 3. User Needs Assessment
**Specialist**: @specialists/domain/product-manager.md
**MCP Servers**: Perplexity + Sequential

```bash
@commands/core/analyze.md --user-needs --source=perplexity --forums --reviews
```

**Activities**:
- Pain point identification
- Feature request analysis
- User sentiment evaluation
- Unmet needs discovery

### 4. Data Synthesis
**Specialist**: @specialists/domain/data-scientist.md
**MCP Servers**: Sequential + Firecrawl

```bash
@commands/core/analyze.md --synthesize --patterns --insights
```

**Activities**:
- Pattern recognition
- Statistical analysis
- Trend forecasting
- Opportunity identification

### 5. Strategic Recommendations
**Specialist**: @specialists/cognitive/strategist.md
**MCP Servers**: Sequential + Context7

```bash
@commands/core/plan.md --strategic --recommendations --action-items
```

**Activities**:
- Market entry strategies
- Differentiation opportunities
- Risk assessment
- Implementation roadmap

## Automation Script

```javascript
// Market Research Automation
TodoWrite([
  {
    id: "market_landscape",
    content: "Analyze industry trends and market size using Perplexity",
    status: "pending",
    priority: "high",
    specialist: "@specialists/cognitive/researcher.md"
  },
  {
    id: "competitor_analysis",
    content: "Extract competitor data using Firecrawl",
    status: "pending",
    priority: "high",
    specialist: "@specialists/cognitive/analyzer.md"
  },
  {
    id: "user_research",
    content: "Analyze user needs and pain points",
    status: "pending",
    priority: "medium",
    specialist: "@specialists/domain/product-manager.md"
  },
  {
    id: "data_synthesis",
    content: "Synthesize findings and identify patterns",
    status: "pending",
    priority: "medium",
    specialist: "@specialists/domain/data-scientist.md"
  },
  {
    id: "recommendations",
    content: "Develop strategic recommendations",
    status: "pending",
    priority: "low",
    specialist: "@specialists/cognitive/strategist.md"
  }
]);
```

## Output Deliverables

### Market Research Report
- Executive summary
- Market landscape overview
- Competitive analysis matrix
- User needs assessment
- Strategic recommendations
- Implementation roadmap

### Supporting Documents
- Raw data exports (Firecrawl)
- Search results compilation (Perplexity)
- Statistical analysis (Sequential)
- Reference documentation (Context7)

## Success Criteria
- Comprehensive market coverage
- Actionable insights identified
- Data-driven recommendations
- Clear differentiation opportunities
- Validated market opportunities

## Integration Points
- **@workflows/development/feature-development.md** - Feature planning based on research
- **@workflows/operations/product-launch.md** - Go-to-market strategy
- **@workflows/analysis/competitive-analysis.md** - Ongoing monitoring

## Memory Integration
- Store findings: `@memory/knowledge/market-research.md`
- Track competitors: `@memory/context/competitive-landscape.md`
- Save insights: `@memory/sessions/current-session.md#market-insights`

## Error Handling
- **Data gaps**: Use multiple sources to fill information gaps
- **Access issues**: Fallback to alternative data sources
- **Conflicting data**: Cross-reference and validate findings
- **Time constraints**: Prioritize high-impact research areas